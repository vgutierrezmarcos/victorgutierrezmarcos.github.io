// Clases con el preparador: lógica pura (clases.ts) y las herramientas preparar_clase y
// agendar_clase con un Firestore simulado que tiene la red, un preparador y un alumno.
import { Client } from '@modelcontextprotocol/sdk/client/index.js';
import { InMemoryTransport } from '@modelcontextprotocol/sdk/inMemory.js';
import { beforeEach, describe, expect, it } from 'vitest';
import { ahoraMadrid, compararCodigos, construirReserva, construirSesion, copiaParaAlumno, fechaClase, fijarTemasClase, huecosLibres, temasDelCante } from '../src/clases';
import { Contenido } from '../src/contenido';
import { temasDePreguntas } from '../src/datos';
import { type AlmacenDatos, type Consulta, ErrorFirestore, type Json } from '../src/firestore';
import { type Contexto, crearServidor } from '../src/herramientas';

type Obj = { [k: string]: Json };

/** Toda la base en memoria, por ruta absoluta; cada almacén es una vista con su raíz. */
class Base {
  docs = new Map<string, Obj>();
  /** Rutas (prefijos) en las que la regla niega la escritura, como haría Firestore con un 403. */
  prohibidas: string[] = [];
}
class Vista implements AlmacenDatos {
  constructor(private readonly base: Base, private readonly raiz: string) {}
  private abs = (r: string) => [this.raiz, r].filter(Boolean).join('/');
  async leer(ruta: string) {
    return this.base.docs.get(this.abs(ruta)) ?? null;
  }
  async listar(coleccion: string) {
    const prefijo = `${this.abs(coleccion)}/`;
    return [...this.base.docs.entries()].filter(([r]) => r.startsWith(prefijo) && !r.slice(prefijo.length).includes('/')).map(([r, datos]) => ({ id: r.slice(prefijo.length), datos }));
  }
  async consultar(coleccion: string, c: Consulta) {
    const out = await this.listar(coleccion);
    return c.where ? out.filter((d) => d.datos[c.where!.campo] === c.where!.valor) : out;
  }
  async escribir(ruta: string, datos: Obj, soloCampos?: string[]) {
    const abs = this.abs(ruta);
    if (this.base.prohibidas.some((p) => abs.startsWith(p))) throw new ErrorFirestore(403, 'Missing or insufficient permissions.');
    if (!soloCampos) return void this.base.docs.set(abs, datos);
    const actual = { ...(this.base.docs.get(abs) ?? {}) };
    for (const campo of soloCampos) actual[campo] = datos[campo];
    this.base.docs.set(abs, actual);
  }
}

describe('clases.ts', () => {
  it('fechaClase y ahoraMadrid dan horas de Madrid sin zona', () => {
    expect(fechaClase('2026-11-04', '18:00')).toBe('2026-11-04T18:00:00.000');
    expect(fechaClase('2026-11-04', '9.30')).toBe('2026-11-04T09:30:00.000');
    expect(fechaClase('2026-02-30', '18:00')).toBeNull();
    expect(fechaClase('2026-11-04', '25:00')).toBeNull();
    expect(ahoraMadrid(new Date('2026-07-01T10:00:00Z'))).toBe('2026-07-01T12:00:00.000'); // verano: UTC+2
    expect(ahoraMadrid(new Date('2026-12-01T10:00:00Z'))).toBe('2026-12-01T11:00:00.000'); // invierno: UTC+1
  });

  it('huecosLibres quita lo pasado, lo ocupado y lo ya pedido', () => {
    // 2026-11-02 es lunes. Franja los lunes a las 18:00 (1080 min) de 120 minutos.
    const pub = { activo: true, huecos: [{ diaSemana: 1, minutoDelDia: 1080, minutos: 120 }], ocupados: [{ inicio: '2026-11-09T18:30:00.000', minutos: 60 }] };
    const libres = huecosLibres(pub, ['2026-11-16T18:00:00.000'], '2026-11-02T19:00:00.000', 4);
    expect(libres.map((h) => h.inicio)).toEqual(['2026-11-23T18:00:00.000']);
    expect(huecosLibres({ ...pub, activo: false }, [], '2026-11-01T00:00:00.000')).toEqual([]);
  });

  it('temasDelCante coge la semana cuyo cante cae más cerca y quita los desmarcados', () => {
    const crono: Obj = { semanas: [{ lunes: '2026-11-02T00:00:00.000', temas: ['3.A.8', '3.A.9'] }, { lunes: '2026-11-09T00:00:00.000', temas: ['3.A.10'], descanso: true }], desmarcados: ['3.A.9'] };
    expect(temasDelCante(crono, '2026-11-07')).toEqual(['3.A.8']); // cante el domingo 8
    expect(temasDelCante(crono, '2026-11-15')).toBeNull(); // descanso
    expect(temasDelCante(crono, '2026-12-20')).toBeNull(); // fuera
  });

  it('fijarTemasClase sustituye la de esa clase, ordena los códigos y guarda cuándo se fijaron', () => {
    expect(['3.A.10', '3.A.2', '3.B.1'].sort(compararCodigos)).toEqual(['3.A.2', '3.A.10', '3.B.1']);
    const r = fijarTemasClase(['res_x@2026-10-01T10:00:00.000@3.A.1', 'otra@2026-10-02T10:00:00.000@3.B.1'], 'res_x', '2026-10-30T12:00:00.000', ['3.A.10', '3.A.2']);
    expect(r).toEqual(['otra@2026-10-02T10:00:00.000@3.B.1', 'res_x@2026-10-30T12:00:00.000@3.A.2,3.A.10']);
  });

  it('la reserva, la sesión y la copia del alumno llevan los campos de la app', () => {
    const p = { fecha: '2026-11-04T18:00:00.000', minutos: 120, modalidad: 'online' as const, temas: ['3.A.8'], nota: 'ver Slutsky' };
    const r = construirReserva('r1', p, 'prep', 'alu', 'Ana', '2026-10-30T11:00:00.000Z');
    expect(r).toMatchObject({ id: 'r1', preparador: 'prep', alumno: 'alu', alumnoNombre: 'Ana', fecha: p.fecha, minutos: 120, nota: 'ver Slutsky', modalidad: 'online', temas: ['3.A.8'], estado: 'pedida' });
    const s = construirSesion('s1', p, 'alu', 3, 30, { nombre: 'Víctor', minutosClase: 120, plataforma: '', numTemas: 1 }, '2026-10-30T11:00:00.000Z');
    expect(s).toMatchObject({ id: 's1', modalidad: 'online', plataforma: 'meet', bolsa: 'estudiados', estado: 'pendiente', alumno: 'alu', numTemas: 1, exposicion: 30, temasPropuestos: ['3.A.8'] });
    expect(s).not.toHaveProperty('lugar');
    const c = copiaParaAlumno({ ...s, eventoGoogle: 'ev' }, 'prep', 'Víctor');
    expect(c).toMatchObject({ titulo: 'Con Víctor', preparador: 'prep', preparadorNombre: 'Víctor' });
    expect(c).not.toHaveProperty('alumno');
    expect(c).not.toHaveProperty('eventoGoogle');
  });
});

describe('preparar_clase y agendar_clase', () => {
  let base: Base;
  let ctx: (uid: string) => Contexto;
  const llamar = async (uid: string, nombre: string, args: Obj) => {
    const servidor = crearServidor(ctx(uid));
    const [a, b] = InMemoryTransport.createLinkedPair();
    await servidor.connect(a);
    const c = new Client({ name: 'prueba', version: '0' });
    await c.connect(b);
    const r = await c.callTool({ name: nombre, arguments: args });
    const t = (r.content as Array<{ text: string }>)[0].text;
    return { error: r.isError === true, texto: t, datos: r.isError ? null : (JSON.parse(t) as Obj) };
  };
  const anio = new Date().getUTCFullYear() + 1;

  beforeEach(() => {
    base = new Base();
    // Opositora «alu» enlazada con el preparador «prep» (TCEE)
    base.docs.set('users/alu/preparadores/prep', { uid: 'prep', nombre: 'Víctor', aceptado: true });
    base.docs.set('preparadores/prep/alumnos/alu', { uid: 'alu', nombre: 'Ana', aceptado: true });
    base.docs.set('huecos/prep', { activo: true, nombre: 'Víctor', huecos: [1, 2, 3, 4, 5, 6, 7].map((d) => ({ diaSemana: d, minutoDelDia: 1080, minutos: 120 })), ocupados: [] });
    base.docs.set('users/alu/cronogramas/c1', { archivado: false, compartir: true, creado: '2026-01-01T00:00:00.000', semanas: [{ lunes: `${anio}-03-01T00:00:00.000`, temas: ['3.A.8', '3.A.9'] }] });
    base.docs.set('users/alu/progress/settings', { temasClases: [], temasEstudiados: ['3.A.1'] });
    // El preparador, verificado, con la ficha de Ana
    base.docs.set('users/prep/progress/preparador', { activo: true, nombre: 'Víctor', minutosClase: 90, plataforma: 'meet' });
    base.docs.set('preparadoresVerificados/prep', { activo: true });
    base.docs.set('users/prep/alumnos/alu', { id: 'alu', nombre: 'Ana', uid: 'alu', ejercicio: 3, borrado: false });
    ctx = (uid) => ({
      uid,
      email: `${uid}@example.org`,
      almacen: async (op) => new Vista(base, op === 'tcee' ? `users/${uid}` : `users/${uid}/oposiciones/${op}`),
      almacenEn: async (raiz) => new Vista(base, raiz),
      banco: async () => temasDePreguntas({ preguntas: [] }),
      contenido: new Contenido({ get: async () => null }),
      skill: async () => null,
      fuentes: async () => ({ aviso: '', bloques: [], tcee: {}, dce: {} }),
      apuntes: async () => ({ formato: 'docx', esquema: [], texto: '' }),
      textos: async () => null,
      pagina: async () => null,
      cliente: async () => 'Claude',
      desconectar: async () => undefined,
    });
  });

  it('como opositor ve a su preparador con huecos y los temas del cronograma para ese día', async () => {
    // El 1 de marzo de ${anio}+6 días es el cante de esa semana: los temas se piden para el día 6
    const r = await llamar('alu', 'preparar_clase', { dia: `${anio}-03-06` });
    expect(r.error).toBe(false);
    const op = r.datos!.como_opositor as Obj;
    const prep = (op.preparadores as Obj[])[0];
    expect(prep).toMatchObject({ uid: 'prep', nombre: 'Víctor', aceptado: true, reservas_abiertas: true, minutos_por_defecto: 120 });
    expect((prep.huecos_libres as Obj[]).length).toBeGreaterThan(10);
    expect((op.temas_del_cronograma as Obj)[`${anio}-03-06`]).toEqual(['3.A.8', '3.A.9']);
    expect(r.datos!.como_preparador).toBeUndefined();
  });

  it('como opositor pide la reserva con modalidad y temas y los fija en su agenda', async () => {
    const r = await llamar('alu', 'agendar_clase', { como: 'opositor', con: 'prep', dia: `${anio}-03-06`, hora: '18:00', modalidad: 'online', temas: ['3.A.9', '3.A.8'], nota: 'Slutsky' });
    expect(r.error).toBe(false);
    const id = r.datos!.reserva as string;
    expect(base.docs.get(`reservas/${id}`)).toMatchObject({ preparador: 'prep', alumno: 'alu', alumnoNombre: 'Ana', fecha: `${anio}-03-06T18:00:00.000`, minutos: 120, modalidad: 'online', temas: ['3.A.9', '3.A.8'], estado: 'pedida' });
    const ajustes = base.docs.get('users/alu/progress/settings')!;
    expect((ajustes.temasClases as string[])[0]).toMatch(new RegExp(`^res_${id}@.+@3\\.A\\.8,3\\.A\\.9$`));
    expect(ajustes.temasEstudiados).toEqual(['3.A.1']); // el resto de los ajustes no se toca
  });

  it('no pide clase a quien no es su preparador, ni en el pasado, ni si pisa otra suya sin confirmarlo', async () => {
    expect((await llamar('alu', 'agendar_clase', { como: 'opositor', con: 'otro', dia: `${anio}-03-06`, hora: '18:00', modalidad: 'online' })).error).toBe(true);
    expect((await llamar('alu', 'agendar_clase', { como: 'opositor', con: 'prep', dia: '2020-03-06', hora: '18:00', modalidad: 'online' })).texto).toContain('futuras');
    base.docs.set('users/alu/cantes/x', { id: 'x', fecha: `${anio}-03-06T19:00:00.000`, minutos: 60, estado: 'pendiente', preparadorNombre: 'Otra' });
    const choque = await llamar('alu', 'agendar_clase', { como: 'opositor', con: 'prep', dia: `${anio}-03-06`, hora: '18:00', modalidad: 'presencial' });
    expect(choque.texto).toContain('Pisa otra clase');
    expect((await llamar('alu', 'agendar_clase', { como: 'opositor', con: 'prep', dia: `${anio}-03-06`, hora: '18:00', modalidad: 'presencial', aunque_choque: true })).error).toBe(false);
  });

  it('como preparador ve a sus alumnos y el cronograma compartido del alumno', async () => {
    const r = await llamar('prep', 'preparar_clase', { con: 'alu', dia: `${anio}-03-06` });
    expect(r.error).toBe(false);
    const p = r.datos!.como_preparador as Obj;
    expect(p).toMatchObject({ nombre: 'Víctor', verificado: true, minutos_por_defecto: 90 });
    expect((p.alumnos as Obj[])[0]).toMatchObject({ id: 'alu', nombre: 'Ana', enlazado: true });
    expect(((p.alumno as Obj).temas_del_cronograma as Obj)[`${anio}-03-06`]).toEqual(['3.A.8', '3.A.9']);
  });

  it('como preparador crea la sesión y la copia en la agenda del alumno, con los temas propuestos', async () => {
    const r = await llamar('prep', 'agendar_clase', { como: 'preparador', con: 'alu', dia: `${anio}-03-06`, hora: '17:30', modalidad: 'presencial', lugar: 'Despacho', temas: ['3.A.8'] });
    expect(r.error).toBe(false);
    expect(r.datos!.en_la_agenda_del_alumno).toBe(true);
    const id = r.datos!.sesion as string;
    expect(base.docs.get(`users/prep/sesiones/${id}`)).toMatchObject({ alumno: 'alu', fecha: `${anio}-03-06T17:30:00.000`, minutos: 90, modalidad: 'presencial', lugar: 'Despacho', temasPropuestos: ['3.A.8'], numTemas: 1, exposicion: 30 });
    expect(base.docs.get(`users/alu/cantes/${id}`)).toMatchObject({ preparador: 'prep', preparadorNombre: 'Víctor', titulo: 'Con Víctor', temasPropuestos: ['3.A.8'] });
  });

  it('si la regla niega la copia, la clase queda en la agenda del preparador y lo avisa', async () => {
    base.prohibidas.push('users/alu/cantes');
    const r = await llamar('prep', 'agendar_clase', { como: 'preparador', con: 'alu', dia: `${anio}-03-06`, hora: '17:30', modalidad: 'online' });
    expect(r.datos).toMatchObject({ creada: true, en_la_agenda_del_alumno: false });
    expect(r.datos!.aviso as string).toContain('próxima vez');
  });

  it('quien no es preparador no puede crear sesiones', async () => {
    const r = await llamar('alu', 'agendar_clase', { como: 'preparador', con: 'prep', dia: `${anio}-03-06`, hora: '17:30', modalidad: 'online' });
    expect(r.texto).toContain('no eres preparador');
  });
});
