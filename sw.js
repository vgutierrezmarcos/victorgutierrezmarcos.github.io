/**
 * Service Worker para modo offline del simulador de test
 * Cachea los recursos esenciales del simulador y preguntas
 * Autor: Víctor Gutiérrez Marcos
 */

var CACHE_NAME = 'vgm-simulador-v1';

var PRECACHE_URLS = [
    '/oposicion/temario/primer-ejercicio/test/simulador.html',
    '/oposicion/temario/primer-ejercicio/test/preguntas.json',
    '/oposicion/temario/primer-ejercicio/test/simulator-history.js',
    '/oposicion/temario/primer-ejercicio/test/simulator-stats.js',
    '/oposicion/temario/primer-ejercicio/test/spaced-repetition.js',
    '/styles.css',
    '/search-styles.css',
    '/cookie-consent.css',
    '/search-engine.js',
    '/search-ui.js',
    '/cookie-consent.js',
    '/firebase-config.js',
    '/auth.js',
    '/favicon.ico',
    '/site.webmanifest'
];

// Instalar: cachear recursos esenciales
self.addEventListener('install', function(event) {
    event.waitUntil(
        caches.open(CACHE_NAME).then(function(cache) {
            return cache.addAll(PRECACHE_URLS);
        }).then(function() {
            return self.skipWaiting();
        })
    );
});

// Activar: limpiar caches antiguos
self.addEventListener('activate', function(event) {
    event.waitUntil(
        caches.keys().then(function(cacheNames) {
            return Promise.all(
                cacheNames.filter(function(name) {
                    return name.startsWith('vgm-') && name !== CACHE_NAME;
                }).map(function(name) {
                    return caches.delete(name);
                })
            );
        }).then(function() {
            return self.clients.claim();
        })
    );
});

// Fetch: network first, fallback to cache
self.addEventListener('fetch', function(event) {
    var url = new URL(event.request.url);

    // Solo interceptar peticiones del mismo origen y GET
    if (url.origin !== self.location.origin || event.request.method !== 'GET') {
        return;
    }

    // Para preguntas.json usar cache-first (no cambia frecuentemente)
    if (url.pathname.indexOf('preguntas.json') !== -1) {
        event.respondWith(
            caches.match(event.request).then(function(cached) {
                if (cached) {
                    // Actualizar cache en background
                    fetch(event.request).then(function(response) {
                        if (response.ok) {
                            caches.open(CACHE_NAME).then(function(cache) {
                                cache.put(event.request, response);
                            });
                        }
                    }).catch(function() {});
                    return cached;
                }
                return fetch(event.request).then(function(response) {
                    if (response.ok) {
                        var clone = response.clone();
                        caches.open(CACHE_NAME).then(function(cache) {
                            cache.put(event.request, clone);
                        });
                    }
                    return response;
                });
            })
        );
        return;
    }

    // Para el resto: network first, fallback a cache
    event.respondWith(
        fetch(event.request).then(function(response) {
            if (response.ok) {
                var clone = response.clone();
                caches.open(CACHE_NAME).then(function(cache) {
                    cache.put(event.request, clone);
                });
            }
            return response;
        }).catch(function() {
            return caches.match(event.request);
        })
    );
});
