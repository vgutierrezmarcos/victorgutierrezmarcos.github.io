// Cifrado del refresh token de Firebase antes de guardarlo (AES-GCM con WebCrypto).
// La clave viene del secreto CLAVE_CIFRADO (32 bytes en base64). El texto cifrado se
// guarda como base64 de [iv (12 bytes) + datos]. Es una segunda capa: la biblioteca OAuth
// ya cifra los «props» de cada token, pero así ni quien lea el KV con la clave de la
// biblioteca ve el token de Firebase sin el secreto del Worker.

const codificador = new TextEncoder();
const decodificador = new TextDecoder();

export function aBase64(bytes: Uint8Array): string {
  let s = '';
  for (const b of bytes) s += String.fromCharCode(b);
  return btoa(s);
}

export function deBase64(texto: string): Uint8Array {
  const s = atob(texto);
  const out = new Uint8Array(s.length);
  for (let i = 0; i < s.length; i++) out[i] = s.charCodeAt(i);
  return out;
}

async function clave(secreto: string): Promise<CryptoKey> {
  const bytes = deBase64(secreto);
  if (bytes.length !== 32) throw new Error('CLAVE_CIFRADO tiene que ser 32 bytes en base64 (openssl rand -base64 32)');
  return crypto.subtle.importKey('raw', bytes, { name: 'AES-GCM' }, false, ['encrypt', 'decrypt']);
}

export async function cifrar(texto: string, secreto: string): Promise<string> {
  const k = await clave(secreto);
  const iv = crypto.getRandomValues(new Uint8Array(12));
  const datos = new Uint8Array(await crypto.subtle.encrypt({ name: 'AES-GCM', iv }, k, codificador.encode(texto)));
  const junto = new Uint8Array(iv.length + datos.length);
  junto.set(iv);
  junto.set(datos, iv.length);
  return aBase64(junto);
}

export async function descifrar(cifrado: string, secreto: string): Promise<string> {
  const k = await clave(secreto);
  const junto = deBase64(cifrado);
  const iv = junto.slice(0, 12);
  const datos = junto.slice(12);
  return decodificador.decode(await crypto.subtle.decrypt({ name: 'AES-GCM', iv }, k, datos));
}

/** SHA-256 en hexadecimal (para no guardar en KV el «state» ni el uid en claro). */
export async function sha256(texto: string): Promise<string> {
  const h = new Uint8Array(await crypto.subtle.digest('SHA-256', codificador.encode(texto)));
  return Array.from(h, (b) => b.toString(16).padStart(2, '0')).join('');
}
