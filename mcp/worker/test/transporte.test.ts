// El transporte Streamable HTTP del SDK dentro de workerd: initialize y tools/list por HTTP, sin OAuth.
import { describe, expect, it } from 'vitest';
import { Contenido } from '../src/contenido';
import type { Contexto } from '../src/herramientas';
import { responderMcp } from '../src/mcp';

const ctx: Contexto = {
  uid: 'u1',
  email: 'u1@example.org',
  almacen: async () => {
    throw new Error('no se usa');
  },
  banco: async () => ({ temas: new Map(), respuestas: new Map() }),
  contenido: new Contenido({ get: async () => null }),
  skill: async () => null,
  fuentes: async () => ({ aviso: '', bloques: [], tcee: {}, dce: {} }),
  apuntes: async () => ({ formato: 'docx', esquema: [], texto: '' }),
  desconectar: async () => undefined,
};

function peticion(cuerpo: unknown, cabeceras: Record<string, string> = {}): Request {
  return new Request('http://localhost/mcp', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', Accept: 'application/json, text/event-stream', ...cabeceras },
    body: JSON.stringify(cuerpo),
  });
}

describe('Streamable HTTP sin estado', () => {
  it('initialize contesta en JSON con la versión del protocolo y las capacidades', async () => {
    const r = await responderMcp(peticion({ jsonrpc: '2.0', id: 1, method: 'initialize', params: { protocolVersion: '2025-06-18', capabilities: {}, clientInfo: { name: 'prueba', version: '0' } } }), ctx);
    expect(r.status).toBe(200);
    expect(r.headers.get('content-type')).toContain('application/json');
    const j = (await r.json()) as { result: { protocolVersion: string; serverInfo: { name: string }; capabilities: { tools?: unknown } } };
    expect(j.result.protocolVersion).toBe('2025-06-18');
    expect(j.result.serverInfo.name).toContain('Prepara con Claude');
    expect(j.result.capabilities.tools).toBeDefined();
  });

  it('tools/list devuelve las dieciséis herramientas en una petición independiente (sin sesión)', async () => {
    const r = await responderMcp(peticion({ jsonrpc: '2.0', id: 2, method: 'tools/list', params: {} }, { 'MCP-Protocol-Version': '2025-06-18' }), ctx);
    expect(r.status).toBe(200);
    const j = (await r.json()) as { result: { tools: Array<{ name: string; inputSchema: unknown }> } };
    expect(j.result.tools.map((t) => t.name)).toContain('leer_progreso');
    expect(j.result.tools).toHaveLength(16);
  });

  it('GET no se admite y una petición mal formada da error JSON-RPC', async () => {
    expect((await responderMcp(new Request('http://localhost/mcp'), ctx)).status).toBe(405);
    const r = await responderMcp(new Request('http://localhost/mcp', { method: 'POST', headers: { 'Content-Type': 'application/json', Accept: 'application/json, text/event-stream' }, body: '{' }), ctx);
    expect(r.status).toBe(400);
  });
});
