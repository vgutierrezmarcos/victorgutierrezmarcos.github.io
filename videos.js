/**
 * Vídeos de YouTube (no listados) pedidos por su clave.
 *
 * videos.json (en la raíz, lo mantiene scripts/youtube.py) dice qué vídeo de
 * YouTube vale hoy para cada clave; las páginas nunca llevan el ID:
 *
 *   - <video data-video="clave" poster="…">: se cambia por el póster con un
 *     botón de reproducir; al pulsarlo se carga el reproductor de YouTube
 *     (youtube-nocookie.com) dentro de un visor propio: sin título, canal ni
 *     vídeos relacionados, con nuestros controles y en la calidad máxima.
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

    // ---- Visor propio sobre el reproductor de YouTube ----------------------
    // El iframe de YouTube (youtube-nocookie.com, sin controles ni vídeos
    // relacionados) queda debajo de una capa que se queda con el ratón y el
    // dedo, así YouTube nunca enseña su título, el canal ni el «ver en
    // YouTube»; en pausa y al acabar, el póster lo tapa (ahí es donde YouTube
    // pone su pantalla de fin y sus botones). Los controles son nuestros:
    // reproducir, barra de tiempo, silencio y pantalla completa. Para que
    // YouTube elija la calidad máxima, el iframe se crea al doble o triple de
    // tamaño y se reduce con transform: YouTube sirve la calidad según el
    // tamaño que cree que tiene el reproductor.
    var API = 'https://www.youtube.com/iframe_api';
    var apiLista = null;
    function cargarApi() {
        if (window.YT && window.YT.Player) return Promise.resolve();
        if (apiLista) return apiLista;
        apiLista = new Promise(function (resolver, rechazar) {
            var anterior = window.onYouTubeIframeAPIReady;
            window.onYouTubeIframeAPIReady = function () { if (anterior) anterior(); resolver(); };
            var s = document.createElement('script');
            s.src = API;
            s.async = true;
            s.onerror = function () { rechazar(new Error('sin API')); };
            document.head.appendChild(s);
            setTimeout(function () { rechazar(new Error('sin API')); }, 8000);
        });
        return apiLista;
    }

    function tiempo(s) {
        s = Math.max(0, Math.floor(s || 0));
        var m = Math.floor(s / 60), r = s % 60;
        return m + ':' + (r < 10 ? '0' : '') + r;
    }

    function reproductor(video, id) {
        var titulo = video.getAttribute('aria-label') || 'Vídeo';
        var caja = document.createElement('div');
        caja.className = (video.className + ' video-yt').trim();
        caja.setAttribute('data-estado', 'inicio');
        var boton = document.createElement('button');
        boton.type = 'button';
        boton.className = 'video-yt-boton';
        boton.setAttribute('aria-label', 'Reproducir: ' + titulo);
        if (video.poster) boton.style.backgroundImage = 'url("' + video.poster + '")';
        boton.innerHTML = '<span class="video-yt-icono" aria-hidden="true"></span>';
        boton.addEventListener('click', function () { arrancar(caja, boton, id, titulo, video.poster); });
        caja.appendChild(boton);
        video.replaceWith(caja);
    }

    function arrancar(caja, boton, id, titulo, poster) {
        var factor = Math.min(3, Math.max(2, Math.round(window.devicePixelRatio || 1)));
        var escenario = document.createElement('div');
        escenario.className = 'vgm-escenario';
        var marco = document.createElement('iframe');
        marco.src = 'https://www.youtube-nocookie.com/embed/' + id + '?autoplay=1&controls=0&rel=0&modestbranding=1&iv_load_policy=3&playsinline=1&disablekb=1&fs=0&enablejsapi=1&origin=' + encodeURIComponent(location.origin);
        marco.title = titulo;
        marco.allow = 'autoplay; encrypted-media; picture-in-picture; fullscreen';
        marco.style.width = (factor * 100) + '%';
        marco.style.transform = 'scale(' + (1 / factor) + ')';
        // Más alto que la caja y subido: la barra de título de YouTube (con el
        // canal) cae en la franja que la caja recorta, sobre la banda negra que
        // YouTube deja encima del vídeo; la imagen no pierde nada.
        function recortar() {
            var k = Math.max(0.12, 36 / Math.max(1, caja.clientHeight));
            marco.style.height = (factor * 100 * (1 + 2 * k)) + '%';
            marco.style.top = (-k * 100) + '%';
        }
        escenario.appendChild(marco);
        recortar();
        window.addEventListener('resize', recortar);

        var velo = document.createElement('div');
        velo.className = 'vgm-velo';
        if (poster) velo.style.backgroundImage = 'url("' + poster + '")';
        velo.innerHTML = '<span class="video-yt-icono vgm-icono" aria-hidden="true"></span><span class="vgm-espera" aria-hidden="true"></span>';

        var captura = document.createElement('div');
        captura.className = 'vgm-captura';

        var controles = document.createElement('div');
        controles.className = 'vgm-controles';
        controles.innerHTML =
            '<button type="button" class="vgm-play" aria-label="Pausa"></button>' +
            '<span class="vgm-tiempo">0:00 / 0:00</span>' +
            '<input type="range" class="vgm-barra" min="0" max="1000" value="0" step="1" aria-label="Posición del vídeo">' +
            '<button type="button" class="vgm-silencio" aria-label="Silenciar"></button>' +
            '<button type="button" class="vgm-pantalla" aria-label="Pantalla completa"></button>';

        caja.replaceChild(escenario, boton);
        caja.appendChild(velo);
        caja.appendChild(captura);
        caja.appendChild(controles);
        caja.tabIndex = 0;
        caja.setAttribute('data-estado', 'cargando');

        var player = null, reloj = null, arrastrando = false, silencio = false;
        var bPlay = controles.querySelector('.vgm-play'), bSil = controles.querySelector('.vgm-silencio');
        var bPant = controles.querySelector('.vgm-pantalla'), barra = controles.querySelector('.vgm-barra'), texto = controles.querySelector('.vgm-tiempo');

        function estado(e) { caja.setAttribute('data-estado', e); bPlay.setAttribute('aria-label', e === 'reproduciendo' ? 'Pausa' : 'Reproducir'); }
        function refrescar() {
            if (!player || !player.getDuration) return;
            var d = player.getDuration() || 0, t = player.getCurrentTime() || 0;
            if (!arrastrando && d) barra.value = Math.round(1000 * t / d);
            texto.textContent = tiempo(t) + ' / ' + tiempo(d);
        }
        function alternar() {
            if (!player) return;
            var s = player.getPlayerState();
            if (s === 1) player.pauseVideo();
            else { if (s === 0) player.seekTo(0, true); player.playVideo(); }
        }
        function pantallaCompleta() {
            var doc = document;
            if (doc.fullscreenElement || doc.webkitFullscreenElement) {
                (doc.exitFullscreen || doc.webkitExitFullscreen).call(doc);
            } else if (caja.requestFullscreen || caja.webkitRequestFullscreen) {
                (caja.requestFullscreen || caja.webkitRequestFullscreen).call(caja);
            } else {
                caja.classList.toggle('vgm-fijo');   // iPhone: a toda la ventana
                document.body.classList.toggle('vgm-con-fijo', caja.classList.contains('vgm-fijo'));
            }
        }

        captura.addEventListener('click', alternar);
        velo.addEventListener('click', alternar);
        bPlay.addEventListener('click', alternar);
        bSil.addEventListener('click', function () {
            if (!player) return;
            silencio = !silencio;
            if (silencio) player.mute(); else player.unMute();
            bSil.setAttribute('aria-label', silencio ? 'Con sonido' : 'Silenciar');
            caja.classList.toggle('vgm-silenciado', silencio);
        });
        bPant.addEventListener('click', pantallaCompleta);
        barra.addEventListener('input', function () {
            arrastrando = true;
            if (player && player.getDuration) texto.textContent = tiempo(barra.value / 1000 * player.getDuration()) + ' / ' + tiempo(player.getDuration());
        });
        barra.addEventListener('change', function () {
            arrastrando = false;
            if (player && player.getDuration) player.seekTo(barra.value / 1000 * player.getDuration(), true);
        });
        caja.addEventListener('keydown', function (ev) {
            if (!player || ev.target === barra) return;
            var k = ev.key;
            if (k === ' ' || k === 'k') { ev.preventDefault(); alternar(); }
            else if (k === 'ArrowRight') { ev.preventDefault(); player.seekTo(player.getCurrentTime() + 5, true); }
            else if (k === 'ArrowLeft') { ev.preventDefault(); player.seekTo(Math.max(0, player.getCurrentTime() - 5), true); }
            else if (k === 'm') { bSil.click(); }
            else if (k === 'f') { pantallaCompleta(); }
        });

        cargarApi().then(function () {
            player = new YT.Player(marco, {
                events: {
                    onReady: function () {
                        caja.vgmPlayer = player;
                        // Se pide la calidad más alta (YouTube la ajusta al tamaño del iframe, que va ampliado).
                        try { player.setPlaybackQuality('hd1080'); } catch (e) { /* nada */ }
                        refrescar();
                        reloj = setInterval(refrescar, 250);
                        // Si el navegador no deja arrancar solo (iPhone, ahorro de datos), se pide y, si no, se enseña el botón.
                        try { player.playVideo(); } catch (e) { /* nada */ }
                        setTimeout(function () { if (player.getPlayerState && player.getPlayerState() !== 1 && caja.getAttribute('data-estado') === 'cargando') estado('pausa'); }, 2500);
                    },
                    onStateChange: function (ev) {
                        var s = ev.data;
                        if (s === 1) estado('reproduciendo');
                        else if (s === 2) estado('pausa');
                        else if (s === 0) { estado('fin'); refrescar(); }
                        else if (s === 3) { if (caja.getAttribute('data-estado') !== 'reproduciendo') estado('cargando'); }
                    },
                    onError: function () { sinApi(); }
                }
            });
        }).catch(sinApi);

        // Sin la API (bloqueada o caída): el reproductor normal de YouTube, para que al menos se vea.
        function sinApi() {
            if (reloj) clearInterval(reloj);
            marco.src = 'https://www.youtube-nocookie.com/embed/' + id + '?autoplay=1&rel=0&playsinline=1';
            marco.style.width = marco.style.height = '100%';
            marco.style.transform = 'none';
            [velo, captura, controles].forEach(function (e) { if (e.parentNode) e.parentNode.removeChild(e); });
            caja.setAttribute('data-estado', 'youtube');
        }
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
