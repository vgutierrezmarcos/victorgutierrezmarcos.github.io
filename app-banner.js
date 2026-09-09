/**
 * Muestra los enlaces de descarga de la app móvil cuando existen en oposicion/app-config.json.
 * Autor: Víctor Gutiérrez Marcos
 */
(function () {
    var banner = document.getElementById('app-banner');
    if (!banner) return;
    var base = banner.getAttribute('data-base') || '';
    fetch(base + 'oposicion/app-config.json', { cache: 'no-cache' })
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
