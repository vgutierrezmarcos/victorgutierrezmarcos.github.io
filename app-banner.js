/**
 * Enlaces de descarga de la app "Oposición TCEE".
 *
 * El aviso (div#app-banner) está en index.html y en oposicion/index.html. Se
 * ve desde el principio (si apareciera después del fetch empujaría la página:
 * CLS); este script solo enseña los enlaces según oposicion/app-config.json:
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
 * Invitación de un preparador (solo en app/index.html): el enlace que manda
 * a sus alumnos es /app/?codigo=ABC234&op=tcee. Con la app instalada,
 * Android lo abre directamente en ella (App Links); si no, esta página
 * enseña la invitación (#app-invitacion), pasa el código a Google Play como
 * «referrer» (la app lo lee al primer arranque) y a la app web (abrir/).
 *
 * Autor: Víctor Gutiérrez Marcos
 */
(function () {
    var banner = document.getElementById('app-banner');
    if (!banner) return;
    var invitacion = null;
    try {
        var q = new URLSearchParams(location.search);
        var codigo = (q.get('codigo') || '').toUpperCase().replace(/[\s-]/g, '');
        var op = (q.get('op') || '').toLowerCase();
        if (/^[A-Z0-9]{6}$/.test(codigo)) invitacion = 'codigo=' + codigo + (op ? '&op=' + encodeURIComponent(op) : '');
    } catch (e) { /* sin invitación */ }
    if (invitacion) {
        var aviso = document.getElementById('app-invitacion');
        if (aviso) aviso.hidden = false;
        document.querySelectorAll('a[href="abrir/"]').forEach(function (a) { a.href = 'abrir/?' + invitacion; });
    }
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
            // El APK, «Próximamente en Google Play» y su nota se ven desde el
            // principio (con la dirección del APK fija en el HTML); con Google
            // Play se cambian por su distintivo
            if (cfg.app.urlPlayStore && play) {
                play.href = cfg.app.urlPlayStore; play.hidden = false; alguno = true;
                // Con invitación, Play entrega el código a la app al instalarla.
                if (invitacion) play.href += (play.href.indexOf('?') >= 0 ? '&' : '?') + 'referrer=' + encodeURIComponent(invitacion);
                if (pronto) pronto.hidden = true;
                if (apk) apk.hidden = true;
                if (nota) nota.hidden = true;
            } else {
                if (pronto) pronto.hidden = false;
                if (cfg.app.urlApk && apk) {
                    apk.href = cfg.app.urlApk; apk.hidden = false; alguno = true;
                    if (nota) nota.hidden = false;
                } else {
                    if (apk) apk.hidden = true;
                    if (nota) nota.hidden = true;
                }
            }
            if (cfg.app.urlAppStore && ios) { ios.href = cfg.app.urlAppStore; ios.hidden = false; alguno = true; }
            // Aunque no haya descarga (ni Play ni APK), la tarjeta sale: la app
            // se usa igual en el navegador.
            banner.hidden = false;
        })
        .catch(function () { /* silencio */ });
})();
