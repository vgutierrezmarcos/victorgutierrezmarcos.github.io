// Contenido exclusivo (temas revisados, fichas, guía del dictamen y canon) guardado en
// el KV CONTENIDO por ../publicar-contenido.py, con las mismas rutas que la skill:
//   temas/3A08/tema.md, temas/3A08/ficha.md, temas/3A08/guion-cante.md,
//   dictamen/guia-1D01.md, canon/notacion.md … y un indice.json con lo que hay.
// Solo se sirve a quien tiene sesión: es la protección real del material.

export interface EntradaIndice {
  codigo: string; // 3A08
  tema: string; // 3.A.8
  titulo: string;
  ficha: boolean;
  guion: boolean;
  texto: boolean;
  aprobado: string;
  version: string;
}

export interface Indice {
  /** Versión de la skill con la que se subió (VERSION.txt). */
  version?: string | null;
  generado: string;
  commit?: string;
  temas: EntradaIndice[];
  dictamen: string[];
  canon: string[];
}

export interface AlmacenContenido {
  get(clave: string, tipo: 'text'): Promise<string | null>;
}

// El examen de ejemplo de España y su solución no se publican nunca (Víctor, 24/11/2026): ni aquí ni en el KV.
export const documentosDictamen = ['guia-1D01', 'resumen-1D01', 'guion-1D01'] as const;
export const documentosCanon = ['notacion', 'modelos-indice'] as const;

/** «3.A.8», «3A08», «3a8», «3.a.08» → «3A08»; null si no es un código. */
export function normalizarCodigo(entrada: string): string | null {
  const m = /^\s*(\d)\s*[.\-_ ]?\s*([A-Za-z])\s*[.\-_ ]?\s*(\d{1,2})\s*$/.exec(entrada ?? '');
  if (!m) return null;
  return `${m[1]}${m[2].toUpperCase()}${m[3].padStart(2, '0')}`;
}

/** «3A08» → «3.A.8». */
export function codigoConPuntos(codigo: string): string {
  return `${codigo[0]}.${codigo[1]}.${Number(codigo.slice(2))}`;
}

const sinAcentos = (s: string) => s.normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase();

/** Títulos de los apartados de nivel 2 de un tema en Markdown. */
export function apartadosDe(md: string): string[] {
  return md
    .split('\n')
    .filter((l) => l.startsWith('## '))
    .map((l) => l.slice(3).trim());
}

/**
 * El apartado de nivel 2 cuyo título empieza por la etiqueta pedida («II», «B», «Introducción»)
 * o la contiene («estática comparativa»), con su contenido hasta el siguiente. Null si no está.
 */
export function extraerApartado(md: string, apartado: string): string | null {
  const buscado = sinAcentos(apartado.trim());
  if (!buscado) return null;
  const lineas = md.split('\n');
  const cabeceras = lineas.map((l, i) => (l.startsWith('## ') ? i : -1)).filter((i) => i >= 0);
  // Etiqueta del apartado: «I.», «II.», «B.», «1.», «3)»; nada si el título empieza por una palabra.
  const etiquetaDe = (titulo: string) => /^([A-Za-z]|[IVXivx]+|\d+)[.)]?\s/.exec(titulo)?.[1]?.toLowerCase();
  // Primero la etiqueta exacta (que «I» no se lleve «Introducción»), luego el principio del título y luego cualquier parte.
  const criterios: Array<(titulo: string) => boolean> = [
    (titulo) => etiquetaDe(titulo) === buscado,
    (titulo) => sinAcentos(titulo).startsWith(buscado),
    (titulo) => sinAcentos(titulo).includes(buscado),
  ];
  for (const coincide of criterios) {
    for (let k = 0; k < cabeceras.length; k++) {
      const i = cabeceras[k];
      if (!coincide(lineas[i].slice(3))) continue;
      const fin = k + 1 < cabeceras.length ? cabeceras[k + 1] : lineas.length;
      return lineas.slice(i, fin).join('\n').trim();
    }
  }
  return null;
}

export class Contenido {
  constructor(private readonly kv: AlmacenContenido) {}

  async indice(): Promise<Indice | null> {
    const t = await this.kv.get('indice.json', 'text');
    if (!t) return null;
    try {
      return JSON.parse(t) as Indice;
    } catch {
      return null;
    }
  }

  /** Un fichero del material exclusivo por su clave («temas/3A08/ficha.md», «canon/notacion.md»…). */
  crudo(clave: string): Promise<string | null> {
    return this.kv.get(clave, 'text');
  }

  tema(codigo: string, fichero: 'tema' | 'ficha' | 'guion-cante'): Promise<string | null> {
    return this.kv.get(`temas/${codigo}/${fichero}.md`, 'text');
  }

  dictamen(documento: (typeof documentosDictamen)[number]): Promise<string | null> {
    return this.kv.get(`dictamen/${documento}.md`, 'text');
  }

  canon(documento: (typeof documentosCanon)[number]): Promise<string | null> {
    return this.kv.get(`canon/${documento}.md`, 'text');
  }
}

const VACIAS = new Set(['los', 'las', 'del', 'que', 'con', 'por', 'para', 'una', 'unos', 'unas', 'como', 'sobre', 'segun', 'tema', 'temario', 'dice', 'cual', 'cuales', 'donde', 'esta', 'este', 'entre', 'sus', 'mas']);

/** Palabras de una búsqueda (sin tildes, sin vacías); las cifras («4,2») se quedan. */
export function palabrasBusqueda(consulta: string): string[] {
  return sinAcentos(consulta)
    .split(/[^a-z0-9ñ,.%-]+/)
    .map((p) => p.replace(/^[.,-]+|[.,-]+$/g, ''))
    .filter((p) => (p.length > 2 || /\d/.test(p)) && !VACIAS.has(p));
}

export interface Pasaje {
  apartado: string;
  texto: string;
  coincidencias: number;
}

/**
 * Los pasajes de un Markdown (párrafos, o cada viñeta de primer nivel de una lista) que llevan
 * todas las palabras de la consulta (o, si ninguno las lleva todas, los que llevan más), con la
 * ruta de títulos del apartado en el que están. Para encontrar un dato sin leer el tema entero.
 */
export function buscarEnMd(md: string, consulta: string, maximo = 8): Pasaje[] {
  const palabras = palabrasBusqueda(consulta);
  if (!palabras.length) return [];
  const raiz = (p: string) => (/\d/.test(p) ? p : p.slice(0, Math.max(4, p.length - 2)));
  const ruta: string[] = [];
  const bloques: Array<{ apartado: string; texto: string }> = [];
  let actual: string[] = [];
  const cerrar = () => {
    const texto = actual.join('\n').trim();
    if (texto) bloques.push({ apartado: ruta.filter(Boolean).join(' › '), texto });
    actual = [];
  };
  for (const linea of md.split('\n')) {
    const h = /^(#{1,5})\s+(.*)$/.exec(linea);
    if (h) {
      cerrar();
      ruta.length = h[1].length;
      ruta[h[1].length - 1] = h[2].trim();
      continue;
    }
    if (!linea.trim() || /^[-*+]\s/.test(linea) || /^\d+[.)]\s/.test(linea)) cerrar();
    if (linea.trim()) actual.push(linea);
  }
  cerrar();
  // Solo al principio de una palabra: «Arrow» no puede encontrar «desarrollo».
  const escapar = (x: string) => x.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const patrones = palabras.map((p) => new RegExp(`(?<![a-z0-9ñ])${escapar(raiz(p))}`, 'g'));
  const puntuados = bloques.map((b) => {
    const t = sinAcentos(b.texto);
    const hay = patrones.filter((r) => t.search(r) >= 0).length;
    const veces = patrones.reduce((n, r) => n + (t.match(r)?.length ?? 0), 0);
    return { ...b, hay, veces };
  });
  const mejor = Math.max(0, ...puntuados.map((b) => b.hay));
  if (mejor === 0 || mejor < Math.min(palabras.length, 2)) return [];
  return puntuados
    .filter((b) => b.hay === mejor)
    .sort((a, b) => b.veces - a.veces)
    .slice(0, maximo)
    .map((b) => ({ apartado: b.apartado, texto: b.texto.length > 1500 ? `${b.texto.slice(0, 1500)}…` : b.texto, coincidencias: b.hay }));
}
