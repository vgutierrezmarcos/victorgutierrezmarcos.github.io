// Interruptor de apagado. Las primeras versiones de la app en el navegador
// instalaban un service worker de Flutter con este nombre que guardaba la app
// en caché: quien la abrió entonces podía seguir viendo una versión vieja
// (que además estropeaba datos de las nuevas). El navegador busca este
// fichero para actualizarlo: al encontrar este, se borra a sí mismo, vacía
// sus cachés y recarga las pestañas con la versión publicada.
self.addEventListener('install', function () { self.skipWaiting(); });
self.addEventListener('activate', function (e) {
  e.waitUntil(
    caches.keys()
      .then(function (ks) { return Promise.all(ks.map(function (k) { return caches.delete(k); })); })
      .then(function () { return self.registration.unregister(); })
      .then(function () { return self.clients.matchAll({ type: 'window' }); })
      .then(function (ventanas) { ventanas.forEach(function (v) { v.navigate(v.url); }); })
  );
});
