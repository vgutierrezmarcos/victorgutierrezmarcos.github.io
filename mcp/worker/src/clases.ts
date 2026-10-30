// Clases con el preparador: los documentos que escribe la app al pedir una
// reserva (opositor) o al crear una sesión (preparador), y lo que necesita la IA
// para proponerla (huecos libres, temas del cronograma para ese día, choques).
//
// La app guarda las horas de las clases como hora local de Madrid sin zona
// («2026-11-04T18:00:00.000», `DateTime.toIso8601String()` de Dart), así que
// aquí todas las fechas de clase son textos «ingenuos» en hora de Madrid.
// Modelos: Reserva (app/lib/data/models/red.dart), Cante (plan.dart),
// copiaParaAlumno y sesionDeReserva (data/repos/preparador_repo.dart),
// temasDelCante (cronograma.dart) y temasClases (temas_clase.dart).

import type { Json } from './firestore';

type Obj = { [k: string]: Json };

const texto = (v: Json | undefined, defecto = ''): string => (typeof v === 'string' ? v : defecto);
const numero = (v: Json | undefined, defecto = 0): number => (typeof v === 'number' ? v : defecto);
const lista = (v: Json | undefined): string[] => (Array.isArray(v) ? v.map((x) => String(x)) : []);

export const reTema = /^\d\.[A-Z]\.\d{1,2}$/;
export const MODALIDADES = ['presencial', 'online'] as const;
export type Modalidad = (typeof MODALIDADES)[number];

/** Duración por defecto de una clase (PerfilPreparador.minutosClasePorDefecto). */
export const MINUTOS_CLASE = 120;

/** Hora de Madrid ahora, como texto ingenuo «AAAA-MM-DDTHH:MM:SS.000». */
export function ahoraMadrid(ahora = new Date()): string {
  const p = Object.fromEntries(
    new Intl.DateTimeFormat('en-GB', { timeZone: 'Europe/Madrid', year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', second: '2-digit', hourCycle: 'h23' })
      .formatToParts(ahora)
      .map((x) => [x.type, x.value]),
  );
  return `${p.year}-${p.month}-${p.day}T${p.hour}:${p.minute}:${p.second}.000`;
}

/** «2026-11-04» y «18:00» → «2026-11-04T18:00:00.000»; null si no son válidos. */
export function fechaClase(dia: string, hora: string): string | null {
  const d = /^(\d{4})-(\d{2})-(\d{2})$/.exec(dia.trim());
  const h = /^(\d{1,2})[:.h](\d{2})$/.exec(hora.trim());
  if (!d || !h) return null;
  const [y, m, dd, hh, mi] = [+d[1], +d[2], +d[3], +h[1], +h[2]];
  const prueba = new Date(Date.UTC(y, m - 1, dd));
  if (prueba.getUTCMonth() !== m - 1 || prueba.getUTCDate() !== dd || hh > 23 || mi > 59) return null;
  return `${d[1]}-${d[2]}-${d[3]}T${String(hh).padStart(2, '0')}:${h[2]}:00.000`;
}

/** Minutos desde 1970 de una fecha ingenua (solo para comparar y sumar). */
const minutosDe = (iso: string): number => Math.round(Date.parse(`${iso.slice(0, 19)}Z`) / 60_000);
const isoDeMinutos = (m: number): string => `${new Date(m * 60_000).toISOString().slice(0, 19)}.000`;

export function seSolapan(a: string, aMin: number, b: string, bMin: number): boolean {
  const a0 = minutosDe(a), b0 = minutosDe(b);
  return a0 < b0 + bMin && b0 < a0 + aMin;
}

/** 1 = lunes … 7 = domingo de una fecha ingenua. */
const diaSemanaDe = (iso: string): number => ((new Date(`${iso.slice(0, 10)}T00:00:00Z`).getUTCDay() + 6) % 7) + 1;

export interface Hueco {
  inicio: string;
  minutos: number;
}

/**
 * Huecos libres de un preparador en las próximas semanas (`HuecosPublicos.libres` de la app):
 * sus franjas semanales, sin las que ya pasaron, las que pisan clases suyas (`ocupados`)
 * ni las que el opositor ya ha pedido.
 */
export function huecosLibres(publicos: Obj | null, yaPedidas: string[], ahora: string, semanas = 4): Hueco[] {
  if (!publicos || publicos.activo === false) return [];
  const franjas = (Array.isArray(publicos.huecos) ? publicos.huecos : []) as Obj[];
  const ocupados = ((Array.isArray(publicos.ocupados) ? publicos.ocupados : []) as Obj[]).map((o) => ({ inicio: texto(o.inicio), minutos: numero(o.minutos, 30) }));
  const hoy = minutosDe(`${ahora.slice(0, 10)}T00:00:00`);
  const out: Hueco[] = [];
  for (let d = 0; d < semanas * 7; d++) {
    const dia = isoDeMinutos(hoy + d * 1440);
    for (const f of franjas) {
      if (numero(f.diaSemana) !== diaSemanaDe(dia)) continue;
      const inicio = isoDeMinutos(minutosDe(dia) + numero(f.minutoDelDia));
      const minutos = numero(f.minutos, 30);
      if (inicio <= ahora) continue;
      if (ocupados.some((o) => o.inicio && seSolapan(inicio, minutos, o.inicio, o.minutos))) continue;
      if (yaPedidas.some((p) => p.slice(0, 16) === inicio.slice(0, 16))) continue;
      out.push({ inicio, minutos });
    }
  }
  return out.sort((a, b) => a.inicio.localeCompare(b.inicio));
}

/**
 * Temas que tocan en la clase de ese día según el cronograma (`temasDelCante` de la app):
 * los de la semana cuyo cante (lunes + 6) cae más cerca, a 3 días como mucho, sin los
 * desmarcados. null si cae fuera, en descanso o no queda ninguno.
 */
export function temasDelCante(cronograma: Obj | null, fecha: string): string[] | null {
  if (!cronograma) return null;
  const dia = minutosDe(`${fecha.slice(0, 10)}T00:00:00`);
  const desmarcados = new Set(lista(cronograma.desmarcados));
  let mejor: Obj | null = null;
  let distancia = 99;
  for (const s of (Array.isArray(cronograma.semanas) ? cronograma.semanas : []) as Obj[]) {
    const lunes = texto(s.lunes);
    if (!lunes) continue;
    const domingo = minutosDe(`${lunes.slice(0, 10)}T00:00:00`) + 6 * 1440;
    const d = Math.round(Math.abs(domingo - dia) / 1440);
    if (d < distancia) {
      distancia = d;
      mejor = s;
    }
  }
  if (!mejor || distancia > 3 || mejor.descanso === true) return null;
  const temas = lista(mejor.temas).filter((t) => !desmarcados.has(t));
  return temas.length ? temas : null;
}

/** Próximas clases de una agenda (cantes o sesiones) para ver choques: pendientes, no borradas, desde ahora. */
export function proximas(docs: Array<{ id: string; datos: Obj }>, ahora: string, dias = 60): Array<{ id: string; fecha: string; minutos: number; titulo: string; con?: string }> {
  const limite = isoDeMinutos(minutosDe(ahora) + dias * 1440);
  return docs
    .filter((d) => d.datos.borrado !== true && texto(d.datos.estado, 'pendiente') === 'pendiente')
    .map((d) => ({ id: d.id, fecha: texto(d.datos.fecha), minutos: numero(d.datos.minutos, 30), titulo: texto(d.datos.titulo), con: texto(d.datos.preparadorNombre) || undefined }))
    .filter((c) => c.fecha >= ahora.slice(0, 19) && c.fecha <= limite)
    .sort((a, b) => a.fecha.localeCompare(b.fecha));
}

export interface PeticionClase {
  fecha: string; // ingenua, de fechaClase()
  minutos: number;
  modalidad: Modalidad;
  temas: string[];
  nota?: string;
  lugar?: string;
  enlace?: string;
}

/** Valida temas y textos de una petición; devuelve los errores. */
export function erroresPeticion(p: PeticionClase, ahora: string): string[] {
  const errores: string[] = [];
  if (p.fecha <= ahora) errores.push('la fecha y la hora tienen que ser futuras (hora de Madrid)');
  if (!Number.isInteger(p.minutos) || p.minutos < 30 || p.minutos > 300) errores.push('la duración tiene que ir de 30 a 300 minutos');
  for (const t of p.temas) if (!reTema.test(t)) errores.push(`tema no válido: «${t}» (formato 3.A.8)`);
  if ((p.nota ?? '').length > 500) errores.push('la nota es demasiado larga (500 caracteres como mucho)');
  if (p.enlace && !/^https:\/\//.test(p.enlace)) errores.push('el enlace de la clase online tiene que empezar por https://');
  return errores;
}

/** `reservas/{id}`: la petición del opositor (Reserva.toJson, con modalidad y temas). */
export function construirReserva(id: string, p: PeticionClase, preparador: string, alumno: string, alumnoNombre: string, ahoraIso: string): Obj {
  return {
    id,
    preparador,
    alumno,
    alumnoNombre,
    fecha: p.fecha,
    minutos: p.minutos,
    nota: p.nota ?? '',
    modalidad: p.modalidad,
    ...(p.temas.length ? { temas: p.temas } : {}),
    estado: 'pedida',
    creada: ahoraIso,
    updatedAt: ahoraIso,
  };
}

/** Orden de los códigos de tema como `compararCodigos` de la app: 3.A.2 antes que 3.A.10. */
export function compararCodigos(a: string, b: string): number {
  const pa = a.split('.'), pb = b.split('.');
  for (let i = 0; i < Math.max(pa.length, pb.length); i++) {
    const x = pa[i] ?? '', y = pb[i] ?? '';
    const c = /^\d+$/.test(x) && /^\d+$/.test(y) ? Number(x) - Number(y) : x.localeCompare(y);
    if (c) return c;
  }
  return 0;
}

/**
 * `progress/settings.temasClases` con los temas de una clase («id@cuándo@3.A.1,3.A.2», donde
 * «cuándo» es el momento en que se fijan): sustituye la entrada de esa clase, se queda con las
 * 80 fijadas más recientemente y ordena la lista (`fijarTemasClase` y `TemasClase.aLista`).
 */
export function fijarTemasClase(actuales: string[], claseId: string, ahora: string, temas: string[]): string[] {
  const cuando = (e: string) => e.split('@')[1] ?? '';
  const otras = actuales.filter((e) => e.split('@')[0] !== claseId && e.split('@').length === 3);
  const nueva = `${claseId}@${ahora}@${[...temas].sort(compararCodigos).join(',')}`;
  return [...otras, nueva]
    .sort((x, y) => cuando(y).localeCompare(cuando(x)))
    .slice(0, 80)
    .sort();
}

export interface PerfilClase {
  nombre: string;
  minutosClase: number;
  plataforma: string;
  numTemas: number;
}

/** `sesiones/{id}` del preparador (Cante.toJson, como CanteFormPage), con los temas como propuesta. */
export function construirSesion(id: string, p: PeticionClase, alumnoId: string, ejercicio: number, exposicion: number, perfil: PerfilClase, ahoraIso: string): Obj {
  const online = p.modalidad === 'online';
  return {
    id,
    fecha: p.fecha,
    titulo: '',
    modalidad: p.modalidad,
    ...(!online && p.lugar ? { lugar: p.lugar } : {}),
    ...(online && p.enlace ? { enlace: p.enlace } : {}),
    minutos: p.minutos,
    exposicion,
    ejercicio,
    bolsa: 'estudiados',
    temas: [],
    notas: p.nota ?? '',
    estado: 'pendiente',
    resultado: null,
    serie: null,
    alumno: alumnoId,
    updatedAt: ahoraIso,
    borrado: false,
    ...(perfil.numTemas !== 2 ? { numTemas: perfil.numTemas } : {}),
    ...(online ? { plataforma: perfil.plataforma || 'meet' } : {}),
    ...(p.temas.length ? { temasPropuestos: p.temas, propuestaTemasA: ahoraIso } : {}),
  };
}

/** La copia de la sesión en `cantes/{id}` del alumno (copiaParaAlumno de la app). */
export function copiaParaAlumno(sesion: Obj, preparadorUid: string, preparadorNombre: string): Obj {
  const { alumno: _a, eventoGoogle: _e, temaMandado: _t, temasMandados: _m, temaSorteado: _s, ocultaAlAlumno: _o, ...resto } = sesion;
  return {
    ...resto,
    titulo: texto(sesion.titulo) || (preparadorNombre ? `Con ${preparadorNombre}` : 'Preparador'),
    preparador: preparadorUid,
    preparadorNombre,
  };
}
