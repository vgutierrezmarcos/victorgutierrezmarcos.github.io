/**
 * Materiales exclusivos (desde el 1 de octubre de 2026): lee
 * /oposicion/exclusivos.json (lo genera scripts/exclusivos.py; nada se marca a
 * mano en las páginas) y:
 *   - pone la etiqueta «Exclusivo» junto a cada enlace a un fichero exclusivo
 *     de la web y, debajo de su tarjeta, la llamada a la app;
 *   - rellena la sección «Materiales exclusivos» (#exclusivos-lista) del
 *     temario y la frase de la portada (#exclusivos-portada);
 *   - rellena el botón de descarga de la skill de Claude («EconomIA»)
 *     (#descargar-skill): con sesión iniciada apunta al ZIP; sin sesión, pide
 *     iniciarla o manda a la app;
 *   - con el interruptor TEMAS_EN_WEB (scripts/temas-web-visible.py), abre los
 *     temas revisados con sesión y, sin ella, pide iniciarla o seguir con el
 *     tema antiguo (oposicion/temario/tema-revisado.html).
 * Sin el JSON (sin red, fichero ausente), la página se queda como está.
 */
(function () {
    'use strict';
    var RAIZ = (function () {
        var s = document.currentScript && document.currentScript.getAttribute('src');
        return s ? s.replace(/exclusivos\.js$/, '') : '';
    })();
    var APP = RAIZ + 'app/';
    var CONDICIONES = RAIZ + 'condiciones-materiales.html';

    function etiqueta() {
        var e = document.createElement('span');
        e.className = 'etiqueta-exclusivo';
        e.textContent = 'Exclusivo';
        e.title = 'Material exclusivo de esta web y de la app, para tu estudio personal';
        return e;
    }

    function llamada(texto) {
        var p = document.createElement('p');
        p.className = 'exclusivo-cta';
        p.innerHTML = (texto || 'Apuntes exclusivos: ') + '<a href="' + APP + '">llévalos siempre contigo en la app</a>.';
        return p;
    }

    function marcarEnlaces(datos) {
        var rutas = {};
        datos.materiales.forEach(function (m) { if (m.donde === 'web' && m.ruta) rutas['/' + m.ruta] = m; });
        var tarjetas = [];
        Array.prototype.forEach.call(document.querySelectorAll('a[href]'), function (a) {
            var ruta;
            try { ruta = new URL(a.getAttribute('href'), location.href).pathname; } catch (e) { return; }
            if (!rutas[ruta] || a.closest('.exclusivos-lista') || a.querySelector('.etiqueta-exclusivo') || (a.nextSibling && a.nextSibling.className === 'etiqueta-exclusivo')) return;
            var titulo = a.querySelector('.tema-card-title');
            if (titulo) titulo.appendChild(document.createTextNode(' ')), titulo.appendChild(etiqueta());
            else a.parentNode.insertBefore(etiqueta(), a.nextSibling), a.parentNode.insertBefore(document.createTextNode(' '), a.nextSibling);
            var tarjeta = a.closest('.tema-card') || a.closest('p') || a.parentNode;
            if (tarjetas.indexOf(tarjeta) === -1) tarjetas.push(tarjeta);
        });
        tarjetas.forEach(function (t) {
            if (t.querySelector('.exclusivo-cta')) return;
            var cta = llamada();
            if (t.classList.contains('tema-card')) t.appendChild(cta); else t.parentNode.insertBefore(cta, t.nextSibling);
        });
    }

    function fecha(iso) {
        if (!iso) return '';
        var m = ['ene.', 'feb.', 'mar.', 'abr.', 'may.', 'jun.', 'jul.', 'ago.', 'sept.', 'oct.', 'nov.', 'dic.'];
        var p = iso.split('-');
        return parseInt(p[2], 10) + ' ' + m[parseInt(p[1], 10) - 1] + ' ' + p[0];
    }

    function formatos(f) {
        var n = { pdf: 'PDF', html: 'página web', docx: 'Word', repaso: 'ficha de repaso', app: 'en la app', zip: 'skill para Claude.ai (ZIP)' };
        return (f || []).map(function (x) { return n[x] || x; }).join(', ');
    }

    function lista(datos) {
        var cont = document.getElementById('exclusivos-lista');
        if (!cont) return;
        // Desplegable cerrado al final de /oposicion/temario.html: si se llega con #materiales-exclusivos, abierto.
        var caja = document.getElementById('materiales-exclusivos');
        if (caja && caja.tagName === 'DETAILS' && location.hash === '#materiales-exclusivos') caja.open = true;
        var app = datos.materiales.filter(function (m) { return m.donde === 'app' && !m.oculto; });
        var web = datos.materiales.filter(function (m) { return m.donde === 'web' && !m.oculto; });
        function grupo(titulo, items, nota) {
            if (!items.length) return;
            var h = document.createElement('h3');
            h.textContent = titulo;
            cont.appendChild(h);
            if (nota) { var p = document.createElement('p'); p.className = 'exclusivos-nota'; p.textContent = nota; cont.appendChild(p); }
            var ul = document.createElement('ul');
            items.forEach(function (m) {
                var li = document.createElement('li');
                if ((m.tipo === 'tema' || m.tipo === 'guia') && m.donde === 'app' && m.codigo) li.setAttribute('data-revisado', m.codigo);
                var t = m.codigo && m.tipo === 'tema' ? '<strong>' + m.codigo + '</strong> <span class="exclusivos-nombre">' + m.titulo.replace(/\.$/, '') + '</span>' : m.titulo;
                var revisado = m.tipo === 'tema' || m.tipo === 'guia';
                // En los temas y la guía los formatos son siempre los mismos: solo la fecha.
                var det = revisado ? '' : [formatos(m.formatos), m.fecha ? (revisado ? 'Revisado el ' : 'publicado el ') + fecha(m.fecha || m.revisado) : ''].filter(Boolean).join(' · ');
                if (m.tipo === 'skill') t = '<a href="' + RAIZ + 'oposicion/economia.html">' + m.titulo + '</a>';
                li.innerHTML = (m.ruta ? '<a href="' + RAIZ + m.ruta + '" target="_blank">' + t + '</a>' : t) + (det ? '<span class="exclusivos-detalle">' + det + '</span>' : '');
                ul.appendChild(li);
            });
            cont.appendChild(ul);
        }
        grupo('Con tu cuenta de Google, aquí y en la app', app, '');
        grupo('También en la web', web, 'Con el aviso de uso personal en la portada y en cada página.');
    }

    function portada(datos) {
        var e = document.getElementById('exclusivos-portada');
        if (!e) return;
        var temas = datos.materiales.filter(function (m) { return m.tipo === 'tema'; }).length;
        var guias = datos.materiales.filter(function (m) { return m.tipo === 'guia'; }).length;
        var partes = [];
        if (temas) partes.push(temas + ' temas revisados a fondo');
        if (guias) partes.push(guias === 1 ? 'la guía del dictamen' : guias + ' guías');
        if (datos.materiales.some(function (m) { return m.tipo === 'test'; })) partes.push('las explicaciones de las 1004 preguntas del test');
        e.innerHTML = '<span class="etiqueta-exclusivo">Exclusivo</span> Materiales que solo están en la app: ' + partes.join(', ') + '. Para tu estudio personal (<a href="' + CONDICIONES + '">condiciones</a>).';
        e.hidden = false;
    }

    // ---- Temas revisados en la web, con sesión (Víctor, 24/11/2026) ----
    // Al abrir un tema que tiene versión revisada (en el manifiesto de la rama
    // temario-publicado, el mismo que lee la app):
    //   - con sesión, se abre directamente la versión revisada (página
    //     oposicion/temario/tema-revisado.html, con todos sus formatos y la
    //     versión anterior);
    //   - sin sesión, un aviso: «Inicia sesión para ver el tema nuevo» y, si el
    //     tema tenía versión antigua, «Seguir con el tema antiguo».
    // Vale para los enlaces de todas las páginas (lista del temario, buscador,
    // tarjetas) y para tema-no-disponible.html. Los PDF antiguos abiertos por su
    // URL directa no pasan por aquí (son ficheros estáticos).
    // Interruptor (scripts/temas-web-visible.py --mostrar | --ocultar): con false,
    // todo sigue como antes y los temas revisados solo se leen en la app.
    var TEMAS_EN_WEB = true;
    // Los temas revisados no están en ningún sitio público (Víctor, 26/11/2026): los sirve el
    // conector (mcp/worker/src/temarioPrivado.ts) desde su almacén privado, a quien ha iniciado
    // sesión con Google. El manifiesto (títulos y tamaños, sin contenido) es público; los ficheros
    // salen de una dirección firmada que caduca (acceso()). La URL de siempre de cada PDF
    // (tercer-ejercicio/3A08.pdf) ya no existe: 404.html lleva a la página del tema.
    var SERVIDOR = 'https://mcp.victorgutierrezmarcos.es';
    var MANIFIESTO = SERVIDOR + '/temario/manifiesto';
    var PAGINA_TEMA = RAIZ + 'oposicion/temario/tema-revisado.html';
    // La versión antigua de cada tema sigue en la web: tercer-ejercicio/anterior/3A08.pdf (la guía del dictamen, igual).
    var GUIA_WEB = 'oposicion/temario/primer-ejercicio/esquema_dictamen_economico.pdf';
    var GUIA_ANTIGUA = RAIZ + 'oposicion/temario/primer-ejercicio/anterior/esquema_dictamen_economico.pdf';
    var accesoGuardado = null;
    /** Base firmada del almacén privado (…/t/<caducidad>.<firma>/), con la sesión de Firebase. */
    function acceso() {
        var ahora = Date.now() / 1000;
        if (!accesoGuardado) {
            try {
                var g = JSON.parse(sessionStorage.getItem('tcee_acceso') || 'null');
                if (g && g.expira - 300 > ahora && g.base) accesoGuardado = Promise.resolve(g);
            } catch (e) { /* sin almacenamiento */ }
        }
        if (accesoGuardado) {
            return accesoGuardado.then(function (g) {
                if (g && g.expira - 300 > Date.now() / 1000) return g.base;
                accesoGuardado = null;
                return acceso();
            });
        }
        var u = usuario();
        if (!u) return Promise.reject(new Error('sin sesión'));
        accesoGuardado = u.getIdToken().then(function (token) {
            return fetch(SERVIDOR + '/temario/acceso', { headers: { Authorization: 'Bearer ' + token } });
        }).then(function (r) {
            if (!r.ok) throw new Error('acceso ' + r.status);
            return r.json();
        }).then(function (g) {
            try { sessionStorage.setItem('tcee_acceso', JSON.stringify(g)); } catch (e) { /* lleno o bloqueado */ }
            return g;
        });
        accesoGuardado.catch(function () { accesoGuardado = null; });
        return accesoGuardado.then(function (g) { return g.base; });
    }
    /** …/tercer-ejercicio/3A08.pdf → …/tercer-ejercicio/anterior/3A08.pdf (ya en anterior/, igual). */
    function aAnterior(url) {
        if (!url || /\/anterior\//.test(url)) return url;
        return url.replace(/\/(tercer-ejercicio\/3[AB]\d\d|primer-ejercicio\/esquema_dictamen_economico)\.pdf$/, function (_, r) {
            return '/' + r.replace(/\/([^/]+)$/, '/anterior/$1') + '.pdf';
        });
    }
    var manifiesto = null;
    function leerManifiesto() {
        if (!manifiesto) {
            // Diez minutos en sessionStorage: no se pide a GitHub en cada página.
            try {
                var guardado = JSON.parse(sessionStorage.getItem('tcee_revisados2') || 'null');
                if (guardado && Date.now() - guardado.t < 600000 && guardado.m) manifiesto = Promise.resolve(guardado.m);
            } catch (e) { /* sin almacenamiento */ }
        }
        if (!manifiesto) {
            manifiesto = fetch(MANIFIESTO)
                .then(function (r) { return r.ok ? r.json() : null; })
                .then(function (m) {
                    if (m && m.temas) { try { sessionStorage.setItem('tcee_revisados2', JSON.stringify({ t: Date.now(), m: m })); } catch (e) { /* lleno o bloqueado */ } }
                    else manifiesto = null;
                    return m;
                })
                .catch(function () { manifiesto = null; return null; });
        }
        return manifiesto;
    }
    var manifiestoListo = null; // el manifiesto ya leído (para decidir dentro del clic)

    /** «3.A.8» → «3A08»; «3A08» y «1D01» se quedan; null si no es un código. */
    function archivoDe(codigo) {
        if (!codigo) return null;
        codigo = String(codigo).trim();
        if (/^(3[AB]\d\d|1D01)$/.test(codigo)) return codigo;
        if (codigo === 'Dictamen') return '1D01';
        var m = codigo.match(/^(\d)\.([A-Z])\.(\d{1,2})$/);
        return m ? m[1] + m[2] + (m[3].length === 1 ? '0' : '') + m[3] : null;
    }

    /** La entrada del manifiesto para un archivo (3A08 o 1D01), con su tipo. */
    function revisadoDe(m, archivo) {
        if (!m || !archivo) return null;
        if (archivo === '1D01') return m.dictamen && m.dictamen.html ? { t: m.dictamen, guia: true } : null;
        for (var i = 0; i < (m.temas || []).length; i++) {
            if (m.temas[i].archivo === archivo && m.temas[i].html) return { t: m.temas[i], guia: false };
        }
        return null;
    }

    function urlTema(archivo) { return PAGINA_TEMA + '?tema=' + encodeURIComponent(archivo); }
    /** La página web de un tema revisado, junto a su PDF: …/tercer-ejercicio/3A14.html (la guía, …/esquema_dictamen_economico.html). */
    function paginaWeb(archivo) {
        return archivo === '1D01' ? RAIZ + GUIA_WEB.replace(/\.pdf$/, '.html') : RAIZ + 'oposicion/temario/tercer-ejercicio/' + archivo + '.html';
    }
    /** Lo que abre un tema revisado con sesión: su página web (con la burbuja de EconomIA). */
    function destinoRevisado(rev) {
        return paginaWeb(rev.t.archivo || archivoDe(rev.t.codigo));
    }
    /** El Word nuevo, del almacén privado (con sesión); si no se puede, la página del tema. */
    function abrirWord(rev) {
        if (!rev.t.docx || !rev.t.docx.ruta) { location.href = destinoRevisado(rev); return; }
        acceso().then(function (base) { location.href = base + rev.t.docx.ruta; })
            .catch(function () { location.href = destinoRevisado(rev); });
    }

    /** El tema al que lleva un enlace (su archivo), o null. */
    function temaDelEnlace(a) {
        if (a.hasAttribute('data-tema')) return archivoDe(a.getAttribute('data-tema'));
        var u;
        try { u = new URL(a.getAttribute('href'), location.href); } catch (e) { return null; }
        if (u.origin !== location.origin) return null;
        var p = u.pathname, m = p.match(/\/temario\/tercer-ejercicio\/(3[AB]\d\d)\.(?:pdf|docx)$/);
        if (m) return m[1];
        if (/\/tema-no-disponible\.html$/.test(p)) return archivoDe(u.searchParams.get('tema'));
        if (/\/temario\/primer-ejercicio\/esquema_dictamen_economico\.pdf$/.test(p)) return '1D01';
        return null;
    }

    /** La versión antigua que abre el enlace (no la hay si lleva a «no disponible»). */
    function antiguoDelEnlace(a) {
        var href = a.getAttribute('href') || '';
        if (!href || href === '#' || /tema-no-disponible\.html/.test(href)) return null;
        return /\.docx$/.test(a.href) ? a.href : aAnterior(a.href);
    }

    // Sesión de Firebase: auth.js lo carga después de este script.
    var sesionResuelta = false;
    var oyentesSesion = [];
    function alCambiarSesion(fn) {
        oyentesSesion.push(fn);
        if (sesionResuelta) { fn(usuario()); return; }
        if (oyentesSesion.length > 1) return;
        var intentos = 0;
        (function espera() {
            if (window.firebase && firebase.apps && firebase.apps.length && firebase.auth) {
                var porTiempo = false;
                firebase.auth().onAuthStateChanged(function (u) {
                    // Tras el plazo de abajo ya se pintó «sin sesión»: no se repite.
                    if (porTiempo && !u) { porTiempo = false; return; }
                    porTiempo = false;
                    sesionResuelta = true;
                    oyentesSesion.forEach(function (f) { f(u); });
                });
                // Si el navegador bloquea el almacenamiento de Firebase (prevención de
                // seguimiento estricta de Edge, por ejemplo), onAuthStateChanged puede no
                // llegar nunca: a los 6 s se trata como sin sesión (si llega luego, se repinta).
                setTimeout(function () {
                    if (sesionResuelta) return;
                    sesionResuelta = true;
                    porTiempo = true;
                    oyentesSesion.forEach(function (f) { f(usuario()); });
                }, 6000);
            } else if (intentos++ < 100) {
                setTimeout(espera, 150);
            } else {
                sesionResuelta = true;
                oyentesSesion.forEach(function (f) { f(null); });
            }
        })();
    }
    function usuario() {
        return window.firebase && firebase.apps && firebase.apps.length ? firebase.auth().currentUser : null;
    }

    function iniciarSesion() {
        var proveedor = new firebase.auth.GoogleAuthProvider();
        return firebase.auth().signInWithPopup(proveedor);
    }

    function fechaCorta(iso) {
        var p = (iso || '').split('-');
        return p.length === 3 ? p[2] + '/' + p[1] + '/' + p[0] : '';
    }

    /**
     * Aviso para entrar con Google. [datos]: {archivo, guia, titulo, fecha,
     * antiguo (URL o null), destino (target del enlace antiguo), alEntrar}.
     */
    function avisoSesion(datos) {
        var previo = document.getElementById('aviso-revisado');
        if (previo) previo.parentNode.removeChild(previo);
        var foco = document.activeElement;
        var fondo = document.createElement('div');
        fondo.id = 'aviso-revisado';
        fondo.className = 'aviso-revisado';
        var caja = document.createElement('div');
        caja.className = 'aviso-revisado-caja';
        caja.setAttribute('role', 'dialog');
        caja.setAttribute('aria-modal', 'true');
        caja.setAttribute('aria-labelledby', 'aviso-revisado-titulo');
        var nombre = datos.guia ? 'La guía del dictamen' : 'El tema ' + (datos.codigo || '');
        var nuevo = datos.guia ? 'la guía nueva' : 'el tema nuevo';
        caja.innerHTML =
            '<p class="aviso-revisado-etiqueta"><span class="etiqueta-exclusivo">Exclusivo</span>' + (datos.fecha ? ' ' + fechaCorta(datos.fecha) : '') + '</p>' +
            '<h2 id="aviso-revisado-titulo">Inicia sesión para ver ' + nuevo + '</h2>' +
            '<p>' + nombre + ' tiene versión nueva: datos al día, gráficos nuevos y ' + (datos.guia ? 'resumen' : 'ficha') + ' de repaso. ' +
            'Se lee con tu cuenta de Google y es para tu estudio personal (<a href="' + CONDICIONES + '">condiciones</a>).</p>' +
            '<div class="botones aviso-revisado-botones"></div>' +
            '<p class="aviso-revisado-error" role="alert" hidden></p>';
        var botones = caja.querySelector('.aviso-revisado-botones');
        var error = caja.querySelector('.aviso-revisado-error');

        var entrar = document.createElement('button');
        entrar.type = 'button';
        entrar.className = 'boton';
        entrar.textContent = 'Iniciar sesión con Google';
        botones.appendChild(entrar);
        if (datos.antiguo) {
            var antiguo = document.createElement('a');
            antiguo.className = 'boton boton--secundario';
            antiguo.href = datos.antiguo;
            if (datos.destino) { antiguo.target = datos.destino; antiguo.rel = 'noopener'; }
            antiguo.textContent = 'Seguir con la versión anterior';
            antiguo.addEventListener('click', function () { cerrar(); });
            botones.appendChild(antiguo);
        }
        var cerrarBoton = document.createElement('button');
        cerrarBoton.type = 'button';
        cerrarBoton.className = 'boton boton--texto';
        cerrarBoton.textContent = 'Cerrar';
        botones.appendChild(cerrarBoton);

        function cerrar() {
            document.removeEventListener('keydown', tecla, true);
            if (fondo.parentNode) fondo.parentNode.removeChild(fondo);
            if (foco && foco.focus) foco.focus();
        }
        function tecla(e) {
            if (e.key === 'Escape') { e.preventDefault(); cerrar(); }
            if (e.key === 'Tab') { // el foco no sale del aviso
                var f = caja.querySelectorAll('a[href], button:not([disabled])');
                if (!f.length) return;
                if (e.shiftKey && document.activeElement === f[0]) { e.preventDefault(); f[f.length - 1].focus(); }
                else if (!e.shiftKey && document.activeElement === f[f.length - 1]) { e.preventDefault(); f[0].focus(); }
            }
        }
        cerrarBoton.addEventListener('click', cerrar);
        fondo.addEventListener('click', function (e) { if (e.target === fondo) cerrar(); });
        document.addEventListener('keydown', tecla, true);
        entrar.addEventListener('click', function () {
            if (!window.firebase || !firebase.apps || !firebase.apps.length) { error.textContent = 'No se ha podido cargar el inicio de sesión. Recarga la página.'; error.hidden = false; return; }
            entrar.disabled = true;
            entrar.textContent = 'Entrando…';
            iniciarSesion().then(function () {
                cerrar();
                if (datos.alEntrar) datos.alEntrar(); else location.href = urlTema(datos.archivo);
            }).catch(function (e) {
                entrar.disabled = false;
                entrar.textContent = 'Iniciar sesión con Google';
                if (e && (e.code === 'auth/popup-closed-by-user' || e.code === 'auth/cancelled-popup-request')) return;
                error.textContent = 'No se ha podido iniciar sesión' + (e && e.message ? ': ' + e.message : '.');
                error.hidden = false;
            });
        });

        fondo.appendChild(caja);
        document.body.appendChild(fondo);
        entrar.focus();
        return cerrar;
    }

    /**
     * Abre un tema revisado desde un enlace: con sesión, la versión revisada;
     * sin ella, el aviso. true si se encarga (y el enlace no debe seguir).
     * Lo usa también el buscador (search-ui.js) al pulsar Intro.
     */
    function abrirDesdeEnlace(a, evento) {
        if (!TEMAS_EN_WEB || !manifiestoListo) return false;
        var archivo = temaDelEnlace(a);
        var rev = revisadoDe(manifiestoListo, archivo);
        if (!rev) return false;
        if (evento) { evento.preventDefault(); evento.stopPropagation(); }
        var nueva = a.target === '_blank' || (evento && (evento.ctrlKey || evento.metaKey || evento.shiftKey || evento.button === 1));
        var word = /\.docx(?:$|[?#])/.test(a.getAttribute('href') || '');
        var destino = destinoRevisado(rev);
        function abrir() {
            if (usuario()) {
                if (word) abrirWord(rev);
                else if (nueva && sesionResuelta) window.open(destino, '_blank', 'noopener');
                else location.href = destino;
            } else {
                avisoSesion({ archivo: archivo, guia: rev.guia, codigo: rev.t.codigo, fecha: rev.t.aprobado || rev.t.fecha, antiguo: antiguoDelEnlace(a), destino: a.target || '',
                              alEntrar: function () { if (word) abrirWord(rev); else if (!nueva) location.href = destino; else window.open(destino, '_blank', 'noopener'); } });
            }
        }
        // Si viene del buscador, se cierra (el aviso va encima de la página).
        var cerrarBuscador = a.closest('.search-overlay') && a.closest('.search-overlay').querySelector('.search-close');
        if (cerrarBuscador) cerrarBuscador.click();
        if (sesionResuelta) abrir(); else alCambiarSesion(function () { if (abrir) { var f = abrir; abrir = null; f(); } });
        return true;
    }
    window.tceeTemasRevisados = { abrir: function (a) { return abrirDesdeEnlace(a, null); }, acceso: acceso };

    function interceptarEnlaces() {
        if (!TEMAS_EN_WEB) return;
        leerManifiesto().then(function (m) { if (m && m.temas) manifiestoListo = m; });
        alCambiarSesion(function () {});
        // En la fase de captura: antes que el onclick del buscador («no disponible»).
        document.addEventListener('click', function (e) {
            if (e.defaultPrevented) return;
            var a = e.target && e.target.closest ? e.target.closest('a[href]') : null;
            if (!a || a.closest('#aviso-revisado') || a.closest('.tema-revisado-barra')) return;
            abrirDesdeEnlace(a, e);
        }, true);
        // tema-no-disponible.html?tema=… de un tema que ya tiene versión revisada.
        if (/\/tema-no-disponible\.html$/.test(location.pathname)) {
            var archivo = archivoDe(new URLSearchParams(location.search).get('tema'));
            if (archivo) leerManifiesto().then(function (m) { var r = revisadoDe(m, archivo); if (r) { manifiestoListo = m; location.replace(destinoRevisado(r)); } });
        }
    }

    /** La versión antigua de un tema en la web (temario.json), o null. */
    function antiguoDe(archivo) {
        if (archivo === '1D01') return Promise.resolve(GUIA_ANTIGUA);
        return fetch(RAIZ + 'oposicion/temario/temario.json')
            .then(function (r) { return r.ok ? r.json() : null; })
            .then(function (d) {
                var url = null;
                ((d && d.ejercicios) || []).forEach(function (ej) {
                    (ej.partes || []).forEach(function (p) {
                        (p.temas || []).forEach(function (t) {
                            if (archivoDe(t.codigo) === archivo && t.disponible && t.url && /\.pdf$/.test(t.url)) url = aAnterior(t.url).replace(/^https:\/\/www\.victorgutierrezmarcos\.es\//, RAIZ.replace(/\/?$/, '/'));
                        });
                    });
                });
                return url;
            })
            .catch(function () { return null; });
    }

    /**
     * El HTML del tema revisado, para leerlo dentro de la página (en un iframe):
     * fuera la cabecera, los menús, las migas, el pie y los scripts del sitio
     * (los pone la página que lo envuelve); se quedan el índice, las fórmulas,
     * los gráficos, la licencia y los botones de descarga del tema (PDF, Word,
     * ficha de repaso y versión anterior). Como en la app (html_revisado.dart).
     */
    function prepararHtml(html, urlDocumento) {
        var doc = new DOMParser().parseFromString(html, 'text/html');
        ['header.site-header', 'nav.main-nav', 'nav.sub-nav', 'nav.breadcrumb', 'footer.site-footer', 'section.tema-oposicion', '.cookie-banner'].forEach(function (s) {
            Array.prototype.forEach.call(doc.querySelectorAll(s), function (e) { e.parentNode.removeChild(e); });
        });
        var fuera = /(search-engine|search-ui|cookie-consent|firebase-app|firebase-auth|firebase-firestore|firebase-config|auth|app-banner|exclusivos)\.js$/;
        Array.prototype.forEach.call(doc.querySelectorAll('script[src]'), function (s) {
            if (fuera.test(s.getAttribute('src').split('?')[0]) || /googletagmanager/.test(s.getAttribute('src'))) s.parentNode.removeChild(s);
        });
        Array.prototype.forEach.call(doc.querySelectorAll('link'), function (l) {
            var rel = l.getAttribute('rel') || '', href = l.getAttribute('href') || '';
            if (/canonical|icon|manifest/.test(rel) || /(search-styles|cookie-consent)\.css$/.test(href)) { l.parentNode.removeChild(l); return; }
            // Las hojas de estilos, de la propia web.
            if (/stylesheet/.test(rel) && /(^|\/)styles\.css$/.test(href)) l.setAttribute('href', location.origin + '/styles.css');
            else if (/stylesheet/.test(rel) && /(^|\/)tema\.css$/.test(href)) l.setAttribute('href', location.origin + '/oposicion/temario/latex/tema.css');
        });
        // Las remisiones a otro tema revisado (3B24.html, relativas al almacén privado), a su página
        // de la web, que lo abre con la sesión. Los PDF y el Word quedan en el almacén (dirección firmada).
        Array.prototype.forEach.call(doc.querySelectorAll('a[href]'), function (a) {
            var u;
            try { u = new URL(a.getAttribute('href'), urlDocumento); } catch (e) { return; }
            var m = /\/oposicion\/temario\/tercer-ejercicio\/(3[AB]\d\d)\.html$/.exec(u.pathname);
            if (m && u.origin !== location.origin) a.setAttribute('href', location.origin + '/oposicion/temario/tercer-ejercicio/' + m[1] + '.html' + u.hash);
        });
        var base = doc.createElement('base');
        base.setAttribute('href', urlDocumento);
        doc.head.insertBefore(base, doc.head.firstChild);
        var estilo = doc.createElement('style');
        estilo.textContent = 'body{margin:0}.main-content{padding:0.5rem 1rem 2rem!important;margin-top:0!important}.main-content::before{display:none!important}' +
            'img,svg{max-width:100%;height:auto}html,body{overflow-x:clip}.tema-documento{min-width:0;overflow-wrap:break-word}' +
            // El índice lateral, fijo al bajar (overflow-x:hidden lo rompía); en el móvil, una barra plegable arriba.
            // Sin fondo verde ni tarjeta propios: el tema va directamente en la tarjeta blanca de la página.
            'html,body,.main-content{background:transparent!important;background-image:none!important}' +
            '.tema-documento{box-shadow:none;border-radius:0;padding:.3rem 0 2rem;background:transparent}' +
            '.tema-layout{padding:.4rem 0 2rem;gap:1.8rem}' +
            '.tema-indice{position:sticky;top:.6rem;max-height:calc(100vh - 1.2rem);overflow-y:auto}' +
            // El índice, a la izquierda también en pantallas medianas (tema.css lo subía arriba por debajo de 900 px).
            '@media (min-width:561px) and (max-width:900px){.tema-layout{grid-template-columns:200px minmax(0,1fr);gap:1.2rem}.tema-indice{position:sticky;top:.6rem;max-height:calc(100vh - 1.2rem);overflow-y:auto;font-size:.8rem}.tema-documento{text-align:left}}' +
            // En el móvil estrecho no cabe al lado: barra plegable fija arriba.
            '@media (max-width:560px){.tema-layout{padding:0 0 2rem}.tema-indice{position:sticky;top:0;z-index:5;max-height:2.3rem;overflow:hidden;padding:.6rem .9rem;box-shadow:0 2px 6px rgba(22,19,26,.12);cursor:pointer}' +
            '.tema-indice.abierto{max-height:70vh;overflow-y:auto;padding-bottom:1rem}.tema-indice-titulo{margin:0;display:flex;justify-content:space-between}.tema-indice-titulo::after{content:"▾";color:var(--color-primary)}.tema-indice.abierto .tema-indice-titulo::after{content:"▴"}}' +
            'mjx-container[display="true"]{display:block;overflow-x:auto;overflow-y:hidden;max-width:100%}table{display:block;max-width:100%;overflow-x:auto}';
        doc.head.appendChild(estilo);
        var indice = doc.createElement('script');
        indice.textContent = "(function(){var i=document.querySelector('.tema-indice');if(!i)return;var t=i.querySelector('.tema-indice-titulo');" +
            "if(t)t.addEventListener('click',function(){i.classList.toggle('abierto');});" +
            "i.addEventListener('click',function(e){if(e.target.closest&&e.target.closest('a')&&window.innerWidth<=560)i.classList.remove('abierto');});})();";
        doc.body.appendChild(indice);
        var enlaces = doc.createElement('script');
        enlaces.textContent = "document.addEventListener('click',function(e){var a=e.target&&e.target.closest?e.target.closest('a[href]'):null;if(!a)return;var h=a.getAttribute('href')||'';" +
            "if(h.charAt(0)==='#'){e.preventDefault();var id=decodeURIComponent(h.slice(1));var d=document.getElementById(id)||document.getElementsByName(id)[0];if(d)d.scrollIntoView({behavior:'smooth',block:'start'});return;}" +
            "if(!a.hasAttribute('download')){a.setAttribute('target','_blank');a.setAttribute('rel','noopener');}},true);";
        doc.body.appendChild(enlaces);
        var tema = document.documentElement.getAttribute('data-theme');
        if (tema) doc.documentElement.setAttribute('data-theme', tema); else doc.documentElement.removeAttribute('data-theme');
        return '<!DOCTYPE html>\n' + doc.documentElement.outerHTML;
    }

    /**
     * Baja al apartado del hash (#apartado=I.2. o parte de su título), dentro del marco del tema:
     * lo usan los resultados del buscador.
     */
    function irAlApartado(marco) {
        var m = /[#&]apartado=([^&]+)/.exec(location.hash);
        var d = marco.contentDocument;
        if (!m || !d) return;
        var buscado = decodeURIComponent(m[1]).trim().toLowerCase();
        var numero = (/^([IVXA-H]+(?:\.\d+)*\.)/i.exec(buscado) || [])[1];
        var hs = d.querySelectorAll('h2, h3, h4');
        for (var i = 0; i < hs.length; i++) {
            var n = hs[i].querySelector('.numero');
            var texto = hs[i].textContent.trim().toLowerCase();
            if ((numero && n && n.textContent.trim().toLowerCase() === numero) || (!numero && texto.indexOf(buscado) === 0) || texto === buscado) {
                // El marco tiene altura fija y se desplaza por dentro: primero el marco a la vista, luego el apartado.
                marco.scrollIntoView({ block: 'start' });
                hs[i].scrollIntoView({ block: 'start' });
                return;
            }
        }
    }

    /** La página de un tema revisado: …/tercer-ejercicio/3A08.html (y la antigua tema-revisado.html?tema=3A08). */
    function paginaTema() {
        var cont = document.getElementById('tema-revisado');
        if (!cont) return;
        var archivo = archivoDe(cont.getAttribute('data-tema') || new URLSearchParams(location.search).get('tema'));
        // Enlaces viejos (tema-revisado.html?tema=3A08): a la página del tema, junto a su PDF.
        if (archivo && !cont.getAttribute('data-tema')) { location.replace(paginaWeb(archivo) + location.hash); return; }
        var estado = document.getElementById('tema-revisado-estado');
        var barra = document.getElementById('tema-revisado-barra');
        function mensaje(html) { estado.innerHTML = html; estado.hidden = false; }
        if (!archivo) { mensaje('<p>No se ha indicado ningún tema. Vuelve al <a href="../temario.html">temario</a>.</p>'); return; }
        var guia = archivo === '1D01';
        var codigo = archivo.replace(/^(\d)([AB])0?(\d+)$/, '$1.$2.$3');
        var nombre = guia ? 'la guía del dictamen' : 'el tema ' + codigo;
        var delNombre = guia ? 'de la guía del dictamen' : 'del tema ' + codigo;
        if (!TEMAS_EN_WEB) {
            antiguoDe(archivo).then(function (antiguo) {
                mensaje('<p>La versión revisada ' + delNombre + ' se lee, de momento, en la <a href="' + APP + '">app Oposición TCEE · DCE</a> con tu cuenta de Google.</p>' +
                    (antiguo ? '<p><a class="boton boton--secundario" href="' + antiguo + '" target="_blank" rel="noopener">' + (guia ? 'Ver la guía antigua' : 'Ver el tema antiguo') + '</a></p>' : ''));
            });
            return;
        }
        mensaje('<p>Cargando ' + nombre + '…</p>');
        Promise.all([leerManifiesto(), antiguoDe(archivo)]).then(function (r) {
            var m = r[0], antiguo = r[1], rev = revisadoDe(m, archivo);
            if (!m) { mensaje('<p>No se ha podido cargar el tema revisado. Inténtalo más tarde o léelo en la <a href="' + APP + '">app</a>.</p>' + (antiguo ? '<p><a href="' + antiguo + '">Ver la versión antigua</a></p>' : '')); return; }
            if (!rev) { if (antiguo) location.replace(antiguo); else mensaje('<p>Este tema aún no tiene versión revisada. Vuelve al <a href="../temario.html">temario</a>.</p>'); return; }
            var t = rev.t;
            var titulo = (guia ? 'Guía del dictamen' : 'Tema ' + t.codigo) + (t.titulo ? ': ' + t.titulo : '');
            document.title = (guia ? 'Guía para el dictamen de coyuntura económica' : 'Tema ' + t.codigo + (t.titulo ? ': ' + t.titulo.replace(/\.$/, '') : '')) + ' | Víctor Gutiérrez Marcos';
            document.getElementById('tema-revisado-titulo').textContent = titulo;
            var cargado = false;
            var cerrarAviso = null;
            alCambiarSesion(function (u) {
                if (!u) {
                    if (cargado) { location.reload(); return; } // ha cerrado la sesión
                    mensaje('<p>Inicia sesión con Google (arriba, «Acceder») para leer ' + nombre + '.</p>' +
                        (antiguo ? '<p><a class="boton boton--secundario" href="' + antiguo + '" target="_blank" rel="noopener">Seguir con la versión anterior</a></p>' : ''));
                    cerrarAviso = avisoSesion({ archivo: archivo, guia: guia, codigo: t.codigo, fecha: t.aprobado || t.fecha, antiguo: antiguo, destino: '_blank', alEntrar: function () {} });
                    return;
                }
                if (cerrarAviso) { cerrarAviso(); cerrarAviso = null; }
                if (cargado) return;
                cargado = true;
                mensaje('<p>Cargando ' + nombre + '…</p>');
                var base = null;
                acceso().then(function (b) {
                    base = b;
                    return fetch(base + t.html.ruta);
                }).then(function (r) { if (!r.ok) throw new Error(r.status); return r.text(); }).then(function (html) {
                    // La barra: formatos que hay en el manifiesto y la versión antigua de la web.
                    var enlaces = [];
                    if (t.pdf && t.pdf.ruta) enlaces.push('<a href="' + base + t.pdf.ruta + '" target="_blank" rel="noopener">PDF</a>');
                    if (t.docx && t.docx.ruta) enlaces.push('<a href="' + base + t.docx.ruta + '" download>Word</a>');
                    if (t.repaso && t.repaso.ruta) enlaces.push('<a href="' + base + t.repaso.ruta + '" target="_blank" rel="noopener">' + (guia ? 'Resumen de repaso' : 'Ficha de repaso') + '</a>');
                    if (antiguo) enlaces.push('<a href="' + antiguo + '" target="_blank" rel="noopener">Versión anterior</a>');
                    barra.querySelector('.tema-revisado-formatos').innerHTML = enlaces.join('');
                    var fecha = barra.querySelector('.tema-revisado-fecha');
                    if (fecha) fecha.textContent = '';
                    barra.hidden = false;
                    var marco = document.getElementById('tema-revisado-marco');
                    marco.title = titulo;
                    marco.onload = function () { irAlApartado(marco); };
                    marco.srcdoc = prepararHtml(html, base + t.html.ruta);
                    marco.hidden = false;
                    estado.hidden = true;
                    // El modo claro u oscuro de la web (search-ui.js) pasa al tema.
                    new MutationObserver(function () {
                        var d = marco.contentDocument && marco.contentDocument.documentElement;
                        if (!d) return;
                        var v = document.documentElement.getAttribute('data-theme');
                        if (v) d.setAttribute('data-theme', v); else d.removeAttribute('data-theme');
                    }).observe(document.documentElement, { attributes: true, attributeFilter: ['data-theme'] });
                }).catch(function () {
                    cargado = false;
                    mensaje('<p>No se ha podido cargar ' + nombre + '. Comprueba la conexión y recarga la página, o léelo en la <a href="' + APP + '">app</a>.</p>');
                });
            });
        });
    }

    // Lista «Materiales exclusivos» del temario: cada tema o guía revisados
    // lleva a su página (que pide sesión si hace falta).
    function revisados() {
        var filas = document.querySelectorAll('#exclusivos-lista li[data-revisado]');
        if (!filas.length) return;
        var cont = document.getElementById('exclusivos-lista');
        var aviso = document.createElement('p');
        aviso.className = 'exclusivos-nota';
        aviso.setAttribute('role', 'status');
        cont.insertBefore(aviso, cont.querySelector('ul'));
        if (!TEMAS_EN_WEB) {
            aviso.innerHTML = 'Los temas revisados se leen en la <a href="' + APP + '">app Oposición TCEE · DCE</a> con tu cuenta de Google.';
            return;
        }
        Array.prototype.forEach.call(filas, function (li) {
            var archivo = archivoDe(li.getAttribute('data-revisado'));
            if (!archivo || li.querySelector('a.exclusivos-abrir')) return;
            var a = document.createElement('a');
            a.className = 'exclusivos-abrir';
            // La página del tema (pide sesión si hace falta y da la versión antigua).
            a.href = paginaWeb(archivo);
            // El código y el título juntos, como enlace.
            while (li.firstChild && !(li.firstChild.className === 'exclusivos-detalle' || li.firstChild.className === 'etiqueta-exclusivo')) {
                a.appendChild(li.firstChild);
            }
            li.insertBefore(a, li.firstChild);
        });
        alCambiarSesion(function (u) {
            aviso.textContent = u
                ? 'Con tu sesión iniciada, toca uno para leerlo aquí, con su PDF, su Word, su ficha de repaso y la versión anterior. Son para tu estudio personal: no los compartas ni los subas a otros servicios.'
                : 'Inicia sesión con Google para leerlos aquí; sin sesión puedes seguir con la versión antigua de cada tema.';
        });
    }

    // La skill se descarga con sesión (es material exclusivo: la copia queda
    // ligada a quien la baja). auth.js carga Firebase después de este script,
    // así que se espera a que exista y se escucha el estado de la sesión.
    function skill(datos) {
        var boton = document.getElementById('descargar-skill');
        if (!boton) return;
        var s = datos.materiales.filter(function (m) { return m.tipo === 'skill' && m.url; })[0];
        if (!s) { boton.hidden = true; return; }
        var sinSesion = boton.getAttribute('data-sin-sesion') || 'Inicia sesión para descargar la skill o descárgala desde la app';
        var nota = document.createElement('p');
        nota.className = 'exclusivos-nota';
        // Detrás de la fila de botones (.botones) si el botón está en una; si no, justo detrás del botón.
        var fila = boton.parentNode.classList && boton.parentNode.classList.contains('botones') ? boton.parentNode : boton;
        fila.parentNode.insertBefore(nota, fila.nextSibling);
        function pinta(usuario) {
            if (usuario) {
                // Del almacén privado, con una dirección firmada (la de exclusivos.json es la de antes).
                boton.href = '#';
                acceso().then(function (base) { boton.href = base + 'oposicion/temario/app/prepara-con-claude.zip'; })
                    .catch(function () { boton.href = APP; });
                boton.setAttribute('download', 'prepara-con-claude.zip');
                boton.textContent = 'Descargar la skill (ZIP' + (s.tamano ? ', ' + Math.round(s.tamano / 1024 / 1024 * 10) / 10 + ' MB' : '') + ')';
                nota.textContent = 'Versión ' + (s.version || '') + (s.temas ? ' · ' + s.temas + ' temas revisados' : '') + ' · Para tu uso personal; la copia va ligada a tu cuenta.';
            } else {
                boton.href = APP;
                boton.removeAttribute('download');
                boton.textContent = 'Descargar la skill';
                nota.textContent = sinSesion;
            }
        }
        pinta(null);
        var intentos = 0;
        (function espera() {
            if (window.firebase && firebase.auth) {
                firebase.auth().onAuthStateChanged(pinta);
            } else if (intentos++ < 50) {
                setTimeout(espera, 200);
            }
        })();
    }

    interceptarEnlaces();
    paginaTema();

    // La burbuja de EconomIA (economia-burbuja.js), en todas las páginas de la web.
    if (!window.tceeBurbuja && !/\/app\/abrir\//.test(location.pathname)) {
        var sb = document.createElement('script');
        sb.src = RAIZ + 'economia-burbuja.js';
        sb.defer = true;
        document.head.appendChild(sb);
    }

    fetch(RAIZ + 'oposicion/exclusivos.json', { cache: 'no-cache' })
        .then(function (r) { return r.ok ? r.json() : null; })
        .then(function (datos) {
            if (!datos || !datos.materiales) return;
            marcarEnlaces(datos);
            lista(datos);
            revisados();
            portada(datos);
            skill(datos);
        })
        .catch(function () {});
})();
