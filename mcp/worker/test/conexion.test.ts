// La marca de conexión de la cuenta: qué IA es, una escritura al día y borrado al desconectar.
import { describe, expect, it } from 'vitest';
import { RUTA_CONEXION, anotarConexion, iaDe, olvidarConexion } from '../src/conexion';
import type { AlmacenDatos, Escritura } from '../src/firestore';

const entorno = () => {
  const kv = new Map<string, string>();
  const escritos: Array<{ ruta: string; datos: unknown; soloCampos?: string[] }> = [];
  const lotes: Escritura[][] = [];
  const cuenta = {
    escribir: async (ruta: string, datos: unknown, soloCampos?: string[]) => void escritos.push({ ruta, datos, soloCampos }),
    lote: async (e: Escritura[]) => void lotes.push(e),
  } as unknown as AlmacenDatos;
  return {
    kv,
    escritos,
    lotes,
    e: {
      marcas: { get: async (k: string) => kv.get(k) ?? null, put: async (k: string, v: string) => void kv.set(k, v), delete: async (k: string) => void kv.delete(k) },
      huella: 'abc',
      cuenta: async () => cuenta,
    },
  };
};

describe('marca de conexión', () => {
  it('reconoce la IA por el nombre del cliente o por adónde vuelve', () => {
    expect(iaDe({ clientName: 'Claude' })).toBe('claude');
    expect(iaDe({ clientName: 'Conector', redirectUris: ['https://claude.ai/api/mcp/auth_callback'] })).toBe('claude');
    expect(iaDe({ redirectUris: ['https://chatgpt.com/connector_platform_oauth_redirect'] })).toBe('chatgpt');
    expect(iaDe({ clientName: 'Le Chat' })).toBe('lechat');
    expect(iaDe({ clientName: 'x', redirectUris: ['https://callback.mistral.ai/v1/integrations_auth/oauth2_callback'] })).toBe('lechat');
    expect(iaDe({ clientName: 'Gemini' })).toBe('gemini');
    expect(iaDe({ clientName: 'Cursor' })).toBe('otra');
    expect(iaDe(null)).toBe('otra');
  });

  it('apunta el uso una sola vez al día, solo con la IA y la fecha', async () => {
    const t = entorno();
    expect(await anotarConexion(t.e, 'claude', '2026-11-11T10:00:00.000Z')).toBe(true);
    expect(await anotarConexion(t.e, 'claude', '2026-11-11T11:00:00.000Z')).toBe(false);
    expect(t.escritos).toEqual([{ ruta: RUTA_CONEXION, datos: { ias: { claude: { ultimoUso: '2026-11-11T10:00:00.000Z' } } }, soloCampos: ['ias.claude.ultimoUso'] }]);
    // Otra IA de la misma cuenta se apunta aparte.
    expect(await anotarConexion(t.e, 'lechat', '2026-11-11T12:00:00.000Z')).toBe(true);
    expect(t.escritos).toHaveLength(2);
  });

  it('si la escritura falla no deja la marca del día', async () => {
    const t = entorno();
    const e = { ...t.e, cuenta: async () => ({ escribir: async () => Promise.reject(new Error('sin red')) }) as unknown as AlmacenDatos };
    await expect(anotarConexion(e, 'claude', '2026-11-11T10:00:00.000Z')).rejects.toThrow();
    expect(t.kv.size).toBe(0);
  });

  it('al desconectar borra el documento y las marcas', async () => {
    const t = entorno();
    await anotarConexion(t.e, 'claude', '2026-11-11T10:00:00.000Z');
    await olvidarConexion(t.e);
    expect(t.lotes).toEqual([[{ ruta: RUTA_CONEXION, datos: {}, borrar: true }]]);
    expect(t.kv.size).toBe(0);
    expect(await anotarConexion(t.e, 'claude', '2026-11-12T10:00:00.000Z')).toBe(true);
  });
});
