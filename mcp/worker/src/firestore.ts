// Acceso a Firestore por REST con el ID token del propio opositor: las reglas de
// seguridad de siempre deciden (el dueño lee y escribe users/{uid}/**). Sin cuenta
// de servicio. Convierte los valores tipados de la API REST a JSON llano y al revés.

export type Json = null | boolean | number | string | Json[] | { [k: string]: Json };

/** Valor tipado de la API REST de Firestore. */
export type Valor =
  | { nullValue: null }
  | { booleanValue: boolean }
  | { integerValue: string }
  | { doubleValue: number }
  | { stringValue: string }
  | { timestampValue: string }
  | { arrayValue: { values?: Valor[] } }
  | { mapValue: { fields?: Record<string, Valor> } }
  | { referenceValue: string }
  | { geoPointValue: unknown }
  | { bytesValue: string };

export interface Documento {
  name: string;
  fields?: Record<string, Valor>;
  createTime?: string;
  updateTime?: string;
}

/** JSON → valor tipado. Los enteros van como integerValue; los demás números, como doubleValue. */
export function aValor(v: Json): Valor {
  if (v === null || v === undefined) return { nullValue: null };
  if (typeof v === 'boolean') return { booleanValue: v };
  if (typeof v === 'number') return Number.isInteger(v) ? { integerValue: String(v) } : { doubleValue: v };
  if (typeof v === 'string') return { stringValue: v };
  if (Array.isArray(v)) return { arrayValue: { values: v.map(aValor) } };
  return { mapValue: { fields: aCampos(v) } };
}

export function aCampos(obj: { [k: string]: Json }): Record<string, Valor> {
  const out: Record<string, Valor> = {};
  for (const [k, v] of Object.entries(obj)) if (v !== undefined) out[k] = aValor(v);
  return out;
}

/** Valor tipado → JSON. Las marcas de tiempo quedan como texto ISO. */
export function deValor(v: Valor): Json {
  if ('nullValue' in v) return null;
  if ('booleanValue' in v) return v.booleanValue;
  if ('integerValue' in v) return Number(v.integerValue);
  if ('doubleValue' in v) return v.doubleValue;
  if ('stringValue' in v) return v.stringValue;
  if ('timestampValue' in v) return v.timestampValue;
  if ('arrayValue' in v) return (v.arrayValue.values ?? []).map(deValor);
  if ('mapValue' in v) return deCampos(v.mapValue.fields ?? {});
  if ('referenceValue' in v) return v.referenceValue;
  return null;
}

export function deCampos(campos: Record<string, Valor> | undefined): { [k: string]: Json } {
  const out: { [k: string]: Json } = {};
  for (const [k, v] of Object.entries(campos ?? {})) out[k] = deValor(v);
  return out;
}

/** Id del documento (último tramo de `name`). */
export function idDe(doc: Documento): string {
  return doc.name.slice(doc.name.lastIndexOf('/') + 1);
}

export class ErrorFirestore extends Error {
  constructor(public estado: number, mensaje: string) {
    super(mensaje);
  }
}

export interface Consulta {
  orderBy?: string;
  descendente?: boolean;
  limite?: number;
  /** Filtro de campo único (no necesita índice compuesto si coincide con orderBy). */
  where?: { campo: string; op: 'EQUAL' | 'GREATER_THAN_OR_EQUAL' | 'LESS_THAN_OR_EQUAL'; valor: Json };
}

/** Interfaz mínima que usan las herramientas (así se simula en las pruebas). */
export interface AlmacenDatos {
  leer(ruta: string): Promise<{ [k: string]: Json } | null>;
  listar(coleccion: string): Promise<Array<{ id: string; datos: { [k: string]: Json } }>>;
  consultar(coleccion: string, consulta: Consulta): Promise<Array<{ id: string; datos: { [k: string]: Json }; creado?: string }>>;
  escribir(ruta: string, datos: { [k: string]: Json }, soloCampos?: string[]): Promise<void>;
}

/**
 * Firestore REST sobre la raíz del opositor: `users/{uid}` en TCEE o
 * `users/{uid}/oposiciones/{id}` en las demás oposiciones.
 */
export class Firestore implements AlmacenDatos {
  private readonly base: string;
  private readonly documentos: string;

  constructor(
    proyecto: string,
    private readonly idToken: string,
    private readonly raiz: string,
    private readonly fetchFn: typeof fetch = fetch,
  ) {
    this.documentos = `projects/${proyecto}/databases/(default)/documents`;
    this.base = `https://firestore.googleapis.com/v1/${this.documentos}`;
  }

  /** URL de un documento o colección bajo la raíz (la raíz vacía es la de la base de datos). */
  private url(ruta: string): string {
    return [this.base, this.raiz, ruta].filter(Boolean).join('/');
  }

  static raizDe(uid: string, oposicion: string): string {
    return oposicion === 'tcee' ? `users/${uid}` : `users/${uid}/oposiciones/${oposicion}`;
  }

  private async peticion(metodo: string, url: string, cuerpo?: unknown): Promise<unknown> {
    const r = await this.fetchFn(url, {
      method: metodo,
      headers: { Authorization: `Bearer ${this.idToken}`, 'Content-Type': 'application/json' },
      body: cuerpo === undefined ? undefined : JSON.stringify(cuerpo),
    });
    if (r.status === 404) return null;
    if (!r.ok) {
      const texto = await r.text();
      let mensaje = texto;
      try {
        mensaje = (JSON.parse(texto) as { error?: { message?: string } }).error?.message ?? texto;
      } catch {
        /* texto plano */
      }
      throw new ErrorFirestore(r.status, mensaje);
    }
    return r.json();
  }

  async leer(ruta: string): Promise<{ [k: string]: Json } | null> {
    const doc = (await this.peticion('GET', this.url(ruta))) as Documento | null;
    return doc ? deCampos(doc.fields) : null;
  }

  async listar(coleccion: string): Promise<Array<{ id: string; datos: { [k: string]: Json } }>> {
    const out: Array<{ id: string; datos: { [k: string]: Json } }> = [];
    let token: string | undefined;
    do {
      const url = new URL(this.url(coleccion));
      url.searchParams.set('pageSize', '300');
      if (token) url.searchParams.set('pageToken', token);
      const r = (await this.peticion('GET', url.toString())) as { documents?: Documento[]; nextPageToken?: string } | null;
      for (const d of r?.documents ?? []) out.push({ id: idDe(d), datos: deCampos(d.fields) });
      token = r?.nextPageToken;
    } while (token);
    return out;
  }

  async consultar(coleccion: string, c: Consulta): Promise<Array<{ id: string; datos: { [k: string]: Json }; creado?: string }>> {
    const structuredQuery: Record<string, unknown> = { from: [{ collectionId: coleccion }] };
    if (c.where) structuredQuery.where = { fieldFilter: { field: { fieldPath: c.where.campo }, op: c.where.op, value: aValor(c.where.valor) } };
    if (c.orderBy) structuredQuery.orderBy = [{ field: { fieldPath: c.orderBy }, direction: c.descendente ? 'DESCENDING' : 'ASCENDING' }];
    if (c.limite) structuredQuery.limit = c.limite;
    const padre = this.raiz ? `${this.base}/${this.raiz}` : this.base;
    const r = (await this.peticion('POST', `${padre}:runQuery`, { structuredQuery })) as Array<{ document?: Documento }> | null;
    return (r ?? []).filter((x) => x.document).map((x) => ({ id: idDe(x.document!), datos: deCampos(x.document!.fields), creado: x.document!.createTime }));
  }

  /** PATCH: sin `soloCampos` sustituye el documento entero (o lo crea); con ellos, solo cambia esos campos. */
  async escribir(ruta: string, datos: { [k: string]: Json }, soloCampos?: string[]): Promise<void> {
    const url = new URL(this.url(ruta));
    for (const campo of soloCampos ?? []) url.searchParams.append('updateMask.fieldPaths', campo);
    await this.peticion('PATCH', url.toString(), { fields: aCampos(datos) });
  }
}

/** Marca de tiempo (con `timestampValue`) de un documento de exam_results: la REST la da como texto ISO. */
export function fechaDe(datos: { [k: string]: Json }, campo = 'timestamp'): string | null {
  const v = datos[campo];
  return typeof v === 'string' ? v : null;
}
