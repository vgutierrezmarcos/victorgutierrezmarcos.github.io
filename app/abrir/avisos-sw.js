// Service worker de la app en el navegador: solo para los avisos. No guarda
// nada en caché (la app siempre se descarga de la web, la versión al día).
// Al tocar un aviso se abre la app (o se enfoca la pestaña) en la pantalla
// que corresponde.
self.addEventListener('install', function () { self.skipWaiting(); });
self.addEventListener('activate', function (e) { e.waitUntil(self.clients.claim()); });

self.addEventListener('notificationclick', function (e) {
  e.notification.close();
  var aviso = (e.notification.data && e.notification.data.aviso) || '';
  var ambito = self.registration.scope;
  e.waitUntil(self.clients.matchAll({ type: 'window', includeUncontrolled: true }).then(function (ventanas) {
    for (var i = 0; i < ventanas.length; i++) {
      var v = ventanas[i];
      if (v.url.indexOf(ambito) === 0) {
        if (aviso) v.postMessage({ aviso: aviso });
        return v.focus();
      }
    }
    return self.clients.openWindow(ambito + (aviso ? '?aviso=' + encodeURIComponent(aviso) : ''));
  }));
});
