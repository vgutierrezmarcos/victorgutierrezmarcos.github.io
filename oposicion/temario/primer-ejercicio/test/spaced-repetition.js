/**
 * Sistema de repetición espaciada (modelo Leitner)
 * Almacena preguntas falladas en cajas con intervalos crecientes
 * Autor: Víctor Gutiérrez Marcos
 *
 * Cajas Leitner:
 * - Caja 1: Revisar cada sesión (preguntas nuevas o recién falladas)
 * - Caja 2: Revisar cada 2 sesiones
 * - Caja 3: Revisar cada 4 sesiones
 * - Caja 4: Revisar cada 8 sesiones
 * - Caja 5: Dominadas (no se revisan automáticamente)
 */

var SpacedRepetition = (function() {
    var STORAGE_KEY = 'vgm_spaced_repetition';
    var SESSION_KEY = 'vgm_sr_session';

    // Intervalos de revisión por caja (en número de sesiones)
    var BOX_INTERVALS = { 1: 1, 2: 2, 3: 4, 4: 8, 5: Infinity };

    /**
     * Cargar datos de localStorage
     */
    function loadData() {
        try {
            var raw = localStorage.getItem(STORAGE_KEY);
            if (raw) return JSON.parse(raw);
        } catch (e) { /* silencio */ }
        return { questions: {}, sessionCount: 0 };
    }

    /**
     * Guardar datos en localStorage
     */
    function saveData(data) {
        try {
            localStorage.setItem(STORAGE_KEY, JSON.stringify(data));
        } catch (e) { /* silencio */ }
    }

    /**
     * Registrar resultado de una pregunta tras un examen
     * @param {number} questionId - ID de la pregunta
     * @param {boolean} correct - Si se respondió correctamente
     */
    function recordAnswer(questionId, correct) {
        var data = loadData();
        var key = String(questionId);
        var entry = data.questions[key];

        if (!entry) {
            // Solo añadir si fue incorrecta (primera vez)
            if (!correct) {
                data.questions[key] = {
                    box: 1,
                    lastSession: data.sessionCount,
                    timesCorrect: 0,
                    timesFailed: 1
                };
            }
        } else {
            if (correct) {
                // Mover a la siguiente caja (máximo 5)
                entry.box = Math.min(entry.box + 1, 5);
                entry.timesCorrect = (entry.timesCorrect || 0) + 1;
            } else {
                // Volver a la caja 1
                entry.box = 1;
                entry.timesFailed = (entry.timesFailed || 0) + 1;
            }
            entry.lastSession = data.sessionCount;
        }

        saveData(data);
    }

    /**
     * Registrar todas las respuestas de un examen completado
     * @param {Array} questions - Array de preguntas del examen (con .id)
     * @param {Object} answers - Map index -> respuesta del usuario
     */
    function recordExamResults(questions, answers) {
        for (var i = 0; i < questions.length; i++) {
            var pregunta = questions[i];
            var respuesta = answers[i];

            if (respuesta === undefined) {
                // Sin responder: tratar como fallo
                recordAnswer(pregunta.id, false);
            } else if (pregunta.tipo_pregunta === 'aceptada' || pregunta.respuesta.includes(respuesta)) {
                recordAnswer(pregunta.id, true);
            } else {
                recordAnswer(pregunta.id, false);
            }
        }

        // Incrementar contador de sesiones
        var data = loadData();
        data.sessionCount = (data.sessionCount || 0) + 1;
        saveData(data);
    }

    /**
     * Obtener IDs de preguntas que deben revisarse en esta sesión
     * (preguntas cuyo intervalo de caja ha vencido)
     */
    function getDueQuestionIds() {
        var data = loadData();
        var currentSession = data.sessionCount || 0;
        var due = [];

        var keys = Object.keys(data.questions);
        for (var i = 0; i < keys.length; i++) {
            var entry = data.questions[keys[i]];
            if (entry.box >= 5) continue; // Dominadas
            var interval = BOX_INTERVALS[entry.box] || 1;
            var sessionsSince = currentSession - (entry.lastSession || 0);
            if (sessionsSince >= interval) {
                due.push(parseInt(keys[i]));
            }
        }

        return due;
    }

    /**
     * Obtener resumen de estadísticas de repetición
     */
    function getSummary() {
        var data = loadData();
        var boxes = { 1: 0, 2: 0, 3: 0, 4: 0, 5: 0 };
        var total = 0;

        var keys = Object.keys(data.questions);
        for (var i = 0; i < keys.length; i++) {
            var box = data.questions[keys[i]].box || 1;
            boxes[box] = (boxes[box] || 0) + 1;
            total++;
        }

        return {
            total: total,
            boxes: boxes,
            dueCount: getDueQuestionIds().length,
            sessionCount: data.sessionCount || 0
        };
    }

    /**
     * Limpiar todos los datos de repetición
     */
    function clearAll() {
        localStorage.removeItem(STORAGE_KEY);
    }

    return {
        recordAnswer: recordAnswer,
        recordExamResults: recordExamResults,
        getDueQuestionIds: getDueQuestionIds,
        getSummary: getSummary,
        clearAll: clearAll,
        loadData: loadData
    };
})();
