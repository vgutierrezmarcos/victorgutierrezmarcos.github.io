import { describe, expect, it } from 'vitest';
import { atenderBancoApp, firmaFigura } from '../src/bancoApp';

const kv = (datos: Record<string, string>) =>
  ({ get: async (k: string, tipo?: string) => (k in datos ? (tipo === 'arrayBuffer' ? new TextEncoder().encode(datos[k]).buffer : datos[k]) : null) }) as unknown as KVNamespace;
const env = (datos: Record<string, string>) => ({ CONTENIDO: kv(datos), FIREBASE_API_KEY: 'k', CLAVE_CIFRADO: 'secreto', URL_WORKER: 'https://mcp.example' });
const banco = JSON.stringify({ generado: '2026-11-25', preguntas: [{ id: 1, imagenes: [{ src: 'banco:310811.webp', alt: 'x' }] }] });
const firebase = (ok: boolean) => (async () => new Response(JSON.stringify(ok ? { users: [{ localId: 'u1', email: 'a@b.c', providerUserInfo: [{ providerId: 'google.com' }] }] } : { error: {} }), { status: ok ? 200 : 400 })) as unknown as typeof fetch;

describe('banco de EconomIA para la app', () => {
  it('no es suya otra ruta', async () => {
    expect(await atenderBancoApp(new Request('https://mcp.example/otra'), env({}))).toBeNull();
  });
  it('sin sesión, 401', async () => {
    const r = await atenderBancoApp(new Request('https://mcp.example/app/banco'), env({ 'banco/preguntas.json': banco }), firebase(false));
    expect(r!.status).toBe(401);
  });
  it('con sesión, el banco con las figuras firmadas, y la figura solo con su firma', async () => {
    const r = await atenderBancoApp(new Request('https://mcp.example/app/banco', { headers: { Authorization: 'Bearer t', Origin: 'https://www.victorgutierrezmarcos.es' } }), env({ 'banco/preguntas.json': banco }), firebase(true));
    expect(r!.status).toBe(200);
    expect(r!.headers.get('Access-Control-Allow-Origin')).toBe('https://www.victorgutierrezmarcos.es');
    const src = ((await r!.json()) as { preguntas: Array<{ imagenes: Array<{ src: string }> }> }).preguntas[0].imagenes[0].src;
    expect(src).toBe(`https://mcp.example/app/banco/img/310811.webp?f=${await firmaFigura('310811.webp', 'secreto')}`);
    const e = env({ 'banco/img/310811.webp': 'IMG' });
    expect((await atenderBancoApp(new Request(src), e))!.status).toBe(200);
    expect((await atenderBancoApp(new Request('https://mcp.example/app/banco/img/310811.webp?f=mala'), e))!.status).toBe(403);
  });
});
