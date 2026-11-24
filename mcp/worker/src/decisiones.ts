// Decisiones del autor sobre las sugerencias de mejora, desde los botones del correo.
//
// El agente diario (scripts/agente-sugerencias.py, en el ordenador de Víctor) deja en el KV SESIONES,
// por la API de Cloudflare, lo que hace falta para decidir cada sugerencia (`sug:<id>`) y el informe
// del día (`informe:<clave>`), y manda un correo cuyos botones apuntan aquí:
//
//   GET  /informe?c=<clave>&f=<firma>            el informe del día (es también el cuerpo del correo)
//   GET  /decidir?i=<id>&e=<estado>&f=<firma>    enseña la sugerencia y pide confirmar
//   POST /decidir                                apunta la decisión en `decision:<id>`
//
// Un GET nunca decide nada: los filtros de correo abren los enlaces. La firma es un resumen con el
// secreto del servidor (CLAVE_CIFRADO), que solo tienen el Worker y el agente. Nada de esto lleva
// datos de usuarios: las sugerencias llegan aquí ya sin quién las mandó.

import { sha256 } from './cifrado';
import { escapar } from './paginas';

export interface AlmacenDecisiones {
  get(clave: string): Promise<string | null>;
  put(clave: string, valor: string, opciones?: { expirationTtl?: number }): Promise<void>;
}

export const ESTADOS_DECISION = ['aceptada', 'descartada'] as const;
type Estado = (typeof ESTADOS_DECISION)[number];
const TTL = 90 * 86_400;
const ID = /^[\w-]{3,48}$/;

/** Firma de un enlace: `ambito` es «decidir» o «informe». */
export async function firma(secreto: string, ambito: string, id: string): Promise<string> {
  return (await sha256(`${secreto}:${ambito}:${id}`)).slice(0, 32);
}

/** Comparación en tiempo constante (las dos son hexadecimales de la misma longitud). */
function iguales(a: string, b: string): boolean {
  if (a.length !== b.length) return false;
  let d = 0;
  for (let k = 0; k < a.length; k++) d |= a.charCodeAt(k) ^ b.charCodeAt(k);
  return d === 0;
}

const pagina = (titulo: string, cuerpo: string): string => `<!doctype html>
<html lang="es"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex"><title>${escapar(titulo)}</title>
<style>
  body { background: #E2EFD9; color: #1f1b24; font: 17px/1.5 'Palatino Linotype', Palatino, 'Book Antiqua', Georgia, serif; margin: 0; }
  main { max-width: 680px; margin: 5vh auto 3rem; padding: 0 16px; }
  .card { background: #F6FAF2; border: 1px solid #C9B37E; border-radius: 6px; padding: 1.5rem 1.7rem; }
  h1 { color: #5F2987; font-weight: normal; font-size: 1.6rem; margin: 0 0 .4em; }
  h2 { color: #5F2987; font-weight: normal; font-size: 1.15rem; margin: 1.2em 0 .3em; }
  .sobre { font-variant-caps: all-small-caps; letter-spacing: .04em; color: #4A4452; }
  blockquote { margin: .5em 0; padding: .4em 0 .4em .9em; border-left: 3px solid #C9B37E; }
  .antes { color: #7a2a2a; } .despues { color: #2e6b3f; }
  textarea { width: 100%; box-sizing: border-box; font: inherit; min-height: 90px; padding: 8px 10px; border: 1px solid #b9b3c0; border-radius: 4px; background: #fff; }
  .acciones { display: flex; gap: .8rem; flex-wrap: wrap; margin-top: 1rem; }
  button, .boton { font: inherit; cursor: pointer; border-radius: 4px; padding: 9px 18px; border: 1px solid #5F2987; background: #5F2987; color: #fff; text-decoration: none; }
  .secundario { background: transparent; color: #5F2987; }
  .nota { font-size: .92rem; color: #4A4452; }
  button:focus-visible, textarea:focus-visible, a:focus-visible { outline: 2px solid #C9B37E; outline-offset: 2px; }
</style></head><body><main><div class="card">${cuerpo}</div></main></body></html>`;

const NOMBRE: Record<Estado, string> = { aceptada: 'Aceptar', descartada: 'Descartar' };
const texto = (v: unknown, n = 2000): string => (typeof v === 'string' ? v.slice(0, n) : '');

/** Lo que el agente dejó escrito de una sugerencia, pintado para decidir. */
function resumen(s: Record<string, unknown>): string {
  const cambio = (s.cambio ?? {}) as Record<string, unknown>;
  return [
    `<div class="sobre">${escapar(texto(s.recurso, 20) === 'test' ? 'Pregunta de test' : texto(s.recurso, 20) === 'ficha' ? 'Ficha de repaso' : 'Tema')} · ${escapar(texto(s.tipo, 40))}</div>`,
    `<h1>${escapar(texto(s.titulo, 200) || texto(s.tema, 20))}</h1>`,
    texto(s.apartado) ? `<p class="nota">Apartado: ${escapar(texto(s.apartado, 200))}</p>` : '',
    texto(s.cita) ? `<blockquote>«${escapar(texto(s.cita, 600))}»</blockquote>` : '',
    `<h2>Lo que propone</h2><p>${escapar(texto(s.propuesta))}</p>`,
    texto(s.motivo) ? `<h2>Lo que he comprobado</h2><p>${escapar(texto(s.motivo))}</p>` : '',
    texto(cambio.propuesto)
      ? `<h2>Cambio propuesto</h2>${texto(cambio.actual) ? `<blockquote class="antes">${escapar(texto(cambio.actual))}</blockquote>` : ''}<blockquote class="despues">${escapar(texto(cambio.propuesto))}</blockquote>${texto(cambio.fuente) ? `<p class="nota">Fuente: ${escapar(texto(cambio.fuente, 400))}</p>` : ''}`
      : '',
  ].join('\n');
}

const html = (cuerpo: string, estado = 200): Response =>
  new Response(cuerpo, { status: estado, headers: { 'Content-Type': 'text/html; charset=utf-8', 'Cache-Control': 'no-store', 'X-Robots-Tag': 'noindex', 'Referrer-Policy': 'no-referrer' } });
const error = (mensaje: string, estado = 400): Response => html(pagina('No se puede abrir', `<h1>No se puede abrir</h1><p>${escapar(mensaje)}</p>`), estado);

/** Atiende /informe y /decidir; null si la ruta no es suya. */
export async function atenderDecisiones(request: Request, kv: AlmacenDecisiones, secreto: string): Promise<Response | null> {
  const url = new URL(request.url);
  if (url.pathname === '/informe' && request.method === 'GET') {
    const c = url.searchParams.get('c') ?? '';
    if (!ID.test(c) || !iguales(url.searchParams.get('f') ?? '', await firma(secreto, 'informe', c))) return error('El enlace no es válido.', 403);
    const informe = await kv.get(`informe:${c}`);
    return informe ? html(informe) : error('Ese informe ya no está (se guardan 90 días).', 404);
  }
  if (url.pathname !== '/decidir') return null;

  let id = '', estado = '', f = '', nota = '';
  if (request.method === 'GET') {
    id = url.searchParams.get('i') ?? '';
    estado = url.searchParams.get('e') ?? '';
    f = url.searchParams.get('f') ?? '';
  } else if (request.method === 'POST') {
    const form = await request.formData();
    id = String(form.get('i') ?? '');
    estado = String(form.get('e') ?? '');
    f = String(form.get('f') ?? '');
    nota = String(form.get('nota') ?? '').trim().slice(0, 2000);
  } else return new Response('Método no admitido', { status: 405 });

  if (!ID.test(id) || !iguales(f, await firma(secreto, 'decidir', id))) return error('El enlace no es válido.', 403);
  if (!(ESTADOS_DECISION as readonly string[]).includes(estado)) return error('No sé qué decisión es esa.');
  const guardada = await kv.get(`sug:${id}`);
  if (!guardada) return error('Esa sugerencia ya no está pendiente (o han pasado más de 90 días).', 404);
  let s: Record<string, unknown> = {};
  try {
    s = JSON.parse(guardada) as Record<string, unknown>;
  } catch {
    /* se enseña sin detalle */
  }
  const previa = await kv.get(`decision:${id}`);

  if (request.method === 'POST') {
    await kv.put(`decision:${id}`, JSON.stringify({ estado, nota, fecha: new Date().toISOString() }), { expirationTtl: TTL });
    return html(
      pagina('Apuntado', `<div class="sobre">Sugerencia ${escapar(id)}</div><h1>Apuntado: ${estado === 'aceptada' ? 'aceptada' : 'descartada'}</h1>
<p>El agente lo recogerá en su próxima pasada${estado === 'aceptada' ? ', dejará el cambio en cola para aplicarlo al material' : ''} y contestará a quien la mandó.</p>
${nota ? `<p class="nota">Tu nota: ${escapar(nota)}</p>` : ''}<p class="nota">Si te has equivocado, vuelve a pulsar el otro botón del correo antes de la próxima pasada.</p>`),
    );
  }

  const otro: Estado = estado === 'aceptada' ? 'descartada' : 'aceptada';
  const campos = () => `<input type="hidden" name="i" value="${escapar(id)}"><input type="hidden" name="f" value="${escapar(f)}">`;
  return html(
    pagina(`${NOMBRE[estado as Estado]} la sugerencia`, `${resumen(s)}
${previa ? `<p class="nota"><strong>Ya habías decidido esta sugerencia.</strong> Si confirmas, se cambia.</p>` : ''}
<form method="post" action="/decidir">
  ${campos()}
  <h2>${estado === 'aceptada' ? '¿Algún cambio sobre lo propuesto? (opcional)' : '¿Por qué no? (opcional; ayuda a contestar)'}</h2>
  <textarea name="nota" maxlength="2000" aria-label="Nota"></textarea>
  <div class="acciones">
    <button type="submit" name="e" value="${estado}">${NOMBRE[estado as Estado]}</button>
    <button type="submit" class="secundario" name="e" value="${otro}">Mejor ${NOMBRE[otro].toLowerCase()}</button>
  </div>
</form>`),
  );
}
