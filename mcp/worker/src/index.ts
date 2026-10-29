// Conector remoto MCP «Prepara con Claude»: Cloudflare Worker que es a la vez
// servidor de autorización OAuth 2.1 (PKCE, registro dinámico de clientes, metadatos
// RFC 8414 y RFC 9728; lo hace @cloudflare/workers-oauth-provider sobre OAUTH_KV) y
// servidor MCP (Streamable HTTP sin estado, con el SDK oficial) que lee y escribe los
// datos del opositor en Firestore con su propio ID token de Firebase.
//
// Flujo de conexión (ver ../README.md):
//   Claude → GET /authorize (consentimiento) → POST /authorize (acepta) → login.html de la
//   web (Google) → POST /callback/sesion (tokens de Firebase) → GET /callback → de vuelta a Claude.

import { OAuthProvider, AuthorizationError, CimdFetchError, OAuthError, type OAuthHelpers, type OAuthProviderOptions, type OAuthResourceContext } from '@cloudflare/workers-oauth-provider';
import { cifrar, descifrar, sha256 } from './cifrado';
import { Contenido } from './contenido';
import { temasDePreguntas } from './datos';
import { datosDelIdToken, renovarIdToken } from './firebase';
import { Firestore } from './firestore';
import { type Banco, type Contexto, ErrorSesion, type Oposicion } from './herramientas';
import { responderMcp } from './mcp';
import { paginaConsentimiento, paginaError, paginaPortada } from './paginas';

export interface Env {
  OAUTH_KV: KVNamespace;
  SESIONES: KVNamespace;
  CONTENIDO: KVNamespace;
  OAUTH_PROVIDER: OAuthHelpers;
  FIREBASE_API_KEY: string;
  FIREBASE_PROJECT: string;
  URL_WORKER: string;
  URL_LOGIN: string;
  URL_PREGUNTAS: string;
  URL_REVISADOS: string;
  ORIGENES_LOGIN: string;
  CLAVE_CIFRADO: string;
}

/** Lo que guarda la biblioteca OAuth (cifrado) con cada concesión y entrega en ctx.props. */
interface Props {
  uid: string;
  email: string;
  /** Refresh token de Firebase cifrado con CLAVE_CIFRADO. */
  refresh: string;
}

const ALCANCE = 'opositor';
const TTL_PENDIENTE = 600; // s: lo que dura la sesión de login entre la web y el Worker
const TTL_ID_TOKEN = 3000; // s: caché del ID token de Firebase (dura 3600)

const html = (cuerpo: string, estado = 200, cabeceras?: Headers): Response => {
  const h = new Headers(cabeceras);
  h.set('Content-Type', 'text/html; charset=utf-8');
  h.set('Cache-Control', 'no-store');
  return new Response(cuerpo, { status: estado, headers: h });
};

const urlMcp = (env: Env) => `${env.URL_WORKER.replace(/\/$/, '')}/mcp`;

// ------------------------------------------------------------ Sesión del opositor

/** Un ID token vigente del opositor: de la caché (cifrado en SESIONES) o renovado con su refresh token. */
async function idTokenDe(env: Env, props: Props): Promise<string> {
  const clave = `id:${await sha256(props.uid)}`;
  const guardado = await env.SESIONES.get(clave, 'text');
  if (guardado) {
    try {
      return await descifrar(guardado, env.CLAVE_CIFRADO);
    } catch {
      /* clave cambiada: se renueva */
    }
  }
  const refresh = await descifrar(props.refresh, env.CLAVE_CIFRADO);
  const r = await renovarIdToken(env.FIREBASE_API_KEY, refresh);
  if (!r.ok) throw new ErrorSesion(r.motivo === 'invalido' ? `Firebase ya no acepta el acceso (${r.detalle})` : `Firebase no responde (${r.detalle})`);
  if (r.uid !== props.uid) throw new ErrorSesion('el token no corresponde a esta cuenta');
  await env.SESIONES.put(clave, await cifrar(r.idToken, env.CLAVE_CIFRADO), { expirationTtl: TTL_ID_TOKEN });
  return r.idToken;
}

let bancoEnMemoria: { url: string; banco: Banco } | null = null;

/** El banco de preguntas de la web, en la caché de Cloudflare un día y en memoria mientras viva el aislado. */
async function bancoDePreguntas(env: Env): Promise<Banco> {
  if (bancoEnMemoria?.url === env.URL_PREGUNTAS) return bancoEnMemoria.banco;
  const r = await fetch(env.URL_PREGUNTAS, { cf: { cacheTtl: 86_400, cacheEverything: true } });
  if (!r.ok) return { temas: new Map(), respuestas: new Map() };
  const banco = temasDePreguntas((await r.json()) as Parameters<typeof temasDePreguntas>[0]);
  bancoEnMemoria = { url: env.URL_PREGUNTAS, banco };
  return banco;
}

function contextoDe(env: Env, props: Props): Contexto {
  return {
    uid: props.uid,
    email: props.email,
    async almacen(oposicion: Oposicion) {
      return new Firestore(env.FIREBASE_PROJECT, await idTokenDe(env, props), Firestore.raizDe(props.uid, oposicion));
    },
    banco: () => bancoDePreguntas(env),
    contenido: new Contenido(env.CONTENIDO),
    async desconectar() {
      await env.SESIONES.delete(`id:${await sha256(props.uid)}`);
      let cursor: string | undefined;
      do {
        const r = await env.OAUTH_PROVIDER.listUserGrants(props.uid, { cursor });
        for (const g of r.items) await env.OAUTH_PROVIDER.revokeGrant(g.id, props.uid);
        cursor = r.cursor;
      } while (cursor);
    },
  };
}

// --------------------------------------------------------------- Servidor MCP

const mcpHandler = {
  async fetch(request: Request, env: Env, contexto: ExecutionContext): Promise<Response> {
    const ctx = contexto as OAuthResourceContext<Props>;
    const props = ctx.props;
    if (!props?.uid || !props.refresh) return new Response('Unauthorized', { status: 401 });
    return responderMcp(request, contextoDe(env, props), {
      token: ctx.auth.token,
      clientId: ctx.auth.clientId ?? '',
      scopes: ctx.auth.scope ?? [],
      expiresAt: ctx.auth.expiresAt,
      extra: { uid: props.uid },
    });
  },
};

// ---------------------------------------------------- Autorización y login

function cors(env: Env, request: Request): Headers {
  const origen = request.headers.get('Origin') ?? '';
  const permitidos = env.ORIGENES_LOGIN.split(',').map((o) => o.trim());
  const h = new Headers();
  if (permitidos.includes(origen) || /^http:\/\/(localhost|127\.0\.0\.1)(:\d+)?$/.test(origen)) {
    h.set('Access-Control-Allow-Origin', origen);
    h.set('Access-Control-Allow-Methods', 'POST, OPTIONS');
    h.set('Access-Control-Allow-Headers', 'Content-Type');
    h.set('Vary', 'Origin');
  }
  return h;
}

/** Rutas públicas del Worker: portada, consentimiento, login y callback. */
const defaultHandler = {
  async fetch(request: Request, env: Env): Promise<Response> {
    const url = new URL(request.url);
    const oauth = env.OAUTH_PROVIDER;
    try {
      if (url.pathname === '/' || url.pathname === '') return html(paginaPortada(urlMcp(env)));

      if (url.pathname === '/authorize' && request.method === 'GET') {
        const peticion = await oauth.parseAuthRequest(request);
        const datos = await oauth.describeConsent(peticion);
        const consentimiento = await oauth.beginConsent(peticion);
        return html(paginaConsentimiento(datos, consentimiento.handle), 200, consentimiento.headers);
      }

      if (url.pathname === '/authorize' && request.method === 'POST') {
        const form = await request.formData();
        const handle = String(form.get('handle') ?? '');
        if (form.get('decision') !== 'aceptar') {
          const denegado = await oauth.denyConsent(request, handle, { description: 'El opositor no ha autorizado el acceso' });
          return new Response(null, { status: 302, headers: denegado.headers });
        }
        const aprobado = await oauth.approveConsent(request, handle, { scope: [ALCANCE, ...form.getAll('scope').map(String).filter((s) => s === 'offline_access')] });
        const { state, headers } = await oauth.beginUpstream(aprobado.request, { headers: aprobado.headers });
        const login = new URL(env.URL_LOGIN);
        login.searchParams.set('state', state);
        if (url.hostname === 'localhost' || url.hostname === '127.0.0.1') login.searchParams.set('worker', url.origin);
        headers.set('Location', login.toString());
        return new Response(null, { status: 302, headers });
      }

      if (url.pathname === '/callback/sesion') {
        const cabeceras = cors(env, request);
        if (request.method === 'OPTIONS') return new Response(null, { status: 204, headers: cabeceras });
        if (request.method !== 'POST') return new Response('Method Not Allowed', { status: 405 });
        if (!cabeceras.has('Access-Control-Allow-Origin')) return new Response('Origen no permitido', { status: 403 });
        const cuerpo = (await request.json().catch(() => null)) as { state?: string; idToken?: string; refreshToken?: string } | null;
        if (!cuerpo?.state || !cuerpo.idToken || !cuerpo.refreshToken) return Response.json({ error: 'faltan state, idToken o refreshToken' }, { status: 400, headers: cabeceras });
        const usuario = await datosDelIdToken(env.FIREBASE_API_KEY, cuerpo.idToken);
        if (!usuario) return Response.json({ error: 'Firebase no reconoce el ID token' }, { status: 401, headers: cabeceras });
        const pendiente: Props = { uid: usuario.uid, email: usuario.email, refresh: await cifrar(cuerpo.refreshToken, env.CLAVE_CIFRADO) };
        await env.SESIONES.put(`pendiente:${await sha256(cuerpo.state)}`, JSON.stringify(pendiente), { expirationTtl: TTL_PENDIENTE });
        return Response.json({ ok: true, email: usuario.email }, { headers: cabeceras });
      }

      if (url.pathname === '/callback' && request.method === 'GET') {
        const { request: original, headers } = await oauth.finishUpstream(request);
        const state = url.searchParams.get('state') ?? '';
        const clave = `pendiente:${await sha256(state)}`;
        const guardado = await env.SESIONES.get(clave, 'text');
        if (!guardado) return html(paginaError('Falta el inicio de sesión', 'No ha llegado la sesión de Google de la página de login, o ha caducado (dura diez minutos).'), 400, headers);
        await env.SESIONES.delete(clave);
        const props = JSON.parse(guardado) as Props;
        const { redirectTo } = await oauth.completeAuthorization({
          request: original,
          userId: props.uid,
          metadata: { conectado: new Date().toISOString() },
          scope: original.scope,
          props,
        });
        headers.set('Location', redirectTo);
        return new Response(null, { status: 302, headers });
      }

      return new Response('No encontrado', { status: 404 });
    } catch (e) {
      if (e instanceof AuthorizationError && e.redirectTo) return Response.redirect(e.redirectTo, 302);
      if (e instanceof AuthorizationError) return html(paginaError('No se ha podido autorizar', e.description), 400);
      if (e instanceof CimdFetchError) return html(paginaError('No se ha podido comprobar la aplicación', 'No se ha podido leer el documento de identidad de la aplicación que pide acceso.'), 400);
      throw e;
    }
  },
};

/**
 * En cada renovación del token de Claude comprobamos que Firebase sigue aceptando el
 * refresh token del opositor: si lo ha revocado (contraseña cambiada, cuenta borrada,
 * «Desconectar» desde la app), la concesión OAuth se revoca también (invalid_grant) y
 * Claude pide volver a conectar.
 */
const renovarEnFirebase: NonNullable<OAuthProviderOptions<Env>['tokenExchangeCallback']> = async ({ grantType, props, env }) => {
  if (grantType !== 'refresh_token') return;
  const p = props as Props;
  const refresh = await descifrar(p.refresh, env.CLAVE_CIFRADO);
  const r = await renovarIdToken(env.FIREBASE_API_KEY, refresh);
  if (!r.ok) {
    if (r.motivo === 'invalido') throw new OAuthError('invalid_grant', { description: 'La app ha revocado el acceso de Claude; vuelve a conectar el conector.' });
    throw new OAuthError('temporarily_unavailable', { description: 'Firebase no responde ahora mismo', statusCode: 503 });
  }
  await env.SESIONES.put(`id:${await sha256(p.uid)}`, await cifrar(r.idToken, env.CLAVE_CIFRADO), { expirationTtl: TTL_ID_TOKEN });
  if (r.refreshToken !== refresh) return { newProps: { ...p, refresh: await cifrar(r.refreshToken, env.CLAVE_CIFRADO) } };
};

let proveedor: { url: string; instancia: OAuthProvider<Env> } | null = null;

/** El proveedor OAuth se construye con la URL del Worker (URL_WORKER), que solo se conoce con `env`. */
function proveedorDe(env: Env): OAuthProvider<Env> {
  if (proveedor?.url === env.URL_WORKER) return proveedor.instancia;
  const instancia = new OAuthProvider<Env>({
    apiHandlers: { '/mcp': mcpHandler },
    defaultHandler,
    authorizeEndpoint: '/authorize',
    tokenEndpoint: '/oauth/token',
    clientRegistrationEndpoint: '/oauth/register',
    scopesSupported: [ALCANCE, 'offline_access'],
    requiredScopes: [ALCANCE],
    // Tokens de acceso de 12 horas: menos renovaciones (cada una escribe en KV, y el plan
    // gratuito da 1.000 escrituras al día); los de refresco, 30 días (por defecto).
    accessTokenTTL: 12 * 3600,
    resourceMetadata: { resource: urlMcp(env), resource_name: 'Prepara con Claude · Oposición TCEE · DCE' },
    tokenExchangeCallback: renovarEnFirebase,
  });
  proveedor = { url: env.URL_WORKER, instancia };
  return instancia;
}

export default {
  fetch: (request: Request, env: Env, ctx: ExecutionContext) => proveedorDe(env).fetch(request, env, ctx),
};
