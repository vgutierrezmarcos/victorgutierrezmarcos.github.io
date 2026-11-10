import { describe, expect, it } from 'vitest';
import { paginaMudanza, traducirErrorOAuth } from '../src/paginas';

describe('páginas del conector', () => {
  it('el error de la cookie de sesión sale en español y los demás, tal cual', () => {
    expect(traducirErrorOAuth('This authorization was not started in this browser; start again')).toContain('no se empezó en este navegador');
    expect(traducirErrorOAuth('otro')).toBe('otro');
  });

  it('la dirección antigua explica cómo volver a añadir el conector con la nueva', () => {
    const h = paginaMudanza('https://mcp.victorgutierrezmarcos.es/mcp');
    expect(h).toContain('ha cambiado de dirección');
    expect(h).toContain('<code>https://mcp.victorgutierrezmarcos.es/mcp</code>');
  });
});
