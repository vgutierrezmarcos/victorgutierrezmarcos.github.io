/**
 * Enlaces de descarga de la app móvil "Oposición TCEE".
 *
 * PENDIENTE DE ACTIVAR: la app aún no está publicada en las tiendas, así que
 * ahora mismo ningún HTML incluye este script. Cuando la app esté lista:
 *
 *   1. Rellenar "urlPlayStore" y/o "urlAppStore" en oposicion/app-config.json.
 *   2. Pegar este bloque en oposicion/index.html, justo DESPUÉS del
 *      <h2 class="section-title">MATERIALES PARA LA OPOSICIÓN A TCEE</h2>
 *      (arriba del todo del contenido, antes del texto introductorio):
 *
 *      <div id="app-banner" class="app-banner" hidden>
 *          <div class="app-banner-text">
 *              <span class="app-banner-label">App móvil</span>
 *              <h3 class="app-banner-title">Lleva la oposición en el bolsillo</h3>
 *              <p>Test, temario offline, sorteo de temas y cronómetro para cantar. Mismo historial que en la web.</p>
 *          </div>
 *          <div class="app-banner-links">
 *              <a id="app-link-play" class="download-btn" target="_blank" rel="noopener" hidden>Google Play</a>
 *              <a id="app-link-ios" class="download-btn" target="_blank" rel="noopener" hidden>App Store</a>
 *          </div>
 *      </div>
 *
 *   3. Añadir <script src="../app-banner.js" defer></script> al final del body.
 *
 * El banner permanece oculto mientras app-config.json no tenga URLs, de modo
 * que puede publicarse el HTML antes de que la app esté disponible.
 *
 * Autor: Víctor Gutiérrez Marcos
 */
(function () {
    var banner = document.getElementById('app-banner');
    if (!banner) return;
    fetch('/oposicion/app-config.json', { cache: 'no-cache' })
        .then(function (r) { return r.ok ? r.json() : null; })
        .then(function (cfg) {
            if (!cfg || !cfg.app) return;
            var play = document.getElementById('app-link-play');
            var ios = document.getElementById('app-link-ios');
            var alguno = false;
            if (cfg.app.urlPlayStore && play) { play.href = cfg.app.urlPlayStore; play.hidden = false; alguno = true; }
            if (cfg.app.urlAppStore && ios) { ios.href = cfg.app.urlAppStore; ios.hidden = false; alguno = true; }
            if (alguno) banner.hidden = false;
        })
        .catch(function () { /* silencio */ });
})();
