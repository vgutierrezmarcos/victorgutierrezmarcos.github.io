// Enrutado de las herramientas con un Firestore simulado y un cliente MCP en memoria.
import { Client } from '@modelcontextprotocol/sdk/client/index.js';
import { InMemoryTransport } from '@modelcontextprotocol/sdk/inMemory.js';
import { beforeEach, describe, expect, it } from 'vitest';
import { Contenido } from '../src/contenido';
import { temasDePreguntas } from '../src/datos';
import type { AlmacenDatos, Consulta, Json } from '../src/firestore';
import { type Contexto, crearServidor, ErrorSesion } from '../src/herramientas';

type Obj = { [k: string]: Json };

/** Firestore en memoria: documentos por ruta relativa a la raíz del opositor. */
class FirestoreSimulado implements AlmacenDatos {
  docs = new Map<string, Obj>();
  escrituras: Array<{ ruta: string; datos: Obj; soloCampos?: string[] }> = [];

  async leer(ruta: string) {
    return this.docs.get(ruta) ?? null;
  }
  async listar(coleccion: string) {
    const prefijo = `${coleccion}/`;
    return [...this.docs.entries()]
      .filter(([r]) => r.startsWith(prefijo) && !r.slice(prefijo.length).includes('/'))
      .map(([r, datos]) => ({ id: r.slice(prefijo.length), datos }));
  }
  async consultar(coleccion: string, c: Consulta) {
    let out = await this.listar(coleccion);
    if (c.where) out = out.filter((d) => String(d.datos[c.where!.campo]) >= String(c.where!.valor));
    if (c.orderBy) out.sort((a, b) => String(a.datos[c.orderBy!]).localeCompare(String(b.datos[c.orderBy!])) * (c.descendente ? -1 : 1));
    return out.slice(0, c.limite);
  }
  async escribir(ruta: string, datos: Obj, soloCampos?: string[]) {
    this.escrituras.push({ ruta, datos, soloCampos });
    if (!soloCampos) {
      this.docs.set(ruta, datos);
      return;
    }
    const actual = { ...(this.docs.get(ruta) ?? {}) };
    for (const campo of soloCampos) {
      const [a, b] = campo.split('.');
      if (b) actual[a] = { ...((actual[a] as Obj) ?? {}), [b]: (datos[a] as Obj)[b] };
      else actual[a] = datos[a];
    }
    this.docs.set(ruta, actual);
  }
}

const kv = new Map<string, string>([
  ['indice.json', JSON.stringify({ generado: 'hoy', temas: [{ codigo: '3A08', tema: '3.A.8', titulo: 'Demanda', ficha: true, guion: true, texto: true, aprobado: '2026-10-17', version: 'abc' }], dictamen: ['guia-1D01'], canon: ['notacion'] })],
  ['temas/3A08/tema.md', '# Tema 3.A.8\n\n## Introducción (2′30″)\n\nHola.\n\n## I. Axiomas (11′)\n\nCompletitud.\n'],
  ['temas/3A08/ficha.md', '# Ficha 3.A.8\n\nResumen.'],
  ['dictamen/guia-1D01.md', '# Guía\n\n## 1. Qué es\n\nTexto.\n'],
]);

const banco = temasDePreguntas({ preguntas: [{ id: 1, temas: ['3.A.8'], respuesta: ['a'] }] });

async function cliente(ctx: Contexto) {
  const servidor = crearServidor(ctx);
  const [a, b] = InMemoryTransport.createLinkedPair();
  await servidor.connect(a);
  const c = new Client({ name: 'prueba', version: '0' });
  await c.connect(b);
  return c;
}

const texto = (r: Awaited<ReturnType<Client['callTool']>>) => (r.content as Array<{ type: string; text: string }>)[0].text;
const json = (r: Awaited<ReturnType<Client['callTool']>>) => JSON.parse(texto(r)) as Obj;

describe('herramientas', () => {
  let db: FirestoreSimulado;
  let dbDce: FirestoreSimulado;
  let desconectado: boolean;
  let ctx: Contexto;

  beforeEach(() => {
    db = new FirestoreSimulado();
    dbDce = new FirestoreSimulado();
    desconectado = false;
    db.docs.set('progress/settings', { temasEstudiados: ['3.A.1'], rubrica: [] });
    db.docs.set('progress/plan', { fechas: { '3': '2027-06-15T00:00:00.000' }, hitos: [] });
    db.docs.set('notes/3_A_8', { tema: '3.A.8', texto: 'nota' });
    db.docs.set('exam_results/r1', { timestamp: '2026-10-28T09:00:00Z', notaSobre10: 6, respuestas: { '1': 'a' }, tipo: 'test', origen: 'app' });
    db.docs.set('exam_results/r0', { timestamp: '2026-09-01T09:00:00Z', notaSobre10: 4, tipo: 'test', origen: 'web' });
    db.docs.set('cantes/c1', { id: 'c1', fecha: '2026-10-10T18:00:00.000', estado: 'hecho', temas: ['3.A.8'], resultado: { temaCantado: '3.A.8', valoracion: 2, comentarios: 'regular' }, updatedAt: '2026-10-10T19:00:00.000' });
    db.docs.set('cantes/c2', { id: 'c2', fecha: '2026-10-20T18:00:00.000', estado: 'pendiente', temas: ['3.A.9'] });
    db.docs.set('cronogramas/viejo', { id: 'viejo', archivado: false, creado: '2026-09-01T00:00:00.000', ejercicio: 3, semanas: [] });
    dbDce.docs.set('progress/settings', { temasEstudiados: ['1.A.1'] });
    ctx = {
      uid: 'u1',
      email: 'u1@example.org',
      almacen: async (op) => (op === 'dce' ? dbDce : db),
      banco: async () => banco,
      contenido: new Contenido({ get: async (k) => kv.get(k) ?? null }),
      fuentes: async () => ({
        aviso: 'aviso',
        bloques: [{ nombre: 'Modelo neoclásico básico', categoria: 'Microeconomía', temas: ['3.A.8'] }],
        manuales: [{ bloque: 'Microeconomía y organización industrial', manuales: [{ cita: 'Varian' }] }, { bloque: 'Macroeconomía', manuales: [{ cita: 'Romer' }] }],
        tcee: {
          '3.A.8': { oposicion: 'tcee', titulo: 'Teoría de la demanda del consumidor (I)', ejercicio: 3, parte: 'A', bloque: 'Modelo neoclásico básico', categoria: 'Microeconomía', revisado: true, manuel: [], atcee: [] },
          '3.B.26': { oposicion: 'tcee', titulo: 'Crisis financieras y pánicos bancarios', ejercicio: 3, parte: 'B', bloque: 'Economía Corporativa y Financiera', categoria: 'Microeconomía', revisado: false,
            web: { pdf: null, disponible: false }, manuel: [], atcee: [{ autor: 'Tebar', promocion: 'LXXV', anio: 2026, numeracion: 'actual', fichero: 'B.26.docx', url: 'u' }, { autor: 'Fuentes', promocion: 'LXXI', anio: 2022, numeracion: 'antigua', fichero: '26B.docx', url: 'v' }] },
        },
        dce: {},
      }),
      skill: async (ruta) => ({ 'SKILL.md': '# Prepara con Claude', 'references/agentes/dudas.md': '# Dudas', 'references/temas/3A08/ficha.md': '# Ficha' } as Record<string, string>)[ruta] ?? null,
      desconectar: async () => {
        desconectado = true;
      },
    };
  });

  it('lista las herramientas del diseño', async () => {
    const c = await cliente(ctx);
    const nombres = (await c.listTools()).tools.map((t) => t.name).sort();
    expect(nombres).toEqual(['desconectar', 'guardar_informe_cante', 'leer_skill', 'fuentes_tema', 'buscar_temario', 'leer_cantes', 'leer_canon', 'leer_cronograma', 'leer_ficha', 'leer_guia_dictamen', 'leer_progreso', 'leer_resultados_test', 'leer_tema', 'listar_temas_revisados', 'proponer_cronograma'].sort());
  });

  it('leer_skill carga SKILL.md con la nota del conector, los ficheros citados y rechaza rutas raras', async () => {
    const c = await cliente(ctx);
    const texto = (r: unknown) => ((r as { content: Array<{ text: string }> }).content[0].text);
    const s = texto(await c.callTool({ name: 'leer_skill', arguments: {} }));
    expect(s).toContain('# Prepara con Claude');
    expect(s).toContain('leer_skill(ruta)');
    expect(texto(await c.callTool({ name: 'leer_skill', arguments: { ruta: './references/agentes/dudas.md' } }))).toBe('# Dudas');
    expect(texto(await c.callTool({ name: 'leer_skill', arguments: { ruta: 'references/temas/3A08/ficha.md' } }))).toContain('Material exclusivo');
    const malo = await c.callTool({ name: 'leer_skill', arguments: { ruta: '../../index.html' } });
    expect(malo.isError).toBe(true);
    const falta = await c.callTool({ name: 'leer_skill', arguments: { ruta: 'references/no-existe.md' } });
    expect(falta.isError).toBe(true);
    const info = c.getInstructions();
    expect(info).toContain('leer_skill()');
  });

  it('fuentes_tema reúne las fuentes y avisa de la numeración antigua; buscar_temario agrupa por bloque', async () => {
    const c = await cliente(ctx);
    const f = json(await c.callTool({ name: 'fuentes_tema', arguments: { tema: '3b26' } }));
    expect(f.tema).toBe('3.B.26');
    expect((f.atcee as Obj[])[1].ojo).toContain('numeración antigua');
    expect((f.manuales as Obj[]).map((m) => m.bloque)).toEqual(['Microeconomía y organización industrial']);
    const b = json(await c.callTool({ name: 'buscar_temario', arguments: { consulta: 'teoría microeconómica' } }));
    expect((b.bloques as Obj[])[0].bloque).toBe('Modelo neoclásico básico');
    const nada = await c.callTool({ name: 'buscar_temario', arguments: { consulta: 'astronomía' } });
    expect(nada.isError).toBe(true);
  });

  it('leer_progreso devuelve el formato de la skill y respeta la oposición', async () => {
    const c = await cliente(ctx);
    const p = json(await c.callTool({ name: 'leer_progreso', arguments: {} }));
    expect(p.oposicion).toBe('tcee');
    expect((p.temas as Obj).estudiados).toEqual(['3.A.1']);
    expect((p.examen as Obj).fechas).toEqual({ '3': '2027-06-15' });
    expect(p.notas).toEqual({ '3.A.8': 'nota' });
    const d = json(await c.callTool({ name: 'leer_progreso', arguments: { oposicion: 'dce' } }));
    expect((d.temas as Obj).estudiados).toEqual(['1.A.1']);
  });

  it('leer_resultados_test ordena, limita, filtra por fecha y calcula el acierto por tema', async () => {
    const c = await cliente(ctx);
    const r = json(await c.callTool({ name: 'leer_resultados_test', arguments: { limite: 5 } })) as { tests: Obj[] };
    expect(r.tests.map((t) => t.id)).toEqual(['r1', 'r0']);
    expect(r.tests[0].porTema).toEqual({ '3.A.8': { correctas: 1, incorrectas: 0, sinResponder: 0 } });
    const desde = json(await c.callTool({ name: 'leer_resultados_test', arguments: { desde: '2026-10-01' } })) as { tests: Obj[] };
    expect(desde.tests.map((t) => t.id)).toEqual(['r1']);
  });

  it('leer_cantes y leer_cronograma', async () => {
    const c = await cliente(ctx);
    const r = json(await c.callTool({ name: 'leer_cantes', arguments: { n: 5 } })) as { hechos: Obj[]; pendientes: Obj[] };
    expect(r.hechos.map((x) => x.id)).toEqual(['c1']);
    expect(r.pendientes).toEqual([]); // 2026-10-20 ya pasó respecto a «ahora» en la prueba (fecha real)
    const cr = json(await c.callTool({ name: 'leer_cronograma', arguments: {} })) as { cronograma: Obj };
    expect(cr.cronograma.id).toBe('viejo');
  });

  it('proponer_cronograma archiva el anterior y escribe el nuevo con manual:true', async () => {
    const c = await cliente(ctx);
    const r = await c.callTool({ name: 'proponer_cronograma', arguments: { ejercicio: 3, diaCante: 6, semanas: [{ cante: '2026-11-07', temas: ['3.A.8'] }] } });
    expect(r.isError).toBeFalsy();
    const salida = json(r);
    expect(salida.guardado).toBe(true);
    expect(salida.archivados).toEqual(['viejo']);
    expect(db.escrituras[0]).toMatchObject({ ruta: 'cronogramas/viejo', soloCampos: ['archivado', 'updatedAt'] });
    expect(db.escrituras[0].datos.archivado).toBe(true);
    const nuevo = db.docs.get(`cronogramas/${salida.id as string}`)!;
    expect(nuevo).toMatchObject({ manual: true, archivado: false, diaCante: 6, temas: ['3.A.8'], semanas: [{ lunes: '2026-11-01T00:00:00.000', temas: ['3.A.8'] }] });
    expect(db.docs.get('cronogramas/viejo')!.archivado).toBe(true);
  });

  it('proponer_cronograma no escribe nada si hay errores', async () => {
    const c = await cliente(ctx);
    const r = await c.callTool({ name: 'proponer_cronograma', arguments: { ejercicio: 3, diaCante: 6, semanas: [{ cante: '2026-11-08', temas: ['3.A.8'] }] } });
    expect(r.isError).toBe(true);
    expect(texto(r)).toContain('no cae en el día de cante');
    expect(db.escrituras).toEqual([]);
  });

  it('guardar_informe_cante escribe el informe y actualiza el resultado del cante hecho', async () => {
    const c = await cliente(ctx);
    const r = json(await c.callTool({ name: 'guardar_informe_cante', arguments: { canteId: 'c1', informe: '# Informe', valoracion: 3, comentarios: 'Mejor' } }));
    expect(r.guardado).toBe(true);
    expect(r.diarioActualizado).toBe(true);
    const informe = db.escrituras.find((e) => e.ruta.startsWith('cantes/c1/informes/'))!;
    expect(informe.datos).toMatchObject({ origen: 'claude', informe: '# Informe', valoracion: 3, comentarios: 'Mejor' });
    const cante = db.docs.get('cantes/c1')!;
    expect(cante.resultado).toEqual({ temaCantado: '3.A.8', valoracion: 3, comentarios: 'Mejor' });
    expect(cante.updatedAt).not.toBe('2026-10-10T19:00:00.000');
  });

  it('guardar_informe_cante en un cante pendiente guarda el informe pero no el diario; en uno inexistente, error', async () => {
    const c = await cliente(ctx);
    const r = json(await c.callTool({ name: 'guardar_informe_cante', arguments: { canteId: 'c2', informe: 'x', valoracion: 4 } }));
    expect(r.diarioActualizado).toBe(false);
    expect(db.docs.get('cantes/c2')!.resultado).toBeUndefined();
    const e = await c.callTool({ name: 'guardar_informe_cante', arguments: { canteId: 'nada', informe: 'x' } });
    expect(e.isError).toBe(true);
  });

  it('contenido exclusivo: índice, tema entero o por apartado, ficha, guía y errores claros', async () => {
    const c = await cliente(ctx);
    const i = json(await c.callTool({ name: 'listar_temas_revisados', arguments: {} })) as { temas: Obj[] };
    expect(i.temas[0].codigo).toBe('3A08');
    const t = texto(await c.callTool({ name: 'leer_tema', arguments: { tema: '3.A.8', apartado: 'I' } }));
    expect(t).toContain('Material exclusivo');
    expect(t).toContain('Completitud');
    expect(t).not.toContain('Hola');
    const entero = texto(await c.callTool({ name: 'leer_tema', arguments: { tema: '3A08' } }));
    expect(entero).toContain('Apartados: Introducción (2′30″) · I. Axiomas (11′)');
    const f = texto(await c.callTool({ name: 'leer_ficha', arguments: { tema: '3.A.8' } }));
    expect(f).toContain('Resumen.');
    const g = texto(await c.callTool({ name: 'leer_guia_dictamen', arguments: { seccion: '1' } }));
    expect(g).toContain('Qué es');
    const no = await c.callTool({ name: 'leer_tema', arguments: { tema: '3.A.9' } });
    expect(no.isError).toBe(true);
    expect(texto(no)).toContain('no está entre los revisados');
    const canon = await c.callTool({ name: 'leer_canon', arguments: {} });
    expect(canon.isError).toBe(true);
  });

  it('desconectar llama al contexto', async () => {
    const c = await cliente(ctx);
    const r = json(await c.callTool({ name: 'desconectar', arguments: { confirmar: true } }));
    expect(r.desconectado).toBe(true);
    expect(desconectado).toBe(true);
  });

  it('una sesión caducada se explica sin romper', async () => {
    ctx.almacen = async () => {
      throw new ErrorSesion('token revocado');
    };
    const c = await cliente(ctx);
    const r = await c.callTool({ name: 'leer_progreso', arguments: {} });
    expect(r.isError).toBe(true);
    expect(texto(r)).toContain('vuelva a conectar');
  });
});
