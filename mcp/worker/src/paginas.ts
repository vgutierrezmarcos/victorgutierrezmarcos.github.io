// Páginas HTML mínimas del Worker (consentimiento OAuth, errores y portada), con la
// estética de la web: morado como tinta, verde salvia como papel, Palatino y versalitas.

export const escapar = (v: string): string => v.replace(/[&<>"']/g, (c) => `&#${c.charCodeAt(0)};`);

const estilo = `
  :root { color-scheme: light; }
  body { margin: 0; background: #E2EFD9; color: #1F1A24; font-family: "TeX Gyre Pagella", "Palatino Linotype", Palatino, "Book Antiqua", serif; line-height: 1.5; }
  main { max-width: 560px; margin: 8vh auto; padding: 0 16px; }
  .tarjeta { background: #F6FAF2; border: 1px solid #C9B37E; border-radius: 6px; padding: 28px 28px 24px; }
  h1 { color: #5F2987; font-size: 1.5rem; font-weight: normal; margin: 0 0 .5em; font-variant-caps: all-small-caps; letter-spacing: .02em; }
  p { margin: 0 0 .8em; }
  ul { margin: 0 0 1em 1.2em; padding: 0; }
  .nota { font-size: .92rem; color: #4A4452; }
  .aviso { border-left: 3px solid #C9B37E; padding-left: 12px; }
  .botones { margin-top: 1.2em; display: flex; gap: 12px; flex-wrap: wrap; }
  button { font: inherit; font-variant-caps: all-small-caps; letter-spacing: .03em; padding: .5em 1.3em; border-radius: 4px; cursor: pointer; border: 1px solid #5F2987; }
  .boton { background: #5F2987; color: #fff; }
  .boton--secundario { background: transparent; color: #5F2987; }
  button:focus-visible { outline: 3px solid #C9B37E; outline-offset: 2px; }
  code { font-size: .9em; }
  a { color: #5F2987; }
  footer { font-size: .85rem; color: #4A4452; margin-top: 1.5em; }
`;

function pagina(titulo: string, cuerpo: string): string {
  return `<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex">
<title>${escapar(titulo)}</title>
<style>${estilo}</style>
</head>
<body>
<main>
<div class="tarjeta">
${cuerpo}
</div>
<footer>Conector «Prepara con Claude» de <a href="https://www.victorgutierrezmarcos.es/oposicion/prepara-con-claude.html">victorgutierrezmarcos.es</a> · <a href="https://www.victorgutierrezmarcos.es/politica-cookies.html">política de privacidad</a> · <a href="https://www.victorgutierrezmarcos.es/condiciones-materiales.html#ia">condiciones</a></footer>
</main>
</body>
</html>`;
}

export interface DatosConsentimiento {
  clientName: string;
  clientDomain?: string;
  redirectHost: string;
  redirectIsLoopback: boolean;
  scope: string[];
}

/** Página de consentimiento: qué aplicación pide acceso y a qué; después se entra con Google. */
export function paginaConsentimiento(d: DatosConsentimiento, handle: string): string {
  const nombre = escapar(d.clientName || 'Una aplicación');
  const origen = d.clientDomain
    ? `Publicada por <strong>${escapar(d.clientDomain)}</strong>.`
    : 'Se ha registrado ella misma: el nombre lo pone la propia aplicación.';
  const local = d.redirectIsLoopback
    ? `<p class="aviso"><strong>El acceso se enviará a un programa de tu ordenador</strong> (${escapar(d.redirectHost)}). Sigue solo si acabas de empezar la conexión desde Claude Code o Claude Desktop.</p>`
    : `<p class="nota">El acceso se enviará a <strong>${escapar(d.redirectHost)}</strong>.</p>`;
  return pagina(
    'Conectar Claude con la app',
    `<h1>¿Conectar ${nombre} con tu app?</h1>
<p>${origen}</p>
${local}
<p>Si aceptas, en el paso siguiente entrarás con tu cuenta de Google (la misma de la app «Oposición TCEE · DCE») y Claude podrá, en tu nombre:</p>
<ul>
  <li>leer tu progreso, tus tests, tu diario de cantes y tu cronograma;</li>
  <li>leer los materiales exclusivos (temas revisados, fichas, guía del dictamen);</li>
  <li>guardar en la app, solo cuando tú lo confirmes en la conversación, un cronograma nuevo y el informe de un cante.</li>
</ul>
<p class="nota">No verá los datos de nadie más, ni tu Google Calendar, ni las grabaciones o transcripciones del móvil. Puedes revocarlo cuando quieras desde la app (Más → Prepara con Claude → Desconectar Claude) o pidiéndoselo a Claude («desconéctate de la app»).</p>
<form method="post">
  <input type="hidden" name="handle" value="${escapar(handle)}">
  ${d.scope.map((s) => `<input type="hidden" name="scope" value="${escapar(s)}">`).join('')}
  <div class="botones">
    <button class="boton" name="decision" value="aceptar">Aceptar y entrar con Google</button>
    <button class="boton--secundario" name="decision" value="denegar">No, gracias</button>
  </div>
</form>`,
  );
}

export function paginaError(titulo: string, mensaje: string): string {
  return pagina(titulo, `<h1>${escapar(titulo)}</h1><p>${escapar(mensaje)}</p><p class="nota">Vuelve a Claude y empieza la conexión otra vez.</p>`);
}

export function paginaPortada(urlMcp: string): string {
  return pagina(
    'Prepara con Claude · conector',
    `<h1>Conector «Prepara con Claude»</h1>
<p>Servidor MCP remoto de la app «Oposición TCEE · DCE». No es una página para navegar: se añade como conector personalizado en Claude.</p>
<p>URL del conector: <code>${escapar(urlMcp)}</code></p>
<p class="nota">Cómo conectarlo y qué puede hacer: <a href="https://www.victorgutierrezmarcos.es/oposicion/prepara-con-claude.html">Prepara con Claude</a>.</p>`,
  );
}
