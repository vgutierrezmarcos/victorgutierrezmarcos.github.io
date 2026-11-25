/**
 * Motor del buscador de victorgutierrezmarcos.es (25/11/2026).
 *
 * - Texto completo con Pagefind (/pagefind/, lo genera scripts/buscador/): cada
 *   apartado de cada tema en PDF, las páginas de la web, el blog y las preguntas
 *   oficiales del test. Descarga solo los trozos del índice que necesita.
 * - Los números de tema van aparte («3a14», «3.A.14», «tema 14»), con la lista
 *   ligera de search-index.json, que sirve también para «¿Quisiste decir…?».
 * - Los temas revisados llevan a su página web (…/3A14.html#apartado=I.2.); los
 *   demás, al PDF en la página del apartado (…/4A01.pdf#page=7).
 *
 * Autor: Víctor Gutiérrez Marcos
 */
class SearchEngine {
    static VACIAS = new Set(['los', 'las', 'del', 'una', 'que', 'con', 'por', 'para', 'sus', 'como', 'tema', 'temas']);

    constructor() {
        this.index = null;      // search-index.json (temas, páginas)
        this.pf = null;         // Pagefind
        this.vocabulario = null;
        this.cargando = null;
    }

    // Se llama al abrir el buscador; varias llamadas comparten la misma carga.
    initialize() {
        if (!this.cargando) this.cargando = this._cargar().then(ok => { if (!ok) this.cargando = null; return ok; });
        return this.cargando;
    }

    async _cargar() {
        try {
            const [indice, pf] = await Promise.all([
                fetch('/search-index.json').then(r => r.json()),
                import('/pagefind/pagefind.js'),
            ]);
            this.index = indice;
            await pf.options({ excerptLength: 22 });
            await pf.init();
            this.pf = pf;
            return true;
        } catch (error) {
            console.error('Error cargando el buscador:', error);
            return false;
        }
    }

    normalize(text) {
        return String(text || '').toLowerCase().normalize('NFD').replace(/[\u0300-\u036f]/g, '')
            .replace(/[^\w\s.]/g, ' ').replace(/\s+/g, ' ').trim();
    }

    /** «3a14», «3.A.14», «tema 3 a 14» → ['3.A.14']; «tema 14» → los 14 de cada parte. */
    temasPorNumero(q) {
        const n = this.normalize(q);
        let m = /^(?:tema\s*)?(\d)\s*[.\-_ ]?\s*([ab])\s*[.\-_ ]?\s*(\d{1,2})$/.exec(n);
        const temas = (this.index && this.index.temas) || [];
        if (m) {
            const codigo = `${m[1]}.${m[2].toUpperCase()}.${Number(m[3])}`;
            return temas.filter(t => t.numero === codigo);
        }
        m = /^tema\s+(\d{1,2})$/.exec(n);
        if (m) return temas.filter(t => t.numero && t.numero.split('.')[2] === String(Number(m[1])));
        return [];
    }

    /** La URL de un tema del índice ligero (relativas a /oposicion/). */
    urlTema(t) {
        if (!t.url || t.disponible === false) return null;
        const u = /^(https?:)?\//.test(t.url) ? t.url : '/oposicion/' + t.url;
        return u;
    }

    /** Adónde lleva un registro de Pagefind. */
    destino(d) {
        const m = d.meta || {};
        if (m.tipo === 'tema' && m.pdf) {
            const pdf = m.pdf.replace(/^https:\/\/www\.victorgutierrezmarcos\.es/, '');
            if (m.revisado === 'si') {
                const etiqueta = (/^([IVX]+(?:\.\d+)*\.|[A-H]\.)\s/.exec(m.apartado || '') || [])[1];
                return { url: pdf.replace(/\.pdf$/, '.html') + (etiqueta ? '#apartado=' + encodeURIComponent(etiqueta) : ''), pdf: false };
            }
            return { url: pdf + (m.pagina ? '#page=' + m.pagina : ''), pdf: true };
        }
        return { url: d.url, pdf: /\.pdf(#|$)/.test(d.url) };
    }

    /**
     * Busca: { directos: [temas por número], grupos: [{tipo, titulo, url, codigo, items:[{apartado, url, extracto}]}],
     * total, sugerencia }. [tipo]: '', 'Temas', 'Páginas', 'Blog', 'Preguntas de test'.
     */
    async buscar(query, { tipo = '', max = 30 } = {}) {
        await this.initialize();
        const directos = this.temasPorNumero(query);
        // Un número de tema («3a14», «tema 14») va directo, sin buscar en el texto.
        if (directos.length) return { directos, grupos: [], total: 0, sugerencia: null };
        const opciones = tipo ? { filters: { tipo } } : undefined;
        // Sin tildes: el índice lleva cada palabra con tilde también sin ella (indexar.mjs), y Pagefind
        // no iguala «óptimas» con «optimas»; con la tilde, la palabra a veces ni se encuentra.
        const sinTildes = query.normalize('NFD').replace(/[\u0300-\u036f]/g, '');
        let r = this.pf ? await this.pf.search(sinTildes, opciones) : { results: [] };
        if (sinTildes !== query && this.pf && !r.results.length) r = await this.pf.search(query, opciones);
        // Reordena los primeros por coincidencia exacta en el apartado o el título: Pagefind
        // reduce «plazas» y «plazos» a la misma raíz y no premia la frase del título.
        const cand = r.results.slice(0, Math.max(max, 30));
        const datosCand = await Promise.all(cand.map(x => x.data()));
        const pal = this.normalize(query).split(' ').filter(w => w.length > 2 && !SearchEngine.VACIAS.has(w));
        const esta = (texto, w) => new RegExp(`(^|[^a-z0-9])${w.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}`).test(texto);
        const puntos = cand.map((x, i) => {
            const m = datosCand[i].meta || {};
            const ap = this.normalize(m.apartado || ''), ti = this.normalize(m.title || '');
            let f = 1;
            if (pal.length && pal.every(w => esta(ap, w))) f += 3;
            else if (pal.length && pal.every(w => esta(ti, w))) f += 1.5;
            // La frase entera, seguida, en el apartado o el título. (El fragmento no cuenta: puede
            // salir de la lista de palabras sin tilde del índice y premiaría lo que no es.)
            if (pal.length > 1 && [ap, ti].some(t => t.includes(pal.join(' ')))) f += 1;
            if (m.tipo === 'test') f *= 0.6;
            // Los anexos, un poco por debajo de los apartados que se cantan.
            if (/^[A-L]\. Anexo/.test(m.apartado || '')) f *= 0.75;
            return { i, s: (x.score || 0) * f };
        }).sort((a, b) => b.s - a.s);
        const datos = puntos.slice(0, max).map(p => datosCand[p.i]);
        const grupos = [];
        const porTema = new Map();
        for (const d of datos) {
            const m = d.meta || {};
            const dest = this.destino(d);
            if (m.tipo === 'tema' && m.codigo) {
                let g = porTema.get(m.codigo);
                if (!g) {
                    const urlTema = m.revisado === 'si' ? dest.url.replace(/#.*$/, '') : (m.pdf || '').replace(/^https:\/\/www\.victorgutierrezmarcos\.es/, '');
                    g = { tipo: 'tema', titulo: m.title || '', codigo: m.codigo, url: urlTema, pdf: m.revisado !== 'si', items: [] };
                    porTema.set(m.codigo, g);
                    grupos.push(g);
                }
                if (g.items.length < 3) g.items.push({ apartado: m.apartado || '', url: dest.url, pdf: dest.pdf, extracto: d.excerpt });
            } else {
                // Los trozos de una misma página (…#parte-2), una sola vez: el mejor.
                const base = dest.url.replace(/#parte-\d+$/, '');
                if (porTema.has('url:' + base)) continue;
                porTema.set('url:' + base, true);
                grupos.push({ tipo: m.tipo || 'pagina', titulo: m.title || d.url, url: base, pdf: dest.pdf, extracto: d.excerpt, codigo: m.codigo || '' });
            }
        }
        const total = r.results.length;
        return { directos, grupos, total, sugerencia: total > 1 ? null : this.sugerir(query) };
    }

    /** Repone las tildes de las palabras escritas sin ellas que aparecen con tilde en títulos y conceptos. */
    acentuar(query) {
        if (!this.tildes) {
            this.tildes = new Map();
            const meter = t => String(t || '').toLowerCase().split(/[^a-záéíóúüñ]+/).forEach(w => {
                if (w.length >= 4 && /[áéíóúü]/.test(w)) this.tildes.set(this.normalize(w), w);
            });
            for (const t of (this.index && this.index.temas) || []) { meter(t.title); (t.keywords || []).forEach(meter); }
            for (const p of (this.index && this.index.pages) || []) { meter(p.title); (p.keywords || []).forEach(meter); }
        }
        return query.split(/(\s+)/).map(w => (/[áéíóúü]/i.test(w) ? w : this.tildes.get(this.normalize(w)) || w)).join('');
    }

    // ---------------------------------------------------------------- ¿Quisiste decir…?

    _vocabulario() {
        if (this.vocabulario) return this.vocabulario;
        const v = new Set();
        const meter = t => this.normalize(t).split(' ').forEach(w => { if (w.length >= 4 && !/^\d/.test(w)) v.add(w); });
        for (const t of (this.index && this.index.temas) || []) {
            meter(t.title);
            (t.keywords || []).forEach(meter);
        }
        for (const p of ((this.index && this.index.pages) || [])) { meter(p.title); (p.keywords || []).forEach(meter); }
        this.vocabulario = [...v];
        return this.vocabulario;
    }

    /** La consulta con cada palabra desconocida cambiada por la más parecida del vocabulario (o null). */
    sugerir(query) {
        const voc = this._vocabulario();
        const conocidas = new Set(voc);
        let cambiada = false;
        const palabras = this.normalize(query).split(' ').map(w => {
            if (w.length < 4 || conocidas.has(w)) return w;
            let mejor = null, dist = w.length <= 6 ? 2 : 3; // como mucho 1 cambio en palabras cortas, 2 en largas
            for (const c of voc) {
                if (Math.abs(c.length - w.length) > 2) continue;
                const d = this.levenshtein(w, c);
                if (d < dist) { dist = d; mejor = c; }
            }
            if (mejor) { cambiada = true; return mejor; }
            return w;
        });
        return cambiada ? palabras.join(' ') : null;
    }

    levenshtein(a, b) {
        const m = Array.from({ length: b.length + 1 }, (_, i) => [i]);
        for (let j = 0; j <= a.length; j++) m[0][j] = j;
        for (let i = 1; i <= b.length; i++) {
            for (let j = 1; j <= a.length; j++) {
                m[i][j] = b[i - 1] === a[j - 1] ? m[i - 1][j - 1] : Math.min(m[i - 1][j - 1] + 1, m[i][j - 1] + 1, m[i - 1][j] + 1);
            }
        }
        return m[b.length][a.length];
    }
}

// Instancia global del motor de búsqueda
const searchEngine = new SearchEngine();
