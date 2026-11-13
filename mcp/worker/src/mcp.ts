// Atiende una petición MCP (Streamable HTTP, sin estado): un servidor y un transporte
// nuevos por petición, con las herramientas ligadas al opositor del token. Separado de
// index.ts para poder probarlo en workerd sin pasar por OAuth.

import { WebStandardStreamableHTTPServerTransport } from '@modelcontextprotocol/sdk/server/webStandardStreamableHttp.js';
import type { AuthInfo } from '@modelcontextprotocol/sdk/server/auth/types.js';
import { type Contexto, crearServidor } from './herramientas';

export async function responderMcp(request: Request, ctx: Contexto, authInfo?: AuthInfo): Promise<Response> {
  if (request.method === 'GET') {
    // Sin estado no hay flujo SSE que abrir ni reanudar.
    return new Response('Method Not Allowed', { status: 405, headers: { Allow: 'POST, DELETE' } });
  }
  const servidor = crearServidor(ctx);
  const transporte = new WebStandardStreamableHTTPServerTransport({ sessionIdGenerator: undefined, enableJsonResponse: true });
  await servidor.connect(transporte);
  try {
    return await transporte.handleRequest(request, { authInfo });
  } finally {
    void transporte.close().catch(() => undefined);
  }
}
