// Las vistas (src/vistas/*.html) entran en el Worker como texto (regla «Text» de wrangler.toml).
declare module '*.html' {
  const texto: string;
  export default texto;
}
