import { afterEach, beforeEach, describe, expect, it } from 'vitest';
import { ErrorFirestore, Firestore, aCampos, aValor, deCampos, deValor, idDe, type Json } from '../src/firestore';

describe('conversión de valores de Firestore', () => {
  it('JSON → valor tipado: enteros, decimales, textos, booleanos, nulos, listas y mapas', () => {
    expect(aValor(3)).toEqual({ integerValue: '3' });
    expect(aValor(6.4)).toEqual({ doubleValue: 6.4 });
    expect(aValor('3.A.8')).toEqual({ stringValue: '3.A.8' });
    expect(aValor(true)).toEqual({ booleanValue: true });
    expect(aValor(null)).toEqual({ nullValue: null });
    expect(aValor(['a', 1])).toEqual({ arrayValue: { values: [{ stringValue: 'a' }, { integerValue: '1' }] } });
    expect(aValor({ x: { y: [] } })).toEqual({ mapValue: { fields: { x: { mapValue: { fields: { y: { arrayValue: { values: [] } } } } } } } });
  });

  it('valor tipado → JSON, con integerValue como texto y marcas de tiempo como ISO', () => {
    expect(deValor({ integerValue: '42' })).toBe(42);
    expect(deValor({ doubleValue: 2.5 })).toBe(2.5);
    expect(deValor({ timestampValue: '2026-10-28T10:00:00Z' })).toBe('2026-10-28T10:00:00Z');
    expect(deValor({ arrayValue: {} })).toEqual([]);
    expect(deValor({ mapValue: {} })).toEqual({});
    expect(deValor({ nullValue: null })).toBeNull();
  });

  it('ida y vuelta de un documento como los de la app (cronograma)', () => {
    const doc: { [k: string]: Json } = {
      id: 'abc',
      ejercicio: 3,
      temas: ['3.A.8', '3.A.9'],
      inicio: '2026-10-05T00:00:00.000',
      fin: null,
      intercalar: true,
      cadaN: null,
      semanas: [{ lunes: '2026-10-05T00:00:00.000', temas: ['3.A.8'] }, { lunes: '2026-10-12T00:00:00.000', temas: [], descanso: true }],
      hechos: { '3.A.8': '2026-10-10T18:00:00.000' },
      temasPorSemana: 3,
      manual: true,
    };
    expect(deCampos(aCampos(doc))).toEqual(doc);
  });

  it('idDe saca el último tramo del nombre', () => {
    expect(idDe({ name: 'projects/web-vgm/databases/(default)/documents/users/u1/cantes/c9' })).toBe('c9');
  });
});

// La capa HTTP, con el `fetch` global sustituido por uno que, como el de workerd, rechaza
// que lo llamen con un `this` que no sea el global (así falló en producción: «Illegal invocation»).
describe('Firestore por REST con el fetch global', () => {
  const llamadas: Array<{ url: string; metodo: string; cuerpo: unknown }> = [];
  let respuestas: unknown[] = [];
  const original = globalThis.fetch;

  beforeEach(() => {
    llamadas.length = 0;
    globalThis.fetch = function (this: unknown, entrada: RequestInfo | URL, opciones?: RequestInit) {
      if (this !== undefined && this !== globalThis) throw new TypeError('Illegal invocation: function called with incorrect `this` reference.');
      llamadas.push({ url: String(entrada), metodo: opciones?.method ?? 'GET', cuerpo: opciones?.body ? JSON.parse(String(opciones.body)) : undefined });
      const r = respuestas.shift();
      return Promise.resolve(r === null ? new Response('{}', { status: 404 }) : Response.json(r));
    } as typeof fetch;
  });
  afterEach(() => {
    globalThis.fetch = original;
  });

  const base = 'https://firestore.googleapis.com/v1/projects/p/databases/(default)/documents';

  it('leer: un documento de la raíz del opositor, o null si no existe', async () => {
    const db = new Firestore('p', 'tok', Firestore.raizDe('u1', 'dce'));
    respuestas = [{ name: 'x/cantes/c1', fields: { estado: { stringValue: 'hecho' } } }, null];
    expect(await db.leer('cantes/c1')).toEqual({ estado: 'hecho' });
    expect(await db.leer('cantes/c2')).toBeNull();
    expect(llamadas[0].url).toBe(`${base}/users/u1/oposiciones/dce/cantes/c1`);
  });

  it('listar: sigue las páginas hasta el final', async () => {
    const db = new Firestore('p', 'tok', 'users/u1');
    respuestas = [
      { documents: [{ name: 'x/cantes/a', fields: {} }], nextPageToken: 'sig' },
      { documents: [{ name: 'x/cantes/b', fields: {} }] },
    ];
    expect((await db.listar('cantes')).map((d) => d.id)).toEqual(['a', 'b']);
    expect(llamadas[1].url).toContain('pageToken=sig');
  });

  it('consultar: una marca de tiempo se filtra como timestampValue, no como texto', async () => {
    const db = new Firestore('p', 'tok', 'users/u1');
    respuestas = [[{ document: { name: 'x/exam_results/r1', fields: { correctas: { integerValue: '7' } } } }, { readTime: 'ahora' }]];
    const docs = await db.consultar('exam_results', { orderBy: 'timestamp', descendente: true, limite: 5, where: { campo: 'timestamp', op: 'GREATER_THAN_OR_EQUAL', valor: '2026-10-31T23:00:00.000Z', marcaDeTiempo: true } });
    expect(docs).toEqual([{ id: 'r1', datos: { correctas: 7 }, creado: undefined }]);
    expect(llamadas[0].url).toBe(`${base}/users/u1:runQuery`);
    const q = (llamadas[0].cuerpo as { structuredQuery: { where: { fieldFilter: { value: unknown } } } }).structuredQuery;
    expect(q.where.fieldFilter.value).toEqual({ timestampValue: '2026-10-31T23:00:00.000Z' });
  });

  it('consultar en la raíz de la base (la red) y escribir con máscara de campos', async () => {
    const red = new Firestore('p', 'tok', '');
    respuestas = [[], {}];
    await red.consultar('reservas', { where: { campo: 'alumno', op: 'EQUAL', valor: 'u1' } });
    expect(llamadas[0].url).toBe(`${base}:runQuery`);
    await red.escribir('reservas/r1', { estado: 'pedida', nota: '' }, ['estado']);
    expect(llamadas[1].metodo).toBe('PATCH');
    expect(llamadas[1].url).toBe(`${base}/reservas/r1?updateMask.fieldPaths=estado`);
  });

  it('un error de Firestore sale como ErrorFirestore con su estado y su mensaje', async () => {
    globalThis.fetch = (() => Promise.resolve(Response.json({ error: { message: 'Missing or insufficient permissions.' } }, { status: 403 }))) as typeof fetch;
    const db = new Firestore('p', 'tok', 'users/otro');
    await expect(db.leer('cantes/c1')).rejects.toBeInstanceOf(ErrorFirestore);
    await expect(db.leer('cantes/c1')).rejects.toMatchObject({ estado: 403, message: 'Missing or insufficient permissions.' });
  });

  it('lote: varias escrituras en un solo commit, con sus nombres completos y sus máscaras', async () => {
    const db = new Firestore('p', 'tok', 'users/u1');
    respuestas = [{}];
    await db.lote([
      { ruta: 'cronogramas/viejo', datos: { archivado: true }, soloCampos: ['archivado'] },
      { ruta: 'cronogramas/nuevo', datos: { id: 'nuevo' } },
    ]);
    expect(llamadas).toHaveLength(1);
    expect(llamadas[0].url).toBe(`${base}:commit`);
    const { writes } = llamadas[0].cuerpo as { writes: Array<{ update: { name: string }; updateMask?: { fieldPaths: string[] } }> };
    expect(writes.map((w) => w.update.name)).toEqual(['projects/p/databases/(default)/documents/users/u1/cronogramas/viejo', 'projects/p/databases/(default)/documents/users/u1/cronogramas/nuevo']);
    expect(writes[0].updateMask).toEqual({ fieldPaths: ['archivado'] });
    expect(writes[1].updateMask).toBeUndefined();
  });

  it('lote: borra documentos con «delete» y su nombre completo', async () => {
    const db = new Firestore('p', 'tok', 'users/u1/oposiciones/dce');
    respuestas = [{}];
    await db.lote([{ ruta: 'cantes/c1/informes/i1', datos: {}, borrar: true }, { ruta: 'cantes/c1', datos: {}, borrar: true }]);
    expect((llamadas[0].cuerpo as { writes: unknown[] }).writes).toEqual([
      { delete: 'projects/p/databases/(default)/documents/users/u1/oposiciones/dce/cantes/c1/informes/i1' },
      { delete: 'projects/p/databases/(default)/documents/users/u1/oposiciones/dce/cantes/c1' },
    ]);
  });

  it('tramo: un id que viene de la IA no puede cambiar la ruta', () => {
    expect(Firestore.tramo(' c1/../../x?y ')).toBe('c1%2F..%2F..%2Fx%3Fy');
  });
});
