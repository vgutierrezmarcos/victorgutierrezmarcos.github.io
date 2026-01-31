/**
 * Panel de estadísticas del simulador de test
 * Visualiza la evolución de puntuación, aciertos por tema y resumen general
 * Autor: Víctor Gutiérrez Marcos
 */

// Mapa de temas para nombres legibles
const TEMA_NOMBRES = {};
for (let i = 1; i <= 36; i++) {
    TEMA_NOMBRES[i] = 'Tema ' + i;
}

/**
 * Muestra el panel de estadísticas en un modal
 */
async function showStatsPanel() {
    const user = firebase.auth().currentUser;
    if (!user) {
        alert('Debes iniciar sesión para ver tus estadísticas.');
        return;
    }

    // Crear o reutilizar modal
    let modal = document.getElementById('stats-modal');
    if (!modal) {
        modal = document.createElement('div');
        modal.id = 'stats-modal';
        modal.className = 'profile-modal';
        document.body.appendChild(modal);
        modal.addEventListener('click', function(e) {
            if (e.target === modal) modal.style.display = 'none';
        });
    }

    modal.style.display = 'block';
    modal.innerHTML = '<div class="profile-content history-content" style="max-width:700px;">' +
        '<span class="close-profile" onclick="document.getElementById(\'stats-modal\').style.display=\'none\'">&times;</span>' +
        '<h3 class="history-title">Tus estadísticas</h3>' +
        '<div class="history-loading"><div class="loading-spinner"></div><span>Cargando estadísticas...</span></div>' +
        '</div>';

    try {
        const db = firebase.firestore();
        const snapshot = await db.collection('users').doc(user.uid).collection('exam_results')
            .orderBy('timestamp', 'asc')
            .get();

        if (snapshot.empty) {
            modal.querySelector('.history-loading').innerHTML =
                '<div class="history-empty">' +
                '<span class="empty-icon">📊</span>' +
                '<p>No hay datos suficientes para mostrar estadísticas.</p>' +
                '<p>Completa al menos un test para ver tu progreso.</p>' +
                '</div>';
            return;
        }

        var results = [];
        snapshot.forEach(function(doc) {
            var data = doc.data();
            if (data.timestamp) {
                data._date = data.timestamp.toDate();
            }
            results.push(data);
        });

        renderStats(modal, results);
    } catch (error) {
        console.error('Error cargando estadísticas:', error);
        modal.querySelector('.history-loading').innerHTML =
            '<div class="history-error">Error al cargar las estadísticas.</div>';
    }
}

/**
 * Renderiza todas las secciones de estadísticas
 */
function renderStats(modal, results) {
    var content = modal.querySelector('.profile-content');
    content.innerHTML =
        '<span class="close-profile" onclick="document.getElementById(\'stats-modal\').style.display=\'none\'">&times;</span>' +
        '<h3 class="history-title">Tus estadísticas</h3>' +
        '<div class="stats-body">' +
            '<div class="stats-summary" id="stats-summary"></div>' +
            '<div class="stats-section" id="stats-evolution"><h4 class="stats-section-title">Evolución de puntuación</h4><div class="stats-chart" id="chart-evolution"></div></div>' +
            '<div class="stats-section" id="stats-temas"><h4 class="stats-section-title">Rendimiento por tema</h4><div id="temas-bars"></div></div>' +
        '</div>';

    renderSummary(results);
    renderEvolutionChart(results);
    renderTemasBars(results);
}

/**
 * Resumen general: media, mejor nota, tests totales
 */
function renderSummary(results) {
    var container = document.getElementById('stats-summary');
    var totalTests = results.length;
    var sumNota = 0;
    var bestNota = 0;
    var totalCorrectas = 0;
    var totalPreguntas = 0;
    var totalTiempo = 0;

    for (var i = 0; i < results.length; i++) {
        var r = results[i];
        sumNota += r.notaSobre10 || 0;
        if ((r.notaSobre10 || 0) > bestNota) bestNota = r.notaSobre10;
        totalCorrectas += r.correctas || 0;
        totalPreguntas += r.totalPreguntas || 0;
        totalTiempo += r.tiempoSeconds || 0;
    }

    var avgNota = totalTests > 0 ? (sumNota / totalTests) : 0;
    var pctAciertos = totalPreguntas > 0 ? ((totalCorrectas / totalPreguntas) * 100) : 0;
    var avgTiempo = totalTests > 0 ? Math.round(totalTiempo / totalTests) : 0;

    // Tendencia: comparar últimos 3 con los 3 anteriores
    var tendencia = '';
    if (results.length >= 6) {
        var recent = results.slice(-3);
        var previous = results.slice(-6, -3);
        var avgRecent = recent.reduce(function(s, r) { return s + (r.notaSobre10 || 0); }, 0) / 3;
        var avgPrevious = previous.reduce(function(s, r) { return s + (r.notaSobre10 || 0); }, 0) / 3;
        if (avgRecent > avgPrevious + 0.3) tendencia = '<span class="trend-up">&#9650; Mejorando</span>';
        else if (avgRecent < avgPrevious - 0.3) tendencia = '<span class="trend-down">&#9660; Bajando</span>';
        else tendencia = '<span class="trend-stable">&#9654; Estable</span>';
    }

    container.innerHTML =
        '<div class="stats-cards">' +
            '<div class="stat-card">' +
                '<div class="stat-value">' + totalTests + '</div>' +
                '<div class="stat-label">Tests realizados</div>' +
            '</div>' +
            '<div class="stat-card">' +
                '<div class="stat-value ' + (avgNota >= 5 ? 'score-pass' : 'score-fail') + '">' + avgNota.toFixed(1) + '</div>' +
                '<div class="stat-label">Nota media</div>' +
                (tendencia ? '<div class="stat-trend">' + tendencia + '</div>' : '') +
            '</div>' +
            '<div class="stat-card">' +
                '<div class="stat-value">' + bestNota.toFixed(1) + '</div>' +
                '<div class="stat-label">Mejor nota</div>' +
            '</div>' +
            '<div class="stat-card">' +
                '<div class="stat-value">' + pctAciertos.toFixed(0) + '%</div>' +
                '<div class="stat-label">Tasa de acierto</div>' +
            '</div>' +
        '</div>';
}

/**
 * Gráfico de evolución temporal (barras horizontales con CSS)
 */
function renderEvolutionChart(results) {
    var container = document.getElementById('chart-evolution');
    if (results.length === 0) {
        container.innerHTML = '<p class="stats-empty">Sin datos</p>';
        return;
    }

    // Mostrar últimos 15 resultados
    var data = results.slice(-15);
    var html = '<div class="evolution-chart">';

    for (var i = 0; i < data.length; i++) {
        var r = data[i];
        var nota = r.notaSobre10 || 0;
        var pct = (nota / 10) * 100;
        var dateStr = r._date ? r._date.toLocaleDateString('es-ES', { day: 'numeric', month: 'short' }) : '';
        var cls = nota >= 5 ? 'bar-pass' : 'bar-fail';

        html += '<div class="evo-row">' +
            '<span class="evo-date">' + dateStr + '</span>' +
            '<div class="evo-bar-bg">' +
                '<div class="evo-bar ' + cls + '" style="width:' + pct + '%">' +
                    '<span class="evo-bar-label">' + nota.toFixed(1) + '</span>' +
                '</div>' +
                '<div class="evo-bar-threshold" style="left:50%"></div>' +
            '</div>' +
        '</div>';
    }

    html += '</div>';
    container.innerHTML = html;
}

/**
 * Rendimiento por tema (barras horizontales)
 */
function renderTemasBars(results) {
    var container = document.getElementById('temas-bars');

    // Agregar datos por tema
    var temaStats = {};
    for (var i = 0; i < results.length; i++) {
        var r = results[i];
        if (!r.temas || !Array.isArray(r.temas)) continue;
        // Para datos agregados a nivel de test, repartir entre temas seleccionados
        var temasEnTest = r.temas;
        for (var j = 0; j < temasEnTest.length; j++) {
            var t = temasEnTest[j];
            if (!temaStats[t]) {
                temaStats[t] = { tests: 0, sumNota: 0 };
            }
            temaStats[t].tests++;
            temaStats[t].sumNota += r.notaSobre10 || 0;
        }
    }

    var temaKeys = Object.keys(temaStats).sort(function(a, b) { return parseInt(a) - parseInt(b); });

    if (temaKeys.length === 0) {
        container.innerHTML = '<p class="stats-empty">No hay datos por tema disponibles.</p>';
        return;
    }

    var html = '<div class="temas-chart">';
    for (var k = 0; k < temaKeys.length; k++) {
        var tema = temaKeys[k];
        var stats = temaStats[tema];
        var avg = stats.tests > 0 ? (stats.sumNota / stats.tests) : 0;
        var pct = (avg / 10) * 100;
        var cls = avg >= 5 ? 'bar-pass' : 'bar-fail';
        var nombre = TEMA_NOMBRES[tema] || ('Tema ' + tema);

        html += '<div class="tema-row">' +
            '<span class="tema-label">' + nombre + ' <small>(' + stats.tests + ')</small></span>' +
            '<div class="tema-bar-bg">' +
                '<div class="tema-bar ' + cls + '" style="width:' + pct + '%"></div>' +
                '<span class="tema-bar-value">' + avg.toFixed(1) + '</span>' +
            '</div>' +
        '</div>';
    }
    html += '</div>';
    container.innerHTML = html;
}
