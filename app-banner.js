/**
 * Enlaces de descarga de la app "Oposición TCEE".
 *
 * El aviso (div#app-banner) está en index.html y en oposicion/index.html y
 * permanece oculto mientras oposicion/app-config.json no tenga ninguna URL:
 *
 *   - "urlApk":       descarga directa del APK de Android (publicada como
 *                     release "app-latest" en GitHub).
 *   - "urlPlayStore": ficha de Google Play, cuando exista.
 *   - "urlAppStore":  ficha del App Store, cuando exista.
 *
 * Con "urlPlayStore" se muestra el distintivo oficial de Google Play
 * (#app-link-play) y deja de ofrecerse el APK; sin ella, «Próximamente en
 * Google Play» (#app-play-pronto) y la descarga directa. Cuando la app esté
 * en Google Play, basta con rellenar "urlPlayStore" (y, pasado un tiempo,
 * poner "urlApk" a null). Cómo instalarla, paso a paso: app/instalar.html.
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
            var apk = document.getElementById('app-link-apk');
            var nota = document.getElementById('app-banner-note');
            var pronto = document.getElementById('app-play-pronto');
            var alguno = false;
            if (cfg.app.urlPlayStore && play) {
                play.href = cfg.app.urlPlayStore; play.hidden = false; alguno = true;
            } else {
                if (pronto) pronto.hidden = false;
                if (cfg.app.urlApk && apk) {
                    apk.href = cfg.app.urlApk; apk.hidden = false; alguno = true;
                    if (nota) nota.hidden = false;
                }
            }
            if (cfg.app.urlAppStore && ios) { ios.href = cfg.app.urlAppStore; ios.hidden = false; alguno = true; }
            if (alguno) banner.hidden = false;
        })
        .catch(function () { /* silencio */ });
})();
