/**
 * Motor de búsqueda para victorgutierrezmarcos.es
 * Implementa búsqueda fuzzy con ranking de relevancia
 */

class SearchEngine {
    constructor() {
        this.index = null;
        this.results = [];
        this.initialized = false;
    }

    async initialize() {
        try {
            const response = await fetch('/search-index.json');
            this.index = await response.json();
            this.initialized = true;
            return true;
        } catch (error) {
            console.error('Error cargando índice de búsqueda:', error);
            return false;
        }
    }

    /**
     * Normaliza texto para búsqueda (quita acentos, lowercase, etc)
     */
    normalize(text) {
        return text
            .toLowerCase()
            .normalize('NFD')
            .replace(/[\u0300-\u036f]/g, '') // Quitar acentos
            .replace(/[^\w\s.]/g, ' ') // Reemplazar puntuación por espacios (excepto puntos)
            .replace(/\s+/g, ' ') // Normalizar espacios
            .trim();
    }
    
    /**
     * Normaliza números de tema para comparación
     * Genera variaciones: "3.A.8" → ["3.a.8", "3a8", "3 a 8"]
     */
    normalizeThemeNumber(numero) {
        if (!numero) return [];
        const normalized = this.normalize(numero);
        return [
            normalized,                           // "3.a.8"
            normalized.replace(/\./g, ''),       // "3a8"
            normalized.replace(/\./g, ' '),      // "3 a 8"
            normalized.replace(/\./g, '-'),      // "3-a-8"
        ];
    }

    /**
     * Calcula similitud entre dos strings usando Levenshtein distance
     */
    similarity(str1, str2) {
        const longer = str1.length > str2.length ? str1 : str2;
        const shorter = str1.length > str2.length ? str2 : str1;
        
        if (longer.length === 0) return 1.0;
        
        const editDistance = this.levenshteinDistance(longer, shorter);
        return (longer.length - editDistance) / longer.length;
    }

    levenshteinDistance(str1, str2) {
        const matrix = [];
        
        for (let i = 0; i <= str2.length; i++) {
            matrix[i] = [i];
        }
        
        for (let j = 0; j <= str1.length; j++) {
            matrix[0][j] = j;
        }
        
        for (let i = 1; i <= str2.length; i++) {
            for (let j = 1; j <= str1.length; j++) {
                if (str2.charAt(i - 1) === str1.charAt(j - 1)) {
                    matrix[i][j] = matrix[i - 1][j - 1];
                } else {
                    matrix[i][j] = Math.min(
                        matrix[i - 1][j - 1] + 1,
                        matrix[i][j - 1] + 1,
                        matrix[i - 1][j] + 1
                    );
                }
            }
        }
        
        return matrix[str2.length][str1.length];
    }

    /**
     * Calcula la relevancia de un item para una query
     */
    calculateRelevance(item, queryTerms, queryNormalized, isThemeNumber = false) {
        let score = 0;
        const itemText = this.normalize(
            `${item.title} ${item.description || ''} ${item.content || ''} ${(item.keywords || []).join(' ')}`
        );

        // Búsqueda específica por número de tema (prioridad máxima)
        if (item.numero && (isThemeNumber || queryNormalized.match(/\d+[a-z]\d+/))) {
            const themeVariations = this.normalizeThemeNumber(item.numero);
            const queryVariations = this.normalizeThemeNumber(queryNormalized);
            
            // Coincidencia exacta de número de tema
            for (const themeVar of themeVariations) {
                for (const queryVar of queryVariations) {
                    if (themeVar === queryVar) {
                        score += 500; // Peso muy alto para coincidencia exacta de número
                    }
                    if (themeVar.includes(queryVar) || queryVar.includes(themeVar)) {
                        score += 200; // Peso alto para coincidencia parcial
                    }
                }
            }
            
            // Búsqueda del número en el query normalizado
            const numeroNormalized = this.normalize(item.numero);
            if (queryNormalized.includes(numeroNormalized)) {
                score += 300;
            }
            
            // Variantes sin puntos (ej: "3a8", "3b15")
            const numeroSinPuntos = numeroNormalized.replace(/\./g, '');
            const querySinPuntos = queryNormalized.replace(/\./g, '').replace(/\s+/g, '');
            if (querySinPuntos === numeroSinPuntos) {
                score += 400;
            }
            if (querySinPuntos.includes(numeroSinPuntos) || numeroSinPuntos.includes(querySinPuntos)) {
                score += 150;
            }
            
            // También buscar en keywords
            if (item.keywords) {
                const queryClean = queryNormalized.replace(/\s+/g, '').toLowerCase();
                item.keywords.forEach(keyword => {
                    const keywordClean = keyword.replace(/\./g, '').replace(/\s+/g, '').toLowerCase();
                    if (keywordClean === queryClean) {
                        score += 450;
                    }
                });
            }
        }

        // Coincidencia exacta en título (peso alto)
        if (this.normalize(item.title).includes(queryNormalized)) {
            score += 100;
        }

        // Coincidencia exacta de término completo
        queryTerms.forEach(term => {
            if (term.length < 2) return;

            // Título
            if (this.normalize(item.title).includes(term)) {
                score += 50;
            }

            // Keywords
            if (item.keywords) {
                item.keywords.forEach(keyword => {
                    const keywordNorm = this.normalize(keyword);
                    if (keywordNorm === term) {
                        score += 40;
                    } else if (keywordNorm.includes(term)) {
                        score += 30;
                    }
                });
            }

            // Descripción/contenido
            if (item.description && this.normalize(item.description).includes(term)) {
                score += 20;
            }
            if (item.content && this.normalize(item.content).includes(term)) {
                score += 15;
            }

            // Grupo/ejercicio
            if (item.grupo && this.normalize(item.grupo).includes(term)) {
                score += 25;
            }
            if (item.ejercicio && this.normalize(item.ejercicio).includes(term)) {
                score += 25;
            }
        });

        // Búsqueda fuzzy para términos que no coinciden exactamente
        queryTerms.forEach(term => {
            if (term.length < 3) return;

            const titleWords = this.normalize(item.title).split(' ');
            titleWords.forEach(word => {
                if (word.length < 3) return;
                const sim = this.similarity(term, word);
                if (sim > 0.8) { // Similitud alta
                    score += 20 * sim;
                }
            });

            // Similitud en keywords
            if (item.keywords) {
                item.keywords.forEach(keyword => {
                    const sim = this.similarity(term, this.normalize(keyword));
                    if (sim > 0.8) {
                        score += 15 * sim;
                    }
                });
            }
        });

        // Boost para temas vs ejercicios vs páginas
        if (item.type === 'tema') score *= 1.2;
        if (item.type === 'ejercicio') score *= 1.1;

        return score;
    }

    /**
     * Realiza la búsqueda
     */
    search(query) {
        if (!this.initialized || !query || query.trim().length < 2) {
            return [];
        }

        const queryNormalized = this.normalize(query);
        
        // Detectar si es una búsqueda por número de tema
        const isThemeNumber = /^\d+[\.\s\-]?[a-z][\.\s\-]?\d+$/i.test(query.trim());
        
        const queryTerms = queryNormalized.split(' ').filter(t => t.length >= 2);

        if (queryTerms.length === 0 && !isThemeNumber) {
            return [];
        }

        const allItems = [
            ...this.index.pages,
            ...this.index.temas,
            ...this.index.recursos,
            ...(this.index.blog || [])
        ];

        // Calcular relevancia para cada item
        const results = allItems
            .map(item => ({
                ...item,
                relevance: this.calculateRelevance(item, queryTerms, queryNormalized, isThemeNumber)
            }))
            .filter(item => item.relevance > 0)
            .sort((a, b) => b.relevance - a.relevance)
            .slice(0, 50); // Limitar a 50 resultados

        this.results = results;
        return results;
    }

    /**
     * Obtiene sugerencias mientras se escribe
     */
    getSuggestions(query, limit = 5) {
        const results = this.search(query);
        return results.slice(0, limit);
    }

    /**
     * Resalta términos de búsqueda en texto
     */
    highlightTerms(text, query) {
        if (!text || !query) return text;

        const queryNormalized = this.normalize(query);
        const terms = queryNormalized.split(' ').filter(t => t.length >= 2);
        
        let highlighted = text;
        terms.forEach(term => {
            const regex = new RegExp(`(${term})`, 'gi');
            highlighted = highlighted.replace(regex, '<mark>$1</mark>');
        });

        return highlighted;
    }
}

// Instancia global del motor de búsqueda
const searchEngine = new SearchEngine();
