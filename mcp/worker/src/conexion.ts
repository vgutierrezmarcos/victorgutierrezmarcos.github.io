// La marca de conexión: con qué IA usa el opositor el conector y cuándo fue la última vez.
// Va en su propia cuenta (`users/{uid}/cuenta/conector`), para que la app sepa que puede
// ofrecerle la burbuja que abre esa IA. Solo la IA y la fecha: nada de lo que se habla.
import type { AlmacenDatos } from './firestore';

export const IAS = ['claude', 'lechat', 'chatgpt', 'gemini', 'otra'] as const;
export type Ia = (typeof IAS)[number];

/** Documento de la marca, bajo `users/{uid}`. */
export const RUTA_CONEXION = 'cuenta/conector';
/** Una escritura al día por usuario e IA, como mucho. */
const TTL_MARCA = 86_400;

interface Cliente {
  clientName?: string;
  redirectUris?: string[];
  clientUri?: string;
}

/** La IA que hay detrás de un cliente OAuth, por el nombre con el que se registró y por adónde vuelve. */
export function iaDe(cliente: Cliente | null | undefined): Ia {
  if (!cliente) return 'otra';
  const texto = [cliente.clientName ?? '', cliente.clientUri ?? '', ...(cliente.redirectUris ?? [])].join(' ').toLowerCase();
  if (/claude|anthropic/.test(texto)) return 'claude';
  if (/chatgpt|openai/.test(texto)) return 'chatgpt';
  if (/mistral|le ?chat/.test(texto)) return 'lechat';
  if (/gemini|google/.test(texto)) return 'gemini';
  return 'otra';
}

interface Marcas {
  get(clave: string): Promise<string | null>;
  put(clave: string, valor: string, opciones?: { expirationTtl?: number }): Promise<unknown>;
  delete(clave: string): Promise<unknown>;
}

export interface EntornoConexion {
  marcas: Marcas;
  /** sha256 del uid: las claves del KV no llevan el uid en claro. */
  huella: string;
  /** La cuenta del opositor (`users/{uid}`), con su propia sesión. */
  cuenta: () => Promise<AlmacenDatos>;
}

const clave = (huella: string, ia: Ia) => `con:${huella}:${ia}`;

/** Apunta que hoy se ha usado el conector con [ia]. Devuelve si ha escrito (false: ya estaba apuntado hoy). */
export async function anotarConexion(e: EntornoConexion, ia: Ia, ahora: string): Promise<boolean> {
  const k = clave(e.huella, ia);
  if (await e.marcas.get(k)) return false;
  await (await e.cuenta()).escribir(RUTA_CONEXION, { ias: { [ia]: { ultimoUso: ahora } } }, [`ias.${ia}.ultimoUso`]);
  await e.marcas.put(k, '1', { expirationTtl: TTL_MARCA });
  return true;
}

/** Al desconectar: la marca desaparece de la cuenta (la app deja de ofrecer la burbuja) y del KV. */
export async function olvidarConexion(e: EntornoConexion): Promise<void> {
  await (await e.cuenta()).lote([{ ruta: RUTA_CONEXION, datos: {}, borrar: true }]);
  for (const ia of IAS) await e.marcas.delete(clave(e.huella, ia));
}
