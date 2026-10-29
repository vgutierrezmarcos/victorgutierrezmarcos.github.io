/**
 * Apuntes de otros TCEE (oposicion/enlaces.html): lee
 * /oposicion/temario/apuntes-otros.json (lo genera scripts/apuntes-otros.py
 * cada lunes desde el repositorio de apuntes de la ATCEE) y rellena
 * #apuntes-otros-lista por promoción: cada autor con su nota y sus enlaces
 * (carpetas de Drive y webs; los ficheros uno a uno no se listan aquí).
 * Sin el JSON (sin red, fichero ausente), la sección se queda con el párrafo
 * fijo que enlaza al repositorio.
 */
(function () {
    'use strict';
    var RAIZ = (function () {
        var s = document.currentScript && document.currentScript.getAttribute('src');
        return s ? s.replace(/apuntes-otros\.js$/, '') : '';
    })();
    var JSON_URL = RAIZ + 'oposicion/temario/apuntes-otros.json';
    var NOTA_CORTA = 180; // caracteres: más largo, se pliega

    function el(etiqueta, clase, texto) {
        var e = document.createElement(etiqueta);
        if (clase) e.className = clase;
        if (texto) e.textContent = texto;
        return e;
    }

    function esEstaWeb(autor) {
        return autor.recursos.length > 0 && autor.recursos.every(function (r) {
            return r.tipo === 'web' && /victorgutierrezmarcos\.es/.test(r.url);
        });
    }

    function enlace(r) {
        var n = r.ficheros ? r.ficheros.length : 0;
        if (r.error) {
            var s = el('span', 'boton boton--secundario boton--peq', r.etiqueta + ' (no pública)');
            s.setAttribute('aria-disabled', 'true');
            s.title = 'La carpeta no es pública en este momento';
            return s;
        }
        var a = el('a', 'boton boton--secundario boton--peq', r.etiqueta);
        a.href = r.url;
        a.target = '_blank';
        a.rel = 'noopener';
        if (n) a.title = n + (n === 1 ? ' fichero' : ' ficheros');
        return a;
    }

    function autorBloque(autor) {
        var b = el('div', 'apuntes-autor');
        var nombre = el('p', 'apuntes-autor-nombre');
        nombre.appendChild(el('strong', null, autor.nombre));
        if (autor.numeracion === 'antigua') {
            var n = el('span', 'apuntes-numeracion', 'numeración del temario anterior');
            n.title = 'Los números de los temas son los del temario anterior a 2023: comprueba por el título';
            nombre.appendChild(n);
        }
        b.appendChild(nombre);
        if (autor.nota) {
            if (autor.nota.length > NOTA_CORTA) {
                var d = el('details', 'apuntes-nota');
                d.appendChild(el('summary', null, autor.nota.slice(0, NOTA_CORTA).replace(/\s+\S*$/, '') + '…'));
                d.appendChild(el('p', null, autor.nota));
                b.appendChild(d);
            } else {
                b.appendChild(el('p', 'apuntes-nota', autor.nota));
            }
        }
        var enlaces = el('p', 'apuntes-enlaces');
        autor.recursos.forEach(function (r) { enlaces.appendChild(enlace(r)); });
        b.appendChild(enlaces);
        return b;
    }

    function pintar(datos) {
        var lista = document.getElementById('apuntes-otros-lista');
        if (!lista || !datos || !datos.promociones) return;
        var frag = document.createDocumentFragment();
        datos.promociones.forEach(function (p) {
            var autores = p.autores.filter(function (a) { return !esEstaWeb(a); });
            if (!autores.length) return;
            var s = el('section', 'apuntes-promocion');
            s.appendChild(el('h4', null, 'Promoción ' + p.promocion + ' (' + p.anio + ')'));
            autores.forEach(function (a) { s.appendChild(autorBloque(a)); });
            frag.appendChild(s);
        });
        lista.textContent = '';
        lista.appendChild(frag);
        var fecha = document.getElementById('apuntes-otros-fecha');
        if (fecha && datos.generado) fecha.textContent = ' Índice actualizado el ' + datos.generado + '.';
    }

    function cargar() {
        if (!document.getElementById('apuntes-otros-lista') || !window.fetch) return;
        fetch(JSON_URL, { cache: 'no-cache' })
            .then(function (r) { return r.ok ? r.json() : null; })
            .then(pintar)
            .catch(function () { /* sin red: queda el párrafo fijo */ });
    }

    if (document.readyState === 'loading') document.addEventListener('DOMContentLoaded', cargar);
    else cargar();
})();
