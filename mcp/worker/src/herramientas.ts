// Las herramientas del conector: lo que Claude puede leer y escribir de la app en
// nombre del opositor. Cada petición MCP crea un servidor nuevo (sin estado) con un
// Contexto que sabe abrir Firestore con el ID token del opositor y leer el contenido.

import { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import type { CallToolResult } from '@modelcontextprotocol/sdk/types.js';
import { z } from 'zod';
import { Contenido, apartadosDe, codigoConPuntos, documentosCanon, documentosDictamen, extraerApartado, normalizarCodigo } from './contenido';
import {
  construirCronograma,
  construirInforme,
  cronogramaActivo,
  resumenCantes,
  resumenCronograma,
  resumenProgreso,
  resumenTest,
  type TemasPorPregunta,
} from './datos';
import { type Apuntes, ErrorApuntes, idDeDrive } from './drive';
import { type AlmacenDatos, ErrorFirestore, type Json } from './firestore';

export const OPOSICIONES = ['tcee', 'dce'] as const;
export type Oposicion = (typeof OPOSICIONES)[number];

export interface Banco {
  temas: TemasPorPregunta;
  respuestas: Map<number, string[]>;
}

/** Lo que las herramientas necesitan del Worker (se simula en las pruebas). */
export interface Contexto {
  uid: string;
  email: string;
  /** Firestore sobre la raíz del opositor en esa oposición, con un ID token vigente. */
  almacen(oposicion: Oposicion): Promise<AlmacenDatos>;
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
  /** Revoca las concesiones OAuth del opositor y borra su token de Firebase guardado. */
  desconectar(): Promise<void>;
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

const AVISO_EXCLUSIVO =
  'Material exclusivo de victorgutierrezmarcos.es: solo para la preparación personal de este opositor en su cuenta de Claude (condiciones-materiales.html, apartado 1 bis). No lo copies fuera de esta conversación.';

/** Ficheros de texto de la skill que se pueden pedir con leer_skill. */
const RUTA_SKILL = /^(SKILL\.md|LICENCIA\.md|VERSION\.txt|(references|assets|scripts)\/[A-Za-z0-9_\-./]+\.(md|txt|json|tex|sty|lua|py|csv))$/;

const NOTA_CONECTOR =
  '[Cargada desde el conector «Prepara con Claude». Cada ruta relativa que cite este fichero (references/…, assets/…, scripts/…) se lee con leer_skill(ruta). Para los temas revisados, las fichas, el dictamen y el canon usa mejor leer_tema, leer_ficha, leer_guia_dictamen y leer_canon (permiten pedir un apartado), y para los datos del opositor, las herramientas leer_* en vez de pedirle el JSON o los ficheros (references/conector.md). El paso 0 «Versión al día» no hace falta: esto ya es la última versión.]';

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

/** Convierte los fallos previsibles en un mensaje útil para Claude y el opositor. */
async function protegido(f: () => Promise<CallToolResult>): Promise<CallToolResult> {
  try {
    return await f();
  } catch (e) {
    if (e instanceof ErrorSesion) return error(`La sesión con la app ha caducado o se ha revocado: ${e.message}. Pide al opositor que vuelva a conectar el conector «Prepara con Claude» (en Claude, Personalizar → Conectores).`);
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
      name: 'Prepara con Claude · Oposición TCEE · DCE',
      title: 'Prepara con Claude',
      version: '0.1.0',
      // Icono y web del servidor (MCP 2025-11-25): los clientes que los admiten enseñan el icono de la app junto al conector.
      websiteUrl: 'https://www.victorgutierrezmarcos.es/oposicion/prepara-con-claude.html',
      icons: [
        { src: 'https://www.victorgutierrezmarcos.es/app/assets/icon/icon.svg', mimeType: 'image/svg+xml', sizes: ['any'] },
        { src: 'https://www.victorgutierrezmarcos.es/app/abrir/icons/Icon-512.png', mimeType: 'image/png', sizes: ['512x512'] },
      ],
    },
    {
      instructions: 'Conector oficial de victorgutierrezmarcos.es: el equipo de preparación de las oposiciones a TCEE y DCE (corrige cantes, dictámenes y escritos, resuelve dudas del temario, hace el cronograma, simula al tribunal, test, tarjetas, informes semanales y prepara clases para preparadores), con los datos de la app «Oposición TCEE · DCE» del usuario conectado. ANTES de responder a cualquier petición sobre la oposición, llama a leer_skill() sin argumentos: devuelve las instrucciones completas (SKILL.md) y síguelas durante toda la conversación; los ficheros que citen (references/…, assets/…) se leen con leer_skill(ruta). Si la skill «prepara-oposicion» ya está instalada en la cuenta, úsala igual: es la misma. Para recomendar fuentes de un tema usa fuentes_tema (y leer_fuente para leer, valorar o comparar cualquiera de esas fuentes), y para saber qué temas forman una materia o un bloque, buscar_temario. Usa estas herramientas solo para el usuario conectado; escribe en la app (proponer_cronograma, guardar_informe_cante) solo cuando lo confirme.',
    },
  );

  server.registerTool(
    'leer_skill',
    {
      title: 'Cargar la skill «Prepara con Claude»',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'LLÁMALA PRIMERO, antes de cualquier tarea sobre la oposición. Sin ruta devuelve SKILL.md: las instrucciones de todo el equipo de preparación (qué agente usar para cada petición, reglas, formatos de la app, aviso final). Con ruta devuelve el fichero que SKILL.md cite: «references/agentes/corrector-cante.md», «references/datos-app.md», «references/perfiles.md», «assets/plantilla-informe-cante.md»… Siempre la última versión publicada.',
      inputSchema: {
        ruta: z.string().max(160).default('SKILL.md').describe('Ruta relativa dentro de la skill, como la cita SKILL.md (por defecto, SKILL.md).'),
      },
    },
    async ({ ruta }) =>
      protegido(async () => {
        const limpia = ruta.trim().replace(/^\.?\//, '').replace(/^prepara-oposicion\//, '');
        if (!RUTA_SKILL.test(limpia) || limpia.includes('..')) {
          return error(`Ruta no válida: «${ruta}». Usa una ruta relativa de la skill, como «SKILL.md» o «references/agentes/dudas.md».`);
        }
        const texto = await ctx.skill(limpia);
        if (texto === null) return error(`No existe «${limpia}» en la skill publicada. Comprueba la ruta en SKILL.md.`);
        if (limpia === 'SKILL.md') return textoMd(`${NOTA_CONECTOR}\n\n${texto}`);
        return textoMd(/^references\/(temas|dictamen|canon)\//.test(limpia) ? `${AVISO_EXCLUSIVO}\n\n${texto}` : texto);
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
        'Busca en el programa de TCEE y DCE por materia, bloque o palabras del título y devuelve los temas que encajan, agrupados por bloque de la organización del temario, con su idea clave y qué fuentes tienen (revisado, PDF de la web, Manuel, número de apuntes de la ATCEE). Úsala para «¿qué temas forman la teoría microeconómica?», «¿dónde se estudia la curva de Phillips?», «¿qué temas de comercio internacional hay?». Sin consulta, devuelve los bloques con sus temas.',
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
        const enBloques = new Set(bloques.flatMap((b) => b.temas.map((t) => t!.codigo)));
        const sueltos = palabras.length
          ? Object.entries(temas).filter(([c, t]) => !enBloques.has(c) && encaja(`${c} ${t.titulo} ${t.bloque ?? ''} ${t.categoria ?? ''} ${t.idea ?? ''} ${t.parte}`)).map(([c]) => resumen(c))
          : [];
        if (!bloques.length && !sueltos.length) return error(`Nada en el programa de ${oposicion.toUpperCase()} encaja con «${consulta}». Prueba con otra palabra o sin consulta para ver los bloques.`);
        return json({
          consulta, oposicion, bloques, otrosTemas: sueltos.slice(0, 40),
          nota: 'Los bloques y categorías son la organización del temario de victorgutierrezmarcos.es (oposicion/organizacion.html): agrupan temas que comparten modelos y conviene estudiar juntos. Para las fuentes de un tema concreto, fuentes_tema.',
        });
      }),
  );

  server.registerTool(
    'leer_progreso',
    {
      title: 'Leer el progreso del opositor',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'Resumen de la preparación tal como lo exporta la app en «Prepara con Claude»: fechas de los ejercicios e hitos, temas estudiados y en repaso, agenda por tema (vueltas y pendientes), notas propias, horario semanal, repaso Leitner por caja (vencidas y temas con más fallos) y ajustes (rúbrica, temas que no quiere cantar). Mismo formato que oposicion_<id>_para_claude.json sin «cantes», «cronograma» ni «tests»: para eso están las otras herramientas.',
      inputSchema: { oposicion: oposicionParam },
    },
    async ({ oposicion }) =>
      protegido(async () => {
        const db = await ctx.almacen(oposicion);
        const [settings, plan, leitner, notas, banco] = await Promise.all([
          db.leer('progress/settings'),
          db.leer('progress/plan'),
          db.leer('progress/spaced_repetition'),
          db.listar('notes'),
          ctx.banco(),
        ]);
        return json(resumenProgreso(oposicion, settings, plan, leitner, notas, banco.temas));
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
        const where = desde && /^\d{4}-\d{2}-\d{2}$/.test(desde) ? { campo: 'timestamp', op: 'GREATER_THAN_OR_EQUAL' as const, valor: `${desde}T00:00:00Z` } : undefined;
        const docs = await db.consultar('exam_results', { orderBy: 'timestamp', descendente: true, limite, where });
        const tests = docs.map((d) => resumenTest(d.id, d.datos, banco));
        return json({ oposicion, tests });
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
        return json({ oposicion, ...resumenCantes(docs, n) });
      }),
  );

  server.registerTool(
    'leer_cronograma',
    {
      title: 'Leer el cronograma activo',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'El cronograma de estudio en curso (semana a semana: primer día, día del cante y temas; las de descanso marcadas), con los temas ya hechos, los desmarcados, el ritmo (temasPorSemana), el día de cante (1 = lunes … 7 = domingo), las fases si es por fases y cuántas propuestas de preparadores tiene pendientes. Null si no tiene ninguno activo.',
      inputSchema: { oposicion: oposicionParam },
    },
    async ({ oposicion }) =>
      protegido(async () => {
        const db = await ctx.almacen(oposicion);
        const docs = await db.listar('cronogramas');
        const activo = cronogramaActivo(docs);
        return json({ oposicion, cronograma: activo ? resumenCronograma(activo.id, activo.datos) : null, archivados: docs.length - (activo ? 1 : 0) });
      }),
  );

  server.registerTool(
    'proponer_cronograma',
    {
      title: 'Guardar en la app un cronograma nuevo',
      annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: false, openWorldHint: false },
      description:
        'Crea en la app el cronograma acordado con el opositor (pasa a ser el activo; el anterior queda archivado, no se borra). Úsalo SOLO después de enseñárselo entero y de que confirme expresamente que lo quiere guardar. Una entrada por semana de cante, con la fecha del cante (AAAA-MM-DD, siempre en el día de cante) y los códigos de los temas («3.A.8»); las semanas sin cante entre la primera y la última quedan de descanso. La app lo muestra al sincronizar (al abrirla o cada pocos minutos).',
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
      },
    },
    async ({ oposicion, ejercicio, diaCante, semanas, temasPorSemana, examen }) =>
      protegido(async () => {
        const { documento, errores } = construirCronograma({ semanas, diaCante, ejercicio, temasPorSemana, examen });
        if (errores.length) return error(`No se ha guardado el cronograma:\n- ${errores.join('\n- ')}`);
        const db = await ctx.almacen(oposicion);
        const anteriores = await db.listar('cronogramas');
        const marca = new Date().toISOString();
        for (const c of anteriores) {
          if (c.datos.archivado !== true) await db.escribir(`cronogramas/${c.id}`, { archivado: true, updatedAt: marca }, ['archivado', 'updatedAt']);
        }
        await db.escribir(`cronogramas/${documento.id as string}`, documento);
        return json({
          guardado: true,
          id: documento.id,
          semanas: (documento.semanas as Json[]).length,
          temas: (documento.temas as Json[]).length,
          archivados: anteriores.filter((c) => c.datos.archivado !== true).map((c) => c.id),
          aviso: 'Dile al opositor que lo verá en la app (Cronograma) al sincronizar y que puede retocar cada semana allí.',
        });
      }),
  );

  server.registerTool(
    'guardar_informe_cante',
    {
      title: 'Guardar en la app el informe de un cante',
      annotations: { readOnlyHint: false, destructiveHint: false, idempotentHint: false, openWorldHint: false },
      description:
        'Guarda el informe de corrección de un cante en la app (cantes/{id}/informes) y, si se dan, pone en el diario la valoración (1-5, general y por tema), los comentarios (hasta 300 caracteres) y los criterios de la rúbrica, como haría el opositor en «¿Cómo ha ido el cante?». Úsalo SOLO con un cante que ya está en el diario (su «id» viene de leer_cantes) y después de que el opositor confirme el bloque «Para la app».',
      inputSchema: {
        oposicion: oposicionParam,
        canteId: z.string().min(1).describe('Id del cante (de leer_cantes).'),
        informe: z.string().min(1).describe('El informe completo en Markdown (lo que se le ha dicho al opositor).'),
        valoracion: z.number().int().min(1).max(5).optional().describe('Valoración general 1-5.'),
        valoraciones: z.record(z.string(), z.number().int().min(1).max(5)).optional().describe('Valoración por tema cantado («3.A.8»: 3).'),
        comentarios: z.string().max(300).optional().describe('Comentarios para el diario, lo más importante primero (≤ 300 caracteres).'),
        criterios: z.record(z.string(), z.number().int().min(1).max(5)).optional().describe('Nota 1-5 por criterio de la rúbrica, solo si el opositor la usa.'),
        tareas: z.array(z.string()).max(10).optional().describe('Tareas para antes del próximo cante.'),
      },
    },
    async ({ oposicion, canteId, informe, valoracion, valoraciones, comentarios, criterios, tareas }) =>
      protegido(async () => {
        const { id, documento, resultado, errores } = construirInforme({ informe, valoracion, valoraciones, comentarios, criterios, tareas });
        if (errores.length) return error(`No se ha guardado el informe:\n- ${errores.join('\n- ')}`);
        const db = await ctx.almacen(oposicion);
        const cante = await db.leer(`cantes/${canteId}`);
        if (!cante) return error(`No hay ningún cante con id «${canteId}» en la app.`);
        await db.escribir(`cantes/${canteId}/informes/${id}`, documento);
        let diario = false;
        if (Object.keys(resultado).length && cante.estado === 'hecho') {
          const campos = Object.keys(resultado).map((k) => `resultado.${k}`);
          await db.escribir(`cantes/${canteId}`, { resultado, updatedAt: new Date().toISOString() }, [...campos, 'updatedAt']);
          diario = true;
        }
        return json({ guardado: true, informe: id, diarioActualizado: diario, aviso: diario ? undefined : 'El cante no está marcado como hecho en la app: el informe se ha guardado, pero la valoración y los comentarios no (que lo cierre en la app).' });
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
        'El texto completo de un tema revisado (como se canta: introducción, apartados con sus minutos, conclusión y anexos) en Markdown, o solo un apartado («Introducción», «II», «B», o parte de su título). Sin «apartado» devuelve la lista de apartados y el tema entero si cabe. Material exclusivo: solo para el opositor conectado.',
      inputSchema: { tema: temaParam, apartado: z.string().optional().describe('Apartado concreto; si falta, el tema entero.'), guion: z.boolean().default(false).describe('true: el guion del cante de 30 minutos en vez del tema.') },
    },
    async ({ tema, apartado, guion }) =>
      protegido(async () => {
        const codigo = normalizarCodigo(tema);
        if (!codigo) return error(`Código de tema no válido: «${tema}».`);
        const md = await ctx.contenido.tema(codigo, guion ? 'guion-cante' : 'tema');
        if (!md) return error(`El tema ${codigoConPuntos(codigo)} no está entre los revisados (mira listar_temas_revisados).`);
        if (apartado) {
          const parte = extraerApartado(md, apartado);
          return parte ? textoMd(`${AVISO_EXCLUSIVO}\n\n${parte}`) : error(`No hay ningún apartado «${apartado}» en ${codigoConPuntos(codigo)}. Apartados: ${apartadosDe(md).join(' · ')}`);
        }
        return textoMd(`${AVISO_EXCLUSIVO}\n\nApartados: ${apartadosDe(md).join(' · ')}\n\n${md}`);
      }),
  );

  server.registerTool(
    'leer_ficha',
    {
      title: 'Leer la ficha de repaso de un tema',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description: 'La ficha de repaso de cuatro páginas de un tema revisado, en Markdown. Material exclusivo: solo para el opositor conectado.',
      inputSchema: { tema: temaParam },
    },
    async ({ tema }) =>
      protegido(async () => {
        const codigo = normalizarCodigo(tema);
        if (!codigo) return error(`Código de tema no válido: «${tema}».`);
        const md = await ctx.contenido.tema(codigo, 'ficha');
        return md ? textoMd(`${AVISO_EXCLUSIVO}\n\n${md}`) : error(`No hay ficha de repaso de ${codigoConPuntos(codigo)} (mira listar_temas_revisados).`);
      }),
  );

  server.registerTool(
    'leer_guia_dictamen',
    {
      title: 'Leer la guía del dictamen de coyuntura',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description:
        'La guía del dictamen (1D01) y sus piezas: «guia-1D01» (la guía entera), «resumen-1D01» (resumen de 6-8 páginas), «guion-1D01» (guion del vídeo), «examen-espana» (examen de ejemplo) y «solucion-espana» (solución de máximos). Con «seccion» devuelve solo ese apartado de nivel 2. Material exclusivo.',
      inputSchema: {
        documento: z.enum(documentosDictamen).default('guia-1D01'),
        seccion: z.string().optional().describe('Apartado concreto (número, letra o parte del título); si falta, el documento entero.'),
      },
    },
    async ({ documento, seccion }) =>
      protegido(async () => {
        const md = await ctx.contenido.dictamen(documento);
        if (!md) return error(`El documento «${documento}» no está publicado en el conector.`);
        if (seccion) {
          const parte = extraerApartado(md, seccion);
          return parte ? textoMd(`${AVISO_EXCLUSIVO}\n\n${parte}`) : error(`No hay ninguna sección «${seccion}». Secciones: ${apartadosDe(md).join(' · ')}`);
        }
        return textoMd(`${AVISO_EXCLUSIVO}\n\n${md}`);
      }),
  );

  server.registerTool(
    'leer_canon',
    {
      title: 'Leer el canon del temario',
      annotations: { readOnlyHint: true, openWorldHint: false },
      description: 'El canon común del temario revisado: «notacion» (convenciones de notación y símbolos) y «modelos-indice» (índice de los modelos y en qué tema vive cada uno). Material exclusivo.',
      inputSchema: { documento: z.enum(documentosCanon).default('notacion') },
    },
    async ({ documento }) =>
      protegido(async () => {
        const md = await ctx.contenido.canon(documento);
        return md ? textoMd(`${AVISO_EXCLUSIVO}\n\n${md}`) : error(`El documento «${documento}» no está publicado en el conector.`);
      }),
  );

  server.registerTool(
    'desconectar',
    {
      title: 'Desconectar Claude de la app',
      annotations: { readOnlyHint: false, destructiveHint: true, idempotentHint: true, openWorldHint: false },
      description:
        'Revoca el acceso de este conector a los datos del opositor: borra del servidor su token de Firebase y las autorizaciones OAuth. Después, ninguna herramienta funciona hasta que vuelva a conectar. Úsalo solo si el opositor lo pide. También puede hacerlo desde la app (Más → Prepara con Claude → Desconectar Claude).',
      inputSchema: { confirmar: z.literal(true).describe('Tiene que ser true: el opositor ha pedido desconectar.') },
    },
    async () =>
      protegido(async () => {
        await ctx.desconectar();
        return json({ desconectado: true, aviso: 'Acceso revocado. Para volver a usar el conector, el opositor tiene que conectarlo de nuevo en Claude.' });
      }),
  );

  return server;
}
