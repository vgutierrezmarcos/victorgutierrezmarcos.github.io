#!/usr/bin/env node
// Prueba de humo del conector desplegado, para pasar tras cada `wrangler deploy`:
//   node mcp/prueba-humo.mjs                      # lo público: portada, metadatos OAuth, 401 de /mcp, dirección antigua
//   MCP_TOKEN=… node mcp/prueba-humo.mjs          # además, con un token de acceso: tools/list y una lectura por herramienta
// El token es el «access token» de una conexión propia (caduca a las 12 h); sin él no se toca ningún dato.
const BASE = process.env.MCP_URL ?? 'https://mcp.victorgutierrezmarcos.es';
const ANTIGUA = 'https://prepara-con-claude.victorgutierrezmarcos.workers.dev';
let fallos = 0;
const ok = (bien, texto) => {
  console.log(`${bien ? '  ok   ' : '  FALLA'} ${texto}`);
  if (!bien) fallos++;
};

const portada = await fetch(`${BASE}/`);
ok(portada.status === 200 && (await portada.text()).includes('Conector'), 'portada');
const meta = await fetch(`${BASE}/.well-known/oauth-authorization-server`);
const m = meta.ok ? await meta.json() : {};
ok(meta.ok && m.issuer === BASE && m.registration_endpoint, 'metadatos OAuth (issuer y registro dinámico)');
const recurso = await fetch(`${BASE}/.well-known/oauth-protected-resource/mcp`);
ok(recurso.ok && (await recurso.json()).resource === `${BASE}/mcp`, 'metadatos del recurso protegido');
const sinToken = await fetch(`${BASE}/mcp`, { method: 'POST', headers: { 'Content-Type': 'application/json' }, body: '{}' });
ok(sinToken.status === 401 && (sinToken.headers.get('www-authenticate') ?? '').includes('resource_metadata'), '/mcp sin token da 401 con WWW-Authenticate');
const vieja = await fetch(`${ANTIGUA}/authorize?x=1`);
ok(vieja.ok && (await vieja.text()).includes('ha cambiado de dirección'), 'la dirección antigua explica el cambio');

const token = process.env.MCP_TOKEN;
if (token) {
  let n = 0;
  const rpc = async (method, params) => {
    const r = await fetch(`${BASE}/mcp`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json', Accept: 'application/json, text/event-stream', Authorization: `Bearer ${token}`, 'MCP-Protocol-Version': '2025-06-18' },
      body: JSON.stringify({ jsonrpc: '2.0', id: ++n, method, params }),
    });
    return r.ok ? (await r.json()).result : { error: r.status };
  };
  const lista = await rpc('tools/list', {});
  ok(Array.isArray(lista?.tools) && lista.tools.length >= 33, `tools/list (${lista?.tools?.length ?? 0} herramientas)`);
  // Vistas interactivas (MCP Apps): las herramientas que las declaran y sus páginas.
  const conVista = (lista?.tools ?? []).filter((t) => t._meta?.ui?.resourceUri);
  ok(conVista.length === 5, `herramientas con vista (${conVista.map((t) => t.name).join(', ')})`);
  const recursos = await rpc('resources/list', {});
  ok((recursos?.resources ?? []).filter((r) => r.uri.startsWith('ui://economia/') && r.mimeType === 'text/html;profile=mcp-app').length === 5, 'resources/list (cinco vistas)');
  for (const t of conVista) {
    const r = await rpc('resources/read', { uri: t._meta.ui.resourceUri });
    const c = r?.contents?.[0];
    ok(c?.mimeType === 'text/html;profile=mcp-app' && c.text?.includes("pedir('ui/initialize'") && c.text.length > 4000, `${t._meta.ui.resourceUri} (${c?.text?.length ?? 0} caracteres)`);
  }
  // Solo lecturas: ninguna de estas escribe nada.
  const lecturas = [
    ['empezar', {}], ['leer_metodo', {}], ['leer_skill', { ruta: 'VERSION.txt' }], ['leer_progreso', {}], ['leer_resultados_test', { limite: 1 }],
    ['leer_cantes', { n: 1 }], ['leer_cronograma', {}], ['leer_informes_cante', { n: 1 }], ['listar_temas_revisados', {}], ['leer_tema', { tema: '3.A.8', apartado: 'Introducción' }],
    ['leer_ficha', { tema: '3.A.8', limite: 2000 }], ['leer_guia_dictamen', { limite: 2000 }], ['leer_canon', { limite: 2000 }], ['buscar_temario', { consulta: 'curva de Phillips' }],
    ['fuentes_tema', { tema: '3.A.28' }], ['preguntas_test', { temas: ['3.A.8'], n: 2 }], ['test_interactivo', { temas: ['3.A.8'], n: 2 }], ['leer_proceso', {}],
  ];
  for (const [name, args] of lecturas) {
    const r = await rpc('tools/call', { name, arguments: args });
    ok(r && !r.error && r.isError !== true, `${name}${r?.isError ? `: ${r.content?.[0]?.text?.slice(0, 120)}` : ''}`);
  }
} else {
  console.log('  (sin MCP_TOKEN: no se prueban las herramientas con datos)');
}
console.log(fallos ? `\n${fallos} comprobaciones han fallado.` : '\nTodo bien.');
process.exit(fallos ? 1 : 0);
