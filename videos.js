/**
 * Vídeos de YouTube (no listados) pedidos por su clave.
 *
 * videos.json (en la raíz, lo mantiene scripts/youtube.py) dice qué vídeo de
 * YouTube vale hoy para cada clave; las páginas nunca llevan el ID:
 *
 *   - <video data-video="clave" poster="…">: se cambia por el póster con un
 *     botón de reproducir; el reproductor de YouTube (youtube-nocookie.com)
 *     solo se carga al pulsarlo.
 *   - <a data-video="clave">: el enlace pasa a apuntar al vídeo.
 *
 * Si la clave no está en videos.json (o no se puede leer), se queda lo que
 * haya en la página: el <video> con su archivo local o el enlace original.
 *
 * Autor: Víctor Gutiérrez Marcos
 */
(function () {
    var elementos = document.querySelectorAll('[data-video]');
    if (!elementos.length) return;

    function reproductor(video, id) {
        var caja = document.createElement('div');
        caja.className = (video.className + ' video-yt').trim();
        var boton = document.createElement('button');
        boton.type = 'button';
        boton.className = 'video-yt-boton';
        boton.setAttribute('aria-label', 'Reproducir: ' + (video.getAttribute('aria-label') || 'vídeo'));
        if (video.poster) boton.style.backgroundImage = 'url("' + video.poster + '")';
        boton.innerHTML = '<span class="video-yt-icono" aria-hidden="true"></span>';
        boton.addEventListener('click', function () {
            var marco = document.createElement('iframe');
            marco.src = 'https://www.youtube-nocookie.com/embed/' + id + '?autoplay=1&rel=0&playsinline=1';
            marco.title = video.getAttribute('aria-label') || 'Vídeo';
            marco.allow = 'autoplay; encrypted-media; picture-in-picture; fullscreen';
            marco.allowFullscreen = true;
            caja.replaceChild(marco, boton);
        });
        caja.appendChild(boton);
        video.replaceWith(caja);
    }

    fetch('/videos.json', { cache: 'no-cache' })
        .then(function (r) { return r.ok ? r.json() : null; })
        .then(function (registro) {
            if (!registro || !registro.videos) return;
            elementos.forEach(function (el) {
                var v = registro.videos[el.getAttribute('data-video')];
                if (!v || !v.youtube) return;
                if (el.tagName === 'VIDEO') reproductor(el, v.youtube);
                else if (el.tagName === 'A') el.href = 'https://youtu.be/' + v.youtube;
            });
        })
        .catch(function () { /* sin registro: se queda el vídeo local */ });
})();
