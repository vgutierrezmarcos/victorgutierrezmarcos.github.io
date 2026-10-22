/* Gráficos interactivos de «La oposición a TCEE en cifras» (Chart.js).
   Cada .grafico-js lleva un <script type="application/json"> con los datos que
   escribe scripts/cifras_graficos.py; sin JavaScript queda el SVG del <noscript>.
   Colores y letra salen de las variables de styles.css, también en el tema oscuro.
   Autor: Víctor Gutiérrez Marcos. */
(function () {
    'use strict';
    var graficos = [];

    function variable(nombre) {
        return getComputedStyle(document.documentElement).getPropertyValue(nombre).trim();
    }

    function colores() {
        return {
            'primary': variable('--color-primary'),
            'primary-light': variable('--color-primary-light'),
            'primary-pale': variable('--color-primary-pale'),
            'gold': variable('--color-accent-gold'),
            'text-light': variable('--color-text-light'),
            'border-strong': variable('--color-border-strong'),
            'border-light': variable('--color-border-light'),
            texto: variable('--color-text-muted'),
            rejilla: variable('--color-border-light'),
            fondo: variable('--color-bg-cream') || '#fff',
            tooltipFondo: variable('--color-text') || '#2a2530',
            tooltipTexto: variable('--color-bg-cream') || '#fbfaf6'
        };
    }

    function formato(v, unidad) {
        if (v === null || v === undefined) return '—';
        var n = Math.round(v * 10) / 10;
        var s = (n % 1 === 0 ? n.toFixed(0) : n.toFixed(1)).replace('.', ',');
        return s.replace(/\B(?=(\d{3})+(?!\d))/g, ' ') + (unidad || '');
    }

    function configurar(spec, c) {
        var letra = { family: variable('--font-ui') || 'Source Sans 3, sans-serif', size: 12 };
        var horizontal = !!spec.horizontal;
        var temporal = !!spec.temporal;
        var datasets = spec.series.map(function (serie, i) {
            var color = c[serie.color] || c.primary;
            var ds = {
                label: serie.nombre,
                data: serie.valores,
                type: serie.tipo,
                yAxisID: serie.eje === 'y2' ? 'y2' : 'y',
                order: serie.tipo === 'line' ? 0 : 1,
                borderColor: color,
                backgroundColor: color,
                borderWidth: serie.tipo === 'line' ? 2.5 : 0,
                pointRadius: serie.tipo === 'line' ? 3.5 : 0,
                pointHoverRadius: 6,
                pointBackgroundColor: color,
                pointBorderColor: c.fondo,
                tension: 0.15,
                spanGaps: false,
                borderRadius: serie.apilar ? 0 : 2,
                stack: serie.apilar ? 'pila' : undefined,
                maxBarThickness: horizontal ? 18 : 40,
                categoryPercentage: 0.8,
                barPercentage: 0.9
            };
            if (horizontal && i > 0) { ds.grouped = false; }
            return ds;
        });
        var ejeValores = {
            position: horizontal ? 'bottom' : (temporal ? 'right' : 'left'),
            beginAtZero: true,
            min: spec.ejes.y.min,
            max: spec.ejes.y.max || undefined,
            grid: { color: c.rejilla, drawBorder: false },
            ticks: { color: c.texto, font: letra, callback: function (v, i, ticks) { return formato(v, i === ticks.length - 1 ? spec.ejes.y.unidad : ''); } }
        };
        var ejeCategorias = {
            grid: { color: temporal ? c.rejilla : 'transparent', drawOnChartArea: temporal, drawTicks: false },
            ticks: { color: c.texto, font: letra, maxRotation: 0, autoSkip: true, autoSkipPadding: 12 },
            offset: true
        };
        var escalas = horizontal ? { x: ejeValores, y: ejeCategorias } : { x: ejeCategorias, y: ejeValores };
        if (spec.ejes.y2 && !horizontal) {
            escalas.y2 = {
                position: 'left',
                beginAtZero: true,
                max: spec.ejes.y2.max || undefined,
                grid: { drawOnChartArea: false, drawBorder: false },
                ticks: { color: c.gold, font: letra, callback: function (v, i, ticks) { return formato(v, i === ticks.length - 1 ? spec.ejes.y2.unidad : ''); } }
            };
        }
        if (horizontal) { escalas.y.stacked = false; escalas.x.stacked = false; }
        else if (spec.series.some(function (s) { return s.apilar; })) { escalas.x.stacked = true; escalas.y.stacked = true; }
        var textos = spec.textos || null;
        return {
            type: 'bar',
            data: { labels: spec.etiquetas, datasets: datasets },
            options: {
                indexAxis: horizontal ? 'y' : 'x',
                responsive: true,
                maintainAspectRatio: false,
                animation: { duration: 300 },
                interaction: { mode: 'index', intersect: false, axis: horizontal ? 'y' : 'x' },
                layout: { padding: { top: 8, right: 4, left: 4, bottom: 0 } },
                scales: escalas,
                plugins: {
                    legend: {
                        display: datasets.length > 1,
                        position: 'bottom',
                        labels: { color: c.texto, font: letra, boxWidth: 14, boxHeight: 10, padding: 14, usePointStyle: false }
                    },
                    tooltip: {
                        backgroundColor: c.tooltipFondo,
                        titleColor: c.tooltipTexto,
                        bodyColor: c.tooltipTexto,
                        titleFont: { family: letra.family, size: 13, weight: '600' },
                        bodyFont: letra,
                        padding: 10,
                        cornerRadius: 4,
                        displayColors: datasets.length > 1,
                        filter: function (item) { return item.raw !== null && item.raw !== undefined; },
                        callbacks: {
                            title: function (items) {
                                if (!items.length) return '';
                                var et = items[0].label;
                                return temporal ? 'Exámenes de ' + et : et;
                            },
                            label: function (item) {
                                if (textos && datasets.length <= 2) { return textos[item.dataIndex]; }
                                var unidad = item.dataset.yAxisID === 'y2' ? spec.ejes.y2.unidad : spec.ejes.y.unidad;
                                return item.dataset.label + ': ' + formato(item.raw, unidad);
                            },
                            footer: function (items) {
                                if (!items.length || !items[0].dataset.stack) return '';
                                var total = items.reduce(function (t, it) { return t + (it.raw || 0); }, 0);
                                return 'Total: ' + formato(total, spec.ejes.y.unidad);
                            }
                        }
                    }
                }
            }
        };
    }

    function pintar() {
        if (typeof Chart === 'undefined') return;
        var c = colores();
        Chart.defaults.font.family = variable('--font-ui') || 'Source Sans 3, sans-serif';
        document.querySelectorAll('.grafico-js').forEach(function (caja) {
            var datos = caja.querySelector('.datos-grafico');
            var lienzo = caja.querySelector('canvas');
            if (!datos || !lienzo) return;
            var spec;
            try { spec = JSON.parse(datos.textContent); } catch (e) { return; }
            if (lienzo.__grafico) { lienzo.__grafico.destroy(); }
            if (spec.horizontal) { caja.style.setProperty('--alto-grafico', (24 + 28 * spec.etiquetas.length) + 'px'); }
            lienzo.__grafico = new Chart(lienzo, configurar(spec, c));
            caja.classList.add('pintado');
            graficos.push(lienzo.__grafico);
        });
    }

    function arrancar() {
        pintar();
        // Cambio de tema claro/oscuro (search-ui.js pone data-theme en <html>)
        new MutationObserver(function (cambios) {
            if (cambios.some(function (m) { return m.attributeName === 'data-theme'; })) { pintar(); }
        }).observe(document.documentElement, { attributes: true });
    }

    if (document.readyState === 'loading') { document.addEventListener('DOMContentLoaded', arrancar); } else { arrancar(); }
})();
