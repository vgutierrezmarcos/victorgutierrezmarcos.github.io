// Los temas revisados (material exclusivo) servidos solo con la sesión de Google (Víctor, 26/11/2026).
// Antes estaban en la rama pública temario-publicado (raw/githack) y cualquiera con la dirección los
// bajaba; ahora viven en el almacén privado R2 (TEMARIO) y solo salen por aquí:
//
//   GET  /temario/manifiesto           el índice (títulos, tamaños, huellas y esquemas; sin contenido): público
//   GET  /temario/acceso               con «Authorization: Bearer <ID token de Firebase>» →
//                                      { base, expira }: base = URL_WORKER/t/<caducidad>.<firma>/
//   GET  /t/<caducidad>.<firma>/<ruta> el fichero (PDF, Word, HTML con sus gráficos, ZIP), con Range.
//                                      Va en la ruta y no en una cabecera para que el HTML resuelva
//                                      sus gráficos relativos y el PDF se abra en el navegador.
//
// Subida (solo scripts/temario-privado.py, con el secreto ADMIN_TEMARIO):
//   GET    /temario/admin/lista                         claves con su huella (customMetadata.sha)
//   GET    /temario/admin/acceso                        una base firmada de 10 minutos (para comprobar)
//   PUT    /temario/admin/f/<clave>?sha=…               un fichero (≤ 100 MB por petición)
//   POST   /temario/admin/f/<clave>?subida=crear        empieza una subida por partes (el ZIP)
//   PUT    /temario/admin/f/<clave>?subida=<id>&parte=n una parte
//   POST   /temario/admin/f/<clave>?subida=<id>&sha=…   la cierra (cuerpo: [{partNumber, etag}])
//   DELETE /temario/admin/f/<clave>                     la borra

import { cuentaDelIdToken } from './firebase';

export interface EnvTemario {
  TEMARIO?: R2Bucket;
  FIREBASE_API_KEY: string;
  CLAVE_CIFRADO: string;
  URL_WORKER: string;
  ADMIN_TEMARIO?: string;
}

/** Horas que vale un acceso: la app y la web piden otro al caducar. */
export const HORAS_ACCESO = 12;

const ORIGENES = ['https://www.victorgutierrezmarcos.es', 'https://victorgutierrezmarcos.es'];
const TIPOS: Record<string, string> = {
  pdf: 'application/pdf',
  docx: 'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
  html: 'text/html; charset=utf-8',
  svg: 'image/svg+xml',
  png: 'image/png',
  webp: 'image/webp',
  jpg: 'image/jpeg',
  css: 'text/css; charset=utf-8',
  json: 'application/json; charset=utf-8',
  zip: 'application/zip',
};
/** Rutas que se pueden pedir: sin «..», sin barras dobles, con una extensión conocida. */
const RUTA_VALIDA = /^(?!.*\.\.)(?!.*\/\/)[\w\-./ ()áéíóúñÁÉÍÓÚÑ]+\.(pdf|docx|html|svg|png|webp|jpg|css|json|zip)$/;

function cors(request: Request): Record<string, string> {
  const origen = request.headers.get('Origin') ?? '';
  const local = /^http:\/\/(localhost|127\.0\.0\.1)(:\d+)?$/.test(origen);
  return ORIGENES.includes(origen) || local
    ? { 'Access-Control-Allow-Origin': origen, 'Access-Control-Allow-Headers': 'Authorization, Range', 'Access-Control-Allow-Methods': 'GET, HEAD, OPTIONS', 'Access-Control-Expose-Headers': 'Content-Length, Content-Range', Vary: 'Origin' }
    : {};
}

function json(cuerpo: unknown, estado: number, cabeceras: Record<string, string>): Response {
  return new Response(JSON.stringify(cuerpo), { status: estado, headers: { ...cabeceras, 'Content-Type': 'application/json; charset=utf-8', 'Cache-Control': 'no-store' } });
}

async function hmac(secreto: string, texto: string): Promise<string> {
  const clave = await crypto.subtle.importKey('raw', new TextEncoder().encode(`temario:${secreto}`), { name: 'HMAC', hash: 'SHA-256' }, false, ['sign']);
  const firma = new Uint8Array(await crypto.subtle.sign('HMAC', clave, new TextEncoder().encode(texto)));
  return Array.from(firma.slice(0, 16), (b) => b.toString(16).padStart(2, '0')).join('');
}

/** Prefijo firmado que da acceso hasta `caducidad` (segundos Unix). */
export async function prefijoAcceso(caducidad: number, secreto: string): Promise<string> {
  return `${caducidad}.${await hmac(secreto, `acceso:${caducidad}`)}`;
}

function iguales(a: string, b: string): boolean {
  if (a.length !== b.length) return false;
  let d = 0;
  for (let i = 0; i < a.length; i++) d |= a.charCodeAt(i) ^ b.charCodeAt(i);
  return d === 0;
}

/** Atiende /temario/… y /t/…; null si la ruta no es suya. */
export async function atenderTemario(request: Request, env: EnvTemario, fetchFn: typeof fetch = fetch, ahora = () => Math.floor(Date.now() / 1000)): Promise<Response | null> {
  const url = new URL(request.url);
  const esAcceso = url.pathname.startsWith('/t/');
  if (!esAcceso && !url.pathname.startsWith('/temario/')) return null;
  const cabeceras = cors(request);
  if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers: { ...cabeceras, 'Access-Control-Max-Age': '86400' } });
  if (!env.TEMARIO) return json({ error: 'El almacén del temario no está configurado.' }, 503, cabeceras);

  if (url.pathname.startsWith('/temario/admin/')) return atenderAdmin(request, url, env as EnvTemario & { TEMARIO: R2Bucket });

  if (request.method !== 'GET' && request.method !== 'HEAD') return json({ error: 'Método no admitido' }, 405, cabeceras);

  if (url.pathname === '/temario/manifiesto') {
    const m = await env.TEMARIO.get('manifiesto.json');
    if (!m) return json({ error: 'El temario no está publicado.' }, 503, cabeceras);
    return new Response(m.body, { headers: { ...cabeceras, 'Content-Type': TIPOS.json, 'Cache-Control': 'public, max-age=300' } });
  }

  if (url.pathname === '/temario/acceso') {
    const token = /^Bearer\s+(.+)$/i.exec(request.headers.get('Authorization') ?? '')?.[1];
    const usuario = token ? await cuentaDelIdToken(env.FIREBASE_API_KEY, token, fetchFn) : null;
    if (!usuario) return json({ error: 'Inicia sesión con Google para leer los temas revisados.' }, 401, cabeceras);
    const caducidad = ahora() + HORAS_ACCESO * 3600;
    const base = `${env.URL_WORKER.replace(/\/$/, '')}/t/${await prefijoAcceso(caducidad, env.CLAVE_CIFRADO)}/`;
    return json({ base, expira: caducidad }, 200, cabeceras);
  }

  if (esAcceso) {
    const m = /^\/t\/(\d+)\.([0-9a-f]{32})\/(.+)$/.exec(url.pathname);
    if (!m) return json({ error: 'No encontrado' }, 404, cabeceras);
    const caducidad = Number(m[1]);
    if (caducidad < ahora()) return json({ error: 'El enlace ha caducado: vuelve a abrir el tema.' }, 403, cabeceras);
    if (caducidad > ahora() + HORAS_ACCESO * 3600 + 60 || !iguales(m[2], (await prefijoAcceso(caducidad, env.CLAVE_CIFRADO)).split('.')[1])) {
      return json({ error: 'Enlace no válido' }, 403, cabeceras);
    }
    let ruta: string;
    try {
      ruta = decodeURIComponent(m[3]);
    } catch {
      return json({ error: 'No encontrado' }, 404, cabeceras);
    }
    if (!RUTA_VALIDA.test(ruta) || ruta === 'manifiesto.json') return json({ error: 'No encontrado' }, 404, cabeceras);
    return servir(request, env.TEMARIO, ruta, cabeceras);
  }
  return json({ error: 'No encontrado' }, 404, cabeceras);
}

async function servir(request: Request, almacen: R2Bucket, ruta: string, cabeceras: Record<string, string>): Promise<Response> {
  const rango = request.headers.get('Range');
  const obj = await almacen.get(ruta, rango ? { range: request.headers } : {});
  if (!obj) return json({ error: 'No encontrado' }, 404, cabeceras);
  const ext = ruta.split('.').pop()!.toLowerCase();
  const nombre = ruta.split('/').pop()!;
  const h: Record<string, string> = {
    ...cabeceras,
    'Content-Type': TIPOS[ext] ?? 'application/octet-stream',
    'Cache-Control': 'private, max-age=3600',
    'Accept-Ranges': 'bytes',
    ETag: obj.httpEtag,
    'X-Robots-Tag': 'noindex, nofollow',
  };
  if (ext === 'docx' || ext === 'zip') h['Content-Disposition'] = `attachment; filename*=UTF-8''${encodeURIComponent(nombre)}`;
  let estado = 200;
  const r = (obj as R2ObjectBody).range as { offset?: number; length?: number } | undefined;
  if (rango && r && r.offset !== undefined) {
    const largo = r.length ?? obj.size - r.offset;
    h['Content-Range'] = `bytes ${r.offset}-${r.offset + largo - 1}/${obj.size}`;
    h['Content-Length'] = String(largo);
    estado = 206;
  } else {
    h['Content-Length'] = String(obj.size);
  }
  return new Response(request.method === 'HEAD' ? null : (obj as R2ObjectBody).body, { status: estado, headers: h });
}

async function atenderAdmin(request: Request, url: URL, env: EnvTemario & { TEMARIO: R2Bucket }): Promise<Response> {
  const token = /^Bearer\s+(.+)$/i.exec(request.headers.get('Authorization') ?? '')?.[1] ?? '';
  if (!env.ADMIN_TEMARIO || !iguales(token, env.ADMIN_TEMARIO)) return json({ error: 'No autorizado' }, 401, {});

  if (url.pathname === '/temario/admin/lista' && request.method === 'GET') {
    const claves: Array<{ clave: string; sha: string; tamano: number }> = [];
    let cursor: string | undefined;
    do {
      const l = await env.TEMARIO.list({ cursor, limit: 1000, include: ['customMetadata'] });
      for (const o of l.objects) claves.push({ clave: o.key, sha: o.customMetadata?.sha ?? '', tamano: o.size });
      cursor = l.truncated ? l.cursor : undefined;
    } while (cursor);
    return json({ claves }, 200, {});
  }

  // Una base firmada de prueba (para comprobar el almacén sin cuenta de Google): 10 minutos.
  if (url.pathname === '/temario/admin/acceso' && request.method === 'GET') {
    const caducidad = Math.floor(Date.now() / 1000) + 600;
    return json({ base: `${env.URL_WORKER.replace(/\/$/, '')}/t/${await prefijoAcceso(caducidad, env.CLAVE_CIFRADO)}/`, expira: caducidad }, 200, {});
  }

  if (!url.pathname.startsWith('/temario/admin/f/')) return json({ error: 'No encontrado' }, 404, {});
  const clave = decodeURIComponent(url.pathname.slice('/temario/admin/f/'.length));
  if (!RUTA_VALIDA.test(clave)) return json({ error: 'Clave no válida' }, 400, {});
  const sha = url.searchParams.get('sha') ?? '';
  const subida = url.searchParams.get('subida');

  if (request.method === 'DELETE') {
    await env.TEMARIO.delete(clave);
    return json({ ok: true }, 200, {});
  }
  if (request.method === 'PUT' && !subida) {
    await env.TEMARIO.put(clave, request.body, { customMetadata: { sha } });
    return json({ ok: true }, 200, {});
  }
  if (request.method === 'POST' && subida === 'crear') {
    const s = await env.TEMARIO.createMultipartUpload(clave, { customMetadata: { sha } });
    return json({ subida: s.uploadId }, 200, {});
  }
  if (request.method === 'PUT' && subida) {
    const parte = Number(url.searchParams.get('parte'));
    if (!parte || !request.body) return json({ error: 'Falta la parte' }, 400, {});
    const s = env.TEMARIO.resumeMultipartUpload(clave, subida);
    const p = await s.uploadPart(parte, request.body);
    return json({ partNumber: p.partNumber, etag: p.etag }, 200, {});
  }
  if (request.method === 'POST' && subida) {
    const partes = (await request.json()) as R2UploadedPart[];
    const s = env.TEMARIO.resumeMultipartUpload(clave, subida);
    await s.complete(partes);
    return json({ ok: true }, 200, {});
  }
  return json({ error: 'Método no admitido' }, 405, {});
}
