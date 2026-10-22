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
        var fechas = spec.tipo === 'fechas';
        var promociones = spec.tipo === 'promociones';
        var datasets = spec.series.map(function (serie, i) {
            var color = c[serie.color] || c.primary;
            var ds = {
                label: serie.nombre,
                data: fechas ? serie.valores.map(function (v, k) { return { x: spec.x[k], y: v }; }) : serie.valores,
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
            if (fechas) { ds.barThickness = 5; ds.borderRadius = 0; }
            if (horizontal) { ds.grouped = false; ds.barThickness = 18; ds.order = spec.series.length - i; }
            return ds;
        });
        var ejeValores = {
            position: horizontal ? 'bottom' : (temporal ? 'right' : 'left'),
            beginAtZero: true,
            min: spec.ejes.y.min,
            max: spec.ejes.y.max || undefined,
            grid: { color: c.rejilla },
            border: { display: false },
            ticks: { color: c.texto, font: letra, callback: function (v, i, ticks) { return formato(v, i === ticks.length - 1 ? spec.ejes.y.unidad : ''); } }
        };
        var ejeCategorias = {
            grid: { display: false },
            border: { color: c.rejilla },
            ticks: { color: c.texto, font: letra, maxRotation: 0, autoSkip: !horizontal, autoSkipPadding: 12 },
            offset: true
        };
        if (fechas) {
            ejeCategorias = {
                type: 'linear', min: spec.x_min, max: spec.x_max, offset: false,
                grid: { display: false },
                border: { color: c.rejilla },
                ticks: { color: c.texto, font: letra, stepSize: 10, maxRotation: 0, callback: function (v) { return String(v); } }
            };
        }
        if (promociones) {
            // Una barra por promoción, todas iguales; el eje marca el año al empezar cada década
            ejeCategorias.ticks = { color: c.texto, font: letra, maxRotation: 0, autoSkip: false, callback: function (v, i) { return spec.decada[i] ? String(Math.floor(spec.anios[i] / 10) * 10) : ''; } };
        }
        var escalas = horizontal ? { x: ejeValores, y: ejeCategorias } : { x: ejeCategorias, y: ejeValores };
        if (spec.ejes.y2 && !horizontal) {
            escalas.y2 = {
                position: 'left',
                beginAtZero: true,
                max: spec.ejes.y2.max || undefined,
                grid: { drawOnChartArea: false },
                border: { display: false },
                ticks: { color: c.gold, font: letra, callback: function (v, i, ticks) { return formato(v, i === ticks.length - 1 ? spec.ejes.y2.unidad : ''); } }
            };
        }
        if (horizontal) { escalas.y.stacked = false; escalas.x.stacked = false; }
        else if (spec.series.some(function (s) { return s.apilar; })) { escalas.x.stacked = true; escalas.y.stacked = true; }
        if (fechas || promociones) { escalas.y.position = 'right'; }
        var textos = spec.textos || null;
        return {
            type: 'bar',
            data: { labels: spec.etiquetas, datasets: datasets },
            options: {
                indexAxis: horizontal ? 'y' : 'x',
                responsive: true,
                maintainAspectRatio: false,
                animation: { duration: 300 },
                interaction: { mode: fechas ? 'nearest' : 'index', intersect: false, axis: horizontal ? 'y' : 'x' },
                layout: { padding: { top: 8, right: horizontal ? 150 : 4, left: 4, bottom: 0 } },
                scales: escalas,
                plugins: {
                    legend: {
                        display: datasets.length > 1,
                        position: 'bottom',
                        align: 'start',
                        labels: { color: c.texto, font: letra, boxWidth: 18, boxHeight: 11, padding: 16, usePointStyle: false }
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
                        filter: function (item) { var r = item.raw && item.raw.y !== undefined ? item.raw.y : item.raw; return r !== null && r !== undefined; },
                        callbacks: {
                            title: function (items) {
                                if (!items.length) return '';
                                if (fechas || promociones) { return spec.etiquetas[items[0].dataIndex]; }
                                var et = items[0].label;
                                return temporal ? 'Exámenes de ' + et : et;
                            },
                            label: function (item) {
                                if (textos && datasets.length <= 2) { return textos[item.dataIndex]; }
                                var unidad = item.dataset.yAxisID === 'y2' ? spec.ejes.y2.unidad : spec.ejes.y.unidad;
                                var valor = item.raw && item.raw.y !== undefined ? item.raw.y : item.raw;
                                return item.dataset.label + ': ' + formato(valor, unidad);
                            },
                            footer: function (items) {
                                if (!items.length || !items[0].dataset.stack) return '';
                                var total = items.reduce(function (t, it) { var r = it.raw; return t + ((r && r.y !== undefined ? r.y : r) || 0); }, 0);
                                return 'Total: ' + formato(total, spec.ejes.y.unidad);
                            }
                        }
                    }
                }
            }
        };
    }

    // Valor encima de cada barra (si hay pocas), dentro de los tramos apilados altos, y el texto al final de las barras horizontales
    var etiquetasValor = {
        id: 'etiquetasValor',
        afterDatasetsDraw: function (chart, args, opts) {
            var spec = chart.$spec, c = chart.$colores;
            if (!spec) return;
            var ctx = chart.ctx;
            ctx.save();
            ctx.font = '10.5px ' + (variable('--font-ui') || 'Source Sans 3, sans-serif');
            var n = spec.etiquetas.length;
            if (spec.horizontal) {
                var meta = chart.getDatasetMeta(0);
                ctx.fillStyle = c.texto; ctx.textAlign = 'left'; ctx.textBaseline = 'middle'; ctx.font = '12px ' + ctx.font.split(' ').slice(1).join(' ');
                meta.data.forEach(function (barra, k) {
                    if (spec.textos && spec.textos[k]) { ctx.fillText(spec.textos[k], barra.x + 8, barra.y); }
                });
                ctx.restore();
                return;
            }
            var apilado = spec.series.some(function (s) { return s.apilar; });
            var barras = spec.series.filter(function (s) { return s.tipo === 'bar'; }).length;
            if (spec.tipo === 'fechas' || spec.tipo === 'promociones' || n > 20 || (!apilado && barras > 2)) { ctx.restore(); return; }
            chart.data.datasets.forEach(function (ds, i) {
                if (ds.type !== 'bar' || !chart.isDatasetVisible(i)) return;
                var meta = chart.getDatasetMeta(i);
                meta.data.forEach(function (barra, k) {
                    var v = ds.data[k];
                    if (v === null || v === undefined || v === 0) return;
                    var alto = Math.abs(barra.base - barra.y);
                    if (apilado) {
                        if (alto < 13) return;
                        ctx.fillStyle = c.fondo; ctx.textAlign = 'center'; ctx.textBaseline = 'middle';
                        ctx.fillText(formato(v), barra.x, barra.y + alto / 2);
                    } else {
                        ctx.fillStyle = c.texto; ctx.textAlign = 'center'; ctx.textBaseline = 'bottom';
                        ctx.fillText(formato(v), barra.x, barra.y - 3);
                    }
                });
            });
            ctx.restore();
        }
    };

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
            var cfg = configurar(spec, c);
            cfg.plugins = [etiquetasValor];
            lienzo.__grafico = new Chart(lienzo, cfg);
            lienzo.__grafico.$spec = spec;
            lienzo.__grafico.$colores = c;
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
