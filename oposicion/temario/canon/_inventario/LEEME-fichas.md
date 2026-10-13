# Paso 2 del canon: fichas de modelos y notación por áreas

Para cada id de tu(s) área(s) en `_inventario/areas.json` que salga en **dos o más
temas** según `mapa.yaml` (`modelos:`), escribe `canon/modelos/<id>.md`:

```markdown
# <Nombre del modelo>

- **Área:** … · **Tema de referencia:** X.Y.Z (<título corto>) — por qué
- **Temas que lo usan:** X.Y.Z (desarrollo), … (resumen), … (mención)
- **Manuales de referencia:** (los citados en los temas; base: Mas-Colell-Whinston-Green, Varian,
  Romer, Blanchard, Krugman-Obstfeld, Feenstra, Gandolfo…; con capítulo si se sabe)

## Presentación de referencia
Pregunta a la que responde. Supuestos. Ecuaciones clave en notación canónica (LaTeX).
Resultado principal. Gráfico de referencia: qué ejes, qué curvas, qué se desplaza
(y ruta del .tex si ya existe en algún tema revisado: oposicion/temario/fuentes/*/graficos/).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |

## Divergencias encontradas en el temario actual
Notación, supuestos o resultados que hoy cambian de un tema a otro, y errores detectados
(con tema). Propuesta de unificación: **[decidir]** si hay alternativas razonables.
```

Además escribe `canon/_notacion/<área>.md`: tabla de símbolos del área (símbolo,
significado, alternativas que aparecen y en qué temas, **propuesta**, motivo), marcando
**[decidir]** cuando haya conflicto real, y los choques con otras áreas que se mezclan.

Fuentes: `mapa.yaml`, `_inventario/resumen-por-area.md` (sección de tu área; ojo, la
detección de conflictos de notación es heurística y tiene ruido: compruébala),
`_inventario/<T>.json` de los temas implicados y, si hace falta precisar, el original del
tema (pandoc sobre el Word; rutas en el campo `fuente`). Para 3.A.8, la fuente revisada
`oposicion/temario/fuentes/3A08/3A08.tex` manda (su notación ya es canon). Usa una
carpeta de trabajo propia (no el scratchpad compartido). No toques nada fuera de
`canon/modelos/` y `canon/_notacion/`. No hagas commit.
