# AGENTS.md

Este archivo contiene instrucciones para agentes de IA que operan en este repositorio.

## 1. Comandos de Build y Test

Este es un sitio web estático sin un sistema de compilación complejo (como Webpack o Vite).

- **Generación del Índice de Búsqueda**:
  Cada vez que se modifica el contenido del temario o se añaden nuevos archivos, se debe regenerar el índice de búsqueda:
  ```bash
  node build-search-index.js
  ```

- **Desarrollo Local**:
  No hay un servidor de desarrollo configurado. Para probar los cambios:
  - Abrir los archivos `.html` directamente en el navegador.
  - Usar una extensión de servidor estático o `python3 -m http.server` si es necesario (especialmente para `fetch` de JSON local).

- **Testing**:
  No hay framework de testing automatizado (Jest, etc.).
  - **Verificación Manual**: Verificar visualmente los cambios en el navegador.
  - **Validación de Enlaces**: Asegurarse de que los enlaces internos funcionan, especialmente en la navegación y el temario.

## 2. Estilo de Código y Convenciones

### General
- **Idioma**: El contenido, los comentarios y la documentación deben estar en **Español**.
- **Indentación**: **4 espacios** para HTML, CSS y JavaScript.
- **Formato de Archivos**: UTF-8.

### HTML
- **Estructura**: HTML5 semántico.
- **Comillas**: Usar comillas dobles (`"`) para los atributos.
- **Estilos**: Preferir clases y CSS externo sobre estilos en línea (`style="..."`), salvo excepciones justificadas (como en sub-navegación específica).
- **SEO**: Mantener las etiquetas `meta` y datos estructurados `ld+json` en el `<head>`.

### CSS (`styles.css`, `search-styles.css`)
- **Variables**: Usar variables CSS (`--color-primary`, `--font-body`) definidas en `:root` para mantener la consistencia visual.
- **Naming**: Nombres de clases descriptivos en inglés o español (mantener consistencia con el archivo existente), estilo BEM relajado (ej. `site-header`, `header-content`).
- **Responsive**: Media queries al final del archivo o sección relevante. Diseño desktop-first adaptado a móvil.
- **Colores**: Usar la paleta definida en `:root` (tonos morados, dorados y cremas).

### JavaScript (`search-engine.js`, `build-search-index.js`)
- **Versión**: ES6+ (Clases, `async/await`, `const`/`let`).
- **Comillas**: Preferir comillas simples (`'`) para strings, backticks (`` ` ``) para plantillas.
- **Documentación**: Usar JSDoc (`/** ... */`) para clases y métodos complejos.
- **Punto y coma**: Usar punto y coma (`;`) al final de las sentencias.
- **Node.js**: `build-search-index.js` usa CommonJS (`require`). El código del cliente usa ES6 nativo.

### Naming Conventions
- **Archivos**: `kebab-case` (ej. `search-engine.js`, `sobre-mi.html`).
- **Variables JS**: `camelCase`.
- **Clases CSS**: `kebab-case`.

### Manejo de Errores
- En operaciones asíncronas (`fetch`, carga de datos), usar bloques `try/catch` y loguear errores en consola (`console.error`).
- Fallar silenciosamente en la UI si es posible, o mostrar mensajes amigables al usuario (no alertas intrusivas).

## 3. Instrucciones Específicas del Proyecto

- **Rutas**: Al usar herramientas de lectura/escritura, usar siempre **rutas absolutas**.
- **Motor de Búsqueda**: Si se edita `search-engine.js`, tener en cuenta la lógica de ranking (Levenshtein) y la normalización de textos (eliminación de acentos).
- **Banner del Curso**: El HTML del banner debe estar presente en las páginas de la sección `oposicion/`.
- **Firebase**: La configuración de autenticación está en `firebase-config.js`. No exponer claves privadas en el código cliente.
