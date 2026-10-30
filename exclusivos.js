/**
 * Materiales exclusivos (desde el 1 de octubre de 2026): lee
 * /oposicion/exclusivos.json (lo genera scripts/exclusivos.py; nada se marca a
 * mano en las páginas) y:
 *   - pone la etiqueta «Exclusivo» junto a cada enlace a un fichero exclusivo
 *     de la web y, debajo de su tarjeta, la llamada a la app;
 *   - rellena la sección «Materiales exclusivos» (#exclusivos-lista) del
 *     temario y la frase de la portada (#exclusivos-portada);
 *   - rellena el botón de descarga de la skill de Claude («Prepara con IA»)
 *     (#descargar-skill): con sesión iniciada apunta al ZIP; sin sesión, pide
 *     iniciarla o manda a la app.
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
                var t = m.codigo && m.tipo === 'tema' ? '<strong>' + m.codigo + '</strong> · ' + m.titulo : m.titulo;
                var det = [formatos(m.formatos), m.fecha ? (m.tipo === 'tema' || m.tipo === 'guia' ? 'revisado el ' : 'publicado el ') + fecha(m.revisado || m.fecha) : ''].filter(Boolean).join(' · ');
                if (m.tipo === 'skill') t = '<a href="' + RAIZ + 'oposicion/prepara-con-ia.html">' + m.titulo + '</a>';
                li.innerHTML = (m.ruta ? '<a href="' + RAIZ + m.ruta + '" target="_blank">' + t + '</a>' : t) + ' <span class="etiqueta-exclusivo">Exclusivo</span>' + (det ? '<span class="exclusivos-detalle">' + det + '</span>' : '');
                ul.appendChild(li);
            });
            cont.appendChild(ul);
        }
        grupo('Solo en la app', app, 'Temas revisados a fondo, con datos al día y gráficos nuevos, en PDF, Word y como página web, con su ficha de repaso; y las explicaciones del test. Se leen dentro de la app.');
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
                boton.href = s.url;
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

    fetch(RAIZ + 'oposicion/exclusivos.json', { cache: 'no-cache' })
        .then(function (r) { return r.ok ? r.json() : null; })
        .then(function (datos) {
            if (!datos || !datos.materiales) return;
            marcarEnlaces(datos);
            lista(datos);
            portada(datos);
            skill(datos);
        })
        .catch(function () {});
})();
