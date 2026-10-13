# Función Cobb-Douglas (producción y utilidad)

- **Área:** consumidor-producción · **Tema de referencia:** **3.A.11** (Teoría de la producción). La Cobb-Douglas que se usa en el resto del temario es casi siempre la *función de producción* (Solow 3.A.43, RBC 3.A.6 y 3.A.42, crecimiento endógeno 3.A.44, emparejamiento 3.A.26, PIB potencial 4.B.4, formas funcionales empíricas 3.A.12), y 3.A.11 tiene en el título rendimientos a escala y elasticidad de sustitución, las dos propiedades que la definen. 3.A.8 es el tema de referencia de la **variante de utilidad** (demandas con participaciones constantes) y remite a 3.A.11 cuando habla de la función de producción.
- **Temas que lo usan:** 3.A.11 (desarrollo; revisado el 13/10/2026), 3.A.8 (resumen), 3.A.9 (resumen), 3.A.6 (mención); también, con otros ids, 3.A.12, 3.A.18, 3.A.26, 3.A.42-3.A.44 y 4.B.4.
- **Manuales de referencia:** Cobb y Douglas (1928); Varian, cap. 1 y 7; Mas-Colell, Whinston y Green, cap. 3 (utilidad) y 5 (producción); Romer, *Advanced Macroeconomics*, cap. 1.
- **Decisión D005 (13/10/2026):** ¿Cuál es el tema de referencia de la Cobb-Douglas? 3.A.11 (función de producción: rendimientos y elasticidad de sustitución), con 3.A.8 como referencia de la variante de utilidad

## Presentación de referencia
Pregunta: la forma funcional más sencilla con buen comportamiento (Inada, isocuantas convexas) y σ=1.

Producción (canon, desarrollo de referencia en 3.A.11, I.3, `eq:cobb-douglas`): $$q=A\,z_K^{\alpha}z_L^{\beta},\qquad A,\alpha,\beta>0$$
- Productividades: $PMg_K=\alpha q/z_K$, $PMg_L=\beta q/z_L$ (exponente × productividad media); elasticidades-producto constantes $\varepsilon_{q,z_K}=\alpha$, $\varepsilon_{q,z_L}=\beta$; con $\alpha,\beta<1$ cumple Inada y está entera en la región económica.
- Sustitución: $RMST_{LK}=\frac{\beta}{\alpha}\frac{z_K}{z_L}$; $\ln(z_K/z_L)=\ln RMST_{LK}+\ln(\alpha/\beta)$, luego $\sigma=1$.
- Escala: $F(tz)=t^{\alpha+\beta}F(z)$, homogénea de grado $k=\alpha+\beta$ ($\varepsilon_{q,t}=\alpha+\beta$).
- Distribución: con $\beta=1-\alpha$ y pago según la PMg, Euler $q=PMg_Kz_K+PMg_Lz_L$; participaciones constantes $\alpha$ y $1-\alpha$.
- Progreso técnico: las neutralidades de Hicks, Solow y Harrod coinciden, $A_tz_K^{\alpha}z_L^{\beta}=(A_t^{1/\alpha}z_K)^{\alpha}z_L^{\beta}=z_K^{\alpha}(A_t^{1/\beta}z_L)^{\beta}$ (ficha `progreso-tecnico-neutral`).
- Límite de la CES cuando σ→1: $q=A\,z_K^{\nu a_K}z_L^{\nu a_L}$ (ficha `ces`).
- Origen: Cobb y Douglas (1928), manufacturas de EE. UU. 1899-1922, $q\approx1{,}01\,z_K^{1/4}z_L^{3/4}$ (exponentes que suman uno y se acercan a las participaciones observadas; Douglas, 1976). Esta es la cifra canónica: no usar «70/30» como estimación de 1928.
En macro, con rendimientos constantes: $Y=AK^{\alpha}L^{1-\alpha}$ (α = participación del capital en la renta con remuneración competitiva).
Utilidad (3.A.8): $U=x_1^{\alpha}x_2^{\beta}$ ⇒ $x_1=\frac{\alpha}{\alpha+\beta}\frac{\overline W}{p_1}$, $x_2=\frac{\beta}{\alpha+\beta}\frac{\overline W}{p_2}$ (participación del gasto constante); límite de la CES cuando σ→1.
Gráfico de referencia: superficie de producción en $\mathbb{R}^3$ con isocuantas, corte de corto plazo y corte por un rayo, `oposicion/temario/fuentes/3A11/graficos/superficie-produccion.tex` (adapta la superficie de utilidad del 3.A.8); en 3.A.8, `oposicion/temario/fuentes/3A08/graficos/superficie-utilidad.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.11 | Tecnología, rendimientos, σ | desarrollo (hecho, 13/10/2026) | Párrafo propio en I.3: productividades e Inada, RMST y σ=1, escala α+β, distribución y Euler, coincidencia de las neutralidades, origen (Cobb y Douglas, 1928, con la estimación $z_K^{1/4}z_L^{3/4}$); superficie de producción; límite de la CES; macro $Y=AK^{\alpha}L^{1-\alpha}$ con remisión a 3.A.43 y 3.A.45 | Las demandas del consumidor (3.A.8) |
| 3.A.8 | Demanda marshalliana | resumen | Variante de utilidad y demandas (anexo der:cobb-douglas) | Rendimientos |
| 3.A.9 | Sistemas de demanda | resumen | Primera forma funcional empírica: participaciones constantes, $\ln x_i=\ln\frac{\alpha_i}{\sum\alpha}+\ln\overline W-\ln p_i$ | Volver a derivar las demandas (remitir a 3.A.8) |
| 3.A.6 | RBC | mención | Tecnología del RBC; remitir a 3.A.11 | — |

## Divergencias encontradas en el temario actual
- 3.A.11: resuelta en la revisión del 13/10/2026 (antes era una línea dentro de la CES, como caso exacto con α, β libres).
- 3.A.9 escribe precios en mayúscula $P_x$ en la Cobb-Douglas y $p$ en el resto: usar $p$.
- 3.A.9 llama a la Cobb-Douglas «lineal en logaritmos» y a la Stone-Geary «log-lineal»: precisar (la Cobb-Douglas es log-lineal en el sentido de que las demandas son lineales en logaritmos).
- Exponentes: α, β en consumo (3.A.8, 3.A.9) y α, 1−α en macro: ambos válidos; en producción general usar α, β y decir «con rendimientos constantes, β=1−α».
