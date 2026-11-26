// El banco de preguntas de test de EconomIA para la app y la web (Víctor, 25/11/2026).
// Es material exclusivo: solo se sirve con la sesión de Google del usuario (token de
// Firebase en «Authorization: Bearer …»). Las figuras van por enlaces firmados que solo
// salen en la respuesta con sesión, para que Image.network no tenga que llevar cabeceras.
//
//   GET /app/banco                 → { generado, aviso, preguntas: [...] } (imagenes con URL firmada)
//   GET /app/banco/img/<fichero>?f=<firma>

import { cuentaDelIdToken } from './firebase';
import { sha256 } from './cifrado';

export interface EnvBancoApp {
  CONTENIDO: KVNamespace;
  FIREBASE_API_KEY: string;
  CLAVE_CIFRADO: string;
  URL_WORKER: string;
}

const ORIGENES = ['https://www.victorgutierrezmarcos.es', 'https://victorgutierrezmarcos.es'];
const TIPOS: Record<string, string> = { webp: 'image/webp', png: 'image/png', svg: 'image/svg+xml', jpg: 'image/jpeg', jpeg: 'image/jpeg' };

function cors(request: Request): Record<string, string> {
  const origen = request.headers.get('Origin') ?? '';
  const local = /^http:\/\/(localhost|127\.0\.0\.1)(:\d+)?$/.test(origen);
  return ORIGENES.includes(origen) || local
    ? { 'Access-Control-Allow-Origin': origen, 'Access-Control-Allow-Headers': 'Authorization', 'Access-Control-Allow-Methods': 'GET, OPTIONS', Vary: 'Origin' }
    : {};
}

export async function firmaFigura(fichero: string, secreto: string): Promise<string> {
  return (await sha256(`banco-img:${fichero}:${secreto}`)).slice(0, 32);
}

/** Atiende /app/banco…; null si la ruta no es suya. */
export async function atenderBancoApp(request: Request, env: EnvBancoApp, fetchFn: typeof fetch = fetch): Promise<Response | null> {
  const url = new URL(request.url);
  if (url.pathname !== '/app/banco' && !url.pathname.startsWith('/app/banco/img/')) return null;
  const cabeceras = cors(request);
  if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers: { ...cabeceras, 'Access-Control-Max-Age': '86400' } });
  if (request.method !== 'GET') return new Response('Método no admitido', { status: 405, headers: cabeceras });

  if (url.pathname.startsWith('/app/banco/img/')) {
    const fichero = decodeURIComponent(url.pathname.slice('/app/banco/img/'.length));
    if (!/^[\w.-]+\.(webp|png|svg|jpe?g)$/i.test(fichero)) return new Response('No encontrado', { status: 404, headers: cabeceras });
    if (url.searchParams.get('f') !== (await firmaFigura(fichero, env.CLAVE_CIFRADO))) return new Response('Enlace no válido', { status: 403, headers: cabeceras });
    const datos = await env.CONTENIDO.get(`banco/img/${fichero}`, 'arrayBuffer');
    if (!datos) return new Response('No encontrado', { status: 404, headers: cabeceras });
    const ext = fichero.split('.').pop()!.toLowerCase();
    return new Response(datos, { headers: { ...cabeceras, 'Content-Type': TIPOS[ext] ?? 'application/octet-stream', 'Cache-Control': 'public, max-age=86400' } });
  }

  const token = /^Bearer\s+(.+)$/i.exec(request.headers.get('Authorization') ?? '')?.[1];
  const usuario = token ? await cuentaDelIdToken(env.FIREBASE_API_KEY, token, fetchFn) : null;
  if (!usuario) return new Response(JSON.stringify({ error: 'Inicia sesión con Google para ver el banco de preguntas de EconomIA.' }), { status: 401, headers: { ...cabeceras, 'Content-Type': 'application/json; charset=utf-8' } });
  const texto = await env.CONTENIDO.get('banco/preguntas.json', 'text');
  if (!texto) return new Response(JSON.stringify({ error: 'El banco no está publicado.' }), { status: 503, headers: { ...cabeceras, 'Content-Type': 'application/json; charset=utf-8' } });
  const banco = JSON.parse(texto) as { preguntas?: Array<{ imagenes?: Array<{ src?: string }> }> };
  const base = env.URL_WORKER.replace(/\/$/, '');
  for (const p of banco.preguntas ?? []) {
    for (const img of p.imagenes ?? []) {
      const m = /^banco:(.+)$/.exec(img.src ?? '');
      if (m) img.src = `${base}/app/banco/img/${encodeURIComponent(m[1])}?f=${await firmaFigura(m[1], env.CLAVE_CIFRADO)}`;
    }
  }
  return new Response(JSON.stringify(banco), { headers: { ...cabeceras, 'Content-Type': 'application/json; charset=utf-8', 'Cache-Control': 'private, max-age=3600' } });
}
