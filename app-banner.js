/**
 * Enlaces de descarga y novedad de la app "Oposición TCEE".
 *
 * El aviso (div#app-banner) está en index.html y en oposicion/index.html y
 * permanece oculto mientras oposicion/app-config.json no tenga ninguna URL:
 *
 *   - "urlApk":       descarga directa del APK de Android (publicada como
 *                     release "app-latest" en GitHub).
 *   - "urlPlayStore": ficha de Google Play, cuando exista.
 *   - "urlAppStore":  ficha del App Store, cuando exista.
 *   - "novedad":      lo último de la app, en una frase (opcional): sale en
 *                     el aviso con la etiqueta «Novedad».
 *
 * Cuando la app esté en Google Play, poner "urlApk" a null para que solo se
 * ofrezca la tienda.
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
            var alguno = false;
            if (cfg.app.urlApk && apk) {
                apk.href = cfg.app.urlApk; apk.hidden = false; alguno = true;
                if (nota) nota.hidden = false;
            }
            if (cfg.app.urlPlayStore && play) { play.href = cfg.app.urlPlayStore; play.hidden = false; alguno = true; }
            if (cfg.app.urlAppStore && ios) { ios.href = cfg.app.urlAppStore; ios.hidden = false; alguno = true; }
            var novedad = document.getElementById('app-banner-new');
            var texto = document.getElementById('app-banner-new-text');
            if (cfg.app.novedad && novedad && texto) { texto.textContent = cfg.app.novedad; novedad.hidden = false; }
            if (alguno) banner.hidden = false;
        })
        .catch(function () { /* silencio */ });
})();
