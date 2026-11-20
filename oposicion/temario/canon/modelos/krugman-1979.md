# Competencia monopolística y comercio (Krugman 1979, 1980)

- **Área:** comercio · **Tema de referencia:** 3.B.6 (Nueva teoría del comercio internacional) — lo tiene en el título (competencia imperfecta, rendimientos crecientes).
- **No confundir** con Krugman (1979, *Journal of Money, Credit and Banking*), el modelo de crisis de balanza de pagos de primera generación (`Krugman1979Model`): ficha `flood-garber` (referencia el 3.B.17, revisado el 12/11/2026). Tampoco `Krugman1998What` (3.B.6, nueva geografía económica) con «What happened to Asia?» (`Krugman1998Asia`, 3.B.17).
- **Temas que lo usan:** 3.B.6 (desarrollo; hecho, 5/11/2026: I.2 `sec:krugman` y I.3 `sec:extensiones-krugman`; derivaciones en `anexo:krugman`), 3.A.18 (mención; hecho, 19/10/2026), 3.B.10 (mención: más variedades y menor precio con el mercado ampliado), 3.B.34 (mención), 3.B.39 (mención), 3.B.41 (mención)
- **Manuales de referencia:** Krugman (1979, *JIE*; 1980, *AER*); Dixit y Stiglitz (1977); Helpman y Krugman, *Market Structure and Foreign Trade* (1985); Feenstra, *Advanced International Trade*, cap. 5; Krugman, Obstfeld y Melitz, cap. 8.

## Presentación de referencia
**Pregunta:** ¿por qué comercian países idénticos (comercio intraindustrial)?

**Supuestos:** preferencias CES por la variedad (Dixit-Stiglitz), trabajo único factor, coste $C(q) = w(F + cq)$, libre entrada, costes iceberg $\tau$ (Krugman, 1980).

**Ecuaciones (notación canónica):**
$$U = \Big[\sum_{i=1}^{n} x_i^{\rho}\Big]^{1/\rho},\quad \rho = \frac{\sigma-1}{\sigma},\; \sigma > 1; \qquad p = \frac{\sigma}{\sigma-1}\,c\,w; \qquad q^* = \frac{F(\sigma-1)}{c}; \qquad n = \frac{L}{\sigma F}$$
**Resultado:** la apertura aumenta el número de variedades disponibles; con Krugman (1979, elasticidad creciente) también baja el margen y aumenta la escala; efecto mercado doméstico (1980). Índice de Grubel-Lloyd para medir el comercio intraindustrial.

**Plano y curvas (CC6 del 3.B.6):** plano $(x,\ p/w)$, con $x$ el consumo por persona de cada variedad y $q=\bar Lx$ ($c$ es el coste marginal: no va en el eje). $PP$: $p/w=\frac{\sigma(x)}{\sigma(x)-1}c$ con $\sigma'(x)<0$; $ZZ$: $p/w=c+F/(\bar Lx)$. Función clave del 3.B.6 `eq:precio-krugman` ($p^*=\frac{\sigma}{\sigma-1}cw$, $q^*$, $n^*=L/(\sigma F)$); el margen sin letra (ficha `dixit-stiglitz`). Vocabulario: «efecto escala» ($q$ sube) y «racionalización» (menos empresas por país) en Krugman; «selección» y «reasignación» solo en Melitz. Ejemplo del enganche del 3.B.6: automóviles de España (no el de Alemania del 3.A.18).

**Gráficos de referencia:** `oposicion/temario/fuentes/3B06/graficos/krugman-ppzz-autarquia.tex` (PP, ZZ, $E_0$) y `krugman-ppzz.tex` (apertura), en 2 pasos; caso CES con PP horizontal en `krugman-ppzz-ces.tex` (caja gris); `krugman-tangencia.tex` (apoyo).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.6 | Nueva teoría del comercio | desarrollo (hecho, 5/11/2026) | Modelo con PP y ZZ en 2 pasos, efecto escala y racionalización; Krugman (1980), costes iceberg y efecto mercado doméstico; Grubel-Lloyd `eq:grubel-lloyd` (anexo `anexo:intraindustrial`); implicaciones con las 4 preguntas | — |
| 3.A.18 | Competencia monopolística | mención (hecho, 19/10/2026) | En c) Extensiones de Dixit-Stiglitz: Krugman (1979) comercio intraindustrial entre países iguales, Krugman (1980) costes de transporte y efecto del mercado doméstico, con `\vertema{3.B.6}`; ejemplo de los turismos con Alemania (Grubel-Lloyd 0,97); en la valoración, la elasticidad creciente de 1979 para que la competencia reduzca el margen | Dixit-Stiglitz se desarrolla en 3.A.18 (`dixit-stiglitz`) y 3.B.6 debe remitir allí para la demanda |
| 3.B.34, 3.B.39, 3.B.41 | OMC, política comercial UE | mención | Ganancias por variedad y escala | — |
| 3.B.10 | Integración económica | mención | Más variedades y menor precio con el mercado ampliado | El modelo |

## Divergencias encontradas en el temario actual
- La variedad se llama $x_i$ en la demanda y $x$/$q$ en la oferta; luego $y_k$ en la NEG del mismo tema. Canon: $x_i$ consumo, $q$ producción por empresa.
- $\rho$ es aquí el parámetro CES y en 3.B.2 la prima de riesgo: ver `_notacion/finanzas-empresa.md`.

Autor: Víctor Gutiérrez Marcos
