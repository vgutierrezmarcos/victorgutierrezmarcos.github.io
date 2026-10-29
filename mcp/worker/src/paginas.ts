// Páginas HTML del Worker (consentimiento OAuth, errores y portada) con la estética de la web
// («edición académica»: morado como tinta, verde salvia como papel, filete dorado, Pagella y
// versalitas). Cargan styles.css de la web para usar sus fuentes y sus botones, y encabezan con
// las dos marcas: el icono de la app y el asterisco de Claude. La página del paso 2 (entrar con
// Google) es mcp/login.html, con la misma cabecera y los mismos pasos.

export const escapar = (v: string): string => v.replace(/[&<>"']/g, (c) => `&#${c.charCodeAt(0)};`);

const WEB = 'https://www.victorgutierrezmarcos.es';

const estilo = `
  :root { color-scheme: light; }
  body { background: #E2EFD9; }
  .conector { max-width: 600px; margin: 5vh auto 3rem; padding: 0 16px; }
  .conector-marcas { display: flex; align-items: center; justify-content: center; gap: 18px; margin-bottom: 1.4rem; }
  .conector-marcas img { height: 56px; width: 56px; }
  .conector-marcas i { display: block; width: 1px; height: 40px; background: #C9B37E; }
  .conector-pasos { display: flex; justify-content: center; gap: 0; margin: 0 0 1.4rem; padding: 0; list-style: none; font-variant-caps: all-small-caps; letter-spacing: .04em; font-size: 1.05rem; color: #4A4452; }
  .conector-pasos li { position: relative; padding: 0 1.1em; }
  .conector-pasos li + li::before { content: ""; position: absolute; left: 0; top: 50%; width: 1px; height: 1em; margin-top: -.5em; background: #C9B37E; }
  .conector-pasos li[aria-current] { color: #5F2987; font-weight: 600; }
  .conector-pasos li[aria-current]::after { content: ""; display: block; height: 2px; background: #C9B37E; margin-top: .15em; }
  .conector .card { padding: 1.7rem 1.9rem 1.5rem; }
  .conector h1 { font-variant-caps: all-small-caps; letter-spacing: .02em; font-weight: normal; font-size: 1.7rem; margin: 0 0 .5em; color: #5F2987; }
  .conector p { margin: 0 0 .85em; }
  .conector ul { margin: 0 0 1em; padding-left: 1.2rem; }
  .conector li { margin-bottom: .25em; }
  .conector .nota { font-size: .92rem; color: #4A4452; }
  .conector .aviso { border-left: 3px solid #C9B37E; background: #F1EBF6; padding: .7em 1em; border-radius: 0 4px 4px 0; }
  .conector .acciones { margin-top: 1.3rem; display: flex; gap: .8rem; flex-wrap: wrap; align-items: center; }
  .conector button { font: inherit; cursor: pointer; }
  .conector code { font-size: .92em; word-break: break-all; }
  .conector-pie { font-size: .85rem; color: #4A4452; text-align: center; margin-top: 1.4rem; }
  .conector-pie a { color: #5F2987; }
  @media (max-width: 480px) { .conector-pasos { font-size: .95rem; } .conector-pasos li { padding: 0 .7em; } .conector .card { padding: 1.3rem 1.2rem; } }
`;

/** Cabecera común: las dos marcas y los tres pasos (1 autorizar, 2 entrar con Google, 3 listo). */
export function cabeceraConector(paso: 1 | 2 | 3): string {
  const pasos = ['Autorizar', 'Entrar con Google', 'Listo'];
  return `<div class="conector-marcas" aria-hidden="true">
  <img src="${WEB}/app/assets/icon/icon.svg" alt="">
  <i></i>
  <img src="${WEB}/oposicion/img/claude/claude-logo.svg" alt="">
</div>
<ol class="conector-pasos" aria-label="Pasos de la conexión">
${pasos.map((p, i) => `  <li${i + 1 === paso ? ' aria-current="step"' : ''}>${i + 1}. ${p}</li>`).join('\n')}
</ol>`;
}

function pagina(titulo: string, cuerpo: string, paso: 1 | 2 | 3): string {
  return `<!doctype html>
<html lang="es">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex">
<title>${escapar(titulo)} · Prepara con Claude</title>
<link rel="icon" href="/favicon.svg" type="image/svg+xml">
<link rel="icon" href="/favicon.png" type="image/png" sizes="512x512">
<link rel="apple-touch-icon" href="/apple-touch-icon.png">
<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Source+Sans+3:wght@400;600&display=swap">
<link rel="stylesheet" href="${WEB}/styles.css">
<style>${estilo}</style>
</head>
<body>
<main class="conector">
${cabeceraConector(paso)}
<div class="card">
${cuerpo}
</div>
<p class="conector-pie">Conector «Prepara con Claude» de <a href="${WEB}/oposicion/prepara-con-claude.html">victorgutierrezmarcos.es</a> · <a href="${WEB}/politica-cookies.html">política de privacidad</a> · <a href="${WEB}/condiciones-materiales.html#ia">condiciones</a></p>
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

/** Página de consentimiento (paso 1): qué aplicación pide acceso y a qué; después se entra con Google. */
export function paginaConsentimiento(d: DatosConsentimiento, handle: string): string {
  const nombre = escapar(d.clientName || 'Una aplicación');
  const origen = d.clientDomain
    ? `Publicada por <strong>${escapar(d.clientDomain)}</strong>.`
    : 'Se ha registrado ella misma: el nombre lo pone la propia aplicación.';
  const local = d.redirectIsLoopback
    ? `<p class="aviso"><strong>El acceso se enviará a un programa de tu ordenador</strong> (${escapar(d.redirectHost)}). Sigue solo si acabas de empezar la conexión desde Claude Code o Claude Desktop.</p>`
    : `<p class="nota">El acceso se enviará a <strong>${escapar(d.redirectHost)}</strong>.</p>`;
  return pagina(
    'Conectar Claude con tu app',
    `<h1>¿Conectar ${nombre} con tu app?</h1>
<p>${origen}</p>
${local}
<p>Si aceptas, en el paso siguiente entrarás con tu cuenta de Google (la misma de la app «Oposición TCEE · DCE») y Claude podrá, en tu nombre:</p>
<ul>
  <li>leer tu progreso, tus tests, tu diario de cantes y tu cronograma;</li>
  <li>leer los materiales exclusivos (temas revisados, fichas, guía del dictamen);</li>
  <li>guardar en la app, solo cuando tú lo confirmes en la conversación, un cronograma nuevo y el informe de un cante.</li>
</ul>
<p class="nota">No verá los datos de nadie más, ni tu Google Calendar, ni las grabaciones o transcripciones del móvil. Puedes desconectarlo cuando quieras desde Claude (Personalizar → Conectores), desde la app (Más → Cuenta → Desconectar Claude) o pidiéndoselo a Claude («desconéctate de la app»).</p>
<form method="post">
  <input type="hidden" name="handle" value="${escapar(handle)}">
  ${d.scope.map((s) => `<input type="hidden" name="scope" value="${escapar(s)}">`).join('')}
  <div class="acciones">
    <button class="boton" name="decision" value="aceptar">Aceptar y entrar con Google</button>
    <button class="boton boton--secundario" name="decision" value="denegar">No, gracias</button>
  </div>
</form>`,
    1,
  );
}

export function paginaError(titulo: string, mensaje: string): string {
  return pagina(
    titulo,
    `<h1>${escapar(titulo)}</h1><p>${escapar(mensaje)}</p><p class="nota">Vuelve a Claude y empieza la conexión otra vez. Si se repite, escribe a <a href="mailto:contacto@victorgutierrezmarcos.es">contacto@victorgutierrezmarcos.es</a>.</p>`,
    3,
  );
}

export function paginaPortada(urlMcp: string): string {
  return pagina(
    'Conector',
    `<h1>Conector «Prepara con Claude»</h1>
<p>Es el servidor que une tu cuenta de Claude con tu cuenta de la app «Oposición TCEE · DCE»: Claude lee tus cantes, tus tests y tu cronograma, y guarda en la app lo que tú le confirmes. No es una página para navegar: se añade como conector personalizado en Claude.</p>
<p>URL del conector: <code>${escapar(urlMcp)}</code></p>
<p class="nota">Cómo conectarlo y qué puede hacer: <a href="${WEB}/oposicion/prepara-con-claude.html#conector">Prepara con Claude</a>.</p>`,
    1,
  );
}
