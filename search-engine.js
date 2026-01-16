/**
 * Motor de búsqueda para victorgutierrezmarcos.es
 * Implementa búsqueda fuzzy con ranking de relevancia
 * Versión mejorada con soporte completo para 4º ejercicio
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
        if (!text) return '';
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
     * Genera variaciones: "3.A.8" → ["3.a.8", "3a8", "3 a 8", "3a08"]
     * También maneja: "4A1" → ["4a1", "4.a.1", "4a01", "4.a.01"]
     */
    normalizeThemeNumber(numero) {
        if (!numero) return [];
        const normalized = this.normalize(numero);
        const variations = [
            normalized,                           // "3.a.8" o "4a1"
            normalized.replace(/\./g, ''),       // "3a8" o "4a1"
            normalized.replace(/\./g, ' '),      // "3 a 8"
            normalized.replace(/\./g, '-'),      // "3-a-8"
        ];
        
        // Detectar y expandir formato compacto (4A1, 4B12, etc.)
        const compactMatch = normalized.match(/^(\d+)([a-z])(\d+)$/i);
        if (compactMatch) {
            const [, num1, letra, num2] = compactMatch;
            const num2Padded = num2.padStart(2, '0');
            variations.push(`${num1}.${letra}.${num2}`);      // "4.a.1"
            variations.push(`${num1}.${letra}.${num2Padded}`); // "4.a.01"
            variations.push(`${num1}${letra}${num2Padded}`);   // "4a01"
        }
        
        // Detectar formato con puntos y expandir
        const dottedMatch = normalized.match(/^(\d+)\.([a-z])\.(\d+)$/i);
        if (dottedMatch) {
            const [, num1, letra, num2] = dottedMatch;
            const num2Padded = num2.padStart(2, '0');
            variations.push(`${num1}${letra}${num2}`);        // "4a1"
            variations.push(`${num1}${letra}${num2Padded}`);  // "4a01"
        }
        
        return [...new Set(variations)]; // Eliminar duplicados
    }

    /**
     * Detecta si una query es un número de tema
     * Soporta: "3.A.1", "3A1", "3a1", "4.B.12", "4B12", "4b12", "4A01", etc.
     */
    isThemeNumberQuery(query) {
        const normalized = this.normalize(query).replace(/\s+/g, '');
        // Patrón para detectar números de tema
        return /^\d+\.?[a-z]\.?\d+$/i.test(normalized);
    }

    /**
     * Calcula similitud entre dos strings usando Levenshtein distance
     */
    similarity(str1, str2) {
        if (!str1 || !str2) return 0;
        const longer = str1.length > str2.length ? str1 : str2;
        const shorter = str1.length > str2.length ? str2 : str1;
        const longerLength = longer.length;
        
        if (longerLength === 0) return 1.0;
        
        const editDistance = this.levenshteinDistance(longer, shorter);
        return (longerLength - editDistance) / longerLength;
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
     * Calcula la relevancia de un item para la búsqueda
     */
    calculateRelevance(item, queryTerms, queryNormalized, isThemeNumber) {
        let score = 0;
        
        // Si es búsqueda por número de tema
        if (isThemeNumber && item.numero) {
            const itemVariations = this.normalizeThemeNumber(item.numero);
            const queryVariations = this.normalizeThemeNumber(queryNormalized);
            
            // Buscar coincidencia exacta entre variaciones
            for (const itemVar of itemVariations) {
                for (const queryVar of queryVariations) {
                    if (itemVar === queryVar) {
                        return 200; // Coincidencia exacta - máxima prioridad
                    }
                    // Coincidencia parcial (ej: "4a" coincide con "4a1", "4a2", etc.)
                    if (itemVar.startsWith(queryVar) || queryVar.startsWith(itemVar)) {
                        score = Math.max(score, 150);
                    }
                }
            }
            
            // También buscar en keywords
            if (item.keywords) {
                const keywordsNorm = item.keywords.map(k => this.normalize(k));
                for (const queryVar of queryVariations) {
                    if (keywordsNorm.some(k => k === queryVar || k.includes(queryVar))) {
                        score = Math.max(score, 180);
                    }
                }
            }
        }

        // Búsqueda en título (alta prioridad)
        const titleNorm = this.normalize(item.title);
        queryTerms.forEach(term => {
            if (titleNorm.includes(term)) {
                score += 50;
                // Bonus si el término aparece al inicio
                if (titleNorm.startsWith(term)) {
                    score += 20;
                }
            }
        });

        // Búsqueda en keywords
        if (item.keywords) {
            const keywordsStr = item.keywords.map(k => this.normalize(k)).join(' ');
            queryTerms.forEach(term => {
                if (keywordsStr.includes(term)) {
                    score += 30;
                }
            });
        }

        // Búsqueda en descripción
        if (item.description) {
            const descNorm = this.normalize(item.description);
            queryTerms.forEach(term => {
                if (descNorm.includes(term)) {
                    score += 15;
                }
            });
        }

        // Búsqueda en contenido (si existe)
        if (item.content) {
            const contentNorm = this.normalize(item.content);
            queryTerms.forEach(term => {
                if (contentNorm.includes(term)) {
                    score += 10;
                }
            });
        }

        // Búsqueda en grupo
        if (item.grupo) {
            const grupoNorm = this.normalize(item.grupo);
            queryTerms.forEach(term => {
                if (grupoNorm.includes(term)) {
                    score += 25;
                }
            });
        }

        // Búsqueda en ejercicio
        if (item.ejercicio) {
            const ejercicioNorm = this.normalize(item.ejercicio);
            queryTerms.forEach(term => {
                if (ejercicioNorm.includes(term)) {
                    score += 25;
                }
            });
        }

        // Búsqueda fuzzy para términos que no coinciden exactamente
        queryTerms.forEach(term => {
            if (term.length < 3) return;

            const titleWords = titleNorm.split(' ');
            titleWords.forEach(word => {
                if (word.length < 3) return;
                const sim = this.similarity(term, word);
                if (sim > 0.8) {
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
        
        // Penalización para temas no disponibles
        if (item.disponible === false) {
            score *= 0.5;
        }

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
        const isThemeNumber = this.isThemeNumberQuery(query);
        
        const queryTerms = queryNormalized.split(' ').filter(t => t.length >= 2);

        if (queryTerms.length === 0 && !isThemeNumber) {
            return [];
        }

        const allItems = [
            ...this.index.pages,
            ...this.index.temas,
            ...this.index.recursos
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
