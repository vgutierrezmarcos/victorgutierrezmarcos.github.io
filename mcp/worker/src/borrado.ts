// Borrado de todos los datos de un usuario en UNA oposición, como hace la app en
// Cuenta → «Borrar mis datos de una oposición» (app/lib/core/providers.dart,
// borrarDatosDeOposicion). Todo con el ID token del propio usuario: las reglas de
// Firestore deciden qué puede borrar. No toca las demás oposiciones ni la cuenta.

import { Firestore, type AlmacenDatos, type Escritura, type Json } from './firestore';

type Doc = { [k: string]: Json };

/**
 * Colecciones del usuario en una oposición (bajo su raíz) con las que cuelgan de cada
 * documento: borrar un documento no borra lo de debajo. La misma lista está en la app
 * (UsuarioRepo.coleccionesOposicion): al añadir una colección, van las dos. «oposiciones»
 * y «cuenta» no están a propósito: son de la cuenta, no de una oposición.
 */
export const COLECCIONES_OPOSICION: Record<string, string[]> = {
  exam_results: [],
  progress: [],
  notes: [],
  cantes: ['reloj', 'pizarra', 'informes'],
  alumnos: [],
  sesiones: ['notas'],
  preparadores: [],
  cronogramas: [],
  cronogramasRecibidos: [],
  contactosPreparadores: [],
  notasPreparadores: [],
  tablon: [],
  coordinacion: [],
  anotaciones: ['paginas'],
};

/** Lo que el usuario entiende de cada colección, para enseñarle qué se borra. */
const NOMBRES: Record<string, string> = {
  exam_results: 'tests hechos',
  notes: 'temas con notas o agenda',
  cantes: 'cantes y clases',
  alumnos: 'alumnos (como preparador)',
  sesiones: 'clases dadas o programadas (como preparador)',
  preparadores: 'preparadores enlazados',
  cronogramas: 'cronogramas',
  cronogramasRecibidos: 'cronogramas recibidos de un preparador',
  anotaciones: 'temas con anotaciones a mano',
};

/** Cuántos documentos hay en cada colección (solo las que tienen algo). */
export async function recuentoOposicion(db: AlmacenDatos): Promise<{ total: number; porColeccion: Record<string, number>; resumen: Record<string, number> }> {
  const porColeccion: Record<string, number> = {};
  const resumen: Record<string, number> = {};
  let total = 0;
  for (const c of Object.keys(COLECCIONES_OPOSICION)) {
    const n = (await db.listar(c)).length;
    if (!n) continue;
    porColeccion[c] = n;
    total += n;
    if (NOMBRES[c]) resumen[NOMBRES[c]] = n;
  }
  return { total, porColeccion, resumen };
}

const TAMANO_LOTE = 400; // un commit admite 500 operaciones

async function borrarRutas(db: AlmacenDatos, rutas: string[]): Promise<void> {
  for (let i = 0; i < rutas.length; i += TAMANO_LOTE) {
    const escrituras: Escritura[] = rutas.slice(i, i + TAMANO_LOTE).map((ruta) => ({ ruta, datos: {}, borrar: true }));
    await db.lote(escrituras);
  }
}

export interface EntornoBorrado {
  uid: string;
  oposicion: string;
  /** Los datos del usuario en esa oposición. */
  db: AlmacenDatos;
  /** La red de preparadores de esa oposición (reservas, huecos, enlaces…). */
  red: AlmacenDatos;
  /** La cuenta del usuario (`users/{uid}`), para dejar la marca de borrado. */
  cuenta: AlmacenDatos;
  /** Los datos de otro usuario en esa oposición (para quitar el enlace del lado del alumno). */
  deOtro(uid: string): Promise<AlmacenDatos>;
  /** Ahora, en ISO y UTC. */
  ahora: string;
  /**
   * Códigos de los temas del programa («3.A.8»). Las anotaciones a mano de un tema están en
   * `anotaciones/{tema}/paginas` y el documento `anotaciones/{tema}` no existe, así que no
   * salen al listar la colección: se va tema a tema (el PDF de siempre y el revisado).
   */
  temas: string[];
}

/**
 * Borra todo. Orden: 1) la marca en la cuenta (para que la app de cada dispositivo borre su
 * copia local en vez de volver a subirla), 2) lo que tiene a su nombre en la red y los
 * enlaces con preparadores y alumnos, 3) sus colecciones. Lo de la red va cosa a cosa:
 * lo que las reglas no dejan (o no existe) se apunta en «avisos» y no impide el resto.
 */
export async function borrarOposicion(e: EntornoBorrado): Promise<{ borrados: number; enlacesRotos: number; avisos: string[] }> {
  const avisos: string[] = [];
  let enlacesRotos = 0;
  const intenta = async (que: string, f: () => Promise<void>) => {
    try {
      await f();
    } catch (err) {
      avisos.push(`No se ha podido borrar ${que}: ${(err as Error).message}`);
    }
  };
  const uid = e.uid;

  await e.cuenta.escribir('cuenta/app', { borrados: { [e.oposicion]: e.ahora } }, [`borrados.${e.oposicion}`]);

  // --- Enlaces y red (antes de borrar lo suyo: hacen falta sus preparadores y su código)
  const misPreparadores = await e.db.listar('preparadores');
  for (const p of misPreparadores) {
    await intenta(`el enlace con el preparador ${String(p.datos.nombre ?? p.id)}`, async () => {
      await borrarRutas(e.red, [`preparadores/${Firestore.tramo(p.id)}/alumnos/${uid}`]);
      enlacesRotos++;
    });
  }
  let misAlumnos: Array<{ id: string; datos: Doc }> = [];
  await intenta('la lista de alumnos enlazados', async () => {
    misAlumnos = await e.red.listar(`preparadores/${uid}/alumnos`);
  });
  for (const a of misAlumnos) {
    await intenta(`el enlace con el alumno ${String(a.datos.nombre ?? a.id)}`, async () => {
      await borrarRutas(e.red, [`preparadores/${uid}/alumnos/${Firestore.tramo(a.id)}`]);
      await borrarRutas(await e.deOtro(a.id), [`preparadores/${uid}`]);
      enlacesRotos++;
    });
  }
  const deLaRed = async (coleccion: string, campo: string) => (await e.red.consultar(coleccion, { where: { campo, op: 'EQUAL', valor: uid } })).map((d) => d.id);
  await intenta('los materiales compartidos con alumnos', async () => borrarRutas(e.red, (await deLaRed('materiales', 'preparador')).map((id) => `materiales/${Firestore.tramo(id)}`)));
  const codigo = (await e.db.leer('progress/preparador'))?.codigo;
  if (typeof codigo === 'string' && codigo) await intenta('el código de preparador', () => borrarRutas(e.red, [`codigos/${Firestore.tramo(codigo)}`]));
  for (const campo of ['alumno', 'preparador']) {
    await intenta('las reservas de clase', async () => borrarRutas(e.red, (await deLaRed('reservas', campo)).map((id) => `reservas/${Firestore.tramo(id)}`)));
  }
  await intenta('los huecos para reservar', () => borrarRutas(e.red, [`huecos/${uid}`]));
  await intenta('la solicitud de alta como preparador', () => borrarRutas(e.red, [`solicitudesPreparador/${uid}`]));
  await intenta('las clases sueltas ofrecidas', async () => {
    for (const id of await deLaRed('sustituciones', 'alumno')) {
      await intenta('los datos privados de una clase suelta', () => borrarRutas(e.red, [`sustituciones/${Firestore.tramo(id)}/privado/alumno`]));
      await borrarRutas(e.red, [`sustituciones/${Firestore.tramo(id)}`]);
    }
  });
  await intenta('las búsquedas de preparador', async () => {
    for (const id of await deLaRed('busquedas', 'alumno')) {
      await intenta('los interesados en una búsqueda', async () =>
        borrarRutas(e.red, (await e.red.listar(`busquedas/${Firestore.tramo(id)}/interesados`)).map((i) => `busquedas/${Firestore.tramo(id)}/interesados/${Firestore.tramo(i.id)}`)),
      );
      await borrarRutas(e.red, [`busquedas/${Firestore.tramo(id)}`]);
    }
  });

  // --- Sus colecciones (si esto falla, falla la herramienta: se puede repetir)
  let borrados = 0;
  for (const [coleccion, debajo] of Object.entries(COLECCIONES_OPOSICION)) {
    const rutas: string[] = [];
    for (const d of await e.db.listar(coleccion)) {
      const doc = `${coleccion}/${Firestore.tramo(d.id)}`;
      for (const sub of debajo) for (const x of await e.db.listar(`${doc}/${sub}`)) rutas.push(`${doc}/${sub}/${Firestore.tramo(x.id)}`);
      rutas.push(doc);
    }
    if (coleccion === 'anotaciones') {
      const ids = [...new Set(e.temas.flatMap((t) => [t, `${t}-revisado`]).map((t) => t.replaceAll('/', '_')))];
      for (let i = 0; i < ids.length; i += 20) {
        const tandas = await Promise.all(
          ids.slice(i, i + 20).map(async (id) => (await e.db.listar(`anotaciones/${Firestore.tramo(id)}/paginas`)).map((x) => `anotaciones/${Firestore.tramo(id)}/paginas/${Firestore.tramo(x.id)}`)),
        );
        for (const r of tandas.flat()) if (!rutas.includes(r)) rutas.push(r);
      }
    }
    await borrarRutas(e.db, rutas);
    borrados += rutas.length;
  }
  return { borrados, enlacesRotos, avisos };
}
