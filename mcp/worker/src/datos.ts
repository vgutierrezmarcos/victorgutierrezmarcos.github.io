// Transformaciones puras entre los documentos de Firestore (tal como los guarda la
// app: ver app/lib/data/models) y el JSON que entiende la skill del equipo de preparación
// (claude/prepara-con-claude/references/datos-app.md, oposicion_<id>_para_claude.json).
// Sin red: todo lo que entra viene ya leído, y por eso se prueba sin Firestore.

import type { Json } from './firestore';
import { ahoraMadrid } from './clases';

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

/** Una pregunta oficial del banco, con lo que hace falta para plantearla. */
export interface PreguntaBanco {
  id: number;
  examen: string;
  numero: number;
  temas: string[];
  enunciado: string;
  opciones: Record<string, string>;
  respuesta: string[];
  /** Lleva figura. */
  figura: boolean;
  /** Sus figuras: dirección de la imagen en la web y la descripción en texto (el «alt»), con la que se puede contestar sin verla. */
  figuras?: Array<{ url: string; descripcion?: string }>;
  nota?: string;
  /** «banco»: pregunta no oficial del banco de EconomIA (las oficiales no llevan este campo). */
  tipo?: 'banco';
  /** Solo en las del banco: la explicación va con la pregunta (las oficiales la tienen en explicaciones/<examen>.json). */
  porQue?: string;
}

/** Las preguntas del banco propio (no oficiales) valen de 100000 en adelante: nunca chocan con las oficiales. */
export const PRIMER_ID_BANCO = 100_000;

/**
 * El banco propio tal como lo publica scripts/banco-test.py en el KV (banco/preguntas.json):
 * mismas claves que preguntas.json más `explicacion: { clave, desarrollo }`.
 */
export function bancoPropioDe(datos: { preguntas?: Array<{ id: number; temas?: string[]; enunciado?: string; opciones?: Record<string, string>; respuesta?: string[]; explicacion?: { clave?: string }; imagenes?: unknown[]; nota?: string }> } | null): Map<number, PreguntaBanco> {
  const out = new Map<number, PreguntaBanco>();
  for (const p of datos?.preguntas ?? []) {
    if (!(p.id >= PRIMER_ID_BANCO) || !p.enunciado || !p.opciones || !p.respuesta?.length) continue;
    out.set(p.id, {
      id: p.id, examen: 'banco', numero: p.id % 100, temas: p.temas ?? [], enunciado: p.enunciado, opciones: p.opciones,
      respuesta: p.respuesta.map((r) => r.toLowerCase()), figura: (p.imagenes?.length ?? 0) > 0,
      ...(figurasDe(p.imagenes).length ? { figuras: figurasDe(p.imagenes) } : {}), ...(p.nota ? { nota: p.nota } : {}),
      tipo: 'banco', ...(p.explicacion?.clave ? { porQue: p.explicacion.clave } : {}),
    });
  }
  return out;
}

const URL_TEST = 'https://www.victorgutierrezmarcos.es/oposicion/temario/primer-ejercicio/test/';

/** Las imágenes de una pregunta del banco ({src, alt}) con la dirección completa. */
export function figurasDe(imagenes: unknown[] | undefined): Array<{ url: string; descripcion?: string }> {
  const out: Array<{ url: string; descripcion?: string }> = [];
  for (const i of imagenes ?? []) {
    const src = typeof i === 'string' ? i : (i as { src?: unknown })?.src;
    if (typeof src !== 'string' || !src) continue;
    const alt = typeof i === 'object' && i ? (i as { alt?: unknown }).alt : undefined;
    out.push({ url: /^https?:/.test(src) ? src : URL_TEST + src.replace(/^\.?\//, ''), ...(typeof alt === 'string' && alt ? { descripcion: alt } : {}) });
  }
  return out;
}

export function temasDePreguntas(banco: { preguntas?: Array<{ id: number; temas?: string[]; respuesta?: string[]; examen?: string; numero?: number; enunciado?: string; opciones?: Record<string, string>; imagenes?: unknown[]; nota?: string }> }): {
  temas: TemasPorPregunta;
  respuestas: Map<number, string[]>;
  preguntas: Map<number, PreguntaBanco>;
} {
  const temas: TemasPorPregunta = new Map();
  const respuestas = new Map<number, string[]>();
  const preguntas = new Map<number, PreguntaBanco>();
  for (const p of banco.preguntas ?? []) {
    const respuesta = (p.respuesta ?? []).map((r) => r.toLowerCase());
    temas.set(p.id, p.temas ?? []);
    respuestas.set(p.id, respuesta);
    if (p.enunciado && p.opciones)
      preguntas.set(p.id, { id: p.id, examen: p.examen ?? '', numero: Number(p.numero ?? 0), temas: p.temas ?? [], enunciado: p.enunciado, opciones: p.opciones, respuesta, figura: (p.imagenes?.length ?? 0) > 0, ...(figurasDe(p.imagenes).length ? { figuras: figurasDe(p.imagenes) } : {}), ...(p.nota ? { nota: p.nota } : {}) });
  }
  return { temas, respuestas, preguntas };
}

/**
 * Preguntas oficiales de unos temas para un test a medida, según lo que el opositor ya ha hecho
 * (`progress/spaced_repetition.questions`): «falladas» (solo las que ha fallado, las más falladas primero),
 * «no_dominadas» (fuera las que tiene acertadas dos veces sin fallo o en las cajas 4-5; primero las falladas,
 * luego las que no ha visto) o «todas». Las anuladas (sin respuesta) no entran. `azar` ordena las no vistas.
 */
export function elegirPreguntas(
  banco: Map<number, PreguntaBanco>,
  temas: string[],
  n: number,
  modo: 'falladas' | 'no_dominadas' | 'todas',
  leitner: Obj | null,
  azar: () => number = Math.random,
): Array<PreguntaBanco & { aciertos: number; fallos: number }> {
  const quiere = new Set(temas);
  const estado = objeto(leitner?.questions);
  const candidatas = [...banco.values()]
    .filter((p) => p.respuesta.length > 0 && p.temas.some((t) => quiere.has(t)))
    .map((p) => {
      const e = objeto(estado[String(p.id)]);
      return { ...p, aciertos: numero(e.timesCorrect), fallos: numero(e.timesFailed), caja: numero(e.box, 0), orden: azar() };
    })
    .filter((p) => (modo === 'falladas' ? p.fallos > 0 : modo === 'no_dominadas' ? !((p.aciertos >= 2 && p.fallos === 0) || p.caja >= 4) : true));
  candidatas.sort((a, b) => b.fallos - a.fallos || (a.aciertos + a.fallos === 0 ? 0 : 1) - (b.aciertos + b.fallos === 0 ? 0 : 1) || a.orden - b.orden);
  return candidatas.slice(0, n).map(({ caja: _c, orden: _o, ...p }) => p);
}

/**
 * Corrige contra el banco lo que el usuario contestó en un test del conector (id de pregunta → letra) y lo deja
 * con el esquema de exam_results de la app y la web (app/lib/data/models/resultado.dart; acierto 1, fallo −0,33).
 * `banco` lleva las oficiales y, si las hay, las del banco propio (no oficiales): las respuestas de estas van aparte
 * (`respuestasBanco`), porque la app busca cada id de `respuestas` en el banco oficial, y el test dice de qué está hecho
 * (`fuente`: oficiales, banco o mixto). Las preguntas que no están en ningún banco (las que genera la IA) se ignoran.
 */
export function corregirTest(respuestas: Record<string, string>, banco: Map<number, PreguntaBanco>, segundos = 0) {
  const oficiales: Array<{ id: number; ok: boolean }> = [];
  const propias: Array<{ id: number; ok: boolean }> = [];
  const limpias: Record<string, string> = {};
  const limpiasBanco: Record<string, string> = {};
  const temas = new Set<string>();
  for (const [idTexto, letra] of Object.entries(respuestas)) {
    const p = banco.get(Number(idTexto));
    if (!p || !p.respuesta.length) continue;
    const marcada = letra.toLowerCase();
    (p.tipo === 'banco' ? limpiasBanco : limpias)[String(p.id)] = marcada;
    (p.tipo === 'banco' ? propias : oficiales).push({ id: p.id, ok: p.respuesta.includes(marcada) });
    p.temas.forEach((t) => temas.add(t));
  }
  const total = oficiales.length + propias.length;
  const correctas = [...oficiales, ...propias].filter((d) => d.ok).length;
  const incorrectas = total - correctas;
  const puntos = Math.round((correctas - 0.33 * incorrectas) * 100) / 100;
  return {
    oficiales,
    propias,
    resultado: {
      puntosBrutos: puntos,
      maxPuntos: total,
      notaSobre10: total ? Math.round((puntos / total) * 1000) / 100 : 0,
      correctas,
      incorrectas,
      sinResponder: 0,
      totalPreguntas: total,
      tiempoSeconds: segundos,
      temas: [...temas].sort(),
      respuestas: limpias,
      origen: 'ia',
      tipo: 'test',
      fuente: !propias.length ? 'oficiales' : !oficiales.length ? 'banco' : 'mixto',
      ...(propias.length ? { respuestasBanco: limpiasBanco, banco: { correctas: propias.filter((d) => d.ok).length, incorrectas: propias.filter((d) => !d.ok).length } } : {}),
    },
  };
}

/**
 * Repaso espaciado (Leitner) tras un test: réplica de EstadoLeitner.registrarExamen de la app
 * (app/lib/features/test/leitner.dart) y de spaced-repetition.js de la web. Una pregunta nueva solo entra
 * si se falla; acertar sube de caja (hasta la 5), fallar la devuelve a la 1; el test cuenta como una sesión.
 */
export function apuntarLeitner(estado: Obj | null, resultados: Array<{ id: number; ok: boolean }>, ahoraMs: number): Obj {
  const sesion = numero(estado?.sessionCount);
  const preguntas: Obj = { ...objeto(estado?.questions) };
  for (const { id, ok } of resultados) {
    const k = String(id);
    const e = preguntas[k];
    if (!esObj(e)) {
      if (!ok) preguntas[k] = { box: 1, lastSession: sesion, timesCorrect: 0, timesFailed: 1, lastDate: ahoraMs };
      continue;
    }
    preguntas[k] = ok
      ? { ...e, box: Math.min(5, numero(e.box, 1) + 1), timesCorrect: numero(e.timesCorrect) + 1, lastSession: sesion, lastDate: ahoraMs }
      : { ...e, box: 1, timesFailed: numero(e.timesFailed) + 1, lastSession: sesion, lastDate: ahoraMs };
  }
  return { ...(estado ?? {}), questions: preguntas, sessionCount: sesion + 1 };
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

/** Una marca de tiempo de Firestore («…Z», UTC) como hora de Madrid sin zona, que es como guarda la app todas las demás fechas. */
export function aHoraMadrid(iso: Json | undefined): Json | undefined {
  if (typeof iso !== 'string' || !/(Z|[+-]\d\d:\d\d)$/.test(iso)) return iso;
  const d = new Date(iso);
  return Number.isNaN(d.getTime()) ? iso : ahoraMadrid(d);
}

/** El comienzo de un día de Madrid («AAAA-MM-DD») como instante UTC, para filtrar marcas de tiempo. */
export function desdeMadrid(dia: string): string {
  const medianocheUtc = new Date(`${dia}T00:00:00Z`);
  // Lo que marca el reloj de Madrid en ese instante dice cuánto va adelantado (1 o 2 horas).
  const adelanto = Date.parse(`${ahoraMadrid(medianocheUtc).slice(0, 19)}Z`) - medianocheUtc.getTime();
  return new Date(medianocheUtc.getTime() - adelanto).toISOString();
}

export function resumenTest(
  id: string,
  d: Obj,
  banco: { temas: TemasPorPregunta; respuestas: Map<number, string[]> },
): TestResumen {
  const fecha = aHoraMadrid(d.timestamp);
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
  ajustes: { rubrica: string[]; temasExtraidos: number; fechaConvocatoria: string | null; noCantar: string[]; noCantarDesde: Record<string, string>; temasClases: Array<{ clase: string; fijados: string; temas: string[] }> };
  uso: { mejorRacha: number; ultimoUso: string | null };
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
      noCantarDesde: Object.fromEntries(lista(settings?.noCantar).map((s) => [s.split('@')[0], soloFecha(s.split('@')[1]) ?? ''])),
      temasClases: lista(settings?.temasClases)
        .map((e) => e.split('@'))
        .filter((p) => p.length === 3)
        .map(([clase, fijados, temas]) => ({ clase, fijados: fijados.slice(0, 16), temas: temas.split(',').filter(Boolean) })),
    },
    uso: { mejorRacha: numero(settings?.mejorRacha), ultimoUso: typeof settings?.ultimoUso === 'string' ? settings.ultimoUso : null },
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
  modalidad?: string;
  lugar?: string;
  temasPropuestos?: string[];
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
    ...(typeof d.modalidad === 'string' ? { modalidad: d.modalidad } : {}),
    ...(typeof d.lugar === 'string' && d.lugar ? { lugar: d.lugar } : {}),
    ...(Array.isArray(d.temasPropuestos) && d.temasPropuestos.length ? { temasPropuestos: lista(d.temasPropuestos) } : {}),
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
  return { hechos, pendientes, totalHechos: vivos.filter((c) => c.datos.estado === 'hecho').length, cancelados: vivos.filter((c) => c.datos.estado === 'cancelado').length };
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
  propuestas: Array<{ de: string; fecha: string | null; nota: string; temasPorSemana: number | null; fin: string | null; temas: number }>;
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
  const sueltas = [...Object.values(objeto(d.propuestas)), ...(esObj(d.propuesta) ? [d.propuesta] : [])].filter(esObj);
  const propuestas = sueltas.length;
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
    propuestas: sueltas.map((p) => ({ de: texto(p.nombre) || 'Preparador', fecha: soloFecha(p.fecha), nota: texto(p.nota), temasPorSemana: typeof p.temasPorSemana === 'number' ? p.temasPorSemana : null, fin: soloFecha(p.fin), temas: Array.isArray(p.temas) ? p.temas.length : 0 })),
    creado: soloFecha(d.creado),
  };
}

/** El cronograma activo: el no archivado más reciente (como `cronogramaActivo()` en la app). */
export function cronogramaActivo(docs: Array<{ id: string; datos: Obj }>): { id: string; datos: Obj } | null {
  return (
    docs
      .filter((c) => c.datos.archivado !== true)
      // La app guarda «creado» en hora de Madrid sin zona; lo que venga con zona se pasa a esa hora antes de comparar.
      .sort((a, b) => texto(aHoraMadrid(b.datos.creado)).localeCompare(texto(aHoraMadrid(a.datos.creado))))[0] ?? null
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
  // Como la app: hora de Madrid sin zona (`DateTime.now().toIso8601String()`).
  const marca = ahoraMadrid(ahora);
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
  // Con varios temas, la valoración general es la media redondeada de las de cada tema (lo que leen las estadísticas).
  if (resultado.valoraciones && resultado.valoracion === undefined) {
    const notas = Object.values(valoraciones);
    resultado.valoracion = Math.round(notas.reduce((s, v) => s + v, 0) / notas.length);
  }
  return { id: marca.replace(/[:.]/g, '-').slice(0, 23), documento, resultado, errores };
}

// ------------------------------------------------------------ Visión de conjunto

/** Un informe guardado de un cante (`cantes/{id}/informes/{fecha}`), con el texto recortado si se pide. */
export function resumenInforme(id: string, canteId: string, d: Obj, maximo = 0) {
  const informe = texto(d.informe);
  return {
    id,
    canteId,
    fecha: soloFecha(d.fecha),
    hechoPor: texto(d.cliente) || texto(d.origen) || 'IA',
    valoracion: typeof d.valoracion === 'number' ? d.valoracion : undefined,
    valoraciones: esObj(d.valoraciones) ? d.valoraciones : undefined,
    criterios: esObj(d.criterios) ? d.criterios : undefined,
    comentarios: texto(d.comentarios) || undefined,
    tareas: lista(d.tareas),
    informe: maximo && informe.length > maximo ? `${informe.slice(0, maximo)}\n[… recortado: ${informe.length} caracteres en total; pídelo con completo: true]` : informe,
  };
}

/** Los deberes sin hacer de todos los cantes (los que pone el preparador o el propio opositor al cerrar un cante). */
export function deberesPendientes(cantes: Array<{ id: string; datos: Obj }>): Array<{ texto: string; cante: string | null; canteId: string }> {
  return cantes
    .filter((c) => c.datos.borrado !== true)
    .sort((a, b) => texto(b.datos.fecha).localeCompare(texto(a.datos.fecha)))
    .flatMap((c) => resumenCante(c.id, c.datos).deberes.filter((t) => !t.hecha && t.texto).map((t) => ({ texto: t.texto, cante: soloFecha(c.datos.fecha), canteId: c.id })))
    .slice(0, 30);
}

/** Días naturales de `hoy` a `fecha` (los dos «AAAA-MM-DD»); negativo si ya pasó. */
export function diasEntre(hoy: string, fecha: string): number | null {
  const a = diaDe(hoy), b = diaDe(fecha);
  return a && b ? Math.round((b.getTime() - a.getTime()) / 86_400_000) : null;
}

/** La semana del cronograma en la que cae `hoy` y la siguiente con temas. */
export function semanaDe(c: CronogramaResumen, hoy: string): { actual: SemanaResumen | null; siguiente: SemanaResumen | null } {
  const actual = c.semanas.find((s) => s.lunes <= hoy && hoy <= s.cante) ?? null;
  const siguiente = c.semanas.find((s) => s.lunes > hoy && !s.descanso) ?? null;
  return { actual, siguiente };
}

// ------------------------------------------------------------ Escrituras prudentes

/**
 * Lo que un cronograma nuevo conserva del que sustituye (si es del mismo ejercicio): si estaba compartido con el
 * preparador, sigue compartido (si no, el preparador dejaría de verlo sin aviso), y los temas ya hechos o
 * desmarcados que siguen en el nuevo no se pierden.
 */
export function heredarCronograma(nuevo: Obj, anterior: Obj | null): { compartido: boolean; hechos: number } {
  if (!anterior || numero(anterior.ejercicio, 3) !== numero(nuevo.ejercicio, 3)) return { compartido: false, hechos: 0 };
  const temas = new Set(lista(nuevo.temas));
  const hechos = Object.fromEntries(Object.entries(objeto(anterior.hechos)).filter(([t]) => temas.has(t)));
  nuevo.hechos = hechos;
  nuevo.desmarcados = lista(anterior.desmarcados).filter((t) => temas.has(t));
  nuevo.compartir = anterior.compartir === true;
  return { compartido: nuevo.compartir === true, hechos: Object.keys(hechos).length };
}

const conValor = (v: Json | undefined): boolean => (typeof v === 'number' ? v > 0 : typeof v === 'string' ? v.trim() !== '' : esObj(v) ? Object.keys(v).length > 0 : false);

/**
 * Lo que ya está apuntado en el diario del cante (por el opositor o su preparador) no se pisa: de `resultado`
 * se quitan los campos que ya tienen un valor distinto y se devuelven aparte, para que la IA lo diga.
 */
export function sinPisar(resultado: Obj, previo: Json | undefined): { escribir: Obj; yaHabia: Obj } {
  const antes = objeto(previo);
  const escribir: Obj = {};
  const yaHabia: Obj = {};
  for (const [k, v] of Object.entries(resultado)) {
    if (conValor(antes[k]) && JSON.stringify(antes[k]) !== JSON.stringify(v)) yaHabia[k] = antes[k];
    else escribir[k] = v;
  }
  return { escribir, yaHabia };
}

/** Las tareas de una corrección como deberes del cante (`Tarea.toJson`, tipo «libre»), sin repetir las que ya están. */
export function anadirDeberes(actuales: Json | undefined, textos: string[], marca: string): { tareas: Json[]; nuevas: number } {
  const tareas = Array.isArray(actuales) ? [...actuales] : [];
  const ya = new Set(tareas.filter(esObj).map((t) => texto(t.texto).trim().toLowerCase()));
  let nuevas = 0;
  for (const t of textos.map((x) => x.trim()).filter(Boolean)) {
    if (ya.has(t.toLowerCase())) continue;
    ya.add(t.toLowerCase());
    tareas.push({ id: nuevoId(), tipo: 'libre', texto: t.slice(0, 200), creada: marca });
    nuevas++;
  }
  return { tareas, nuevas };
}

/** Apuntes nuevos para la agenda de un tema (`Apunte.toJson`), sin repetir los que siguen pendientes. */
export function anadirApuntes(actuales: Json | undefined, textos: string[], marca: string): { pendientes: Json[]; nuevos: number } {
  const pendientes = Array.isArray(actuales) ? [...actuales] : [];
  const ya = new Set(pendientes.filter(esObj).filter((a) => a.hecho == null && a.borrado !== true).map((a) => texto(a.texto).trim().toLowerCase()));
  let nuevos = 0;
  for (const t of textos.map((x) => x.trim()).filter(Boolean)) {
    if (ya.has(t.toLowerCase())) continue;
    ya.add(t.toLowerCase());
    pendientes.push({ id: nuevoId(), texto: t, creado: marca, hecho: null, borrado: false });
    nuevos++;
  }
  return { pendientes, nuevos };
}

// ------------------------------------------------------------ Preparador

export interface TareaNueva {
  tipo: 'estudiar' | 'esquema' | 'cantar' | 'test' | 'libre';
  tema?: string;
  texto?: string;
  preguntas?: number;
}

/** Deberes que pone el preparador en una clase (`Tarea.toJson`), añadidos a los que ya hubiera; devuelve los errores. */
export function anadirTareas(actuales: Json | undefined, nuevas: TareaNueva[], marca: string): { tareas: Json[]; errores: string[] } {
  const tareas = Array.isArray(actuales) ? [...actuales] : [];
  const errores: string[] = [];
  for (const t of nuevas) {
    if (t.tipo === 'libre' && !(t.texto ?? '').trim()) errores.push('una tarea libre necesita texto');
    if (t.tipo !== 'libre' && t.tipo !== 'test' && !reTema.test(t.tema ?? '')) errores.push(`la tarea «${t.tipo}» necesita un tema (formato 3.A.8)`);
    if (t.tema && !reTema.test(t.tema)) errores.push(`tema no válido: «${t.tema}»`);
    tareas.push({ id: nuevoId(), tipo: t.tipo, ...(t.tema ? { tema: t.tema } : {}), ...((t.texto ?? '').trim() ? { texto: t.texto!.trim().slice(0, 200) } : {}), ...(t.preguntas && t.preguntas > 0 ? { preguntas: Math.round(t.preguntas) } : {}), creada: marca });
  }
  return { tareas, errores };
}

/** Las clases de un preparador con un alumno: las últimas hechas (con resultado, notas y deberes) y las próximas. */
export function clasesConAlumno(sesiones: Array<{ id: string; datos: Obj }>, alumnoId: string, n: number, ahora: string) {
  const suyas = sesiones.filter((s) => s.datos.borrado !== true && s.datos.alumno === alumnoId);
  const porFecha = (a: { datos: Obj }, b: { datos: Obj }) => texto(a.datos.fecha).localeCompare(texto(b.datos.fecha));
  const hechas = suyas.filter((s) => s.datos.estado === 'hecho').sort((a, b) => porFecha(b, a));
  return {
    hechas: hechas.slice(0, n).map((s) => resumenCante(s.id, s.datos)),
    totalHechas: hechas.length,
    proximas: suyas.filter((s) => texto(s.datos.estado, 'pendiente') === 'pendiente' && texto(s.datos.fecha) >= ahora.slice(0, 19)).sort(porFecha).slice(0, 5).map((s) => resumenCante(s.id, s.datos)),
    canceladas: suyas.filter((s) => s.datos.estado === 'cancelado').length,
  };
}
