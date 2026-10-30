// Transformaciones puras entre los documentos de Firestore (tal como los guarda la
// app: ver app/lib/data/models) y el JSON que entiende la skill del equipo de preparación
// (claude/prepara-con-claude/references/datos-app.md, oposicion_<id>_para_claude.json).
// Sin red: todo lo que entra viene ya leído, y por eso se prueba sin Firestore.

import type { Json } from './firestore';

type Obj = { [k: string]: Json };

const esObj = (v: Json | undefined): v is Obj => typeof v === 'object' && v !== null && !Array.isArray(v);
const texto = (v: Json | undefined, defecto = ''): string => (typeof v === 'string' ? v : defecto);
const numero = (v: Json | undefined, defecto = 0): number => (typeof v === 'number' ? v : defecto);
const lista = (v: Json | undefined): string[] => (Array.isArray(v) ? v.map((x) => String(x)) : []);
const objeto = (v: Json | undefined): Obj => (esObj(v) ? v : {});

/** «2026-10-05» de un texto ISO (con o sin hora). */
export function soloFecha(iso: Json | undefined): string | null {
  if (typeof iso !== 'string' || iso.length < 10) return null;
  return iso.slice(0, 10);
}

/** «18:02» de un texto ISO con hora; null si no la lleva. */
export function soloHora(iso: Json | undefined): string | null {
  if (typeof iso !== 'string' || iso.length < 16 || iso[10] !== 'T') return null;
  return iso.slice(11, 16);
}

/** La fecha de un día en el formato de `DateTime(y, m, d).toIso8601String()` de Dart (hora local, sin zona). */
export function isoDia(d: Date): string {
  const p = (n: number) => String(n).padStart(2, '0');
  return `${d.getUTCFullYear()}-${p(d.getUTCMonth() + 1)}-${p(d.getUTCDate())}T00:00:00.000`;
}

/** Lee «AAAA-MM-DD» como fecha UTC a las 0:00 (solo se usa para aritmética de días). */
export function diaDe(texto: string): Date | null {
  const m = /^(\d{4})-(\d{2})-(\d{2})/.exec(texto.trim());
  if (!m) return null;
  const d = new Date(Date.UTC(Number(m[1]), Number(m[2]) - 1, Number(m[3])));
  return d.getUTCMonth() === Number(m[2]) - 1 && d.getUTCDate() === Number(m[3]) ? d : null;
}

/** 1 = lunes … 7 = domingo (como `DateTime.weekday` en Dart). */
export const diaSemana = (d: Date): number => ((d.getUTCDay() + 6) % 7) + 1;

export const masDias = (d: Date, n: number): Date => new Date(d.getTime() + n * 86_400_000);

/** Id como `nuevoId()` de la app: microsegundos en base 36 más un número aleatorio en base 36. */
export function nuevoId(): string {
  const micro = BigInt(Date.now()) * 1000n + BigInt(Math.floor(Math.random() * 1000));
  return micro.toString(36) + Math.floor(Math.random() * 1_073_741_824).toString(36);
}

// ----------------------------------------------------------------- Preguntas

/** Tema(s) de cada pregunta del banco (preguntas.json → id → temas). */
export type TemasPorPregunta = Map<number, string[]>;

export function temasDePreguntas(banco: { preguntas?: Array<{ id: number; temas?: string[]; respuesta?: string[] }> }): {
  temas: TemasPorPregunta;
  respuestas: Map<number, string[]>;
} {
  const temas: TemasPorPregunta = new Map();
  const respuestas = new Map<number, string[]>();
  for (const p of banco.preguntas ?? []) {
    temas.set(p.id, p.temas ?? []);
    respuestas.set(p.id, (p.respuesta ?? []).map((r) => r.toLowerCase()));
  }
  return { temas, respuestas };
}

// --------------------------------------------------------------------- Tests

export interface TestResumen {
  id: string;
  fecha: string | null;
  hora: string | null;
  tipo: string;
  origen: string;
  notaSobre10: number;
  correctas: number;
  incorrectas: number;
  sinResponder: number;
  totalPreguntas: number;
  tiempoSeconds: number;
  temas: string[];
  porTema: Record<string, { correctas: number; incorrectas: number; sinResponder: number }>;
}

/**
 * Acierto por tema de un test a partir de sus respuestas (id de pregunta → letra o
 * null) y del banco. Los tests hechos en la web no guardan respuestas: queda vacío.
 */
export function aciertoPorTema(
  respuestas: Obj,
  banco: { temas: TemasPorPregunta; respuestas: Map<number, string[]> },
): TestResumen['porTema'] {
  const out: TestResumen['porTema'] = {};
  for (const [idTexto, letra] of Object.entries(respuestas)) {
    const id = Number(idTexto);
    const temas = banco.temas.get(id);
    if (!temas) continue;
    const correctas = banco.respuestas.get(id) ?? [];
    const clave = letra === null || letra === '' ? 'sinResponder' : correctas.includes(String(letra).toLowerCase()) ? 'correctas' : 'incorrectas';
    for (const t of temas) {
      out[t] ??= { correctas: 0, incorrectas: 0, sinResponder: 0 };
      out[t][clave]++;
    }
  }
  return out;
}

export function resumenTest(
  id: string,
  d: Obj,
  banco: { temas: TemasPorPregunta; respuestas: Map<number, string[]> },
): TestResumen {
  const fecha = d.timestamp;
  return {
    id,
    fecha: soloFecha(fecha),
    hora: soloHora(fecha),
    tipo: texto(d.tipo, 'test'),
    origen: texto(d.origen, 'web'),
    notaSobre10: Math.round(numero(d.notaSobre10) * 100) / 100,
    correctas: numero(d.correctas),
    incorrectas: numero(d.incorrectas),
    sinResponder: numero(d.sinResponder),
    totalPreguntas: numero(d.totalPreguntas),
    tiempoSeconds: numero(d.tiempoSeconds),
    temas: lista(d.temas),
    porTema: aciertoPorTema(objeto(d.respuestas), banco),
  };
}

// ------------------------------------------------------------------ Leitner

export interface LeitnerResumen {
  porCaja: Record<string, number>;
  vencidas: number;
  sessionCount: number;
  temasConMasFallos: string[];
}

/** Intervalos de cada caja, en sesiones y en días, como en la app (leitner.dart). */
const intervalos: Record<number, number> = { 1: 1, 2: 2, 3: 4, 4: 8 };
const intervalosDias: Record<number, number> = { 1: 1, 2: 3, 3: 7, 4: 15 };

export function resumenLeitner(estado: Obj | null, temasPorPregunta: TemasPorPregunta, ahora = Date.now()): LeitnerResumen {
  const porCaja: Record<string, number> = { '1': 0, '2': 0, '3': 0, '4': 0, '5': 0 };
  const fallosPorTema = new Map<string, number>();
  const sessionCount = numero(estado?.sessionCount);
  let vencidas = 0;
  for (const [idTexto, e] of Object.entries(objeto(estado?.questions))) {
    if (!esObj(e)) continue;
    const box = Math.min(5, Math.max(1, numero(e.box, 1)));
    porCaja[String(box)]++;
    if (box < 5) {
      const porSesiones = sessionCount - numero(e.lastSession) >= (intervalos[box] ?? 1);
      const lastDate = numero(e.lastDate, -1);
      const porDias = lastDate > 0 && (ahora - lastDate) / 86_400_000 >= (intervalosDias[box] ?? 1);
      if (porSesiones || porDias) vencidas++;
    }
    const fallos = numero(e.timesFailed);
    if (fallos > 0) for (const t of temasPorPregunta.get(Number(idTexto)) ?? []) fallosPorTema.set(t, (fallosPorTema.get(t) ?? 0) + fallos);
  }
  const temasConMasFallos = [...fallosPorTema.entries()]
    .sort((a, b) => b[1] - a[1])
    .slice(0, 8)
    .map(([t]) => t);
  return { porCaja, vencidas, sessionCount, temasConMasFallos };
}

// ----------------------------------------------------------------- Progreso

const nombresDias = ['lunes', 'martes', 'miércoles', 'jueves', 'viernes', 'sábado', 'domingo'];
const actividades = ['dormir', 'desayuno', 'comida', 'cena', 'estudio', 'idioma', 'ejercicio', 'descanso'];

/** El horario de la app (7 cadenas de 48 franjas de media hora) como texto por día: «estudio 8:30-11, idioma 13-14». */
export function horarioATexto(horario: Json | undefined): Record<string, string> | null {
  if (!Array.isArray(horario) || horario.length !== 7) return null;
  const out: Record<string, string> = {};
  horario.forEach((dia, i) => {
    if (typeof dia !== 'string' || dia.length !== 48) return;
    const tramos: string[] = [];
    let desde = 0;
    for (let f = 1; f <= 48; f++) {
      if (f === 48 || dia[f] !== dia[desde]) {
        const a = actividades[Number(dia[desde])] ?? '?';
        if (a === 'estudio' || a === 'idioma' || a === 'ejercicio') tramos.push(`${a} ${hora(desde)}-${hora(f)}`);
        desde = f;
      }
    }
    out[nombresDias[i]] = tramos.join(', ') || 'libre';
  });
  return out;
}

const hora = (franja: number): string => `${Math.floor(franja / 2)}${franja % 2 ? ':30' : ''}`;

export interface Progreso {
  oposicion: string;
  generado: string;
  origen: 'conector';
  examen: { fechas: Record<string, string>; hitos: Array<{ titulo: string; fecha: string }> };
  temas: { estudiados: string[]; enRepaso: string[]; agenda: Record<string, { vueltas: string[]; pendientes: string[] }> };
  notas: Record<string, string>;
  horario: Record<string, string> | null;
  leitner: LeitnerResumen;
  ajustes: { rubrica: string[]; temasExtraidos: number; fechaConvocatoria: string | null; noCantar: string[] };
}

export function resumenProgreso(
  oposicion: string,
  settings: Obj | null,
  plan: Obj | null,
  leitner: Obj | null,
  notas: Array<{ id: string; datos: Obj }>,
  temasPorPregunta: TemasPorPregunta,
  ahora = new Date(),
): Progreso {
  const fechas: Record<string, string> = {};
  for (const [k, v] of Object.entries(objeto(plan?.fechas))) {
    const f = soloFecha(v);
    if (f) fechas[k] = f;
  }
  const hitos = (Array.isArray(plan?.hitos) ? plan!.hitos : [])
    .filter(esObj)
    .map((h) => ({ titulo: texto(h.titulo), fecha: soloFecha(h.fecha) ?? '' }))
    .filter((h) => h.fecha);
  const agenda: Progreso['temas']['agenda'] = {};
  const textos: Record<string, string> = {};
  for (const n of notas) {
    const codigo = texto(n.datos.tema, n.id.replace(/_/g, '.'));
    const pendientes = (Array.isArray(n.datos.pendientes) ? n.datos.pendientes : [])
      .filter(esObj)
      .filter((a) => a.hecho == null && a.borrado !== true)
      .map((a) => texto(a.texto))
      .filter(Boolean);
    const vueltas = lista(n.datos.vueltas).map((v) => soloFecha(v) ?? v);
    if (pendientes.length || vueltas.length) agenda[codigo] = { vueltas, pendientes };
    const t = texto(n.datos.texto).trim();
    if (t) textos[codigo] = t;
  }
  const noCantar = lista(settings?.noCantar).map((s) => s.split('@')[0]);
  return {
    oposicion,
    generado: ahora.toISOString(),
    origen: 'conector',
    examen: { fechas, hitos },
    temas: { estudiados: lista(settings?.temasEstudiados), enRepaso: lista(settings?.temasEnRepaso), agenda },
    notas: textos,
    horario: horarioATexto(plan?.horario),
    leitner: resumenLeitner(leitner, temasPorPregunta, ahora.getTime()),
    ajustes: {
      rubrica: lista(settings?.rubrica),
      temasExtraidos: numero(settings?.temasExtraidos, 3),
      fechaConvocatoria: soloFecha(settings?.fechaConvocatoria),
      noCantar,
    },
  };
}

// ------------------------------------------------------------------- Cantes

export interface CanteResumen {
  id: string;
  fecha: string | null;
  hora: string | null;
  ejercicio: number;
  temas: string[];
  exposicion: number;
  minutos: number;
  esquema: boolean;
  titulo: string;
  preparadorNombre: string | null;
  notas: string;
  resultado: Obj | null;
  deberes: Array<{ texto: string; hecha: boolean }>;
}

export function resumenCante(id: string, d: Obj): CanteResumen {
  const tareas = (Array.isArray(d.tareas) ? d.tareas : []).filter(esObj).map((t) => ({
    texto: etiquetaTarea(t),
    hecha: t.hecha === true,
  }));
  return {
    id,
    fecha: soloFecha(d.fecha),
    hora: soloHora(d.fecha),
    ejercicio: numero(d.ejercicio, 3),
    temas: lista(d.temas),
    exposicion: numero(d.exposicion, 30),
    minutos: numero(d.minutos, 30),
    esquema: d.esquema === true,
    titulo: texto(d.titulo),
    preparadorNombre: typeof d.preparadorNombre === 'string' ? d.preparadorNombre : null,
    notas: texto(d.notas),
    resultado: esObj(d.resultado) ? d.resultado : null,
    deberes: tareas,
  };
}

function etiquetaTarea(t: Obj): string {
  const tema = texto(t.tema);
  switch (texto(t.tipo)) {
    case 'estudiar':
      return `Estudiar ${tema}`;
    case 'esquema':
      return `Esquema a ciegas de ${tema}`;
    case 'cantar':
      return `Cantar ${tema} por tu cuenta`;
    case 'test':
      return `Test de ${numero(t.preguntas) > 0 ? `${numero(t.preguntas)} preguntas` : 'preguntas'}${tema ? ` de ${tema}` : ''}`;
    default:
      return texto(t.texto);
  }
}

/** Los últimos `n` cantes hechos (no borrados), del más reciente al más antiguo; `pendientes`, los próximos programados. */
export function resumenCantes(docs: Array<{ id: string; datos: Obj }>, n: number, ahora = new Date()) {
  const vivos = docs.filter((c) => c.datos.borrado !== true);
  const hechos = vivos
    .filter((c) => c.datos.estado === 'hecho')
    .sort((a, b) => texto(b.datos.fecha).localeCompare(texto(a.datos.fecha)))
    .slice(0, n)
    .map((c) => resumenCante(c.id, c.datos));
  const limite = ahora.toISOString();
  const pendientes = vivos
    .filter((c) => c.datos.estado === 'pendiente' && texto(c.datos.fecha) >= limite.slice(0, 10))
    .sort((a, b) => texto(a.datos.fecha).localeCompare(texto(b.datos.fecha)))
    .slice(0, 5)
    .map((c) => resumenCante(c.id, c.datos));
  return { hechos, pendientes, totalHechos: vivos.filter((c) => c.datos.estado === 'hecho').length };
}

// --------------------------------------------------------------- Cronograma

export interface SemanaResumen {
  lunes: string;
  cante: string;
  temas: string[];
  descanso?: true;
}

export interface CronogramaResumen {
  id: string;
  ejercicio: number;
  inicio: string | null;
  fin: string | null;
  temasPorSemana: number;
  diaCante: number | null;
  manual: boolean;
  semanas: SemanaResumen[];
  hechos: Record<string, string>;
  desmarcados: string[];
  fases: Array<{ tipo: string; inicio: string; fin: string; saltada?: boolean }>;
  examen: string | null;
  propuestasPendientes: number;
  creado: string | null;
}

export function resumenCronograma(id: string, d: Obj): CronogramaResumen {
  const semanas: SemanaResumen[] = (Array.isArray(d.semanas) ? d.semanas : []).filter(esObj).map((s) => {
    const lunes = soloFecha(s.lunes) ?? '';
    const dia = diaDe(lunes);
    return {
      lunes,
      cante: dia ? soloFecha(masDias(dia, 6).toISOString()) ?? '' : '',
      temas: lista(s.temas),
      ...(s.descanso === true ? { descanso: true as const } : {}),
    };
  });
  const hechos: Record<string, string> = {};
  for (const [k, v] of Object.entries(objeto(d.hechos))) hechos[k] = soloFecha(v) ?? '';
  const propuestas = Object.keys(objeto(d.propuestas)).length + (esObj(d.propuesta) ? 1 : 0);
  return {
    id,
    ejercicio: numero(d.ejercicio, 3),
    inicio: soloFecha(d.inicio),
    fin: soloFecha(d.fin),
    temasPorSemana: numero(d.temasPorSemana, 3),
    diaCante: typeof d.diaCante === 'number' ? d.diaCante : null,
    manual: d.manual === true,
    semanas,
    hechos,
    desmarcados: lista(d.desmarcados),
    fases: (Array.isArray(d.fases) ? d.fases : []).filter(esObj).map((f) => ({
      tipo: texto(f.tipo),
      inicio: soloFecha(f.inicio) ?? '',
      fin: soloFecha(f.fin) ?? '',
      ...(f.saltada === true ? { saltada: true } : {}),
    })),
    examen: soloFecha(d.examen),
    propuestasPendientes: propuestas,
    creado: soloFecha(d.creado),
  };
}

/** El cronograma activo: el no archivado más reciente (como `cronogramaActivo()` en la app). */
export function cronogramaActivo(docs: Array<{ id: string; datos: Obj }>): { id: string; datos: Obj } | null {
  return (
    docs
      .filter((c) => c.datos.archivado !== true)
      .sort((a, b) => texto(b.datos.creado).localeCompare(texto(a.datos.creado)))[0] ?? null
  );
}

export interface SemanaPropuesta {
  /** Fecha del cante de esa semana, «AAAA-MM-DD». */
  cante: string;
  temas: string[];
}

export interface PropuestaCronograma {
  semanas: SemanaPropuesta[];
  /** 1 = lunes … 7 = domingo. */
  diaCante: number;
  ejercicio: number;
  temasPorSemana?: number;
  /** Fecha del examen (cronogramas por fases de un ejercicio escrito). */
  examen?: string;
}

const reTema = /^\d\.[A-Z]\.\d{1,2}$/;

/**
 * Construye el documento `cronogramas/{id}` exactamente como `Cronograma.toJson()` de
 * la app (app/lib/data/models/cronograma.dart), a partir de las semanas de cante que
 * acordaron el opositor y su IA. Cada semana va del día siguiente a un cante hasta
 * el cante siguiente (`inicioSemana` con `diaCante`); las semanas sin cante entre la
 * primera y la última quedan de descanso. Devuelve los errores en vez de lanzar.
 */
export function construirCronograma(p: PropuestaCronograma, ahora = new Date(), autor = 'IA'): { documento: Obj; errores: string[] } {
  const errores: string[] = [];
  if (!Number.isInteger(p.diaCante) || p.diaCante < 1 || p.diaCante > 7) errores.push('diaCante tiene que ser 1 (lunes) … 7 (domingo)');
  if (![1, 2, 3, 4, 5].includes(p.ejercicio)) errores.push('ejercicio tiene que ser 1-5');
  if (!p.semanas?.length) errores.push('hace falta al menos una semana');
  const porCante = new Map<number, string[]>();
  const vistos = new Set<string>();
  for (const s of p.semanas ?? []) {
    const dia = diaDe(s.cante ?? '');
    if (!dia) {
      errores.push(`fecha de cante no válida: «${s.cante}» (AAAA-MM-DD)`);
      continue;
    }
    if (diaSemana(dia) !== p.diaCante) errores.push(`el cante del ${s.cante} no cae en el día de cante (${p.diaCante})`);
    if (porCante.has(dia.getTime())) errores.push(`la semana del ${s.cante} está repetida`);
    const temas: string[] = [];
    for (const t of s.temas ?? []) {
      const codigo = String(t).trim();
      if (!reTema.test(codigo)) errores.push(`código de tema no válido: «${codigo}» (formato 3.A.8)`);
      else if (vistos.has(codigo)) errores.push(`el tema ${codigo} está en dos semanas`);
      else {
        vistos.add(codigo);
        temas.push(codigo);
      }
    }
    porCante.set(dia.getTime(), temas);
  }
  if (errores.length) return { documento: {}, errores };

  const cantes = [...porCante.keys()].sort((a, b) => a - b);
  const primero = new Date(cantes[0]);
  const ultimo = new Date(cantes[cantes.length - 1]);
  const semanas: Obj[] = [];
  const descansos: string[] = [];
  const temas: string[] = [];
  for (let c = primero; c.getTime() <= ultimo.getTime(); c = masDias(c, 7)) {
    const lunes = isoDia(masDias(c, -6));
    const t = porCante.get(c.getTime());
    if (t && t.length) {
      semanas.push({ lunes, temas: t });
      temas.push(...t);
    } else {
      semanas.push({ lunes, temas: [], descanso: true });
      descansos.push(lunes);
    }
  }
  const conTemas = semanas.filter((s) => s.descanso !== true).length;
  const temasPorSemana = p.temasPorSemana && p.temasPorSemana > 0 ? Math.round(p.temasPorSemana) : Math.max(1, Math.round(temas.length / Math.max(1, conTemas)));
  const marca = ahora.toISOString();
  const documento: Obj = {
    id: nuevoId(),
    ejercicio: p.ejercicio,
    temas,
    inicio: isoDia(masDias(primero, -6)),
    temasPorSemana,
    fin: isoDia(ultimo),
    intercalar: true,
    cadaN: null,
    descansos,
    semanas,
    hechos: {},
    desmarcados: [],
    archivado: false,
    compartir: false,
    propuesta: null,
    propuestaResuelta: null,
    autorNombre: autor,
    creado: marca,
    updatedAt: marca,
    diaCante: p.diaCante,
    manual: true,
  };
  if (p.examen) {
    const ex = diaDe(p.examen);
    if (ex) documento.examen = isoDia(ex);
    else errores.push(`fecha de examen no válida: «${p.examen}»`);
  }
  return { documento, errores };
}

// ------------------------------------------------------------- Informe cante

export interface InformeCante {
  informe: string;
  valoracion?: number;
  valoraciones?: Record<string, number>;
  comentarios?: string;
  criterios?: Record<string, number>;
  tareas?: string[];
}

const nota = (v: unknown): number | null => (typeof v === 'number' && Number.isInteger(v) && v >= 1 && v <= 5 ? v : null);

/** Documento `cantes/{id}/informes/{fecha}` y los campos de `resultado` que cambian (vacío si ninguno). */
export function construirInforme(i: InformeCante, ahora = new Date(), cliente = 'IA'): { id: string; documento: Obj; resultado: Obj; errores: string[] } {
  const errores: string[] = [];
  if (!i.informe || !i.informe.trim()) errores.push('el informe está vacío');
  if (i.informe && i.informe.length > 60_000) errores.push('el informe es demasiado largo (máximo 60.000 caracteres)');
  if (i.valoracion !== undefined && nota(i.valoracion) === null) errores.push('valoracion tiene que ser un entero de 1 a 5');
  const valoraciones: Record<string, number> = {};
  for (const [t, v] of Object.entries(i.valoraciones ?? {})) {
    if (!reTema.test(t) || nota(v) === null) errores.push(`valoración no válida para «${t}»`);
    else valoraciones[t] = v;
  }
  const criterios: Record<string, number> = {};
  for (const [c, v] of Object.entries(i.criterios ?? {})) {
    if (!c.trim() || c.length > 40 || nota(v) === null) errores.push(`criterio no válido: «${c}»`);
    else criterios[c.trim()] = v;
  }
  const comentarios = (i.comentarios ?? '').trim();
  if (comentarios.length > 300) errores.push('comentarios tiene que tener 300 caracteres como mucho');
  const marca = ahora.toISOString();
  const documento: Obj = {
    fecha: marca,
    origen: 'ia',
    cliente,
    informe: i.informe ?? '',
    ...(i.valoracion !== undefined ? { valoracion: i.valoracion } : {}),
    ...(Object.keys(valoraciones).length ? { valoraciones } : {}),
    ...(comentarios ? { comentarios } : {}),
    ...(Object.keys(criterios).length ? { criterios } : {}),
    ...(i.tareas?.length ? { tareas: i.tareas.map(String).slice(0, 10) } : {}),
  };
  const resultado: Obj = {};
  if (i.valoracion !== undefined) resultado.valoracion = i.valoracion;
  if (Object.keys(valoraciones).length) resultado.valoraciones = valoraciones;
  if (comentarios) resultado.comentarios = comentarios;
  if (Object.keys(criterios).length) resultado.criterios = criterios;
  return { id: marca.replace(/[:.]/g, '-').slice(0, 19), documento, resultado, errores };
}
