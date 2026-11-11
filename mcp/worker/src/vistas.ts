// Vistas interactivas (MCP Apps, «interactive connectors»): páginas pequeñas que el cliente pinta dentro del chat
// cuando una herramienta lo declara en _meta.ui.resourceUri. El cliente las pide como recursos ui://… y les pasa el
// resultado de la herramienta; la vista puede llamar a otras herramientas (siempre con la sesión del usuario).
// Los clientes que no las admiten no ven nada de esto: reciben el mismo texto de siempre.

import type { McpServer } from '@modelcontextprotocol/sdk/server/mcp.js';
import comun from './vistas/comun.html';
import borrado from './vistas/borrado.html';
import clase from './vistas/clase.html';
import cronograma from './vistas/cronograma.html';
import informe from './vistas/informe.html';
import test from './vistas/test.html';

export const MIME_VISTA = 'text/html;profile=mcp-app';
const WEB = 'https://www.victorgutierrezmarcos.es';

interface Vista {
  uri: string;
  nombre: string;
  descripcion: string;
  cuerpo: string;
  /** Orígenes de los que la vista carga imágenes o scripts (el resto lo bloquea el cliente). Ninguna hace peticiones de red propias. */
  recursos: string[];
}

export const VISTAS = {
  test: { uri: 'ui://economia/test.html', nombre: 'Test interactivo', descripcion: 'Preguntas oficiales con corrección al momento.', cuerpo: test, recursos: [WEB, 'https://cdn.jsdelivr.net'] },
  cronograma: { uri: 'ui://economia/cronograma.html', nombre: 'Cronograma', descripcion: 'El plan semana a semana, con el botón para guardarlo en la app.', cuerpo: cronograma, recursos: [] },
  informe: { uri: 'ui://economia/informe.html', nombre: 'Informe del cante', descripcion: 'Valoración, rúbrica, comentarios y tareas, editables antes de guardar.', cuerpo: informe, recursos: [] },
  clase: { uri: 'ui://economia/clase.html', nombre: 'Clase', descripcion: 'El resumen de la clase antes de pedirla o crearla.', cuerpo: clase, recursos: [] },
  borrado: { uri: 'ui://economia/borrado.html', nombre: 'Borrar una oposición', descripcion: 'Lo que se borraría y la frase de confirmación.', cuerpo: borrado, recursos: [] },
} satisfies Record<string, Vista>;

export type NombreVista = keyof typeof VISTAS;

/** La página completa de una vista: lo común (estilos y puente con el cliente) y su cuerpo. */
export function paginaVista(nombre: NombreVista): string {
  const v = VISTAS[nombre];
  return `<!doctype html>\n<html lang="es">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1">\n<title>${v.nombre}</title>\n${comun}</head>\n<body>\n${v.cuerpo}</body>\n</html>\n`;
}

/** Lo que una herramienta pone en su _meta para que el cliente pinte la vista (la clave con barra es la de los clientes antiguos). */
export function metaVista(nombre: NombreVista): Record<string, unknown> {
  const uri = VISTAS[nombre].uri;
  return { ui: { resourceUri: uri }, 'ui/resourceUri': uri };
}

export function registrarVistas(server: McpServer): void {
  for (const nombre of Object.keys(VISTAS) as NombreVista[]) {
    const v: Vista = VISTAS[nombre];
    const ui = { prefersBorder: true, ...(v.recursos.length ? { csp: { resourceDomains: v.recursos } } : {}) };
    server.registerResource(nombre, v.uri, { title: v.nombre, description: v.descripcion, mimeType: MIME_VISTA, _meta: { ui } }, async () => ({
      contents: [{ uri: v.uri, mimeType: MIME_VISTA, text: paginaVista(nombre), _meta: { ui } }],
    }));
  }
}
