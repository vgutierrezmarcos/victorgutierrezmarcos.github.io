/**
 * Burbuja de EconomIA en la web (Víctor, 25/11/2026): como la de la app, abre la IA
 * del usuario (Claude, Le Chat, ChatGPT o Gemini) con el mensaje ya escrito, con
 * accesos según la página (en un tema: dudas, preguntas de repaso, test…). No hay
 * chat propio: lo demás lo hace el conector «Oposición TCEE · DCE» en la IA.
 *
 * - La IA elegida es de la cuenta: con sesión se lee y se guarda en
 *   users/{uid}/cuenta/app (campo «ia»), el mismo que usa la app; sin sesión, en
 *   este navegador (localStorage).
 * - Con sesión, users/{uid}/cuenta/conector dice si el conector ya se ha usado
 *   con esa IA (la marca que apunta el Worker).
 * - Solo cuenta qué acceso se usa (nunca el texto), y solo si Analytics está
 *   aceptado (gtag cargado por cookie-consent.js).
 * La carga exclusivos.js en todas las páginas (salvo la app web, que tiene la suya).
 *
 * Autor: Víctor Gutiérrez Marcos
 */
(function () {
    'use strict';
    if (window.tceeBurbuja) return;
    window.tceeBurbuja = true;

    var RAIZ = (function () {
        var s = document.currentScript && document.currentScript.getAttribute('src');
        return s ? s.replace(/economia-burbuja\.js$/, '') : '/';
    })();
    var ECONOMIA = RAIZ + 'oposicion/economia.html';
    var CONECTOR = 'Oposición TCEE · DCE';
    var IAS = {
        claude: { nombre: 'Claude', url: 'https://claude.ai/new', rellena: true, ancla: 'conector', nota: 'La más completa. Plan de pago (Pro, Max o Team).' },
        lechat: { nombre: 'Le Chat', url: 'https://chat.mistral.ai/chat', rellena: true, ancla: 'plataformas', nota: 'También con el plan gratuito.' },
        chatgpt: { nombre: 'ChatGPT', url: 'https://chatgpt.com/', rellena: true, ancla: 'plataformas', nota: 'Con los planes que admiten conectores propios.' },
        gemini: { nombre: 'Gemini', url: 'https://gemini.google.com/app', rellena: false, ancla: 'plataformas', nota: 'Solo en la web; el mensaje se copia para que lo pegues.' }
    };
    var CLAVE = 'tcee_ia';

    // ------------------------------------------------------------------ Estado

    var estado = leerLocal();
    var conectadas = {};
    function leerLocal() {
        try { return JSON.parse(localStorage.getItem(CLAVE) || 'null') || {}; } catch (e) { return {}; }
    }
    function guardar(nuevo) {
        estado = nuevo;
        try { localStorage.setItem(CLAVE, JSON.stringify(nuevo)); } catch (e) { /* bloqueado */ }
        var u = usuario();
        if (u && window.firebase && firebase.firestore) {
            try {
                firebase.firestore().collection('users').doc(u.uid).collection('cuenta').doc('app')
                    .set({ ia: { preferida: nuevo.preferida || null, aMano: !!nuevo.aMano, burbuja: nuevo.burbuja !== false } }, { merge: true })
                    .catch(function () {});
            } catch (e) { /* sin Firestore */ }
        }
        pintar();
    }
    function usuario() {
        return window.firebase && firebase.apps && firebase.apps.length && firebase.auth ? firebase.auth().currentUser : null;
    }
    function iaElegida() {
        if (estado.preferida && IAS[estado.preferida]) return estado.preferida;
        var ult = null, fecha = '';
        Object.keys(conectadas).forEach(function (k) { if (IAS[k] && conectadas[k] > fecha) { ult = k; fecha = conectadas[k]; } });
        return ult;
    }
    function conectada(ia) { return !!(ia && (conectadas[ia] || (estado.aMano && estado.preferida === ia))); }

    // Con sesión: lo que diga la cuenta (la misma que la app).
    (function escucharSesion() {
        var intentos = 0;
        (function espera() {
            if (window.firebase && firebase.apps && firebase.apps.length && firebase.auth) {
                if (!firebase.firestore) return; // página sin Firestore: se queda con lo de este navegador
                firebase.auth().onAuthStateChanged(function (u) {
                    if (!u) { conectadas = {}; pintar(); return; }
                    var cuenta = firebase.firestore().collection('users').doc(u.uid).collection('cuenta');
                    cuenta.doc('app').get().then(function (d) {
                        var ia = d.exists && d.data().ia;
                        if (ia && typeof ia === 'object') {
                            estado = { preferida: ia.preferida || estado.preferida, aMano: !!ia.aMano, burbuja: ia.burbuja !== false };
                            try { localStorage.setItem(CLAVE, JSON.stringify(estado)); } catch (e) { /* */ }
                        } else if (estado.preferida) {
                            guardar(estado); // lo elegido en este navegador pasa a la cuenta
                        }
                        pintar();
                    }).catch(function () {});
                    cuenta.doc('conector').get().then(function (d) {
                        var ias = (d.exists && d.data().ias) || {};
                        conectadas = {};
                        Object.keys(ias).forEach(function (k) { if (ias[k] && ias[k].ultimoUso) conectadas[k] = String(ias[k].ultimoUso); });
                        pintar();
                    }).catch(function () {});
                });
            } else if (intentos++ < 60) {
                setTimeout(espera, 250);
            }
        })();
    })();

    // ------------------------------------------------------------------ Accesos según la página

    function con(peticion) {
        return 'Usa el conector «' + CONECTOR + '» (EconomIA). Oposición: TCEE. ' + peticion;
    }
    function contexto() {
        var p = location.pathname;
        var tema = document.querySelector('#tema-revisado[data-tema]');
        if (tema) {
            var arch = tema.getAttribute('data-tema');
            if (arch === '1D01') {
                return { titulo: 'En la guía del dictamen', acciones: [
                    ['duda', 'Tengo una duda de la guía', con('Tengo una duda de la guía del dictamen de coyuntura. Mi duda es: ')],
                    ['dictamen', 'Ponme un dictamen de práctica', con('Ponme un dictamen de coyuntura de práctica.')],
                    ['informe_dictamen', 'Informe de evaluación de mi dictamen', con('Hazme el informe de evaluación de un dictamen que te voy a pasar.')]
                ] };
            }
            var codigo = arch.replace(/^(\d)([AB])0?(\d+)$/, '$1.$2.$3');
            var h1 = document.getElementById('tema-revisado-titulo');
            var titulo = h1 ? h1.textContent.replace(/^Tema [^:]+:\s*/, '').trim() : '';
            var t = 'tema ' + codigo + (titulo ? ' («' + titulo + '»)' : '');
            return { titulo: 'En el tema ' + codigo, acciones: [
                ['duda', 'Tengo una duda de este tema', con('Tengo una duda del ' + t + '. Mi duda es: ')],
                ['repaso', 'Hazme preguntas de repaso', con('Hazme preguntas de repaso del ' + t + ', de una en una, y corrígeme.')],
                ['test_tema', 'Hazme un test de este tema', con('Hazme un test del ' + t + ', primero con preguntas oficiales.')],
                ['tarjetas', 'Tarjetas de repaso del tema', con('Hazme tarjetas de repaso del ' + t + '.')]
            ] };
        }
        if (/\/test\//.test(p) || /simulador|probabilidad-test/.test(p)) {
            return { titulo: 'En el test', acciones: [
                ['test', 'Hazme un test de lo que más fallo', con('Mira mis últimos tests y hazme uno con lo que más fallo.')],
                ['fallos', 'Repasa conmigo los fallos', con('Repasa conmigo las preguntas que he fallado en mis últimos tests y explícame por qué.')]
            ] };
        }
        if (/primer-ejercicio/.test(p)) {
            return { titulo: 'En el primer ejercicio', acciones: [
                ['dictamen', 'Ponme un dictamen de práctica', con('Ponme un dictamen de coyuntura de práctica.')],
                ['test', 'Hazme un test', con('Hazme un test de diez preguntas oficiales de lo que llevo estudiado.')]
            ] };
        }
        if (/\/temario|temario\.html/.test(p)) {
            return { titulo: 'En el temario', acciones: [
                ['donde', '¿En qué tema se estudia…?', con('Quiero saber en qué tema se estudia lo siguiente y con qué otros temas se relaciona: ')],
                ['cronograma', 'Hazme el cronograma', con('Hazme el cronograma de estudio hasta el examen. Enséñame la propuesta antes de guardarla en la app.')]
            ] };
        }
        return { titulo: 'Tu IA', acciones: [
            ['hoy', '¿Qué me toca hoy?', con('Dime qué me toca hoy según mi cronograma y mis últimos cantes, y por dónde empezar.')],
            ['duda', 'Tengo una duda del temario', con('Tengo una duda del temario: ')],
            ['test', 'Hazme un test', con('Hazme un test de diez preguntas oficiales de lo que llevo estudiado.')]
        ] };
    }

    // ------------------------------------------------------------------ Abrir la IA

    function medir(ia, acceso) {
        if (typeof window.gtag === 'function') window.gtag('event', 'ia_burbuja_web', { ia: ia, acceso: acceso });
    }
    function abrir(ia, mensaje, acceso) {
        var d = IAS[ia];
        medir(ia, acceso);
        if (d.rellena) {
            window.open(d.url + (d.url.indexOf('?') < 0 ? '?' : '&') + 'q=' + encodeURIComponent(mensaje), '_blank', 'noopener');
            return;
        }
        var avisa = function () { aviso('Mensaje copiado: pégalo en ' + d.nombre + '.'); window.open(d.url, '_blank', 'noopener'); };
        if (navigator.clipboard && navigator.clipboard.writeText) navigator.clipboard.writeText(mensaje).then(avisa, function () { window.open(d.url, '_blank', 'noopener'); });
        else window.open(d.url, '_blank', 'noopener');
    }
    function aviso(texto) {
        var t = document.createElement('div');
        t.className = 'ia-burbuja-aviso';
        t.setAttribute('role', 'status');
        t.textContent = texto;
        document.body.appendChild(t);
        setTimeout(function () { if (t.parentNode) t.parentNode.removeChild(t); }, 4000);
    }

    // ------------------------------------------------------------------ Interfaz

    var boton, panel;
    function esc(t) { return String(t).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/"/g, '&quot;'); }

    function estilos() {
        var css = document.createElement('style');
        css.textContent =
            '.ia-burbuja{position:fixed;right:calc(1.5rem + env(safe-area-inset-right,0px));bottom:calc(1.5rem + 56px + env(safe-area-inset-bottom,0px));z-index:900;width:52px;height:52px;border-radius:50%;border:1px solid var(--color-accent-gold,#b8913a);background:#5F2987;color:#fff;display:flex;align-items:center;justify-content:center;cursor:pointer;box-shadow:0 2px 8px rgba(22,19,26,.25)}' +
            '.ia-burbuja:focus-visible{outline:2px solid var(--color-accent-gold,#b8913a);outline-offset:3px}' +
            '.ia-burbuja svg{width:24px;height:24px}' +
            '.ia-burbuja-marca{position:absolute;right:2px;top:2px;width:12px;height:12px;border-radius:50%;background:#3f8f5a;border:2px solid #fff}' +
            '.ia-panel{position:fixed;right:calc(1.5rem + env(safe-area-inset-right,0px));bottom:calc(1.5rem + 116px + env(safe-area-inset-bottom,0px));z-index:901;width:min(360px,calc(100vw - 2rem));max-height:calc(100vh - 160px);overflow:auto;background:var(--color-white,#fff);color:var(--color-text,#2b2530);border:1px solid var(--color-border,#d9d2df);border-radius:8px;box-shadow:0 8px 24px rgba(22,19,26,.18);font-family:var(--font-ui,"Source Sans 3",sans-serif);font-size:.95rem}' +
            '.ia-panel[hidden]{display:none}' +
            '.ia-panel-cab{padding:.8rem 1rem .5rem;border-bottom:1px solid var(--color-border-light,#ece7f0)}' +
            '.ia-panel-cab strong{font-family:var(--font-display,inherit);font-size:1.05rem;color:var(--color-primary,#5F2987)}' +
            '.ia-panel-cab p{margin:.15rem 0 0;font-size:.82rem;color:var(--color-text-muted,#6b6372)}' +
            '.ia-panel-cuerpo{padding:.6rem .8rem}' +
            '.ia-panel h3{margin:.3rem .2rem .4rem;font-size:.8rem;font-variant-caps:all-small-caps;letter-spacing:.05em;color:var(--color-text-muted,#6b6372)}' +
            '.ia-accion,.ia-opcion{display:block;width:100%;text-align:left;margin:0 0 .35rem;padding:.55rem .7rem;border:1px solid var(--color-border-light,#ece7f0);border-radius:6px;background:var(--color-bg-cream,#faf8f3);color:inherit;font:inherit;cursor:pointer}' +
            '.ia-accion:hover,.ia-opcion:hover{border-color:var(--color-primary,#5F2987)}' +
            '.ia-opcion small{display:block;color:var(--color-text-muted,#6b6372);font-size:.8rem}' +
            '.ia-panel-pie{display:flex;flex-wrap:wrap;gap:.3rem 1rem;padding:.5rem 1rem .8rem;border-top:1px solid var(--color-border-light,#ece7f0);font-size:.85rem}' +
            '.ia-panel-pie a,.ia-panel-pie button{color:var(--color-primary,#5F2987);background:none;border:0;padding:0;font:inherit;cursor:pointer;text-decoration:underline;text-decoration-color:var(--color-accent-gold,#b8913a)}' +
            '.ia-conectar{margin:.2rem .2rem .6rem;padding:.6rem .7rem;border-left:3px solid var(--color-accent-gold,#b8913a);background:var(--color-primary-pale,#f1eaf6);border-radius:0 6px 6px 0;font-size:.88rem}' +
            '.ia-burbuja-aviso{position:fixed;left:50%;bottom:1.5rem;transform:translateX(-50%);z-index:1200;background:#2b2530;color:#fff;padding:.6rem 1rem;border-radius:6px;font-family:var(--font-ui,sans-serif);font-size:.9rem}' +
            '@media (max-width:640px){.ia-burbuja{right:calc(1rem + env(safe-area-inset-right,0px));bottom:calc(1rem + 52px + env(safe-area-inset-bottom,0px));width:48px;height:48px}.ia-panel{right:1rem;bottom:calc(1rem + 108px + env(safe-area-inset-bottom,0px))}}' +
            // En la portada: un globo junto a la burbuja y un anillo que late, ligados a la tarjeta de EconomIA.
            '.ia-burbuja::after{content:"";position:absolute;inset:-6px;border-radius:50%;border:2px solid var(--color-accent-gold,#b8913a);opacity:0;pointer-events:none}' +
            '.ia-burbuja--llama::after{animation:ia-latido 1.6s ease-out 3}' +
            '.ia-burbuja--enlazada::after{opacity:1;animation:none}' +
            '@keyframes ia-latido{0%{opacity:.9;inset:-2px}100%{opacity:0;inset:-14px}}' +
            '.ia-burbuja-globo{position:fixed;right:calc(1.5rem + 64px + env(safe-area-inset-right,0px));bottom:calc(1.5rem + 56px + env(safe-area-inset-bottom,0px));z-index:899;max-width:min(270px,calc(100vw - 6.5rem));display:flex;align-items:flex-start;gap:.5rem;padding:.6rem .7rem .6rem .9rem;background:var(--color-white,#fff);color:var(--color-text,#2b2530);border:1px solid var(--color-border,#d9d2df);border-left:3px solid var(--color-accent-gold,#b8913a);border-radius:8px;box-shadow:0 6px 18px rgba(22,19,26,.18);font-family:var(--font-ui,"Source Sans 3",sans-serif);font-size:.9rem;line-height:1.35;cursor:pointer;opacity:0;transition:opacity .35s ease}' +
            '.ia-burbuja-globo.visible{opacity:1}' +
            '.ia-burbuja-globo strong{color:var(--color-primary,#5F2987);font-family:var(--font-display,inherit)}' +
            '.ia-burbuja-globo button{flex:none;background:none;border:0;padding:0 .1rem;font:inherit;font-size:1.1rem;line-height:1;color:var(--color-text-muted,#6b6372);cursor:pointer}' +
            '.ia-burbuja-globo::after{content:"";position:absolute;right:-7px;bottom:18px;width:12px;height:12px;background:var(--color-white,#fff);border-right:1px solid var(--color-border,#d9d2df);border-top:1px solid var(--color-border,#d9d2df);transform:rotate(45deg)}' +
            '@media (max-width:640px){.ia-burbuja-globo{max-width:calc(100vw - 9rem);right:calc(1rem + 58px + env(safe-area-inset-right,0px));bottom:calc(1rem + 52px + env(safe-area-inset-bottom,0px))}}' +
            '@media (prefers-reduced-motion:reduce){.ia-burbuja--llama::after{animation:none;opacity:1}.ia-burbuja-globo{transition:none}}' +
            '@media print{.ia-burbuja,.ia-panel,.ia-burbuja-globo{display:none}}';
        document.head.appendChild(css);
    }

    function crear() {
        estilos();
        boton = document.createElement('button');
        boton.type = 'button';
        boton.className = 'ia-burbuja';
        boton.setAttribute('aria-haspopup', 'dialog');
        boton.setAttribute('aria-expanded', 'false');
        boton.innerHTML = '<svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" aria-hidden="true"><path d="M12 3l1.8 4.7L18.5 9.5l-4.7 1.8L12 16l-1.8-4.7L5.5 9.5l4.7-1.8z"/><path d="M18 15l.8 2.2 2.2.8-2.2.8L18 21l-.8-2.2-2.2-.8 2.2-.8z"/></svg>';
        panel = document.createElement('div');
        panel.className = 'ia-panel';
        panel.setAttribute('role', 'dialog');
        panel.setAttribute('aria-label', 'EconomIA: abre tu IA con el mensaje ya escrito');
        panel.hidden = true;
        boton.addEventListener('click', function () { panel.hidden ? mostrar() : ocultar(); });
        document.addEventListener('keydown', function (e) { if (e.key === 'Escape' && !panel.hidden) { ocultar(); boton.focus(); } });
        document.addEventListener('click', function (e) { if (!panel.hidden && !panel.contains(e.target) && !boton.contains(e.target)) ocultar(); });
        document.body.appendChild(panel);
        document.body.appendChild(boton);
        pintar();
    }
    function mostrar() { quitarGlobo(true); pintarPanel(); panel.hidden = false; boton.setAttribute('aria-expanded', 'true'); var f = panel.querySelector('button, a'); if (f) f.focus(); }
    function ocultar() { panel.hidden = true; boton.setAttribute('aria-expanded', 'false'); }

    function pintar() {
        if (!boton) return;
        boton.hidden = estado.burbuja === false;
        var ia = iaElegida();
        boton.setAttribute('aria-label', ia ? 'EconomIA: abrir ' + IAS[ia].nombre : 'EconomIA: elige tu IA');
        boton.title = boton.getAttribute('aria-label');
        var marca = boton.querySelector('.ia-burbuja-marca');
        if (conectada(ia) && !marca) { marca = document.createElement('span'); marca.className = 'ia-burbuja-marca'; marca.setAttribute('aria-hidden', 'true'); boton.appendChild(marca); }
        if (!conectada(ia) && marca) marca.parentNode.removeChild(marca);
        if (!panel.hidden) pintarPanel();
    }

    function pintarPanel() {
        var ia = iaElegida();
        var cab = '<div class="ia-panel-cab"><strong>EconomIA</strong><p>Tu IA como equipo de preparación, con el temario y tus datos de la app. Complementa a tu preparador.</p></div>';
        if (!ia || estado.cambiando) {
            panel.innerHTML = cab + '<div class="ia-panel-cuerpo"><h3>¿Qué IA usas?</h3>' +
                Object.keys(IAS).map(function (k) { return '<button type="button" class="ia-opcion" data-ia="' + k + '">' + esc(IAS[k].nombre) + '<small>' + esc(IAS[k].nota) + '</small></button>'; }).join('') +
                '</div><div class="ia-panel-pie"><a href="' + ECONOMIA + '">Qué es EconomIA</a><button type="button" data-ocultar>Ocultar la burbuja</button></div>';
        } else {
            var c = contexto();
            var conectar = conectada(ia) ? '' :
                '<div class="ia-conectar">Para que ' + esc(IAS[ia].nombre) + ' use el temario y tus datos, añade el conector una vez: <a href="' + ECONOMIA + '#' + IAS[ia].ancla + '">cómo se conecta</a> (1 minuto). <button type="button" class="ia-ya" data-ya style="background:none;border:0;padding:0;color:inherit;text-decoration:underline;cursor:pointer;font:inherit">Ya lo he conectado</button></div>';
            panel.innerHTML = cab + '<div class="ia-panel-cuerpo">' + conectar + '<h3>' + esc(c.titulo) + '</h3>' +
                c.acciones.map(function (a, i) { return '<button type="button" class="ia-accion" data-accion="' + i + '">' + esc(a[1]) + '</button>'; }).join('') +
                '<button type="button" class="ia-accion" data-libre>Abrir ' + esc(IAS[ia].nombre) + ' sin más</button>' +
                '</div><div class="ia-panel-pie"><button type="button" data-cambiar>Cambiar de IA (' + esc(IAS[ia].nombre) + ')</button><a href="' + ECONOMIA + '">Qué es EconomIA</a><button type="button" data-ocultar>Ocultar la burbuja</button></div>';
            Array.prototype.forEach.call(panel.querySelectorAll('[data-accion]'), function (b) {
                b.addEventListener('click', function () { var a = c.acciones[+b.getAttribute('data-accion')]; abrir(ia, a[2], a[0]); ocultar(); });
            });
            var libre = panel.querySelector('[data-libre]');
            libre.addEventListener('click', function () { abrir(ia, con('Mira cómo voy y pregúntame qué quiero hacer hoy.'), 'libre'); ocultar(); });
        }
        Array.prototype.forEach.call(panel.querySelectorAll('[data-ia]'), function (b) {
            b.addEventListener('click', function () {
                var nueva = b.getAttribute('data-ia');
                guardar({ preferida: nueva, aMano: nueva === estado.preferida && estado.aMano, burbuja: true });
                estado.cambiando = false;
                pintarPanel();
            });
        });
        var cambiar = panel.querySelector('[data-cambiar]');
        if (cambiar) cambiar.addEventListener('click', function () { estado.cambiando = true; pintarPanel(); });
        var ya = panel.querySelector('[data-ya]');
        if (ya) ya.addEventListener('click', function () { guardar({ preferida: ia, aMano: true, burbuja: true }); });
        var ocu = panel.querySelector('[data-ocultar]');
        if (ocu) ocu.addEventListener('click', function () {
            guardar({ preferida: estado.preferida, aMano: estado.aMano, burbuja: false });
            ocultar();
            aviso('Burbuja oculta. Puedes volver a mostrarla en la página de EconomIA.');
        });
    }

    // ------------------------------------------------------------------ Portada: la tarjeta de EconomIA y la burbuja, enlazadas

    var globo = null, GLOBO = 'tcee_ia_globo';
    function quitarGlobo(recordar) {
        if (recordar) { try { localStorage.setItem(GLOBO, '1'); } catch (e) { /* */ } }
        if (globo && globo.parentNode) globo.parentNode.removeChild(globo);
        globo = null;
    }
    function latir() {
        if (!boton) return;
        boton.classList.remove('ia-burbuja--llama');
        void boton.offsetWidth; // reinicia la animación
        boton.classList.add('ia-burbuja--llama');
    }
    function portada() {
        var tarjeta = document.getElementById('economia-portada');
        if (!tarjeta || !boton) return;
        // «Probar ahora» abre la burbuja (si está oculta, el enlace lleva a la página de EconomIA).
        Array.prototype.forEach.call(tarjeta.querySelectorAll('[data-abrir-burbuja]'), function (a) {
            a.addEventListener('click', function (e) {
                if (boton.hidden) return;
                e.preventDefault();
                e.stopPropagation();
                medir(iaElegida() || 'ninguna', 'portada_probar');
                mostrar();
            });
        });
        // Al pasar por la tarjeta, la burbuja se enciende: se ve que es lo mismo.
        tarjeta.addEventListener('mouseenter', function () { boton.classList.add('ia-burbuja--enlazada'); });
        tarjeta.addEventListener('mouseleave', function () { boton.classList.remove('ia-burbuja--enlazada'); });
        // Late al cargar y cada vez que la tarjeta entra en pantalla.
        latir();
        if ('IntersectionObserver' in window) {
            new IntersectionObserver(function (es) { es.forEach(function (e) { if (e.isIntersecting) latir(); }); }, { threshold: 0.6 }).observe(tarjeta);
        }
        // Un globo junto a la burbuja, desde arriba de la página, hasta que se abra o se cierre una vez.
        var visto = false;
        try { visto = localStorage.getItem(GLOBO) === '1'; } catch (e) { /* */ }
        if (visto || boton.hidden) return;
        setTimeout(function () {
            if (!panel.hidden || boton.hidden) return;
            globo = document.createElement('div');
            globo.className = 'ia-burbuja-globo';
            globo.setAttribute('role', 'note');
            globo.innerHTML = '<span><strong>EconomIA</strong> · Pregunta a tu IA con tus datos de la app: dudas, test, tu cronograma…</span><button type="button" aria-label="Cerrar">×</button>';
            globo.querySelector('button').addEventListener('click', function (e) { e.stopPropagation(); quitarGlobo(true); });
            globo.addEventListener('click', function (e) { e.stopPropagation(); mostrar(); });
            document.body.appendChild(globo);
            requestAnimationFrame(function () { if (globo) globo.classList.add('visible'); });
        }, 1200);
    }

    // En la página de EconomIA, si está oculta, un enlace para volver a mostrarla.
    function enlaceMostrar() {
        if (!/\/oposicion\/economia\.html$/.test(location.pathname) || estado.burbuja !== false) return;
        var p = document.createElement('p');
        p.className = 'app-nota';
        p.innerHTML = 'Tienes oculta la burbuja de EconomIA en esta web. <button type="button" class="boton boton--texto">Volver a mostrarla</button>';
        p.querySelector('button').addEventListener('click', function () { guardar({ preferida: estado.preferida, aMano: estado.aMano, burbuja: true }); p.parentNode.removeChild(p); });
        var main = document.querySelector('main');
        if (main) main.insertBefore(p, main.firstChild);
    }

    if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', function () { crear(); enlaceMostrar(); portada(); });
    else { crear(); enlaceMostrar(); portada(); }
})();
