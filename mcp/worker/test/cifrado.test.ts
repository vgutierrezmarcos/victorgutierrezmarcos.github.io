import { describe, expect, it } from 'vitest';
import { cifrar, deBase64, descifrar, sha256 } from '../src/cifrado';

const CLAVE = 'MDEyMzQ1Njc4OWFiY2RlZjAxMjM0NTY3ODlhYmNkZWY=';

describe('cifrado del refresh token', () => {
  it('cifra y descifra con la misma clave, con un vector de inicialización distinto cada vez', async () => {
    const a = await cifrar('refresh-token-de-firebase', CLAVE);
    const b = await cifrar('refresh-token-de-firebase', CLAVE);
    expect(a).not.toBe(b);
    expect(deBase64(a).length).toBe(12 + 'refresh-token-de-firebase'.length + 16);
    expect(await descifrar(a, CLAVE)).toBe('refresh-token-de-firebase');
    expect(await descifrar(b, CLAVE)).toBe('refresh-token-de-firebase');
  });

  it('con otra clave no se descifra', async () => {
    const otra = 'ZmVkY2JhOTg3NjU0MzIxMGZlZGNiYTk4NzY1NDMyMTA=';
    const c = await cifrar('secreto', CLAVE);
    await expect(descifrar(c, otra)).rejects.toThrow();
  });

  it('rechaza una clave que no tenga 32 bytes', async () => {
    await expect(cifrar('x', btoa('corta'))).rejects.toThrow(/32 bytes/);
  });

  it('sha256 en hexadecimal', async () => {
    expect(await sha256('abc')).toBe('ba7816bf8f01cfea414140de5dae2223b00361a396177a9cb410ff61f20015ad');
  });
});
