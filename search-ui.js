/**
 * Interfaz de búsqueda - UI y handlers
 * Versión mejorada con soporte para 4º ejercicio
 */

class SearchUI {
    constructor() {
        this.searchInput = null;
        this.searchButton = null;
        this.searchResults = null;
        this.searchOverlay = null;
        this.currentQuery = '';
        this.debounceTimer = null;
        this.selectedIndex = -1;
    }

    async initialize() {
        // Inicializar el motor de búsqueda
        const initialized = await searchEngine.initialize();
        if (!initialized) {
            console.error('No se pudo inicializar el buscador');
            return;
        }

        this.createSearchUI();
        this.attachEventListeners();
    }

    createSearchUI() {
        // Crear el overlay de búsqueda
        const overlay = document.createElement('div');
        overlay.id = 'search-overlay';
        overlay.className = 'search-overlay';
        overlay.innerHTML = `
            <div class="search-modal">
                <div class="search-header">
                    <div class="search-input-container">
                        <svg class="search-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <circle cx="11" cy="11" r="8"/>
                            <path d="m21 21-4.35-4.35"/>
                        </svg>
                        <input 
                            type="text" 
                            id="search-input" 
                            class="search-input" 
                            placeholder="Buscar temas, ejercicios, recursos..."
                            autocomplete="off"
                            spellcheck="false"
                        />
                        <button class="search-close" aria-label="Cerrar búsqueda">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                                <line x1="18" y1="6" x2="6" y2="18"/>
                                <line x1="6" y1="6" x2="18" y2="18"/>
                            </svg>
                        </button>
                    </div>
                    <div class="search-tips">
                        <span class="search-tip">💡 Escribe el número del tema (ej: "4A1", "3.B.5") o palabras clave</span>
                    </div>
                </div>
                <div class="search-results-container">
                    <div id="search-results" class="search-results"></div>
                </div>
                <div class="search-footer">
                    <div class="search-shortcuts">
                        <span><kbd>↑</kbd> <kbd>↓</kbd> para navegar</span>
                        <span><kbd>Enter</kbd> para abrir</span>
                        <span><kbd>Esc</kbd> para cerrar</span>
                    </div>
                </div>
            </div>
        `;

        document.body.appendChild(overlay);

        this.searchOverlay = overlay;
        this.searchInput = document.getElementById('search-input');
        this.searchResults = document.getElementById('search-results');

        // Agregar botón de búsqueda en la navegación
        const nav = document.querySelector('.nav-list');
        if (nav) {
            const searchLi = document.createElement('li');
            searchLi.innerHTML = `
                <a href="#" id="open-search" class="search-trigger">
                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                        <circle cx="11" cy="11" r="8"/>
                        <path d="m21 21-4.35-4.35"/>
                    </svg>
                    BUSCAR
                </a>
            `;
            nav.appendChild(searchLi);
        }
    }

    attachEventListeners() {
        // Abrir búsqueda
        const openSearchBtn = document.getElementById('open-search');
        if (openSearchBtn) {
            openSearchBtn.addEventListener('click', (e) => {
                e.preventDefault();
                this.openSearch();
            });
        }

        // Cerrar búsqueda
        const closeBtn = this.searchOverlay.querySelector('.search-close');
        closeBtn.addEventListener('click', () => this.closeSearch());

        // Cerrar al hacer click fuera del modal
        this.searchOverlay.addEventListener('click', (e) => {
            if (e.target === this.searchOverlay) {
                this.closeSearch();
            }
        });

        // Input de búsqueda con debounce
        this.searchInput.addEventListener('input', (e) => {
            clearTimeout(this.debounceTimer);
            this.debounceTimer = setTimeout(() => {
                this.performSearch(e.target.value);
            }, 200); // Reducido de 300ms a 200ms para mejor respuesta
        });

        // Atajos de teclado
        document.addEventListener('keydown', (e) => {
            // Ctrl/Cmd + K para abrir búsqueda
            if ((e.ctrlKey || e.metaKey) && e.key === 'k') {
                e.preventDefault();
                this.openSearch();
            }

            // Escape para cerrar
            if (e.key === 'Escape' && this.searchOverlay.classList.contains('active')) {
                this.closeSearch();
            }

            // Navegación con flechas
            if (this.searchOverlay.classList.contains('active')) {
                if (e.key === 'ArrowDown' || e.key === 'ArrowUp') {
                    e.preventDefault();
                    this.navigateResults(e.key === 'ArrowDown' ? 1 : -1);
                }

                // Enter para abrir resultado seleccionado
                if (e.key === 'Enter') {
                    const selected = this.searchResults.querySelector('.search-result-item.selected');
                    if (selected) {
                        e.preventDefault();
                        const link = selected.querySelector('a');
                        if (link) {
                            window.location.href = link.href;
                        }
                    }
                }
            }
        });
    }

    openSearch() {
        this.searchOverlay.classList.add('active');
        this.searchInput.focus();
        document.body.style.overflow = 'hidden';
    }

    closeSearch() {
        this.searchOverlay.classList.remove('active');
        this.searchInput.value = '';
        this.searchResults.innerHTML = '';
        this.selectedIndex = -1;
        document.body.style.overflow = '';
    }

    navigateResults(direction) {
        const items = this.searchResults.querySelectorAll('.search-result-item');
        if (items.length === 0) return;

        // Quitar selección actual
        items.forEach(item => item.classList.remove('selected'));

        // Actualizar índice
        this.selectedIndex += direction;
        if (this.selectedIndex < 0) this.selectedIndex = items.length - 1;
        if (this.selectedIndex >= items.length) this.selectedIndex = 0;

        // Seleccionar nuevo item
        const selectedItem = items[this.selectedIndex];
        selectedItem.classList.add('selected');
        selectedItem.scrollIntoView({ block: 'nearest' });
    }

    performSearch(query) {
        this.currentQuery = query;
        this.selectedIndex = -1;

        if (!query || query.trim().length < 2) {
            this.searchResults.innerHTML = this.renderEmptyState();
            return;
        }

        const results = searchEngine.search(query);
        this.renderResults(results, query);
    }

    renderEmptyState() {
        return `
            <div class="search-empty">
                <p>Escribe al menos 2 caracteres para buscar...</p>
                <div class="search-suggestions">
                    <p><strong>Sugerencias:</strong></p>
                    <ul>
                        <li>Número de tema: <code>4A1</code>, <code>3.B.5</code>, <code>4B12</code></li>
                        <li>Palabras clave: <code>balanza de pagos</code>, <code>imposición</code></li>
                        <li>Ejercicio: <code>tercer ejercicio</code>, <code>cuarto ejercicio</code></li>
                    </ul>
                </div>
            </div>
        `;
    }

    renderResults(results, query) {
        if (results.length === 0) {
            this.searchResults.innerHTML = `
                <div class="search-no-results">
                    <p>No se encontraron resultados para "<strong>${this.escapeHtml(query)}</strong>"</p>
                    <p class="search-no-results-hint">Prueba con otros términos o el número del tema (ej: 4A1, 3B5)</p>
                </div>
            `;
            return;
        }

        // Agrupar resultados por tipo
        const grouped = this.groupResults(results);
        
        let html = '';
        
        // Renderizar cada grupo
        for (const [groupName, items] of Object.entries(grouped)) {
            if (items.length === 0) continue;
            
            html += `<div class="search-result-group">`;
            html += `<div class="search-result-group-title">${groupName}</div>`;
            
            items.forEach(item => {
                html += this.renderResultItem(item, query);
            });
            
            html += `</div>`;
        }

        this.searchResults.innerHTML = html;
    }

    groupResults(results) {
        const groups = {
            'Temas del 4º ejercicio': [],
            'Temas del 3er ejercicio': [],
            'Otros ejercicios': [],
            'Páginas': [],
            'Recursos': []
        };

        results.forEach(item => {
            if (item.type === 'tema' || item.type === 'subtema') {
                if (item.ejercicio === 'Cuarto ejercicio') {
                    groups['Temas del 4º ejercicio'].push(item);
                } else if (item.ejercicio === 'Tercer ejercicio') {
                    groups['Temas del 3er ejercicio'].push(item);
                } else {
                    groups['Otros ejercicios'].push(item);
                }
            } else if (item.type === 'ejercicio') {
                groups['Otros ejercicios'].push(item);
            } else if (item.type === 'excel' || item.type === 'pdf' || item.type === 'word' || item.type === 'presentacion') {
                groups['Recursos'].push(item);
            } else {
                groups['Páginas'].push(item);
            }
        });

        return groups;
    }

    renderResultItem(item, query) {
        const isUnavailable = item.disponible === false;
        const unavailableClass = isUnavailable ? 'unavailable' : '';
        const unavailableBadge = isUnavailable ? '<span class="badge-unavailable">No disponible</span>' : '';
        
        let icon = this.getTypeIcon(item.type);
        let subtitle = this.getSubtitle(item);
        let title = item.numero ? `${item.numero}: ${item.title}` : item.title;
        
        // Resaltar términos de búsqueda
        title = searchEngine.highlightTerms(title, query);
        
        return `
            <div class="search-result-item ${unavailableClass}" data-url="${item.url}">
                <a href="${item.url}" class="search-result-link">
                    <div class="search-result-icon">${icon}</div>
                    <div class="search-result-content">
                        <div class="search-result-title">${title} ${unavailableBadge}</div>
                        ${subtitle ? `<div class="search-result-subtitle">${subtitle}</div>` : ''}
                    </div>
                </a>
            </div>
        `;
    }

    getTypeIcon(type) {
        const icons = {
            'tema': '📄',
            'subtema': '📑',
            'ejercicio': '📚',
            'page': '📖',
            'pdf': '📕',
            'excel': '📊',
            'word': '📝',
            'presentacion': '🎯'
        };
        return icons[type] || '📄';
    }

    getSubtitle(item) {
        const parts = [];
        
        if (item.ejercicio) {
            parts.push(item.ejercicio);
        }
        
        if (item.grupo) {
            parts.push(item.grupo);
        }
        
        if (item.description) {
            parts.push(item.description);
        }
        
        if (item.category) {
            parts.push(item.category);
        }
        
        return parts.join(' › ');
    }

    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
}

// Inicializar cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
    const searchUI = new SearchUI();
    searchUI.initialize();
});
