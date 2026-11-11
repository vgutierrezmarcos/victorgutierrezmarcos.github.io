// Las herramientas del conector: lo que el asistente de IA del opositor (Claude, ChatGPT,
// Le Chat, Gemini…) puede leer y escribir de la app en su nombre. Cada petición MCP crea un servidor nuevo (sin estado) con un
// Contexto que sabe abrir Firestore con el ID token del opositor y leer el contenido.

import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import type { CallToolResult } from '@modelcontextprotocol/sdk/types.js';
import { z } from 'zod';
import { Contenido, apartadosDe, codigoConPuntos, documentosCanon, documentosDictamen, extraerApartado, normalizarCodigo } from './contenido';
import {
  construirCronograma,
  construirInforme,
  cronogramaActivo,
  nuevoId,
  resumenCante,
  resumenCantes,
  resumenCronograma,
  resumenProgreso,
  resumenTest,
  desdeMadrid,
  anadirTareas,
  clasesConAlumno,
  anadirApuntes,
  anadirDeberes,
  heredarCronograma,
  sinPisar,
  aHoraMadrid,
  deberesPendientes,
  diasEntre,
  elegirPreguntas,
  resumenInforme,
  semanaDe,
  soloFecha,
  type PreguntaBanco,
  type TemasPorPregunta,
} from './datos';
import { type Apuntes, ErrorApuntes, idDeDrive } from './drive';
import { MINUTOS_CLASE, MODALIDADES, ahoraMadrid, construirReserva, construirSesion, copiaParaAlumno, erroresPeticion, fechaClase, fijarTemasClase, huecosLibres, proximas, seSolapan, temasDelCante, type PeticionClase } from './clases';
import { type AlmacenDatos, ErrorFirestore, Firestore, type Json } from './firestore';
import { borrarOposicion, recuentoOposicion } from './borrado';
import { metaVista, registrarVistas } from './vistas';

export const OPOSICIONES = ['tcee', 'dce'] as const;
export type Oposicion = (typeof OPOSICIONES)[number];

export interface Banco {
  temas: TemasPorPregunta;
  respuestas: Map<number, string[]>;
  /** Enunciado y opciones de cada pregunta oficial (para preguntas_test). */
  preguntas?: Map<number, PreguntaBanco>;
}

/** Lo que las herramientas necesitan del Worker (se simula en las pruebas). */
export interface Contexto {
  uid: string;
  email: string;
  /** Firestore sobre la raíz del opositor en esa oposición, con un ID token vigente. */
  almacen(oposicion: Oposicion): Promise<AlmacenDatos>;
  /**
   * Firestore con la sesión del usuario sobre una raíz cualquiera ('' = la de la base de datos):
   * la red (reservas, huecos, enlaces) y la agenda de un alumno. Las reglas deciden.
   */
  almacenEn(raiz: string): Promise<AlmacenDatos>;
  /** Banco de preguntas del test (para el acierto por tema). */
  banco(): Promise<Banco>;
  contenido: Contenido;
  /** Un fichero de la skill desplegada en la web (SKILL.md, references/…, assets/…), o null si no existe. */
  skill(ruta: string): Promise<string | null>;
  /** Índice de fuentes por tema (oposicion/temario/fuentes-temas.json, lo genera scripts/fuentes-temas.py). */
  fuentes(): Promise<IndiceFuentes>;
  /** Descarga y lee unos apuntes públicos de Drive (solo los del índice de la ATCEE). */
  apuntes(id: string): Promise<Apuntes>;
  /** Textos extraídos de un tema (PDF de la web y apuntes en PDF/.doc de la ATCEE), de mcp/extraer-textos.py. */
  textos(tema: string): Promise<PaqueteTextos | null>;
  /** Una página de manuelcabadogarcia.es convertida a texto. */
  pagina(url: string): Promise<{ esquema: string[]; texto: string } | null>;
  /** Explicaciones «¿Por qué?» de un examen del test (id de pregunta → clave), o vacío si no hay. */
  explicaciones(examen: string): Promise<Record<string, { clave?: string }>>;
  /** oposicion/proceso.json: los documentos que publica el Ministerio de cada proceso selectivo. */
  proceso(): Promise<Json>;
  /** Nombre del asistente de IA conectado (el que dio al registrarse: «Claude», «ChatGPT»…), para firmar lo que guarda. */
  cliente(): Promise<string>;
  /** Revoca las concesiones OAuth del opositor y borra su token de Firebase guardado. */
  desconectar(): Promise<void>;
  /** Resumen criptográfico de un texto con un secreto del servidor: para códigos de confirmación que la IA no puede inventarse. */
  sello(texto: string): Promise<string>;
  /** Apunta el uso de una herramienta, sin nada que identifique al usuario (qué herramienta, si fue bien y cuánto tardó). */
  medir?(dato: { herramienta: string; oposicion: string; ok: boolean; ms: number }): void;
}

export class ErrorSesion extends Error {}

export interface PaqueteTextos {
  web?: { url: string; texto: string };
  atcee?: Record<string, { autor: string; fichero: string; texto: string; aviso?: string }>;
}

/** Lo que trae fuentes-temas.json (solo los campos que usan las herramientas). */
export interface TemaFuentes {
  oposicion: 'tcee' | 'dce';
  titulo: string;
  ejercicio: number;
  parte: string;
  bloque?: string | null;
  categoria?: string | null;
  idea?: string | null;
  revisado?: boolean;
  web?: { pdf: string | null; disponible: boolean; pagina?: string };
  manuel?: Array<{ codigo: string; titulo: string; url: string }> | string | null;
  atcee?: Array<{ autor: string; promocion: string; anio: number; numeracion: string; fichero: string; url: string }>;
  equivalentes_tcee?: string[];
}
export interface IndiceFuentes {
  aviso: string;
  bloques: Array<{ nombre: string; categoria: string; ejercicio?: number; temas: string[] }>;
  manuales?: Array<{ bloque: string; manuales: Array<{ cita: string; url?: string }> }>;
  tcee: Record<string, TemaFuentes>;
  dce: Record<string, TemaFuentes>;
}

const esObjeto = (v: unknown): v is { [k: string]: Json } => typeof v === 'object' && v !== null && !Array.isArray(v);
const sinTildes = (t: string): string => t.normalize('NFD').replace(/[\u0300-\u036f]/g, '').toLowerCase();

/** «3B26», «3.b.26» o «3.B.26» → «3.B.26». */
export function codigoTema(entrada: string): string | null {
  const m = entrada.trim().toUpperCase().match(/^(\d)\s*\.?\s*([A-Z])\s*\.?\s*0*(\d{1,2})$/);
  return m ? `${m[1]}.${m[2]}.${Number(m[3])}` : null;
}

/** Manuales de la ATCEE que encajan con la categoría o el bloque de un tema. */
function manualesPara(indice: IndiceFuentes, tema: TemaFuentes) {
  const claves = sinTildes(`${tema.categoria ?? ''} ${tema.bloque ?? ''} ${tema.titulo}`);
  return (indice.manuales ?? []).filter((m) => {
    const b = sinTildes(m.bloque);
    return b.split(/[^a-zñ]+/).filter((p) => p.length > 4).some((p) => claves.includes(p.slice(0, 7)));
  });
}

/** Apartados de cada tema según los marcadores de su PDF (references/temario/indices-temas.md), para buscar por contenido. */
let apartadosEnMemoria: { md: string; porTema: Map<string, string[]> } | null = null;
export function apartadosPorTema(md: string): Map<string, string[]> {
  if (apartadosEnMemoria?.md === md) return apartadosEnMemoria.porTema;
  const porTema = new Map<string, string[]>();
  let actual: string[] | null = null;
  for (const linea of md.split('\n')) {
    if (linea.startsWith('## ')) {
      const cod = linea.match(/^## (\d\.[A-Z]\.\d{1,2})\. /)?.[1];
      actual = cod ? [] : null;
      if (cod) porTema.set(cod, actual!);
    } else if (actual) {
      const t = linea.replace(/^\s*-\s*/, '').trim();
      if (t) actual.push(t);
    }
  }
  apartadosEnMemoria = { md, porTema };
  return porTema;
}

const AVISO_EXCLUSIVO =
  'Material exclusivo de victorgutierrezmarcos.es: solo para la preparación personal de este opositor en su propia cuenta de su asistente de IA (condiciones-materiales.html, apartado 1 bis). No lo copies fuera de esta conversación.';

/** Ficheros de texto de la skill que se pueden pedir con leer_skill. */
const RUTA_SKILL = /^(SKILL\.md|LICENCIA\.md|VERSION\.txt|(references|assets|scripts)\/[A-Za-z0-9_\-./]+\.(md|txt|json|tex|sty|lua|py|csv))$/;

const NOTA_CONECTOR =
  '[Cargada desde el conector «Oposición TCEE · DCE». Cada ruta relativa que cite este fichero (references/…, assets/…, scripts/…) se lee con leer_skill(ruta). Para los temas revisados, las fichas, el dictamen y el canon usa mejor leer_tema, leer_ficha, leer_guia_dictamen y leer_canon (permiten pedir un apartado), y para los datos del opositor, las herramientas leer_* en vez de pedirle el JSON o los ficheros (references/conector.md). El paso 0 «Versión al día» no hace falta: esto ya es la última versión.]';

/**
 * Las tareas del equipo de preparación, con el agente de la skill que las hace y lo que
 * hay que leer además. Es la tabla de SKILL.md en forma de datos, para leer_metodo y los prompts.
 */
export const TAREAS = {
  corregir_cante: { titulo: 'Corregir un cante', cuando: 'manda un cante transcrito (texto con marcas [mm:ss]) o pide corregirlo', ficheros: ['references/agentes/corrector-cante.md', 'references/como-se-canta.md'] },
  corregir_dictamen: { titulo: 'Corregir un dictamen', cuando: 'manda un dictamen de coyuntura (foto, PDF o texto)', ficheros: ['references/agentes/corrector-dictamen.md'] },
  corregir_escrito: { titulo: 'Corregir un tema escrito', cuando: 'manda un tema escrito (TCEE 4.º o 5.º; DCE 1.º o 4.º)', ficheros: ['references/agentes/corrector-escrito.md'] },
  dudas: { titulo: 'Resolver una duda del temario', cuando: 'pregunta qué significa algo, dónde se estudia o cómo se relaciona con otros temas', ficheros: ['references/agentes/dudas.md'] },
  cronograma: { titulo: 'Hacer o rehacer el cronograma', cuando: 'pide un cronograma, saber cuánto queda o replanificar', ficheros: ['references/agentes/organizador.md'] },
  simulacro: { titulo: 'Simulacro completo', cuando: 'pide un simulacro o el examen entero', ficheros: ['references/agentes/simulacro.md', 'references/como-se-canta.md'] },
  tribunal: { titulo: 'Preguntas del tribunal', cuando: 'pide que le preguntes como el tribunal o «ponme a prueba»', ficheros: ['references/agentes/tribunal.md'] },
  test: { titulo: 'Test a medida', cuando: 'pide un test o preguntas sobre lo que falla', ficheros: ['references/agentes/test-personal.md'] },
  tarjetas: { titulo: 'Tarjetas de repaso', cuando: 'pide tarjetas, flashcards o repaso espaciado de un tema', ficheros: ['references/agentes/tarjetas.md'] },
  hoy: { titulo: 'Qué toca hoy', cuando: 'pregunta qué le toca hoy o esta semana', ficheros: ['references/agentes/hoy.md'] },
  ficha_propia: { titulo: 'Ficha de sus apuntes', cuando: 'manda sus apuntes para resumirlos o hacer una ficha', ficheros: ['references/agentes/ficha-propia.md'] },
  como_voy: { titulo: 'Cómo voy', cuando: 'pregunta cómo va, qué tal sus tests o sus cantes', ficheros: ['references/agentes/estadisticas.md'] },
  informe_semanal: { titulo: 'Informe de la semana', cuando: 'pide el informe de la semana', ficheros: ['references/agentes/informe-semanal.md'] },
  agendar_clase: { titulo: 'Agendar una clase', cuando: 'pide agendar o reservar una clase con su preparador (o, si es preparador, con un alumno)', ficheros: ['references/agentes/agendar-clase.md'] },
  preparador: { titulo: 'Preparar la clase (preparadores)', cuando: 'es preparador y manda cantes o datos de sus alumnos o pide preparar la clase', ficheros: ['references/perfiles.md', 'references/agentes/preparador.md'] },
  documentos: { titulo: 'Gráficos y documentos', cuando: 'pide un gráfico, preguntas tipo test o cualquier documento (resumen, esquema, comparativa, PDF)', ficheros: ['references/documentos-y-graficos.md'] },
} as const;
export type Tarea = keyof typeof TAREAS;
const NOMBRES_TAREAS = Object.keys(TAREAS) as [Tarea, ...Tarea[]];

/** Apartados de SKILL.md que valen para todas las tareas (se añaden al método de cada una). */
const APARTADOS_COMUNES = ['Reglas comunes', 'Cómo termina'];

const NOTA_METODO =
  '[Método cargado desde el conector «Oposición TCEE · DCE». Síguelo durante toda la tarea. Cada ruta relativa que cite (references/…, assets/…, scripts/…) se lee con leer_skill(ruta); para los temas revisados usa leer_tema y leer_ficha, y para los datos del opositor, las herramientas del conector (empezar, leer_*; no le pidas el JSON). Antes de escribir un bloque «Para la app» o un cronograma lee los formatos en leer_skill(«references/datos-app.md»), y qué herramienta guarda cada cosa, en leer_skill(«references/conector.md»). Si tu entorno no puede ejecutar código, entrega en Markdown lo que aquí sale en PDF y dilo en una línea.]';

const oposicionParam = z.enum(OPOSICIONES).default('tcee').describe('Oposición de la que se leen los datos: «tcee» (la de siempre) o «dce».');

function json(valor: unknown): CallToolResult {
  return { content: [{ type: 'text', text: JSON.stringify(valor, null, 1) }] };
}

function textoMd(texto: string): CallToolResult {
  return { content: [{ type: 'text', text: texto }] };
}

function error(mensaje: string): CallToolResult {
  return { content: [{ type: 'text', text: mensaje }], isError: true };
}

/** Lo que se devuelve de un texto largo en una llamada (las IA cortan o rechazan los resultados enormes). */
const LIMITE_TEXTO = 40_000;
const tramoParams = {
  desde: z.number().int().min(0).default(0).describe('Carácter desde el que se devuelve el texto (para seguir leyendo donde se quedó).'),
  limite: z.number().int().min(2000).max(120_000).default(LIMITE_TEXTO).describe('Caracteres que se devuelven como mucho (por defecto 40.000).'),
};

/** Un tramo de un texto largo, cortado en un salto de línea, con la indicación de cómo seguir. */
export function tramoTexto(texto: string, desde: number, limite: number, cabecera = '', consejo = ''): CallToolResult {
  if (desde > 0 && desde >= texto.length) return error(`«desde» (${desde}) pasa del final del texto (${texto.length} caracteres).`);
  let fin = Math.min(texto.length, desde + limite);
  if (fin < texto.length) {
    const corte = texto.lastIndexOf('\n', fin);
    if (corte > desde + limite / 2) fin = corte;
  }
  const pie = fin < texto.length ? `\n\n[Sigue: has leído hasta el carácter ${fin} de ${texto.length}. Para continuar, repite la llamada con desde: ${fin}.${consejo ? ` ${consejo}` : ''}]` : '';
  return textoMd(`${cabecera}${texto.slice(desde, fin)}${pie}`);
}

const otraOposicion = (o: Oposicion): Oposicion => (o === 'tcee' ? 'dce' : 'tcee');

/** Si una lectura sale vacía, mira si los datos del opositor están en la otra oposición (el parámetro va a «tcee» por defecto). */
async function avisoOtraOposicion(ctx: Contexto, oposicion: Oposicion): Promise<string | undefined> {
  try {
    const otra = otraOposicion(oposicion);
    const db = await ctx.almacen(otra);
    const [cantes, cronos, ajustes] = await Promise.all([db.listar('cantes'), db.listar('cronogramas'), db.leer('progress/settings')]);
    const hay = cantes.length > 0 || cronos.length > 0 || (Array.isArray(ajustes?.temasEstudiados) && ajustes.temasEstudiados.length > 0);
    return hay ? `Aquí no hay datos de ${oposicion.toUpperCase()}, pero sí de ${otra.toUpperCase()}: repite la llamada con oposicion «${otra}» y úsala en el resto de la conversación.` : undefined;
  } catch {
    return undefined;
  }
}

/** Convierte los fallos previsibles en un mensaje útil para la IA y el opositor. */
async function protegido(f: () => Promise<CallToolResult>): Promise<CallToolResult> {
  try {
    return await f();
  } catch (e) {
    if (e instanceof ErrorSesion) return error(`La sesión con la app ha caducado o se ha revocado: ${e.message}. Pide al opositor que vuelva a conectar el conector «Oposición TCEE · DCE» (en los conectores de su asistente de IA).`);
    if (e instanceof ErrorFirestore) {
      if (e.estado === 403) return error('Firestore ha denegado el acceso (las reglas solo dejan al dueño leer y escribir sus datos). Si el opositor acaba de cambiar de cuenta, que vuelva a conectar el conector.');
      return error(`Error de Firestore (${e.estado}): ${e.message}`);
    }
    return error(`Error inesperado: ${(e as Error).message}`);
  }
}

export function crearServidor(ctx: Contexto): McpServer {
  const server = new McpServer(
    {
      name: 'Oposición TCEE · DCE',
      title: 'Oposición TCEE · DCE',
      version: '1.0.0',
      // Icono y web del servidor (MCP 2025-11-25): los clientes que los admiten enseñan el icono de la app junto al conector.
      websiteUrl: 'https://www.victorgutierrezmarcos.es/oposicion/economia.html',
      icons: [
        { src: 'https://www.victorgutierrezmarcos.es/app/assets/icon/icon.svg', mimeType: 'image/svg+xml', sizes: ['any'] },
        { src: 'https://www.victorgutierrezmarcos.es/app/abrir/icons/Icon-512.png', mimeType: 'image/png', sizes: ['512x512'] },
      ],
    },
    {
      instructions: 'Conector oficial de victorgutierrezmarcos.es para las oposiciones a TCEE y DCE: un equipo de preparación (corrige cantes, dictámenes y escritos, resuelve dudas del temario, hace el cronograma, simula al tribunal, test, tarjetas, informes semanales y prepara clases para preparadores) con los datos de la app «Oposición TCEE · DCE» del usuario conectado. Al empezar una conversación sobre la oposición llama a empezar (dice si es opositor o preparador, en qué oposición tiene datos, cuánto falta para el examen, qué toca esta semana y cómo le han ido los últimos cantes) y, ANTES de cualquier tarea, a leer_metodo(tarea) (sin tarea, la lista), y sigue ese método durante toda la conversación; los ficheros que cite (references/…, assets/…) se leen con leer_skill(ruta), y leer_skill() sin argumentos da las instrucciones generales. Si la skill «prepara-oposicion» ya está instalada, es la misma. Para recomendar fuentes de un tema usa fuentes_tema (y leer_fuente para leer, valorar o comparar cualquiera de esas fuentes), y para saber qué temas forman una materia o un bloque, buscar_temario. Usa estas herramientas solo para el usuario conectado; escribe en la app (proponer_cronograma, guardar_informe_cante, anotar_tema, agendar_clase y, si es preparador, responder_reserva, guardar_nota_alumno, guardar_deberes) solo cuando lo confirme. borrar_datos_oposicion borra todo lo de una oposición y no se puede deshacer: nunca por iniciativa tuya, y solo con la frase que el usuario escriba él mismo. Algunas herramientas llevan una vista interactiva que ciertos clientes (Claude) pintan dentro del chat: test_interactivo (el usuario contesta con botones) y, con vistaPrevia: true, proponer_cronograma, guardar_informe_cante y agendar_clase (el usuario revisa y guarda él con un botón); como no puedes saber si tu cliente la pinta, di siempre al usuario qué va a ver y qué hacer si no ve ningún cuadro. Si es preparador (lo dice empezar), sus alumnos están en leer_alumnos y leer_alumno. Los textos largos se devuelven por tramos (desde/limite): pide un apartado concreto cuando puedas.',
    },
  );

  // Medición anónima del uso: cada herramienta se envuelve para apuntar su nombre, si fue bien y cuánto tardó.
  const registrar = server.registerTool.bind(server) as (...a: unknown[]) => unknown;
  (server as unknown as { registerTool: (...a: unknown[]) => unknown }).registerTool = (nombre, config, manejador) =>
    registrar(nombre, config, async (args: unknown, extra: unknown) => {
      const t0 = Date.now();
      let ok = false;
      try {
        const r = await (manejador as (a: unknown, e: unknown) => Promise<CallToolResult>)(args, extra);
        ok = r?.isError !== true;
        return r;
      } finally {
        const op = (args as { oposicion?: unknown } | null)?.oposicion;
        ctx.medir?.({ herramienta: String(nombre), oposicion: typeof op === 'string' ? op : '', ok, ms: Date.now() - t0 });
      }
    });

  registrarVistas(server);

  /** Títulos de los temas (para las vistas): solo los que se piden y existen en el programa. */
  const titulosDe = async (oposicion: Oposicion, temas: string[]): Promise<Record<string, string>> => {
    const programa = await ctx.fuentes().then((i) => (oposicion === 'dce' ? i.dce : i.tcee)).catch(() => null);
    const t: Record<string, string> = {};
    for (const c of new Set(temas)) if (programa?.[c]?.titulo) t[c] = programa[c].titulo;
    return t;
  };
  const VISTA_PREVIA = (que: string, boton: string) =>
    z.boolean().default(false).describe(`true: no ${que} nada; lo valida y lo devuelve para enseñarlo. En los clientes que pintan vistas interactivas (Claude) el usuario lo ve en un cuadro con el botón «${boton}» y lo hace él; en los demás, enséñaselo tú y, cuando confirme, repite la llamada sin vistaPrevia. Recomendado como primer paso.`);
  const siguientePrevia = (boton: string) =>
    `No se ha guardado nada todavía. Dile al usuario, en una o dos líneas, que lo revise y que pulse «${boton}» en el cuadro que tiene delante; y que, si no ve ningún cuadro (su cliente no pinta vistas), te lo confirme por escrito: entonces repite la llamada sin vistaPrevia. No repitas el contenido entero si ya se lo has enseñado.`;

  server.registerTool(
    'leer_skill',
    {
      title: 'Cargar las instrucciones del equipo de preparación',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Sin ruta devuelve SKILL.md: las instrucciones generales de todo el equipo de preparación (para una tarea concreta es mejor leer_metodo, que ya trae lo necesario) (qué agente usar para cada petición, reglas, formatos de la app, aviso final). Con ruta devuelve el fichero que SKILL.md cite: «references/agentes/corrector-cante.md», «references/datos-app.md», «references/perfiles.md», «assets/plantilla-informe-cante.md»… Siempre la última versión publicada.',
      inputSchema: {
        ruta: z.string().max(160).default('SKILL.md').describe('Ruta relativa dentro de la skill, como la cita SKILL.md (por defecto, SKILL.md).'),
        ...tramoParams,
      },
    },
    async ({ ruta, desde, limite }) =>
      protegido(async () => {
        const limpia = ruta.trim().replace(/^\.?\//, '').replace(/^prepara-oposicion\//, '');
        if (!RUTA_SKILL.test(limpia) || limpia.includes('..')) {
          return error(`Ruta no válida: «${ruta}». Usa una ruta relativa de la skill, como «SKILL.md» o «references/agentes/dudas.md».`);
        }
        // El material exclusivo no está en la web: sale del KV del conector, que solo se lee con sesión.
        const exclusivo = /^references\/((?:temas\/[^/]+|dictamen|canon)\/.+)$/.exec(limpia)?.[1];
        const texto = exclusivo ? await ctx.contenido.crudo(exclusivo) : await ctx.skill(limpia);
        if (texto === null) return error(`No existe «${limpia}» en la skill publicada. Comprueba la ruta en SKILL.md${exclusivo ? ' o en listar_temas_revisados' : ''}.`);
        const cabecera = desde > 0 ? '' : limpia === 'SKILL.md' ? `${NOTA_CONECTOR}\n\n` : exclusivo ? `${AVISO_EXCLUSIVO}\n\n` : '';
        return tramoTexto(texto, desde, limite, cabecera);
      }),
  );

  server.registerTool(
    'leer_metodo',
    {
      title: 'Cargar el método de una tarea',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Las instrucciones del equipo de preparación para una tarea concreta (corregir un cante, simular al tribunal, hacer el cronograma…) con las reglas comunes y cómo se entrega. LLÁMALA ANTES de hacer cualquiera de estas tareas y síguela. Sin «tarea» devuelve la lista de tareas y cuándo usar cada una.',
      inputSchema: { tarea: z.enum(NOMBRES_TAREAS).optional().describe('La tarea; si falta, la lista de tareas.') },
    },
    async ({ tarea }) =>
      protegido(async () => {
        if (!tarea) {
          const filas = NOMBRES_TAREAS.map((t) => `- \`${t}\` (${TAREAS[t].titulo}): cuando el opositor ${TAREAS[t].cuando}.`);
          return textoMd(`Tareas del equipo de preparación. Elige la que encaje con lo que pide el opositor y llama a leer_metodo(tarea). Si encaja en varias, haz primero lo que ha pedido y ofrece el resto en una línea al final.\n\n${filas.join('\n')}`);
        }
        const skill = await ctx.skill('SKILL.md');
        const textos = await Promise.all(TAREAS[tarea].ficheros.map(async (ruta) => [ruta, await ctx.skill(ruta)] as const));
        const faltan = textos.filter(([, t]) => t === null).map(([r]) => r);
        if (faltan.length === textos.length) return error(`El método de «${tarea}» no está publicado (${faltan.join(', ')}).`);
        // La cabecera de SKILL.md (quién eres y para quién trabajas) y las reglas comunes a todas las tareas.
        const cabecera = skill ? skill.replace(/^---[\s\S]*?---\s*/, '').split(/\n## /)[0].trim() : '';
        const comunes = skill ? APARTADOS_COMUNES.map((a) => extraerApartado(skill, a)).filter(Boolean) : [];
        const partes = [NOTA_METODO, cabecera, ...comunes, ...textos.filter(([, t]) => t !== null).map(([ruta, t]) => `<!-- ${ruta} -->\n${t}`)];
        return textoMd(partes.filter(Boolean).join('\n\n---\n\n'));
      }),
  );

  server.registerTool(
    'fuentes_tema',
    {
      title: 'Fuentes para estudiar un tema',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Todas las fuentes que hay para un tema de TCEE o DCE, para recomendar con qué estudiarlo: si está revisado (material exclusivo: léelo con leer_tema y leer_ficha), el PDF del temario de victorgutierrezmarcos.es, el tema equivalente de manuelcabadogarcia.es (DCE), los apuntes de otros TCEE del repositorio de la ATCEE (autor, promoción, numeración y enlace) y los manuales que recomienda la ATCEE para su bloque. Úsala para «¿qué fuente me recomiendas para el 3.B.26?», «¿quién tiene apuntes de este tema?» o antes de explicar un tema no revisado.',
      inputSchema: { tema: z.string().describe('Código del tema: «3.B.26», «3B26», «1.A.4» (DCE)…'), oposicion: oposicionParam },
    },
    async ({ tema, oposicion }) =>
      protegido(async () => {
        const cod = codigoTema(tema);
        if (!cod) return error(`«${tema}» no parece un código de tema (por ejemplo, «3.B.26»).`);
        const indice = await ctx.fuentes();
        const t = (oposicion === 'dce' ? indice.dce : indice.tcee)[cod] ?? indice.tcee[cod] ?? indice.dce[cod];
        if (!t) return error(`No encuentro el tema ${cod} en el programa de ${oposicion.toUpperCase()}. Usa buscar_temario para localizarlo.`);
        const atcee = t.atcee ?? [];
        return json({
          tema: cod,
          ...t,
          atcee: atcee.map((a) => ({ ...a, ...(a.numeracion === 'antigua' ? { ojo: 'numeración antigua: comprueba por el nombre del fichero que es este tema' } : {}) })),
          manuales: manualesPara(indice, t),
          equivalentes: t.equivalentes_tcee?.map((c) => ({ codigo: c, titulo: indice.tcee[c]?.titulo })),
          comoRecomendar:
            'Orden: 1) si está revisado, el tema revisado y su ficha (son la referencia de la skill); 2) si no, el PDF de la web si está disponible; 3) en teoría económica, el tema de Manuel; 4) los apuntes de la ATCEE de numeración actual y promoción más reciente (LXXV, LXXIV), y después los demás; 5) los manuales del bloque para profundizar. Di por qué recomiendas cada uno (actualidad, enfoque, extensión si la sabes) y que contraste con su preparador. Para valorar unos apuntes (calidad, actualidad, enfoque, si cubren el título oficial) léelos con leer_fuente; no reproduzcas su texto: resume, valora y cita al autor y la promoción. ' +
            indice.aviso,
        });
      }),
  );

  server.registerTool(
    'leer_fuente',
    {
      title: 'Leer una fuente de un tema',
      annotations: { readOnlyHint: true, openWorldHint: true },
      description:
        'Lee cualquier fuente de las que da fuentes_tema para valorarla, compararla o explicar su enfoque: los apuntes de otros TCEE del repositorio de la ATCEE (enlace de Drive: Word, Documento de Google, PDF, .doc antiguo o presentación), el PDF de un tema de victorgutierrezmarcos.es o la página de un tema de manuelcabadogarcia.es. Devuelve autor, promoción y numeración (si es de la ATCEE), el esquema (los títulos), el número de palabras y el texto por tramos (desde/limite, en caracteres). Úsala para ordenar apuntes por calidad, ver si cubren el título oficial, comparar autores o preparar una explicación. No reproduzcas su texto: resume, valora y cita al autor.',
      inputSchema: {
        enlace: z.string().describe('El enlace tal como lo da fuentes_tema: Drive (https://drive.google.com/file/d/…/view), el PDF de la web (https://www.victorgutierrezmarcos.es/oposicion/temario/…pdf) o la página de Manuel (https://manuelcabadogarcia.es/…html).'),
        desde: z.number().int().min(0).default(0).describe('Carácter desde el que se devuelve el texto (para seguir leyendo).'),
        limite: z.number().int().min(1000).max(40000).default(15000).describe('Caracteres de texto que se devuelven (por defecto 15.000; para comparar varios, el esquema y 4.000 suelen bastar).'),
      },
    },
    async ({ enlace, desde, limite }) =>
      protegido(async () => {
        const indice = await ctx.fuentes();
        const tramo = (ficha: Record<string, unknown>, formato: string, esquema: string[], texto: string, aviso: string) => {
          if (!texto.trim()) return error(`«${ficha.fichero ?? enlace}» no tiene texto que se pueda leer (probablemente es un escaneado). Recomiéndalo con su enlace.`);
          const fin = Math.min(texto.length, desde + limite);
          return json({
            ...ficha, formato, palabras: texto.split(/\s+/).filter(Boolean).length, caracteres: texto.length,
            esquema: esquema.length ? esquema : undefined, texto: texto.slice(desde, fin), siguiente: fin < texto.length ? fin : undefined, aviso,
          });
        };
        // 1. El PDF de un tema de esta web: su texto, extraído y guardado por tema
        const web = enlace.match(/victorgutierrezmarcos\.es\/oposicion\/temario\/[^\s?#]+?\/(\d[A-Z]\d{2})\.pdf/i);
        if (web) {
          const cod = codigoTema(web[1])!;
          const paquete = await ctx.textos(cod);
          if (!paquete?.web?.texto) return error(`El texto del PDF del ${cod} no está en el conector todavía. Enlace: ${enlace}`);
          const esquema = [...paquete.web.texto.matchAll(/^((?:[IVX]{1,5}|\d{1,2}(?:\.\d{1,2}){0,2})\.\s.{3,110})$/gm)].map((m) => m[1]).slice(0, 80);
          return tramo({ tema: cod, tituloOficial: indice.tcee[cod]?.titulo, autor: 'Víctor Gutiérrez Marcos', fuente: 'temario de victorgutierrezmarcos.es (sin revisar: puede tener datos desfasados)', enlace }, 'pdf', esquema, paquete.web.texto,
            'Tema del temario de la web, de Víctor Gutiérrez Marcos (licencia CC BY-NC-ND). Si el tema está revisado, manda la versión revisada (leer_tema).');
        }
        // 2. Una página de manuelcabadogarcia.es (con permiso de Manuel Cabado García)
        if (/^https:\/\/(www\.)?manuelcabadogarcia\.es\/[\w\-/.]+\.html?$/i.test(enlace.trim())) {
          const pagina = await ctx.pagina(enlace.trim());
          if (!pagina) return error(`No se ha podido leer ${enlace}.`);
          let tema: string | undefined;
          for (const [cod, t] of Object.entries(indice.dce)) if (t.manuel === enlace.trim()) tema = cod;
          return tramo({ temaDce: tema, tituloOficial: tema ? indice.dce[tema]?.titulo : undefined, equivalentesTcee: tema ? indice.dce[tema]?.equivalentes_tcee : undefined, autor: 'Manuel Cabado García', fuente: 'manuelcabadogarcia.es (DCE)', enlace }, 'html', pagina.esquema, pagina.texto,
            'Tema de Manuel Cabado García (DCE): sirve para la teoría económica de TCEE, pero el título de TCEE puede pedir más. Cítalo como suyo.');
        }
        // 3. Unos apuntes del repositorio de la ATCEE
        const id = idDeDrive(enlace);
        if (!id) return error(`«${enlace}» no es una fuente que el conector sepa leer: usa los enlaces que da fuentes_tema.`);
        let ficha: Record<string, unknown> | null = null;
        let tema = '';
        for (const [cod, t] of Object.entries(indice.tcee)) {
          const a = t.atcee?.find((x) => x.url.includes(id));
          if (a) {
            tema = cod;
            ficha = { tema: cod, tituloOficial: t.titulo, autor: a.autor, promocion: a.promocion, anio: a.anio, numeracion: a.numeracion, fichero: a.fichero, enlace: a.url };
            break;
          }
        }
        if (!ficha) return error('Ese fichero no está en el índice de apuntes de la ATCEE: el conector solo lee los apuntes de ese repositorio (búscalos con fuentes_tema).');
        const aviso = `Apuntes de ${ficha.autor} (${ficha.promocion}), del repositorio de la ATCEE: son de su autor y no son condición necesaria ni suficiente para aprobar. Léelos para valorarlos y explicarlos; no copies su texto. ${ficha.numeracion === 'antigua' ? 'Numeración antigua: comprueba por el contenido que es este tema.' : ''}`.trim();
        const guardado = (await ctx.textos(tema))?.atcee?.[id];
        if (guardado) return tramo(ficha, String(ficha.fichero).split('.').pop() ?? 'texto', [], guardado.texto, aviso);
        try {
          const ap = await ctx.apuntes(id);
          return tramo(ficha, ap.formato, ap.esquema, ap.texto, aviso);
        } catch (e) {
          if (e instanceof ErrorApuntes) return error(`No se puede leer «${ficha.fichero}» todavía: ${e.message}. Enlace: ${ficha.enlace}`);
          throw e;
        }
      }),
  );

  server.registerTool(
    'buscar_temario',
    {
      title: 'Buscar en el programa',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Busca en el programa de TCEE y DCE por materia, bloque o palabras del título, y también por contenido (los apartados de cada tema del temario de la web: un modelo, una curva, un autor), y devuelve los temas que encajan, agrupados por bloque de la organización del temario, con su idea clave, qué fuentes tienen (revisado, PDF de la web, Manuel, número de apuntes de la ATCEE) y, en «porContenido», los apartados donde aparece lo buscado. Úsala para «¿qué temas forman la teoría microeconómica?», «¿dónde se estudia la curva de Phillips?», «¿qué temas de comercio internacional hay?». Sin consulta, devuelve los bloques con sus temas (en DCE, las partes del programa).',
      inputSchema: {
        consulta: z.string().max(120).default('').describe('Materia, bloque o palabras: «microeconomía», «crecimiento», «Phillips», «parte B»…'),
        oposicion: oposicionParam,
      },
    },
    async ({ consulta, oposicion }) =>
      protegido(async () => {
        const indice = await ctx.fuentes();
        const temas = oposicion === 'dce' ? indice.dce : indice.tcee;
        const resumen = (cod: string) => {
          const t = temas[cod];
          if (!t) return null;
          return {
            codigo: cod, titulo: t.titulo, idea: t.idea ?? undefined, revisado: t.revisado || undefined,
            pdfWeb: t.web?.disponible ? t.web.pdf : undefined,
            manuel: Array.isArray(t.manuel) ? t.manuel.map((m) => m.url) : t.manuel || undefined,
            apuntesAtcee: t.atcee?.length || undefined,
          };
        };
        const palabras = sinTildes(consulta).split(/[^a-z0-9ñ.]+/).filter((p) => p.length > 2 && !['los', 'las', 'del', 'que', 'tema', 'temas', 'parte', 'teoria'].includes(p));
        const encaja = (texto: string) => palabras.length > 0 && palabras.every((p) => sinTildes(texto).includes(p.slice(0, Math.max(5, p.length - 2))));
        const bloques = indice.bloques
          .filter((b) => oposicion === 'tcee' && (!palabras.length || encaja(`${b.nombre} ${b.categoria}`)))
          .map((b) => ({ bloque: b.nombre, categoria: b.categoria, temas: b.temas.map(resumen).filter(Boolean) }));
        if (oposicion === 'dce' && !palabras.length) {
          // DCE no tiene bloques propios: sin consulta, el programa por partes.
          const partes = new Map<string, string[]>();
          for (const [c, t] of Object.entries(temas)) partes.set(t.parte, [...(partes.get(t.parte) ?? []), c]);
          for (const [parte, codigos] of partes) bloques.push({ bloque: parte, categoria: `Ejercicio ${temas[codigos[0]].ejercicio}`, temas: codigos.map(resumen).filter(Boolean) });
        }
        const enBloques = new Set(bloques.flatMap((b) => b.temas.map((t) => t!.codigo)));
        const sueltos = palabras.length
          ? Object.entries(temas).filter(([c, t]) => !enBloques.has(c) && encaja(`${c} ${t.titulo} ${t.bloque ?? ''} ${t.categoria ?? ''} ${t.idea ?? ''} ${t.parte}`)).map(([c]) => resumen(c))
          : [];
        // Por contenido: los apartados de los PDF del temario (solo TCEE) que llevan todas las palabras.
        const indices = palabras.length && oposicion === 'tcee' ? await ctx.skill('references/temario/indices-temas.md').catch(() => null) : null;
        const porContenido = indices
          ? [...apartadosPorTema(indices)]
              .map(([cod, lineas]) => ({ cod, lineas: lineas.filter((l) => encaja(l)) }))
              .filter((x) => x.lineas.length && temas[x.cod])
              .sort((a, b) => b.lineas.length - a.lineas.length)
              .slice(0, 12)
              .map((x) => ({ ...resumen(x.cod)!, apartados: x.lineas.slice(0, 6), masApartados: x.lineas.length > 6 ? x.lineas.length - 6 : undefined }))
          : [];
        if (!bloques.length && !sueltos.length && !porContenido.length) return error(`Nada en el programa de ${oposicion.toUpperCase()} encaja con «${consulta}». Prueba con otra palabra o sin consulta para ver los bloques.`);
        return json({
          consulta, oposicion, bloques, otrosTemas: sueltos.slice(0, 40), porContenido: porContenido.length ? porContenido : undefined,
          nota: 'Los bloques y categorías son la organización del temario de victorgutierrezmarcos.es (oposicion/organizacion.html): agrupan temas que comparten modelos y conviene estudiar juntos. «porContenido» son los temas cuyos apartados (marcadores del PDF de la web, con su página) llevan lo buscado, ordenados por número de apartados. Para las fuentes de un tema concreto, fuentes_tema.',
        });
      }),
  );

  server.registerTool(
    'leer_progreso',
    {
      title: 'Leer el progreso del opositor',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Resumen de la preparación tal como lo exporta la app para la IA: fechas de los ejercicios e hitos, temas estudiados y en repaso, agenda por tema (vueltas y pendientes), notas propias, horario semanal, repaso Leitner por caja (vencidas y temas con más fallos) y ajustes (rúbrica, temas que no quiere cantar y desde cuándo, temas fijados para cada clase), los deberes pendientes de sus cantes y su mejor racha. Mismo formato que oposicion_<id>_para_claude.json sin «cantes», «cronograma» ni «tests»: para eso están las otras herramientas.',
      inputSchema: { oposicion: oposicionParam },
    },
    async ({ oposicion }) =>
      protegido(async () => {
        const db = await ctx.almacen(oposicion);
        const [settings, plan, leitner, notas, banco, cantes] = await Promise.all([
          db.leer('progress/settings'),
          db.leer('progress/plan'),
          db.leer('progress/spaced_repetition'),
          db.listar('notes'),
          ctx.banco(),
          db.listar('cantes'),
        ]);
        const aviso = !settings && !plan && !cantes.length ? await avisoOtraOposicion(ctx, oposicion) : undefined;
        return json({ ...resumenProgreso(oposicion, settings, plan, leitner, notas, banco.temas), deberesPendientes: deberesPendientes(cantes), ...(aviso ? { aviso } : {}) });
      }),
  );

  server.registerTool(
    'leer_resultados_test',
    {
      title: 'Leer los resultados de los tests',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Los últimos tests del opositor (simulacros «test», reto «diario» y repaso «repaso»), del más reciente al más antiguo, con nota sobre 10, aciertos, fallos, sin responder, tiempo y el acierto por tema calculado a partir de sus respuestas (solo en los tests hechos en la app; los de la web no guardan respuestas).',
      inputSchema: {
        oposicion: oposicionParam,
        desde: z.string().optional().describe('Solo tests desde esta fecha, «AAAA-MM-DD».'),
        limite: z.number().int().min(1).max(100).default(20).describe('Cuántos tests como mucho (1-100).'),
      },
    },
    async ({ oposicion, desde, limite }) =>
      protegido(async () => {
        const db = await ctx.almacen(oposicion);
        const banco = await ctx.banco();
        const where = desde && /^\d{4}-\d{2}-\d{2}$/.test(desde) ? { campo: 'timestamp', op: 'GREATER_THAN_OR_EQUAL' as const, valor: desdeMadrid(desde), marcaDeTiempo: true } : undefined;
        const docs = await db.consultar('exam_results', { orderBy: 'timestamp', descendente: true, limite, where });
        const tests = docs.map((d) => resumenTest(d.id, d.datos, banco));
        const aviso = !tests.length && !where ? await avisoOtraOposicion(ctx, oposicion) : undefined;
        return json({ oposicion, tests, ...(aviso ? { aviso } : {}) });
      }),
  );

  server.registerTool(
    'leer_cantes',
    {
      title: 'Leer el diario de cantes',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Los últimos cantes hechos (con su «resultado»: tema cantado, segundos, valoración 1-5 y por tema, comentarios, criterios de la rúbrica, apartados cubiertos) y los próximos programados. «esquema: true» es un esquema a ciegas, no un cante entero. La transcripción del cante no está en la nube (queda en el móvil): el opositor la sube si quiere. El «id» de cada cante sirve para guardar_informe_cante.',
      inputSchema: {
        oposicion: oposicionParam,
        n: z.number().int().min(1).max(100).default(15).describe('Cuántos cantes hechos, del más reciente al más antiguo (1-100).'),
      },
    },
    async ({ oposicion, n }) =>
      protegido(async () => {
        const db = await ctx.almacen(oposicion);
        const docs = await db.listar('cantes');
        const aviso = !docs.length ? await avisoOtraOposicion(ctx, oposicion) : undefined;
        return json({ oposicion, ...resumenCantes(docs, n), ...(aviso ? { aviso } : {}), nota: 'Las correcciones guardadas de cada cante (informes anteriores) se leen con leer_informes_cante.' });
      }),
  );

  server.registerTool(
    'leer_cronograma',
    {
      title: 'Leer el cronograma activo',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'El cronograma de estudio en curso (semana a semana: primer día, día del cante y temas; las de descanso marcadas), con los temas ya hechos, los desmarcados, el ritmo (temasPorSemana), el día de cante (1 = lunes … 7 = domingo), las fases si es por fases, las propuestas de cambio de sus preparadores que tiene pendientes (quién, nota, ritmo y fin) y los cronogramas completos que le han mandado y aún no ha respondido. Null si no tiene ninguno activo.',
      inputSchema: { oposicion: oposicionParam },
    },
    async ({ oposicion }) =>
      protegido(async () => {
        const db = await ctx.almacen(oposicion);
        const docs = await db.listar('cronogramas');
        const activo = cronogramaActivo(docs);
        const recibidos = (await db.listar('cronogramasRecibidos').catch(() => []))
          .filter((r) => r.datos.respuesta == null)
          .map((r) => ({ id: r.id, de: typeof r.datos.deNombre === 'string' ? r.datos.deNombre : 'Preparador', enviado: soloFecha(r.datos.enviado), nota: typeof r.datos.nota === 'string' ? r.datos.nota : '', ...(({ semanas, ejercicio, fin }) => ({ ejercicio, fin, semanas }))(resumenCronograma(r.id, r.datos)) }));
        const aviso = !docs.length ? await avisoOtraOposicion(ctx, oposicion) : undefined;
        return json({ oposicion, cronograma: activo ? resumenCronograma(activo.id, activo.datos) : null, archivados: docs.length - (activo ? 1 : 0), recibidosSinResponder: recibidos.length ? recibidos : undefined, ...(aviso ? { aviso } : {}) });
      }),
  );

  server.registerTool(
    'proponer_cronograma',
    {
      title: 'Guardar en la app un cronograma nuevo',
      annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: false, openWorldHint: false },
      description:
        'Crea en la app el cronograma acordado con el opositor (pasa a ser el activo; el anterior queda archivado, no se borra; si era del mismo ejercicio, conserva los temas que ya tenía hechos y sigue compartido con su preparador si lo estaba). Sin vistaPrevia, úsalo SOLO después de enseñárselo entero y de que confirme expresamente que lo quiere guardar; con vistaPrevia: true no guarda nada y el usuario lo ve como calendario y lo guarda él con un botón (en los clientes con vistas interactivas). Una entrada por semana de cante, con la fecha del cante (AAAA-MM-DD, siempre en el día de cante) y los códigos de los temas («3.A.8»); las semanas sin cante entre la primera y la última quedan de descanso. La app lo muestra al sincronizar (al abrirla o cada pocos minutos).',
      inputSchema: {
        oposicion: oposicionParam,
        ejercicio: z.number().int().min(1).max(5).describe('Ejercicio (3 o 4 en TCEE; 1 en DCE).'),
        diaCante: z.number().int().min(1).max(7).describe('Día de la semana en que canta: 1 = lunes … 7 = domingo.'),
        semanas: z
          .array(z.object({ cante: z.string().describe('Fecha del cante de esa semana, AAAA-MM-DD.'), temas: z.array(z.string()).describe('Códigos de los temas, «3.A.8».') }))
          .min(1)
          .max(120),
        temasPorSemana: z.number().int().min(1).max(12).optional().describe('Ritmo nominal; si falta, la media de las semanas con temas.'),
        examen: z.string().optional().describe('Fecha del examen (AAAA-MM-DD), solo en cronogramas de un ejercicio escrito.'),
        vistaPrevia: VISTA_PREVIA('guarda', 'Guardar en la app'),
      },
      _meta: metaVista('cronograma'),
    },
    async ({ oposicion, ejercicio, diaCante, semanas, temasPorSemana, examen, vistaPrevia }) =>
      protegido(async () => {
        const { documento, errores } = construirCronograma({ semanas, diaCante, ejercicio, temasPorSemana, examen }, new Date(), await ctx.cliente());
        if (errores.length) return error(`No se ha guardado el cronograma:\n- ${errores.join('\n- ')}`);
        // Un código que no está en el programa se queda en la app como un tema fantasma: mejor pararlo aquí.
        const programa = await ctx.fuentes().then((i) => (oposicion === 'dce' ? i.dce : i.tcee)).catch(() => null);
        if (programa && Object.keys(programa).length >= 20) {
          const ajenos = (documento.temas as string[]).filter((t) => !programa[t]);
          if (ajenos.length) return error(`No se ha guardado el cronograma: ${ajenos.join(', ')} no ${ajenos.length > 1 ? 'están' : 'está'} en el programa de ${oposicion.toUpperCase()} (míralo con buscar_temario).`);
        }
        const vista = { oposicion, cronograma: resumenCronograma(documento.id as string, documento), titulos: await titulosDe(oposicion, documento.temas as string[]) };
        if (vistaPrevia) return json({ guardado: false, vistaPrevia: true, ...vista, siguiente: siguientePrevia('Guardar en la app') });
        const db = await ctx.almacen(oposicion);
        const anteriores = await db.listar('cronogramas');
        const marca = ahoraMadrid();
        const heredado = heredarCronograma(documento, cronogramaActivo(anteriores)?.datos ?? null);
        // Archivar el anterior y crear el nuevo, a la vez: si algo falla, no se queda sin cronograma activo.
        await db.lote([
          ...anteriores.filter((c) => c.datos.archivado !== true).map((c) => ({ ruta: `cronogramas/${Firestore.tramo(c.id)}`, datos: { archivado: true, updatedAt: marca }, soloCampos: ['archivado', 'updatedAt'] })),
          { ruta: `cronogramas/${documento.id as string}`, datos: documento },
        ]);
        return json({
          guardado: true,
          sigueCompartido: heredado.compartido || undefined,
          temasYaHechosConservados: heredado.hechos || undefined,
          id: documento.id,
          semanas: (documento.semanas as Json[]).length,
          temas: (documento.temas as Json[]).length,
          archivados: anteriores.filter((c) => c.datos.archivado !== true).map((c) => c.id),
          aviso: `Dile al opositor que lo verá en la app (Cronograma) al sincronizar y que puede retocar cada semana allí.${heredado.compartido ? ' Sigue compartido con su preparador, como el anterior.' : ' No está compartido con ningún preparador: si quiere que su preparador lo vea, que lo comparta desde la app.'}`,
          ...vista,
        });
      }),
  );

  server.registerTool(
    'guardar_informe_cante',
    {
      title: 'Guardar en la app el informe de un cante',
      annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: false, openWorldHint: false },
      description:
        'Guarda el informe de corrección de un cante en la app (cantes/{id}/informes) y, si se dan, pone en el diario la valoración (1-5, general y por tema), los comentarios (hasta 300 caracteres) y los criterios de la rúbrica, como haría el opositor en «¿Cómo ha ido el cante?». No cambia una valoración o unos comentarios que ya estuvieran puestos (lo dice en «yaHabia») salvo con «sustituir». Úsalo SOLO con un cante que ya está en el diario (su «id» viene de leer_cantes) y después de que el opositor confirme el bloque «Para la app»; o con vistaPrevia: true, que no guarda nada: el usuario ve la valoración, la rúbrica, los comentarios y las tareas en un cuadro, los retoca y lo guarda él con un botón (en los clientes con vistas interactivas).',
      inputSchema: {
        oposicion: oposicionParam,
        canteId: z.string().min(1).describe('Id del cante (de leer_cantes).'),
        informe: z.string().min(1).describe('El informe completo en Markdown (lo que se le ha dicho al opositor).'),
        valoracion: z.number().int().min(1).max(5).optional().describe('Valoración general 1-5.'),
        valoraciones: z.record(z.string(), z.number().int().min(1).max(5)).optional().describe('Valoración por tema cantado («3.A.8»: 3).'),
        comentarios: z.string().max(300).optional().describe('Comentarios para el diario, lo más importante primero (≤ 300 caracteres).'),
        criterios: z.record(z.string(), z.number().int().min(1).max(5)).optional().describe('Nota 1-5 por criterio de la rúbrica, solo si el opositor la usa.'),
        tareas: z.array(z.string()).max(10).optional().describe('Tareas para antes del próximo cante (en un cante propio se apuntan también como deberes en la app).'),
        sustituir: z.boolean().default(false).describe('true solo si el opositor ha confirmado que quiere cambiar la valoración o los comentarios que ya había en el diario.'),
        vistaPrevia: VISTA_PREVIA('guarda', 'Guardar en la app'),
      },
      _meta: metaVista('informe'),
    },
    async ({ oposicion, canteId, informe, valoracion, valoraciones, comentarios, criterios, tareas, sustituir, vistaPrevia }) =>
      protegido(async () => {
        const { id, documento, resultado, errores } = construirInforme({ informe, valoracion, valoraciones, comentarios, criterios, tareas }, new Date(), await ctx.cliente());
        if (errores.length) return error(`No se ha guardado el informe:\n- ${errores.join('\n- ')}`);
        const db = await ctx.almacen(oposicion);
        const cid = Firestore.tramo(canteId);
        const cante = await db.leer(`cantes/${cid}`);
        if (!cante) return error(`No hay ningún cante con id «${canteId}» en la app.`);
        if (vistaPrevia) {
          const c = resumenCante(canteId, cante);
          return json({
            guardado: false,
            vistaPrevia: true,
            oposicion,
            cante: { id: canteId, fecha: c.fecha, temas: c.temas, estado: typeof cante.estado === 'string' ? cante.estado : 'pendiente', conPreparador: typeof cante.preparador === 'string' || undefined },
            propuesta: { valoracion, valoraciones, comentarios, criterios, tareas },
            yaHabia: sinPisar(resultado, cante.resultado).yaHabia,
            siguiente: siguientePrevia('Guardar en la app'),
          });
        }
        await db.escribir(`cantes/${cid}/informes/${id}`, documento);
        const marca = ahoraMadrid();
        const avisos: string[] = [];
        // Lo que ya apuntó el opositor o su preparador no se pisa sin que él lo pida.
        const { escribir, yaHabia } = sustituir ? { escribir: resultado, yaHabia: {} } : sinPisar(resultado, cante.resultado);
        const cambios: { [k: string]: Json } = {};
        const campos: string[] = [];
        if (Object.keys(escribir).length && cante.estado === 'hecho') {
          cambios.resultado = escribir;
          campos.push(...Object.keys(escribir).map((k) => `resultado.${k}`));
        } else if (Object.keys(resultado).length && cante.estado !== 'hecho') {
          avisos.push('El cante no está marcado como hecho en la app: el informe se ha guardado, pero la valoración y los comentarios no (que lo cierre en la app).');
        }
        if (Object.keys(yaHabia).length)
          avisos.push(`En el diario ya había ${Object.keys(yaHabia).join(', ')} (puesto por el opositor o por su preparador) y se ha dejado como estaba. Díselo y, si quiere cambiarlo, repite con sustituir: true.`);
        // Las tareas, como deberes del cante, solo si es suyo: en una clase los deberes los pone el preparador.
        let deberes = 0;
        if (tareas?.length && typeof cante.preparador !== 'string') {
          const d = anadirDeberes(cante.tareas, tareas, marca);
          if (d.nuevas) {
            cambios.tareas = d.tareas;
            campos.push('tareas');
            deberes = d.nuevas;
          }
        } else if (tareas?.length) {
          avisos.push('Es una clase con su preparador: las tareas quedan en el informe, no como deberes (esos los pone el preparador).');
        }
        if (campos.length) await db.escribir(`cantes/${cid}`, { ...cambios, updatedAt: marca }, [...campos, 'updatedAt']);
        return json({ guardado: true, informe: id, diarioActualizado: 'resultado' in cambios, deberesApuntados: deberes || undefined, yaHabia: Object.keys(yaHabia).length ? yaHabia : undefined, aviso: avisos.join(' ') || undefined });
      }),
  );

  server.registerTool(
    'anotar_tema',
    {
      title: 'Apuntar en la agenda de un tema',
      annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: true, openWorldHint: false },
      description:
        'Apunta en la app, en la agenda de un tema, lo que el opositor tiene que arreglar en su próxima vuelta («repasar la ecuación de Slutsky», «aprender la fecha del Acta Única») y, si lo pide, marca el tema como estudiado o en repaso. Úsala al terminar una corrección, una duda o un test, SOLO después de enseñarle lo que vas a apuntar y de que lo confirme. No repite un apunte que ya esté pendiente. La app lo muestra al sincronizar (Temario → el tema → Agenda).',
      inputSchema: {
        oposicion: oposicionParam,
        tema: z.string().describe('Código del tema, «3.A.8».'),
        pendientes: z.array(z.string().min(3).max(200)).max(8).default([]).describe('Apuntes para la próxima vuelta: cortos y concretos, uno por cosa que arreglar.'),
        marcar: z.enum(['estudiado', 'en_repaso']).optional().describe('Marca además el tema como estudiado o en repaso (solo si el opositor lo pide).'),
      },
    },
    async ({ oposicion, tema, pendientes, marcar }) =>
      protegido(async () => {
        const cod = codigoTema(tema);
        if (!cod) return error(`«${tema}» no parece un código de tema (por ejemplo, «3.A.8»).`);
        if (!pendientes.length && !marcar) return error('No hay nada que apuntar: pasa «pendientes» o «marcar».');
        const db = await ctx.almacen(oposicion);
        const marca = ahoraMadrid();
        const salida: Record<string, unknown> = { tema: cod };
        if (pendientes.length) {
          const ruta = `notes/${cod.replace(/\./g, '_')}`;
          const { pendientes: lista, nuevos } = anadirApuntes((await db.leer(ruta))?.pendientes, pendientes, marca);
          if (nuevos) await db.escribir(ruta, { tema: cod, pendientes: lista, agendaUpdatedAt: marca }, ['tema', 'pendientes', 'agendaUpdatedAt']);
          salida.apuntados = nuevos;
          if (nuevos < pendientes.length) salida.yaEstaban = pendientes.length - nuevos;
        }
        if (marcar) {
          const campo = marcar === 'estudiado' ? 'temasEstudiados' : 'temasEnRepaso';
          const ajustes = (await db.leer('progress/settings')) ?? {};
          const actuales = Array.isArray(ajustes[campo]) ? (ajustes[campo] as Json[]).map(String) : [];
          if (!actuales.includes(cod)) await db.escribir('progress/settings', { [campo]: [...actuales, cod].sort(), updatedAt: marca }, [campo, 'updatedAt']);
          salida.marcado = marcar;
        }
        return json({ ...salida, aviso: 'Lo verá en la app al sincronizar (al abrirla o a los pocos minutos).' });
      }),
  );

  // ------------------------------------------------------------ Visión de conjunto

  /** Lo esencial de una oposición para arrancar una conversación; null si no tiene nada en ella. */
  const panorama = async (op: Oposicion, hoy: string) => {
    const db = await ctx.almacen(op);
    const [ajustes, plan, cantes, cronos, tests, perfil, preparadores] = await Promise.all([
      db.leer('progress/settings'),
      db.leer('progress/plan'),
      db.listar('cantes'),
      db.listar('cronogramas'),
      db.consultar('exam_results', { orderBy: 'timestamp', descendente: true, limite: 15 }),
      db.leer('progress/preparador'),
      db.listar('preparadores'),
    ]);
    const estudiados = Array.isArray(ajustes?.temasEstudiados) ? ajustes.temasEstudiados.length : 0;
    const esPreparador = perfil?.activo === true;
    const esOpositor = cantes.length > 0 || cronos.length > 0 || estudiados > 0 || preparadores.length > 0;
    if (!esOpositor && !esPreparador && !tests.length) return null;
    const diario = resumenCantes(cantes, 3);
    const activo = cronogramaActivo(cronos);
    const crono = activo ? resumenCronograma(activo.id, activo.datos) : null;
    const examenes = Object.entries(esObjeto(plan?.fechas) ? plan.fechas : {})
      .map(([ejercicio, f]) => ({ ejercicio, fecha: soloFecha(f) ?? '' }))
      .filter((e) => e.fecha)
      .map((e) => ({ ...e, dias: diasEntre(hoy, e.fecha) }))
      .sort((a, b) => a.fecha.localeCompare(b.fecha));
    const semana = tests.map((t) => ({ fecha: soloFecha(aHoraMadrid(t.datos.timestamp)) ?? '', nota: typeof t.datos.notaSobre10 === 'number' ? t.datos.notaSobre10 : 0 })).filter((t) => (diasEntre(t.fecha, hoy) ?? 99) <= 7);
    // Las tareas que dejó la última corrección guardada, para retomarlas sin que el opositor las repita.
    let ultimaCorreccion: { cante: string | null; fecha: string | null; tareas: string[] } | undefined;
    if (diario.hechos[0]) {
      const informes = await db.listar(`cantes/${Firestore.tramo(diario.hechos[0].id)}/informes`).catch(() => []);
      const ultimo = informes.sort((a, b) => String(b.datos.fecha).localeCompare(String(a.datos.fecha)))[0];
      if (ultimo) ultimaCorreccion = { cante: diario.hechos[0].fecha, fecha: soloFecha(ultimo.datos.fecha), tareas: Array.isArray(ultimo.datos.tareas) ? ultimo.datos.tareas.map(String) : [] };
    }
    return {
      oposicion: op,
      esOpositor,
      esPreparador,
      preparadores: preparadores.map((p) => (typeof p.datos.nombre === 'string' ? p.datos.nombre : 'Preparador')),
      examenes,
      temasEstudiados: estudiados,
      cronograma: crono ? { ejercicio: crono.ejercicio, fin: crono.fin, temasHechos: Object.keys(crono.hechos).length, temasTotales: crono.semanas.reduce((n, s) => n + s.temas.length, 0), estaSemana: semanaDe(crono, hoy).actual, siguiente: semanaDe(crono, hoy).siguiente, propuestasPendientes: crono.propuestasPendientes } : null,
      ultimosCantes: diario.hechos.map((c) => ({ id: c.id, fecha: c.fecha, temas: c.temas, esquema: c.esquema || undefined, valoracion: c.resultado?.valoracion, comentarios: c.resultado?.comentarios })),
      cantesHechos: diario.totalHechos,
      proximasClases: diario.pendientes.slice(0, 3).map((c) => ({ fecha: c.fecha, hora: c.hora, temas: c.temas.length ? c.temas : c.temasPropuestos, con: c.preparadorNombre ?? undefined })),
      deberesPendientes: deberesPendientes(cantes).slice(0, 8),
      ultimaCorreccion,
      testsUltimos7Dias: { hechos: semana.length, notaMedia: semana.length ? Math.round((semana.reduce((s, t) => s + t.nota, 0) / semana.length) * 100) / 100 : null },
      mejorRacha: typeof ajustes?.mejorRacha === 'number' ? ajustes.mejorRacha : undefined,
      ultimoUso: typeof ajustes?.ultimoUso === 'string' ? ajustes.ultimoUso : undefined,
    };
  };

  server.registerTool(
    'empezar',
    {
      title: 'Ponerse al día con el usuario',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'LLÁMALA AL EMPEZAR cualquier conversación sobre la oposición, antes que las demás: en una sola llamada dice quién es el usuario en la app (opositor, preparador o las dos cosas, y en qué oposición: TCEE o DCE), cuántos días faltan para cada ejercicio, qué temas tocan esta semana según su cronograma, sus tres últimos cantes con la valoración, sus próximas clases, los deberes pendientes, las tareas que dejó la última corrección guardada, sus tests de la última semana y qué contenido revisado sirve el conector. Con eso se sabe qué «oposicion» pasar a las demás herramientas y no hay que preguntar lo que ya está en la app. Después, leer_metodo(tarea).',
      inputSchema: {},
    },
    async () =>
      protegido(async () => {
        const hoy = ahoraMadrid().slice(0, 10);
        const [tcee, dce, indice, versionWeb] = await Promise.all([panorama('tcee', hoy), panorama('dce', hoy), ctx.contenido.indice(), ctx.skill('VERSION.txt').catch(() => null)]);
        const con = [tcee, dce].filter((p): p is NonNullable<typeof p> => p !== null);
        const peso = (p: (typeof con)[number]) => p.cantesHechos * 3 + p.temasEstudiados + (p.cronograma ? 5 : 0) + p.testsUltimos7Dias.hechos;
        const principal = con.length ? [...con].sort((a, b) => peso(b) - peso(a))[0].oposicion : null;
        const version = versionWeb?.match(/^version:\s*(\S+)/m)?.[1];
        return json({
          hoy,
          oposicionPrincipal: principal,
          comoSeguir: principal
            ? `Pasa oposicion «${principal}» a las demás herramientas${con.length > 1 ? ' (tiene datos en las dos: pregunta de cuál habla si no queda claro)' : ''}. Antes de la tarea, leer_metodo(tarea).`
            : 'Este usuario aún no tiene datos en la app (ni cantes, ni cronograma, ni temas marcados): trabaja con lo que te cuente y propónle apuntarlo en la app. Antes de la tarea, leer_metodo(tarea).',
          ...(con.some((p) => p.esPreparador) ? { siEsPreparador: `Es preparador en ${con.filter((p) => p.esPreparador).map((p) => p.oposicion.toUpperCase()).join(' y ')}: sus alumnos, sus clases y las reservas que le piden están en leer_alumnos y leer_alumno (método: leer_metodo(«preparador»)).` } : {}),
          oposiciones: con,
          contenido: indice ? { temasRevisados: indice.temas.map((t) => t.tema), dictamen: indice.dictamen.length > 0, version: indice.version ?? undefined, ...(version && indice.version && version !== indice.version ? { aviso: `El método publicado en la web es la versión ${version} y los temas del conector, la ${indice.version}: puede haber un tema recién aprobado que aún no esté aquí.` } : {}) } : null,
        });
      }),
  );

  server.registerTool(
    'leer_informes_cante',
    {
      title: 'Leer las correcciones guardadas de los cantes',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Los informes de corrección que se guardaron en la app con guardar_informe_cante (los de esta IA u otra): fecha, valoración general y por tema, criterios, comentarios, tareas que se pusieron y el informe. Úsala antes de corregir un cante nuevo (para ver si repite los mismos fallos y si hizo las tareas), para el informe de la semana y para «¿cómo voy?». Con «canteId», los de ese cante; sin él, los más recientes de los últimos cantes.',
      inputSchema: {
        oposicion: oposicionParam,
        canteId: z.string().optional().describe('Id del cante (de leer_cantes); si falta, los últimos informes de cualquier cante.'),
        n: z.number().int().min(1).max(10).default(3).describe('Cuántos informes como mucho.'),
        completo: z.boolean().default(false).describe('true: el informe entero; por defecto, sus primeros 6.000 caracteres.'),
      },
    },
    async ({ oposicion, canteId, n, completo }) =>
      protegido(async () => {
        const db = await ctx.almacen(oposicion);
        const ids = canteId ? [canteId] : resumenCantes(await db.listar('cantes'), 8).hechos.map((c) => c.id);
        const porCante = await Promise.all(ids.map(async (id) => (await db.listar(`cantes/${Firestore.tramo(id)}/informes`)).map((d) => resumenInforme(d.id, id, d.datos, completo ? 0 : 6000))));
        const informes = porCante.flat().sort((a, b) => b.id.localeCompare(a.id)).slice(0, n);
        return json({ oposicion, informes, ...(informes.length ? {} : { aviso: canteId ? 'Ese cante no tiene ninguna corrección guardada.' : 'No hay correcciones guardadas en los últimos cantes: se guardan con guardar_informe_cante cuando el opositor lo confirma.' }) });
      }),
  );

  /** Las preguntas de un test a medida (para preguntas_test y test_interactivo), o el error que se devuelve. */
  const testDe = async (oposicion: Oposicion, temas: string[], n: number, modo: 'no_dominadas' | 'falladas' | 'todas'): Promise<CallToolResult | { [k: string]: unknown }> => {
    const codigos = temas.map((t) => codigoTema(t)).filter((t): t is string => !!t);
    if (!codigos.length) return error(`Ningún código de tema válido en ${JSON.stringify(temas)} (formato «3.A.8»).`);
    const banco = await ctx.banco();
    if (!banco.preguntas?.size) return error('El banco de preguntas no está disponible ahora mismo. Inténtalo más tarde o remite al simulador de la web.');
    const db = await ctx.almacen(oposicion);
    const elegidas = elegirPreguntas(banco.preguntas, codigos, n, modo, await db.leer('progress/spaced_repetition'));
    const explicaciones = new Map<string, Record<string, { clave?: string }>>();
    await Promise.all([...new Set(elegidas.map((p) => p.examen))].map(async (ex) => explicaciones.set(ex, await ctx.explicaciones(ex).catch(() => ({})))));
    const disponibles = [...banco.preguntas.values()].filter((p) => p.respuesta.length && p.temas.some((t) => codigos.includes(t))).length;
    return {
      temas: codigos,
      modo,
      oficialesDeEsosTemas: disponibles,
      preguntas: elegidas.map((p) => ({
        id: p.id,
        cabecera: `[${p.temas.join(', ')} · ${p.examen}, pregunta ${p.numero}]`,
        enunciado: p.enunciado,
        opciones: p.opciones,
        ...(p.figura ? { figura: p.figuras?.length ? 'Lleva figura: descríbela con «descripcion» y enlaza «url» para que la abra.' : 'Lleva una figura que no se ve aquí: está en el simulador de la web y en la app.', ...(p.figuras?.length ? { figuras: p.figuras } : {}) } : {}),
        respuesta: p.respuesta,
        ...(p.respuesta.length > 1 ? { variasValidas: true } : {}),
        porQue: explicaciones.get(p.examen)?.[String(p.id)]?.clave,
        ...(p.nota ? { nota: p.nota } : {}),
        historial: p.aciertos + p.fallos > 0 ? { aciertos: p.aciertos, fallos: p.fallos } : 'no la ha hecho',
      })),
      ...(elegidas.length < n ? { aviso: `Solo hay ${elegidas.length} preguntas oficiales de esos temas en el modo «${modo}». Completa con preguntas nuevas del mismo estilo, marcadas como «nueva», o prueba otro modo.` } : {}),
    };
  };

  server.registerTool(
    'preguntas_test',
    {
      title: 'Preguntas oficiales del test por tema',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Preguntas oficiales del test del primer ejercicio de TCEE (exámenes desde 2002; DCE practica con el mismo banco) de los temas que se pidan, con su respuesta y la explicación «¿Por qué?» de la web, elegidas según lo que el opositor ya ha hecho en la app: «no_dominadas» (por defecto: primero las que ha fallado, luego las que no ha visto; fuera las que ya domina), «falladas» (solo las que ha fallado) o «todas». Úsala para un test a medida en vez de leer los ficheros del banco. No enseñes la respuesta ni la explicación hasta que conteste. Si una pregunta lleva figura, viene en «figuras» con la dirección de la imagen y su descripción en texto: describe la figura con esas palabras y pon el enlace (si no viene, remite al simulador de la web o a la app).',
      inputSchema: {
        oposicion: oposicionParam,
        temas: z.array(z.string()).min(1).max(10).describe('Códigos de los temas, «3.A.8» (los flojos salen de leer_resultados_test y leer_progreso).'),
        n: z.number().int().min(1).max(30).default(10).describe('Cuántas preguntas (1-30).'),
        modo: z.enum(['no_dominadas', 'falladas', 'todas']).default('no_dominadas'),
      },
    },
    async ({ oposicion, temas, n, modo }) =>
      protegido(async () => {
        const t = await testDe(oposicion, temas, n, modo);
        return 'content' in t ? (t as CallToolResult) : json({ ...t, comoUsarlas: 'Plantéalas sin la respuesta; corrige cuando conteste, con la explicación («porQue») y la fuente. El desarrollo completo de cada explicación está en el simulador de la web y en la app («¿Por qué?»).' });
      }),
  );

  server.registerTool(
    'test_interactivo',
    {
      title: 'Test interactivo con preguntas oficiales',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Abre un test interactivo dentro del chat: las mismas preguntas oficiales que preguntas_test (mismos parámetros), pero el usuario las contesta con botones en un cuadro, con la figura a la vista, la corrección al momento y el «¿Por qué?», y al terminar te llega su resultado con los fallos para que se los expliques. Solo lo pintan los clientes con vistas interactivas (Claude, en la web y en el escritorio): úsala cuando pida «hazme un test» en uno de ellos y NO copies las preguntas ni las respuestas en el chat; dile que conteste en el cuadro. Si el usuario dice que no ve ningún cuadro, o tu cliente no pinta vistas, usa preguntas_test y plantéaselas tú.',
      inputSchema: {
        oposicion: oposicionParam,
        temas: z.array(z.string()).min(1).max(10).describe('Códigos de los temas, «3.A.8».'),
        n: z.number().int().min(1).max(30).default(10).describe('Cuántas preguntas (1-30).'),
        modo: z.enum(['no_dominadas', 'falladas', 'todas']).default('no_dominadas'),
      },
      _meta: metaVista('test'),
    },
    async ({ oposicion, temas, n, modo }) =>
      protegido(async () => {
        const t = await testDe(oposicion, temas, n, modo);
        return 'content' in t
          ? (t as CallToolResult)
          : json({
              vista:
                'El usuario tiene estas preguntas delante en un cuadro interactivo: las contesta con botones y ve la corrección y el «¿Por qué?» al momento. NO las copies ni des las respuestas en el chat: dile solo, en una línea, que conteste en el cuadro. Cuando termine te llegará su resultado con los fallos: entonces explícaselos con la fuente. Si dice que no ve ningún cuadro, su cliente no pinta vistas: plantéale tú estas mismas preguntas, sin la respuesta.',
              ...t,
            });
      }),
  );

  server.registerTool(
    'leer_proceso',
    {
      title: 'Leer el proceso selectivo en curso',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Lo que ha publicado el Ministerio del proceso selectivo en curso de TCEE o DCE (la web lo rastrea varias veces al día): convocatoria, enlace oficial y los documentos por sección (convocatoria, admitidos, cada ejercicio, cronograma del tribunal), con la fecha en que apareció cada uno. Úsala para fechas de examen, plazos y novedades en vez de responder de memoria; si algo no está aquí, dilo y remite a la página oficial.',
      inputSchema: { oposicion: oposicionParam, seccion: z.string().optional().describe('Solo una sección: «Tercer ejercicio», «Convocatoria», «Cronograma»…') },
    },
    async ({ oposicion, seccion }) =>
      protegido(async () => {
        const todo = await ctx.proceso();
        const datos = esObjeto(todo) && esObjeto(todo[oposicion]) ? todo[oposicion] : null;
        const procesos = datos && Array.isArray(datos.procesos) ? datos.procesos.filter(esObjeto) : [];
        if (!procesos.length) return error('No se ha podido leer el proceso selectivo ahora mismo. Remite a la página del Ministerio.');
        const quiere = seccion ? sinTildes(seccion) : '';
        const salida = procesos.slice(0, 2).map((p, i) => {
          const docs = (Array.isArray(p.documentos) ? p.documentos : []).filter(esObjeto).filter((d) => !quiere || sinTildes(String(d.seccion ?? '')).includes(quiere));
          const porSeccion: Record<string, Array<{ titulo: string; url: string; desde?: string }>> = {};
          for (const d of docs) (porSeccion[String(d.seccion ?? 'Otros')] ??= []).push({ titulo: String(d.titulo ?? ''), url: String(d.url ?? ''), ...(typeof d.desde === 'string' ? { desde: d.desde } : {}) });
          const novedades = docs.filter((d) => typeof d.desde === 'string').sort((a, b) => String(b.desde).localeCompare(String(a.desde))).slice(0, 5).map((d) => ({ desde: String(d.desde), seccion: String(d.seccion ?? ''), titulo: String(d.titulo ?? ''), url: String(d.url ?? '') }));
          // Del proceso anterior, solo lo último (sirve para estimar fechas del siguiente).
          return i === 0 ? { convocatoria: p.convocatoria, paginaOficial: p.url, ultimasNovedades: novedades, documentos: porSeccion } : { convocatoria: p.convocatoria, paginaOficial: p.url, ultimasNovedades: novedades };
        });
        return json({ oposicion, actualizado: esObjeto(todo) ? todo.actualizado : undefined, procesos: salida, nota: '«desde» es el día en que la web vio aparecer el documento (no siempre el de su firma). Los que no lo llevan estaban ya al empezar el rastreo.' });
      }),
  );

  server.registerTool(
    'listar_temas_revisados',
    {
      title: 'Listar los temas revisados disponibles',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description: 'Qué temas revisados (con tema completo, ficha de repaso y guion del cante), documentos de la guía del dictamen y del canon del temario sirve este conector, con su fecha de aprobación. Es el índice para leer_tema, leer_ficha, leer_guia_dictamen y leer_canon.',
      inputSchema: {},
    },
    async () =>
      protegido(async () => {
        const indice = await ctx.contenido.indice();
        if (!indice) return error('El contenido exclusivo aún no se ha publicado en este conector (mcp/publicar-contenido.py).');
        return json(indice);
      }),
  );

  const temaParam = z.string().describe('Código del tema: «3.A.8» o «3A08».');

  server.registerTool(
    'leer_tema',
    {
      title: 'Leer un tema revisado',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'El texto completo de un tema revisado (como se canta: introducción, apartados con sus minutos, conclusión y anexos) en Markdown, o solo un apartado («Introducción», «II», «B», o parte de su título). Sin «apartado» devuelve la lista de apartados y el tema por tramos de 40.000 caracteres (desde/limite): para corregir o explicar algo concreto, pide el apartado. Material exclusivo: solo para el opositor conectado.',
      inputSchema: { tema: temaParam, apartado: z.string().optional().describe('Apartado concreto; si falta, el tema entero.'), guion: z.boolean().default(false).describe('true: el guion del cante de 30 minutos en vez del tema.'), ...tramoParams },
    },
    async ({ tema, apartado, guion, desde, limite }) =>
      protegido(async () => {
        const codigo = normalizarCodigo(tema);
        if (!codigo) return error(`Código de tema no válido: «${tema}».`);
        const md = await ctx.contenido.tema(codigo, guion ? 'guion-cante' : 'tema');
        if (!md) return error(`El tema ${codigoConPuntos(codigo)} no está entre los revisados (mira listar_temas_revisados).`);
        if (apartado) {
          const parte = extraerApartado(md, apartado);
          return parte ? textoMd(`${AVISO_EXCLUSIVO}\n\n${parte}`) : error(`No hay ningún apartado «${apartado}» en ${codigoConPuntos(codigo)}. Apartados: ${apartadosDe(md).join(' · ')}`);
        }
        return tramoTexto(md, desde, limite, desde > 0 ? '' : `${AVISO_EXCLUSIVO}\n\nApartados: ${apartadosDe(md).join(' · ')}\n\n`, 'O pide solo el apartado que necesites («apartado»).');
      }),
  );

  server.registerTool(
    'leer_ficha',
    {
      title: 'Leer la ficha de repaso de un tema',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description: 'La ficha de repaso de cuatro páginas de un tema revisado, en Markdown. Material exclusivo: solo para el opositor conectado.',
      inputSchema: { tema: temaParam, ...tramoParams },
    },
    async ({ tema, desde, limite }) =>
      protegido(async () => {
        const codigo = normalizarCodigo(tema);
        if (!codigo) return error(`Código de tema no válido: «${tema}».`);
        const md = await ctx.contenido.tema(codigo, 'ficha');
        return md ? tramoTexto(md, desde, limite, desde > 0 ? '' : `${AVISO_EXCLUSIVO}\n\n`) : error(`No hay ficha de repaso de ${codigoConPuntos(codigo)} (mira listar_temas_revisados).`);
      }),
  );

  server.registerTool(
    'leer_guia_dictamen',
    {
      title: 'Leer la guía del dictamen de coyuntura',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'La guía del dictamen (1D01) y sus piezas: «guia-1D01» (la guía entera), «resumen-1D01» (resumen de 6-8 páginas), «guion-1D01» (guion del vídeo), «examen-espana» (examen de ejemplo) y «solucion-espana» (solución de máximos). Con «seccion» devuelve solo ese apartado de nivel 2 (lo normal: la guía entera ocupa unos 360.000 caracteres); sin ella, la lista de secciones y el documento por tramos (desde/limite). Material exclusivo.',
      inputSchema: {
        documento: z.enum(documentosDictamen).default('guia-1D01'),
        seccion: z.string().optional().describe('Apartado concreto (número, letra o parte del título); si falta, el documento por tramos.'),
        ...tramoParams,
      },
    },
    async ({ documento, seccion, desde, limite }) =>
      protegido(async () => {
        const md = await ctx.contenido.dictamen(documento);
        if (!md) return error(`El documento «${documento}» no está publicado en el conector.`);
        if (seccion) {
          const parte = extraerApartado(md, seccion);
          return parte ? textoMd(`${AVISO_EXCLUSIVO}\n\n${parte}`) : error(`No hay ninguna sección «${seccion}». Secciones: ${apartadosDe(md).join(' · ')}`);
        }
        return tramoTexto(md, desde, limite, desde > 0 ? '' : `${AVISO_EXCLUSIVO}\n\nSecciones: ${apartadosDe(md).join(' · ')}\n\n`, 'O pide solo la sección que necesites («seccion»): la guía entera es muy larga.');
      }),
  );

  server.registerTool(
    'leer_canon',
    {
      title: 'Leer el canon del temario',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description: 'El canon común del temario revisado: «notacion» (convenciones de notación y símbolos) y «modelos-indice» (índice de los modelos y en qué tema vive cada uno). Son largos: pide una «seccion» o léelos por tramos (desde/limite). Material exclusivo.',
      inputSchema: { documento: z.enum(documentosCanon).default('notacion'), seccion: z.string().optional().describe('Apartado concreto (parte del título); si falta, el documento por tramos.'), ...tramoParams },
    },
    async ({ documento, seccion, desde, limite }) =>
      protegido(async () => {
        const md = await ctx.contenido.canon(documento);
        if (!md) return error(`El documento «${documento}» no está publicado en el conector.`);
        if (seccion) {
          const parte = extraerApartado(md, seccion);
          return parte ? tramoTexto(parte, desde, limite, desde > 0 ? '' : `${AVISO_EXCLUSIVO}\n\n`) : error(`No hay ninguna sección «${seccion}». Secciones: ${apartadosDe(md).join(' · ')}`);
        }
        return tramoTexto(md, desde, limite, desde > 0 ? '' : `${AVISO_EXCLUSIVO}\n\nSecciones: ${apartadosDe(md).join(' · ')}\n\n`, 'O pide solo la sección que necesites («seccion»).');
      }),
  );

  server.registerTool(
    'desconectar',
    {
      title: 'Desconectar la IA de la app',
      annotations: { readOnlyHint: false, destructiveHint: true, idempotentHint: true, openWorldHint: false },
      description:
        'Revoca el acceso de este conector a los datos del opositor: borra del servidor su token de Firebase y las autorizaciones OAuth. Después, ninguna herramienta funciona hasta que vuelva a conectar. Úsalo solo si el opositor lo pide. También puede hacerlo desde la app (Más → EconomIA → Desconectar la IA).',
      inputSchema: { confirmar: z.literal(true).describe('Tiene que ser true: el opositor ha pedido desconectar.') },
    },
    async () =>
      protegido(async () => {
        await ctx.desconectar();
        return json({ desconectado: true, aviso: 'Acceso revocado. Para volver a usar el conector, el opositor tiene que conectarlo de nuevo en su asistente de IA.' });
      }),
  );

  // ------------------------------------------------------------ Borrar una oposición

  /** Código de confirmación del borrado: sale del usuario, la oposición y un tramo de diez minutos; vale en ese tramo y en el siguiente. */
  const TRAMO_CODIGO = 10 * 60 * 1000;
  const codigoBorrado = async (op: Oposicion, tramo: number) => (await ctx.sello(`borrar:${ctx.uid}:${op}:${tramo}`)).slice(0, 8).toUpperCase();
  const fraseBorrado = (op: Oposicion) => `BORRAR ${op.toUpperCase()}`;

  server.registerTool(
    'borrar_datos_oposicion',
    {
      title: 'Borrar todos los datos de una oposición',
      annotations: { readOnlyHint: false, destructiveHint: true, idempotentHint: true, openWorldHint: true },
      description:
        'Borra TODOS los datos del usuario en UNA oposición (TCEE o DCE) y no se puede deshacer: tests, repaso, temas, notas, cantes e informes, cronogramas, clases, alumnos, reservas, y sus enlaces con preparadores y alumnos de esa oposición. No toca la otra oposición ni la cuenta. Es lo mismo que Cuenta → «Borrar mis datos de una oposición» en la app. NUNCA por iniciativa tuya: solo si el usuario lo pide expresamente. Va en dos pasos. PASO 1: llámala solo con «oposicion»; no borra nada y devuelve qué se borraría, un «codigo» y la «frase» de confirmación. Enseña al usuario ese recuento, dile que no se puede deshacer y que puede exportar antes sus datos en la app (Más → Cuenta), y pídele que escriba ÉL, tal cual, la frase. PASO 2: solo cuando la haya escrito literalmente en la conversación (no vale «sí», «adelante» ni que la escribas tú), llámala otra vez con «codigo» y con «frase» copiada de su mensaje. El código caduca en unos minutos. Si duda, no borres. En los clientes con vistas interactivas (Claude), el paso 1 abre además un cuadro con el recuento y un campo donde el usuario escribe la frase y confirma él mismo: díselo, y si lo hace ahí no llames al paso 2.',
      inputSchema: {
        oposicion: z.enum(OPOSICIONES).describe('Oposición cuyos datos se borran: «tcee» o «dce». Sin valor por defecto: tiene que decirla el usuario.'),
        codigo: z.string().max(20).optional().describe('Paso 2: el código que devolvió el paso 1.'),
        frase: z.string().max(40).optional().describe('Paso 2: la frase de confirmación tal como la ha escrito el usuario en la conversación.'),
      },
      _meta: metaVista('borrado'),
    },
    async ({ oposicion, codigo, frase }) =>
      protegido(async () => {
        const db = await ctx.almacen(oposicion);
        const tramo = Math.floor(Date.now() / TRAMO_CODIGO);
        const esperada = fraseBorrado(oposicion);
        if (!codigo && !frase) {
          const r = await recuentoOposicion(db);
          if (!r.total) return json({ oposicion, borrado: false, aviso: `No hay datos en ${oposicion.toUpperCase()}: no hay nada que borrar.` });
          return json({
            oposicion,
            borrado: false,
            seBorraria: r.resumen,
            documentos: r.total,
            ademas: 'Se romperán sus enlaces con preparadores y alumnos de esa oposición y se borrarán sus reservas de clase. No se toca la otra oposición ni la cuenta. No se puede deshacer.',
            frase: esperada,
            codigo: await codigoBorrado(oposicion, tramo),
            siguiente: `Enseña esto al usuario y pídele que escriba él, tal cual, «${esperada}»: en el cuadro que tiene delante, si lo ve (ahí confirma él y no hace falta que llames otra vez), o en el chat. Solo si la escribe en el chat vuelve a llamar con «codigo» y «frase».`,
          });
        }
        if (!codigo || !frase) return error('Faltan «codigo» o «frase». Empieza por el paso 1 (solo «oposicion») y sigue sus indicaciones.');
        if (frase.trim().toUpperCase() !== esperada) return error(`La frase no coincide: el usuario tiene que escribir exactamente «${esperada}». No se ha borrado nada.`);
        const dado = codigo.trim().toUpperCase();
        if (dado !== (await codigoBorrado(oposicion, tramo)) && dado !== (await codigoBorrado(oposicion, tramo - 1)))
          return error('El código no vale o ha caducado. No se ha borrado nada: repite el paso 1 y vuelve a pedir la confirmación al usuario.');
        const r = await borrarOposicion({
          uid: ctx.uid,
          oposicion,
          db,
          red: await ctx.almacenEn(raizRed(oposicion)),
          cuenta: await ctx.almacenEn(`users/${ctx.uid}`),
          deOtro: (uid) => ctx.almacenEn(Firestore.raizDe(uid, oposicion)),
          ahora: new Date().toISOString(),
          temas: Object.keys((await ctx.fuentes().catch(() => null))?.[oposicion] ?? {}),
        });
        return json({
          oposicion,
          borrado: true,
          documentosBorrados: r.borrados,
          enlacesRotos: r.enlacesRotos,
          ...(r.avisos.length ? { avisos: r.avisos } : {}),
          aviso: `Borrados los datos de ${oposicion.toUpperCase()} en la nube. La app borra su copia en cada dispositivo la próxima vez que sincronice (hace falta la versión 1.25.0 o posterior: una anterior podría volver a subir lo que tenga guardado; si pasa, que actualice la app y lo borre desde Cuenta).`,
        });
      }),
  );

  // ------------------------------------------------------------ Clases

  /** Raíz de las colecciones de la red (reservas, huecos, enlaces): la de la base en TCEE, oposiciones/{id} en las demás. */
  const raizRed = (op: Oposicion) => (op === 'tcee' ? '' : `oposiciones/${op}`);
  type Doc = { [k: string]: Json };
  const txt = (v: Json | undefined) => (typeof v === 'string' ? v : '');
  const num = (v: Json | undefined, d: number) => (typeof v === 'number' ? v : d);
  const leerSeguro = async (a: AlmacenDatos, ruta: string): Promise<Doc | null> => {
    try {
      return await a.leer(ruta);
    } catch (e) {
      if (e instanceof ErrorFirestore && e.estado === 403) return null;
      throw e;
    }
  };
  /** Cronograma activo de un árbol (el del opositor; el del alumno, solo si lo comparte con su preparador). */
  const cronogramaDe = async (a: AlmacenDatos, compartido: boolean): Promise<Doc | null> => {
    const docs = compartido ? await a.consultar('cronogramas', { where: { campo: 'compartir', op: 'EQUAL', valor: true } }) : await a.listar('cronogramas');
    return cronogramaActivo(docs)?.datos ?? null;
  };
  /** Los temas de los próximos cantes del cronograma (para proponer los de la clase). */
  const proximasSemanas = (crono: Doc | null, ahora: string, n = 4) =>
    ((Array.isArray(crono?.semanas) ? crono!.semanas : []) as Doc[])
      .map((s) => ({ cante: new Date(Date.parse(`${txt(s.lunes).slice(0, 10)}T00:00:00Z`) + 6 * 86_400_000).toISOString().slice(0, 10), temas: Array.isArray(s.temas) ? s.temas.map(String) : [], descanso: s.descanso === true }))
      .filter((s) => s.cante >= ahora.slice(0, 10))
      .slice(0, n);

  server.registerTool(
    'preparar_clase',
    {
      title: 'Preparar una clase con el preparador o con un alumno',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Todo lo que hace falta para agendar una clase, leído de la app: si el usuario es opositor (sus preparadores aceptados, sus huecos libres de las próximas 4 semanas, la duración habitual y sus reservas pendientes) y/o preparador (sus alumnos, si están enlazados, su duración y plataforma por defecto), sus próximas clases (para ver choques) y los temas que tocan según el cronograma (el suyo como opositor; el del alumno, si lo comparte, como preparador). Llámala ANTES de agendar_clase y pregunta solo lo que falte: día y hora, presencial u online, temas (propón los del cronograma) y con quién. Fechas y horas en hora de Madrid.',
      inputSchema: {
        oposicion: oposicionParam,
        con: z.string().optional().describe('Como preparador: id del alumno (de la lista de alumnos) para ver su agenda y su cronograma compartido.'),
        dia: z.string().optional().describe('Día de la clase, «AAAA-MM-DD», para dar los temas del cronograma de ese día.'),
      },
    },
    async ({ oposicion, con, dia }) =>
      protegido(async () => {
        const yo = await ctx.almacen(oposicion);
        const red = await ctx.almacenEn(raizRed(oposicion));
        const ahora = ahoraMadrid();
        const salida: Record<string, unknown> = { ahora_en_madrid: ahora.slice(0, 16), oposicion };

        // Como opositor
        const vinculos = await yo.listar('preparadores');
        if (vinculos.length) {
          const misReservas = await red.consultar('reservas', { where: { campo: 'alumno', op: 'EQUAL', valor: ctx.uid } });
          const vivas = misReservas.filter((r) => ['pedida', 'aceptada'].includes(txt(r.datos.estado)) && txt(r.datos.fecha) > ahora);
          const preparadores = [];
          for (const v of vinculos) {
            const enlace = await leerSeguro(red, `preparadores/${v.id}/alumnos/${ctx.uid}`);
            const aceptado = !!enlace && enlace.aceptado !== false;
            const huecos = aceptado ? await leerSeguro(red, `huecos/${v.id}`) : null;
            const pedidas = vivas.filter((r) => txt(r.datos.preparador) === v.id).map((r) => txt(r.datos.fecha));
            const libres = huecosLibres(huecos, pedidas, ahora);
            preparadores.push({
              uid: v.id,
              nombre: txt(v.datos.nombre) || txt(huecos?.nombre) || 'Tu preparador',
              aceptado,
              reservas_abiertas: !!huecos && huecos.activo !== false,
              minutos_por_defecto: libres[0]?.minutos ?? MINUTOS_CLASE,
              huecos_libres: libres.slice(0, 24).map((h) => ({ inicio: h.inicio.slice(0, 16), minutos: h.minutos })),
            });
          }
          const crono = await cronogramaDe(yo, false);
          salida.como_opositor = {
            preparadores,
            reservas_pendientes: vivas.map((r) => ({ id: r.id, preparador: txt(r.datos.preparador), fecha: txt(r.datos.fecha).slice(0, 16), minutos: num(r.datos.minutos, MINUTOS_CLASE), estado: txt(r.datos.estado) })),
            mis_proximas_clases: proximas(await yo.listar('cantes'), ahora).map((c) => ({ ...c, fecha: c.fecha.slice(0, 16) })),
            temas_del_cronograma: { ...(dia ? { [dia]: temasDelCante(crono, dia) } : {}), proximos_cantes: proximasSemanas(crono, ahora) },
          };
        }

        // Como preparador
        const perfil = await yo.leer('progress/preparador');
        if (perfil?.activo === true) {
          const verificado = (await leerSeguro(red, `preparadoresVerificados/${ctx.uid}`))?.activo === true;
          const alumnos = (await yo.listar('alumnos')).filter((a) => a.datos.borrado !== true);
          const datos: Record<string, unknown> = {
            nombre: txt(perfil.nombre),
            verificado,
            minutos_por_defecto: num(perfil.minutosClase, MINUTOS_CLASE),
            plataforma_online: txt(perfil.plataforma) || 'meet',
            alumnos: alumnos.map((a) => ({ id: a.id, nombre: txt(a.datos.nombre), enlazado: !!txt(a.datos.uid) && a.datos.suelto !== true, ejercicio: num(a.datos.ejercicio, 3) })),
            mis_proximas_clases: proximas(await yo.listar('sesiones'), ahora).map((c) => ({ ...c, fecha: c.fecha.slice(0, 16) })),
          };
          const alumno = con ? alumnos.find((a) => a.id === con) : undefined;
          if (con && !alumno) return error(`No tienes ningún alumno con id «${con}». Alumnos: ${alumnos.map((a) => `${txt(a.datos.nombre)} (${a.id})`).join(', ') || 'ninguno'}.`);
          const uidAlumno = alumno ? txt(alumno.datos.uid) : '';
          if (alumno && uidAlumno) {
            const suyo = await ctx.almacenEn(Firestore.raizDe(uidAlumno, oposicion));
            let crono: Doc | null = null;
            let agenda: ReturnType<typeof proximas> = [];
            try {
              crono = await cronogramaDe(suyo, true);
              agenda = proximas(await suyo.listar('cantes'), ahora);
            } catch (e) {
              if (!(e instanceof ErrorFirestore && e.estado === 403)) throw e;
            }
            datos.alumno = {
              id: alumno.id,
              nombre: txt(alumno.datos.nombre),
              cronograma_compartido: !!crono,
              temas_del_cronograma: { ...(dia ? { [dia]: temasDelCante(crono, dia) } : {}), proximos_cantes: proximasSemanas(crono, ahora) },
              sus_proximas_clases: agenda.map((c) => ({ fecha: c.fecha.slice(0, 16), minutos: c.minutos, con: c.con })),
            };
          }
          salida.como_preparador = datos;
        }
        if (!salida.como_opositor && !salida.como_preparador)
          return error('En esta oposición no tienes preparadores enlazados ni eres preparador en la app. Para tener clase con un preparador, enlázalo antes desde la app (Más → Mi preparador).');
        return json(salida);
      }),
  );

  server.registerTool(
    'agendar_clase',
    {
      title: 'Agendar una clase en la app',
      // Mundo abierto: la petición o la clase le llega a otra persona (el preparador o el alumno).
      annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: false, openWorldHint: true },
      description:
        'Agenda una clase en la app. Como OPOSITOR («como»: «opositor», «con»: uid del preparador): pide la clase a su preparador (una reserva que él acepta en su app; al aceptarla, aparece en las dos agendas con la modalidad y los temas) y fija esos temas para la clase en la agenda del opositor. Como PREPARADOR («como»: «preparador», «con»: id del alumno): crea la clase en su agenda y en la del alumno (si está enlazado), con los temas como propuesta que el alumno acepta o cambia. Antes, preparar_clase y la confirmación explícita del usuario con el resumen (día, hora, duración, modalidad, temas, con quién); o con vistaPrevia: true, que no agenda nada: el usuario ve ese resumen en un cuadro y la pide o la crea él con un botón (en los clientes con vistas interactivas). Hora de Madrid.',
      inputSchema: {
        oposicion: oposicionParam,
        como: z.enum(['opositor', 'preparador']),
        con: z.string().describe('Opositor: uid del preparador. Preparador: id del alumno. Los dos salen de preparar_clase.'),
        dia: z.string().describe('«AAAA-MM-DD».'),
        hora: z.string().describe('«HH:MM», hora de Madrid.'),
        minutos: z.number().int().optional().describe('Duración; si falta, la habitual (la del hueco o la del preparador; 120 por defecto).'),
        modalidad: z.enum(MODALIDADES),
        temas: z.array(z.string()).max(6).default([]).describe('Códigos «3.A.8». Por defecto, los del cronograma para ese día.'),
        lugar: z.string().max(200).optional().describe('Presencial: dónde.'),
        enlace: z.string().max(300).optional().describe('Online: enlace de la videollamada, si ya lo hay (si no, la app del preparador crea el de Meet).'),
        nota: z.string().max(500).optional().describe('Lo que el usuario quiera decir (qué le preocupa, qué quiere trabajar).'),
        aunque_choque: z.boolean().default(false).describe('true solo si el usuario ya sabe que pisa otra clase suya y quiere seguir.'),
        vistaPrevia: VISTA_PREVIA('agenda', 'Pedir la clase» o «Crear la clase'),
      },
      _meta: metaVista('clase'),
    },
    async ({ oposicion, como, con, dia, hora, minutos, modalidad, temas, lugar, enlace, nota, aunque_choque, vistaPrevia }) =>
      protegido(async () => {
        const fecha = fechaClase(dia, hora);
        if (!fecha) return error(`Fecha u hora no válidas: «${dia}» «${hora}» (formato AAAA-MM-DD y HH:MM).`);
        const yo = await ctx.almacen(oposicion);
        const red = await ctx.almacenEn(raizRed(oposicion));
        const ahora = ahoraMadrid();

        if (como === 'opositor') {
          const conId = Firestore.tramo(con);
          const vinculo = await yo.leer(`preparadores/${conId}`);
          const enlaceRed = await leerSeguro(red, `preparadores/${conId}/alumnos/${ctx.uid}`);
          if (!vinculo || !enlaceRed || enlaceRed.aceptado === false)
            return error('Ese preparador no está enlazado contigo (o aún no ha aceptado el enlace). Mira preparar_clase.');
          const huecos = await leerSeguro(red, `huecos/${conId}`);
          if (huecos && huecos.activo === false) return error('Ese preparador no tiene abiertas las reservas en la app ahora mismo: no se le puede pedir clase desde aquí. Que el opositor hable con él.');
          // Si la hora coincide con un hueco libre del preparador, su duración; si no, se pide igual y se avisa.
          const libre = huecosLibres(huecos, [], ahora, 8).find((h) => h.inicio.slice(0, 16) === fecha.slice(0, 16));
          const p: PeticionClase = { fecha, minutos: minutos ?? libre?.minutos ?? num(((huecos?.huecos as Doc[] | undefined) ?? [])[0]?.minutos, MINUTOS_CLASE), modalidad, temas, nota };
          const errores = erroresPeticion(p, ahora);
          if (errores.length) return error(`No se ha pedido la clase: ${errores.join('; ')}.`);
          const choques = proximas(await yo.listar('cantes'), ahora, 800).filter((c) => seSolapan(fecha, p.minutos, c.fecha, c.minutos));
          if (vistaPrevia)
            return json({
              vistaPrevia: true,
              pedida: false,
              como,
              oposicion,
              preparador: txt(vinculo.nombre) || 'tu preparador',
              fecha: fecha.slice(0, 16),
              minutos: p.minutos,
              modalidad,
              temas,
              titulos: await titulosDe(oposicion, temas),
              nota,
              choques: choques.length ? choques.map((c) => `${c.fecha.slice(0, 16).replace('T', ' ')}${c.con ? ` con ${c.con}` : ''}`) : undefined,
              avisos: [
                ...(huecos && !libre ? ['Esa hora no es uno de los huecos que tu preparador tiene libres en la app: puede que la rechace.'] : []),
                ...(lugar || enlace ? ['El lugar o el enlace no viajan en la petición: los pone el preparador al aceptarla.'] : []),
              ],
              siguiente: siguientePrevia('Pedir la clase'),
            });
          if (choques.length && !aunque_choque)
            return error(`Pisa otra clase tuya: ${choques.map((c) => `${c.fecha.slice(0, 16)}${c.con ? ` con ${c.con}` : ''}`).join(', ')}. Pregunta al usuario y, si quiere seguir, repite con aunque_choque: true.`);
          const id = nuevoId();
          const ahoraIso = ahora;
          await red.escribir(`reservas/${id}`, construirReserva(id, p, con, ctx.uid, txt(enlaceRed.nombre) || ctx.email.split('@')[0], ahoraIso));
          if (temas.length) {
            const ajustes = (await yo.leer('progress/settings')) ?? {};
            const actuales = Array.isArray(ajustes.temasClases) ? ajustes.temasClases.map(String) : [];
            await yo.escribir('progress/settings', { temasClases: fijarTemasClase(actuales, `res_${id}`, ahora, temas), updatedAt: ahora }, ['temasClases', 'updatedAt']);
          }
          return json({
            como,
            pedida: true,
            reserva: id,
            fecha: fecha.slice(0, 16),
            minutos: p.minutos,
            modalidad,
            temas,
            preparador: txt(vinculo.nombre) || 'tu preparador',
            aviso: `Es una petición: tu preparador la verá en su app y tiene que aceptarla. Cuando la acepte, la clase aparecerá en tu agenda con estos temas. Puedes anularla desde la app mientras esté pendiente.${huecos && !libre ? ' Ojo: esa hora no es uno de los huecos que tu preparador tiene libres en la app; puede que la rechace.' : ''}${lugar || enlace ? ' El lugar o el enlace no viajan en la petición: los pone el preparador al aceptarla (díselo en la nota si importa).' : ''}`,
          });
        }

        // Como preparador
        const perfil = await yo.leer('progress/preparador');
        if (perfil?.activo !== true) return error('En esta oposición no eres preparador en la app (Más → Soy preparador).');
        const alumno = await yo.leer(`alumnos/${Firestore.tramo(con)}`);
        if (!alumno || alumno.borrado === true) return error(`No tienes ningún alumno con id «${con}». Mira preparar_clase.`);
        const p: PeticionClase = { fecha, minutos: minutos ?? num(perfil.minutosClase, MINUTOS_CLASE), modalidad, temas, nota, lugar, enlace };
        const errores = erroresPeticion(p, ahora);
        if (errores.length) return error(`No se ha creado la clase: ${errores.join('; ')}.`);
        const uidAlumno = alumno.suelto === true ? '' : txt(alumno.uid);
        const suyo = uidAlumno ? await ctx.almacenEn(Firestore.raizDe(uidAlumno, oposicion)) : null;
        let agendaAlumno: ReturnType<typeof proximas> = [];
        if (suyo) {
          try {
            agendaAlumno = proximas(await suyo.listar('cantes'), ahora, 800);
          } catch (e) {
            if (!(e instanceof ErrorFirestore && e.estado === 403)) throw e;
          }
        }
        const choques = [...proximas(await yo.listar('sesiones'), ahora, 800), ...agendaAlumno].filter((c) => seSolapan(fecha, p.minutos, c.fecha, c.minutos));
        if (vistaPrevia)
          return json({
            vistaPrevia: true,
            creada: false,
            como,
            oposicion,
            alumno: txt(alumno.nombre),
            fecha: fecha.slice(0, 16),
            minutos: p.minutos,
            modalidad,
            temas,
            titulos: await titulosDe(oposicion, temas),
            lugar,
            enlace,
            nota,
            choques: choques.length ? choques.map((c) => c.fecha.slice(0, 16).replace('T', ' ')) : undefined,
            avisos: uidAlumno ? [] : ['Este alumno no usa la app: la clase solo quedará en tu agenda.'],
            siguiente: siguientePrevia('Crear la clase'),
          });
        if (choques.length && !aunque_choque)
          return error(`Pisa otra clase (tuya o del alumno): ${choques.map((c) => c.fecha.slice(0, 16)).join(', ')}. Pregunta al usuario y, si quiere seguir, repite con aunque_choque: true.`);
        const id = nuevoId();
        const ahoraIso = ahora;
        const nombre = txt(perfil.nombre);
        const numTemas = num(perfil.temasPorClase, oposicion === 'tcee' ? 1 : 2);
        const sesion = construirSesion(id, p, con, num(alumno.ejercicio, 3), oposicion === 'tcee' ? 30 : 20, { nombre, minutosClase: p.minutos, plataforma: txt(perfil.plataforma), numTemas }, ahoraIso);
        await yo.escribir(`sesiones/${id}`, sesion);
        let enSuAgenda = false;
        if (suyo) {
          try {
            await suyo.escribir(`cantes/${id}`, copiaParaAlumno(sesion, ctx.uid, nombre));
            enSuAgenda = true;
          } catch (e) {
            if (!(e instanceof ErrorFirestore && e.estado === 403)) throw e;
          }
        }
        return json({
          como,
          creada: true,
          sesion: id,
          fecha: fecha.slice(0, 16),
          minutos: p.minutos,
          modalidad,
          temas_propuestos: temas,
          alumno: txt(alumno.nombre),
          en_la_agenda_del_alumno: enSuAgenda,
          aviso: enSuAgenda
            ? 'La clase ya está en tu agenda y en la del alumno, con los temas como propuesta. Al abrir tu app se crea el evento de Google Calendar (y el enlace de Meet si es online y lo tienes activado).'
            : uidAlumno
              ? 'La clase está en tu agenda; la app la copiará a la del alumno la próxima vez que la abras (hace falta que tu perfil de preparador esté verificado).'
              : 'La clase está en tu agenda. Este alumno no usa la app, así que no le llega: avísale tú.',
        });
      }),
  );

  // ------------------------------------------------------------ Preparadores

  /** El perfil de preparador del usuario en esa oposición, o el error que se le devuelve si no lo es. */
  const perfilPreparador = async (yo: AlmacenDatos): Promise<Doc | CallToolResult> => {
    const perfil = await yo.leer('progress/preparador');
    return perfil?.activo === true ? perfil : error('En esta oposición no eres preparador en la app (Más → Soy preparador). Si eres opositor, usa empezar y las herramientas leer_*.');
  };
  const esError = (v: Doc | CallToolResult): v is CallToolResult => Array.isArray((v as CallToolResult).content);
  const AVISO_ALUMNOS = 'Datos de un alumno, que el preparador ve porque el alumno se ha enlazado con él en la app: úsalos solo para preparar su clase y hablar de él con este preparador. No lo compares con otros alumnos salvo que el preparador lo pida.';

  server.registerTool(
    'leer_alumnos',
    {
      title: 'Preparador: mis alumnos',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Para PREPARADORES: sus alumnos en la app (nombre, ejercicio, si están enlazados, su próxima clase y la última con su valoración), las reservas de clase que le han pedido y aún no ha contestado (con responder_reserva las acepta o rechaza) y las peticiones de enlace pendientes. Es el punto de partida para «¿qué tengo esta semana?», «¿cómo van mis alumnos?» o preparar una clase; el detalle de uno, con leer_alumno.',
      inputSchema: { oposicion: oposicionParam },
    },
    async ({ oposicion }) =>
      protegido(async () => {
        const yo = await ctx.almacen(oposicion);
        const perfil = await perfilPreparador(yo);
        if (esError(perfil)) return perfil;
        const red = await ctx.almacenEn(raizRed(oposicion));
        const ahora = ahoraMadrid();
        const [alumnos, sesiones, reservas, enlaces] = await Promise.all([
          yo.listar('alumnos'),
          yo.listar('sesiones'),
          red.consultar('reservas', { where: { campo: 'preparador', op: 'EQUAL', valor: ctx.uid } }).catch(() => []),
          red.listar(`preparadores/${ctx.uid}/alumnos`).catch(() => []),
        ]);
        return json({
          oposicion,
          ahora_en_madrid: ahora.slice(0, 16),
          preparador: { nombre: txt(perfil.nombre), minutosClase: num(perfil.minutosClase, MINUTOS_CLASE), rubrica: Array.isArray(perfil.rubrica) ? perfil.rubrica : undefined },
          alumnos: alumnos
            .filter((a) => a.datos.borrado !== true && a.datos.suelto !== true)
            .map((a) => {
              const c = clasesConAlumno(sesiones, a.id, 1, ahora);
              return {
                id: a.id,
                nombre: txt(a.datos.nombre),
                ejercicio: num(a.datos.ejercicio, 3),
                enlazado: !!txt(a.datos.uid),
                clasesHechas: c.totalHechas,
                ultimaClase: c.hechas[0] ? { fecha: c.hechas[0].fecha, temas: c.hechas[0].temas, valoracion: c.hechas[0].resultado?.valoracion } : undefined,
                proximaClase: c.proximas[0] ? { id: c.proximas[0].id, fecha: c.proximas[0].fecha, hora: c.proximas[0].hora, temas: c.proximas[0].temas.length ? c.proximas[0].temas : c.proximas[0].temasPropuestos } : undefined,
              };
            }),
          reservasPorResponder: reservas
            .filter((r) => txt(r.datos.estado) === 'pedida' && txt(r.datos.fecha) > ahora)
            .sort((a, b) => txt(a.datos.fecha).localeCompare(txt(b.datos.fecha)))
            .map((r) => ({ id: r.id, alumno: txt(r.datos.alumnoNombre) || 'Alumno', fecha: txt(r.datos.fecha).slice(0, 16), minutos: num(r.datos.minutos, MINUTOS_CLASE), modalidad: txt(r.datos.modalidad) || undefined, temas: Array.isArray(r.datos.temas) ? r.datos.temas : undefined, nota: txt(r.datos.nota) || undefined })),
          enlacesPorAceptar: enlaces.filter((e) => e.datos.aceptado === false).map((e) => txt(e.datos.nombre) || 'Alumno'),
          aviso: AVISO_ALUMNOS,
        });
      }),
  );

  server.registerTool(
    'leer_alumno',
    {
      title: 'Preparador: la ficha de un alumno',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Para PREPARADORES: todo lo que el preparador tiene de un alumno para preparar su clase. De sus propios datos: sus notas privadas sobre él, las últimas clases con el tema cantado, la valoración, los comentarios, los criterios de su rúbrica y los deberes, y las próximas. Y, si el alumno está enlazado, lo que comparte: temas estudiados y en repaso, temas que pide no cantar, los temas fijados para cada clase, su cronograma (si lo comparte) con lo que lleva hecho y los informes de corrección de las clases con este preparador. No da sus tests ni sus notas personales (el alumno no los comparte). «alumno» es el id de leer_alumnos.',
      inputSchema: { oposicion: oposicionParam, alumno: z.string().describe('Id del alumno (de leer_alumnos).'), n: z.number().int().min(1).max(30).default(8).describe('Cuántas clases hechas, de la más reciente a la más antigua.') },
    },
    async ({ oposicion, alumno, n }) =>
      protegido(async () => {
        const yo = await ctx.almacen(oposicion);
        const perfil = await perfilPreparador(yo);
        if (esError(perfil)) return perfil;
        const ficha = await yo.leer(`alumnos/${Firestore.tramo(alumno)}`);
        if (!ficha || ficha.borrado === true) return error(`No tienes ningún alumno con id «${alumno}». Mira leer_alumnos.`);
        const ahora = ahoraMadrid();
        const salida: Record<string, unknown> = {
          alumno: { id: alumno, nombre: txt(ficha.nombre), ejercicio: num(ficha.ejercicio, 3), enlazado: !!txt(ficha.uid) && ficha.suelto !== true, misNotas: txt(ficha.notas) || undefined, temasQueLleva: Array.isArray(ficha.temas) && ficha.temas.length ? ficha.temas : undefined },
          clases: clasesConAlumno(await yo.listar('sesiones'), alumno, n, ahora),
        };
        const uidAlumno = ficha.suelto === true ? '' : txt(ficha.uid);
        if (uidAlumno) {
          const suyo = await ctx.almacenEn(Firestore.raizDe(uidAlumno, oposicion));
          const ajustes = await leerSeguro(suyo, 'progress/settings');
          let crono: Doc | null = null;
          let informes: unknown[] = [];
          try {
            crono = await cronogramaDe(suyo, true);
            // Solo las clases que firma este preparador: lo que el alumno hace por su cuenta o con otros no se enseña aquí.
            const mias = (await suyo.listar('cantes')).filter((c) => c.datos.preparador === ctx.uid && c.datos.estado === 'hecho').sort((a, b) => txt(b.datos.fecha).localeCompare(txt(a.datos.fecha))).slice(0, 4);
            informes = (await Promise.all(mias.map(async (c) => (await suyo.listar(`cantes/${Firestore.tramo(c.id)}/informes`).catch(() => [])).map((d) => resumenInforme(d.id, c.id, d.datos, 3000))))).flat().slice(0, 4);
          } catch (e) {
            if (!(e instanceof ErrorFirestore && e.estado === 403)) throw e;
          }
          const r = crono ? resumenCronograma('', crono) : null;
          salida.loQueComparte = {
            temasEstudiados: Array.isArray(ajustes?.temasEstudiados) ? ajustes.temasEstudiados : undefined,
            temasEnRepaso: Array.isArray(ajustes?.temasEnRepaso) ? ajustes.temasEnRepaso : undefined,
            noCantar: Array.isArray(ajustes?.noCantar) ? ajustes.noCantar.map((x) => String(x).split('@')[0]) : undefined,
            cronograma: r ? { ejercicio: r.ejercicio, fin: r.fin, temasHechos: Object.keys(r.hechos), estaSemana: semanaDe(r, ahora.slice(0, 10)).actual, proximas: r.semanas.filter((s) => s.cante >= ahora.slice(0, 10)).slice(0, 6) } : 'no lo comparte',
            correccionesDeSusClases: informes.length ? informes : undefined,
            ...(ajustes ? {} : { aviso: 'No se ha podido leer lo que comparte (puede que el enlace no esté aceptado todavía).' }),
          };
        }
        return json({ ...salida, aviso: AVISO_ALUMNOS });
      }),
  );

  server.registerTool(
    'responder_reserva',
    {
      title: 'Preparador: aceptar o rechazar una reserva',
      annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: true, openWorldHint: true },
      description:
        'Para PREPARADORES: contesta a una clase que le ha pedido un alumno (las ve en leer_alumnos, «reservasPorResponder»). Al aceptarla se crea la clase en su agenda y en la del alumno, con la modalidad y los temas que pidió (como propuesta), igual que al aceptarla en la app; al rechazarla, el alumno lo ve en la suya. SOLO después de que el preparador lo confirme con el resumen (alumno, día, hora y duración).',
      inputSchema: {
        oposicion: oposicionParam,
        reserva: z.string().describe('Id de la reserva (de leer_alumnos).'),
        aceptar: z.boolean().describe('true: aceptarla; false: rechazarla.'),
        aunque_choque: z.boolean().default(false).describe('true solo si el preparador ya sabe que pisa otra clase suya y quiere seguir.'),
      },
    },
    async ({ oposicion, reserva, aceptar, aunque_choque }) =>
      protegido(async () => {
        const yo = await ctx.almacen(oposicion);
        const perfil = await perfilPreparador(yo);
        if (esError(perfil)) return perfil;
        const red = await ctx.almacenEn(raizRed(oposicion));
        const rid = Firestore.tramo(reserva);
        const r = await leerSeguro(red, `reservas/${rid}`);
        if (!r || txt(r.preparador) !== ctx.uid) return error(`No tienes ninguna reserva con id «${reserva}». Mira leer_alumnos.`);
        if (txt(r.estado) !== 'pedida') return error(`Esa reserva ya está ${txt(r.estado)}: no hay nada que contestar.`);
        const ahora = ahoraMadrid();
        if (!aceptar) {
          await red.escribir(`reservas/${rid}`, { estado: 'rechazada', updatedAt: ahora }, ['estado', 'updatedAt']);
          return json({ rechazada: true, alumno: txt(r.alumnoNombre), fecha: txt(r.fecha).slice(0, 16) });
        }
        const fecha = txt(r.fecha);
        const minutos = num(r.minutos, MINUTOS_CLASE);
        const choques = proximas(await yo.listar('sesiones'), ahora, 800).filter((c) => seSolapan(fecha, minutos, c.fecha, c.minutos));
        if (choques.length && !aunque_choque) return error(`Pisa otra clase tuya: ${choques.map((c) => c.fecha.slice(0, 16)).join(', ')}. Pregunta al preparador y, si quiere seguir, repite con aunque_choque: true.`);
        // La ficha del alumno: la suya de siempre o, si no la tenía, una nueva con su uid (como la app).
        const uidAlumno = txt(r.alumno);
        const alumnos = await yo.listar('alumnos');
        let ficha = alumnos.find((a) => txt(a.datos.uid) === uidAlumno && a.datos.borrado !== true);
        if (!ficha) {
          const datos: Doc = { id: uidAlumno, nombre: txt(r.alumnoNombre) || 'Alumno', ejercicio: 3, notas: '', temas: [], uid: uidAlumno, creado: ahora, updatedAt: ahora, borrado: false };
          await yo.escribir(`alumnos/${Firestore.tramo(uidAlumno)}`, datos);
          ficha = { id: uidAlumno, datos };
        }
        const nombre = txt(perfil.nombre);
        const modalidad = txt(r.modalidad) === 'online' ? 'online' : 'presencial';
        const id = `res_${reserva}`;
        const sesion = construirSesion(id, { fecha, minutos, modalidad, temas: Array.isArray(r.temas) ? r.temas.map(String) : [], nota: txt(r.nota) }, ficha.id, num(ficha.datos.ejercicio, 3), oposicion === 'tcee' ? 30 : 20, { nombre, minutosClase: minutos, plataforma: txt(perfil.plataforma), numTemas: num(perfil.temasPorClase, oposicion === 'tcee' ? 1 : 2) }, ahora);
        if (!txt(r.modalidad)) delete sesion.modalidad;
        await yo.escribir(`sesiones/${Firestore.tramo(id)}`, sesion);
        let enSuAgenda = false;
        try {
          await (await ctx.almacenEn(Firestore.raizDe(uidAlumno, oposicion))).escribir(`cantes/${Firestore.tramo(id)}`, copiaParaAlumno(sesion, ctx.uid, nombre));
          enSuAgenda = true;
        } catch (e) {
          if (!(e instanceof ErrorFirestore && e.estado === 403)) throw e;
        }
        await red.escribir(`reservas/${rid}`, { estado: 'aceptada', updatedAt: ahora }, ['estado', 'updatedAt']);
        return json({ aceptada: true, sesion: id, alumno: txt(ficha.datos.nombre), fecha: fecha.slice(0, 16), minutos, en_la_agenda_del_alumno: enSuAgenda, aviso: enSuAgenda ? 'La clase está en las dos agendas. Al abrir tu app se crea el evento de Google Calendar (y el enlace de Meet si es online y lo tienes activado).' : 'La clase está en tu agenda; la app la copiará a la del alumno la próxima vez que la abras.' });
      }),
  );

  server.registerTool(
    'guardar_nota_alumno',
    {
      title: 'Preparador: apuntar en sus notas de un alumno',
      annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: false, openWorldHint: false },
      description:
        'Para PREPARADORES: añade una anotación, con su fecha, a sus notas privadas sobre un alumno (la ficha del alumno en su app; el alumno no las ve). Úsala al acabar de preparar o de repasar una clase («arrastra la introducción», «insistir en gráficos») SOLO cuando el preparador lo confirme. No borra lo que ya había.',
      inputSchema: { oposicion: oposicionParam, alumno: z.string().describe('Id del alumno (de leer_alumnos).'), nota: z.string().min(3).max(600).describe('La anotación, breve.') },
    },
    async ({ oposicion, alumno, nota }) =>
      protegido(async () => {
        const yo = await ctx.almacen(oposicion);
        const perfil = await perfilPreparador(yo);
        if (esError(perfil)) return perfil;
        const ruta = `alumnos/${Firestore.tramo(alumno)}`;
        const ficha = await yo.leer(ruta);
        if (!ficha || ficha.borrado === true) return error(`No tienes ningún alumno con id «${alumno}». Mira leer_alumnos.`);
        const ahora = ahoraMadrid();
        const [a, m, d] = ahora.slice(0, 10).split('-');
        const notas = `${txt(ficha.notas).trimEnd()}${txt(ficha.notas).trim() ? '\n' : ''}${Number(d)}/${Number(m)}/${a}: ${nota.trim()}`;
        if (notas.length > 8000) return error('Las notas de este alumno ya son muy largas: que el preparador las resuma en la app antes de añadir más.');
        await yo.escribir(ruta, { notas, updatedAt: ahora }, ['notas', 'updatedAt']);
        return json({ guardada: true, alumno: txt(ficha.nombre), aviso: 'Está en la ficha del alumno en tu app (solo la ves tú).' });
      }),
  );

  server.registerTool(
    'guardar_deberes',
    {
      title: 'Preparador: poner deberes en una clase',
      annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: false, openWorldHint: true },
      description:
        'Para PREPARADORES: añade deberes a una clase (la sesión sale de leer_alumno o leer_alumnos), como en la app: «estudiar», «esquema» (esquema a ciegas) o «cantar» un tema, «test» (con un mínimo de preguntas y, si se quiere, de un tema) o «libre» (texto). Los automáticos se tachan solos cuando el alumno lo hace en su app. El alumno enlazado los ve en la clase. SOLO cuando el preparador lo confirme.',
      inputSchema: {
        oposicion: oposicionParam,
        sesion: z.string().describe('Id de la clase.'),
        tareas: z
          .array(z.object({ tipo: z.enum(['estudiar', 'esquema', 'cantar', 'test', 'libre']), tema: z.string().optional().describe('«3.A.8» (obligatorio en estudiar, esquema y cantar).'), texto: z.string().max(200).optional().describe('El texto, en las libres.'), preguntas: z.number().int().min(1).max(200).optional().describe('Mínimo de preguntas, en los test.') }))
          .min(1)
          .max(8),
      },
    },
    async ({ oposicion, sesion, tareas }) =>
      protegido(async () => {
        const yo = await ctx.almacen(oposicion);
        const perfil = await perfilPreparador(yo);
        if (esError(perfil)) return perfil;
        const sid = Firestore.tramo(sesion);
        const clase = await yo.leer(`sesiones/${sid}`);
        if (!clase || clase.borrado === true) return error(`No tienes ninguna clase con id «${sesion}».`);
        const ahora = ahoraMadrid();
        const { tareas: lista, errores } = anadirTareas(clase.tareas, tareas, ahora);
        if (errores.length) return error(`No se han guardado los deberes: ${errores.join('; ')}.`);
        await yo.escribir(`sesiones/${sid}`, { tareas: lista, updatedAt: ahora }, ['tareas', 'updatedAt']);
        // La copia de la clase en la agenda del alumno, si está enlazado.
        const ficha = typeof clase.alumno === 'string' ? await yo.leer(`alumnos/${Firestore.tramo(clase.alumno)}`) : null;
        const uidAlumno = ficha && ficha.suelto !== true ? txt(ficha.uid) : '';
        let leLlega = false;
        if (uidAlumno) {
          try {
            const suyo = await ctx.almacenEn(Firestore.raizDe(uidAlumno, oposicion));
            if (await suyo.leer(`cantes/${sid}`)) {
              await suyo.escribir(`cantes/${sid}`, { tareas: lista, preparador: ctx.uid, updatedAt: ahora }, ['tareas', 'preparador', 'updatedAt']);
              leLlega = true;
            }
          } catch (e) {
            if (!(e instanceof ErrorFirestore && e.estado === 403)) throw e;
          }
        }
        return json({ guardados: tareas.length, deberesDeLaClase: lista.length, le_llegan_al_alumno: leLlega, aviso: leLlega ? undefined : uidAlumno ? 'Están en tu clase; la app los pasará a la del alumno la próxima vez que la abras.' : 'Este alumno no usa la app: díselos tú.' });
      }),
  );

  // Un prompt por tarea: los clientes que los admiten (Claude los enseña en el menú «+»)
  // ofrecen «Corregir un cante», «Simulacro completo»… y arrancan con el método cargado.
  for (const tarea of NOMBRES_TAREAS) {
    server.registerPrompt(
      tarea,
      {
        title: TAREAS[tarea].titulo,
        description: `Para cuando el opositor ${TAREAS[tarea].cuando}.`,
        argsSchema: { detalle: z.string().optional().describe('Lo que quiera añadir: el tema, la transcripción, la fecha del examen…') },
      },
      ({ detalle }) => ({
        messages: [
          {
            role: 'user',
            content: {
              type: 'text',
              text: `${TAREAS[tarea].titulo}.${detalle ? `\n\n${detalle}` : ''}\n\nAntes de empezar, llama a leer_metodo con tarea «${tarea}» y sigue ese método; mis datos de la app los lees con las herramientas del conector.`,
            },
          },
        ],
      }),
    );
  }

  return server;
}
