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
  /** Revoca las concesiones OAuth del opositor y borra su token de Firebase guardado. */
  desconectar(): Promise<void>;
}

export class ErrorSesion extends Error {}

const AVISO_EXCLUSIVO =
  'Material exclusivo de victorgutierrezmarcos.es: solo para la preparación personal de este opositor en su cuenta de Claude (condiciones-materiales.html, apartado 1 bis). No lo copies fuera de esta conversación.';

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
    if (e instanceof ErrorSesion) return error(`La sesión con la app ha caducado o se ha revocado: ${e.message}. Pide al opositor que vuelva a conectar el conector «Prepara con Claude» (en Claude, Configuración → Conectores).`);
    if (e instanceof ErrorFirestore) {
      if (e.estado === 403) return error('Firestore ha denegado el acceso (las reglas solo dejan al dueño leer y escribir sus datos). Si el opositor acaba de cambiar de cuenta, que vuelva a conectar el conector.');
      return error(`Error de Firestore (${e.estado}): ${e.message}`);
    }
    return error(`Error inesperado: ${(e as Error).message}`);
  }
}

export function crearServidor(ctx: Contexto): McpServer {
  const server = new McpServer(
    { name: 'Prepara con Claude · Oposición TCEE · DCE', version: '0.1.0' },
    {
      instructions:
        'Conector oficial de victorgutierrezmarcos.es para la preparación de las oposiciones a TCEE y DCE. Lee el progreso, los tests, los cantes y el cronograma del opositor conectado directamente de la app, sirve los materiales exclusivos (temas revisados, fichas, guía del dictamen, canon) y, solo cuando el opositor lo confirma, guarda en la app el cronograma acordado y el informe de un cante. Sigue la skill «Prepara con Claude» (references/conector.md). Nunca uses estas herramientas para otra persona que no sea el opositor conectado.',
    },
  );

  server.registerTool(
    'leer_progreso',
    {
      title: 'Leer el progreso del opositor',
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
