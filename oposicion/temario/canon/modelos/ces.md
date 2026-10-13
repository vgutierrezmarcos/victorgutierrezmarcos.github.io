# Función CES (elasticidad de sustitución constante)

- **Área:** consumidor-producción · **Tema de referencia:** 3.A.11 (Teoría de la producción) — el título incluye «elasticidad de sustitución» y es donde se desarrolla la forma funcional con sus casos límite; 3.A.8 la presenta como utilidad (ya revisado, sirve de modelo de redacción).
- **Temas que lo usan:** 3.A.11 (desarrollo; revisado el 13/10/2026), 3.A.8 (resumen), 3.A.18 (resumen), 3.A.44 (mención)
- **Manuales de referencia:** Arrow, Chenery, Minhas y Solow (1961); Mas-Colell, Whinston y Green (1995), cap. 3 y 5; Varian, *Análisis microeconómico*, cap. 1; Dixit y Stiglitz (1977) para el agregador de variedades.

## Presentación de referencia
Pregunta: ¿cómo representar una tecnología (o unas preferencias) con una facilidad de sustitución entre factores que no cambia con la proporción en que se usan?
Supuestos: dos o más factores (bienes), pesos positivos, σ constante.

$$q=A\left[\sum_{i=1}^{n}a_i\,z_i^{\rho}\right]^{\frac{\nu}{\rho}},\qquad \rho\equiv\frac{\sigma-1}{\sigma},\qquad A,a_i,\nu>0,\qquad \textstyle\sum_ia_i=1$$
(forma de 3.A.11, `eq:ces`; con ν = 1, rendimientos constantes, que es la habitual). Con dos factores, $RMST_{LK}=\frac{a_L}{a_K}\left(\frac{z_K}{z_L}\right)^{1-\rho}$ y $\sigma=1/(1-\rho)$.
$$\sigma\equiv\frac{d\ln(z_K/z_L)}{d\ln RMST_{LK}}$$
Casos límite (son **límites**, no casos exactos; en ρ = 0 la expresión no está definida; derivación por L'Hôpital en 3.A.11, anexo `der:ces`): σ→∞ (ρ→1) lineal $q=A(a_Kz_K+a_Lz_L)^{\nu}$; σ→1 (ρ→0) Cobb-Douglas $q=A\,z_K^{\nu a_K}z_L^{\nu a_L}$; σ→0 (ρ→−∞) Leontief $q=A\min\{z_K,z_L\}^{\nu}$, que con unidades $z_K/a$, $z_L/b$ es $q=\min\{z_K/a;\,z_L/b\}$. Homogénea de grado ν. Fuera de σ = 1 las participaciones varían con el precio relativo (regla de Hicks). Autoría: Solow (1956) la usa como ejemplo; la formalizan y estiman Arrow, Chenery, Minhas y Solow (1961). Evidencia (3.A.11): σ capital-trabajo por debajo de 1 (0,4-0,6 Chirinko, 2008; en torno a 0,3 Gechert *et al.*, 2022; 0,5-0,7 Oberfield y Raval, 2021).
Gráfico de referencia: isocuantas (curvas de indiferencia en 3.A.8) para σ=0, σ=1, σ=∞ y un valor intermedio en el mismo plano. Versión de utilidad: `oposicion/temario/fuentes/3A08/graficos/ces-curvas-indiferencia.tex`; versión de producción (la de referencia): `oposicion/temario/fuentes/3A11/graficos/ces-isocuantas.tex`, el mismo gráfico reetiquetado.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.11 | Caracterizar la tecnología; elasticidad de sustitución | desarrollo (hecho, 13/10/2026) | Forma general con ν, σ, tres límites (derivación en el anexo `der:ces`), regla de Hicks, σ > 1 (remisión a 3.A.44 y 3.A.18), autoría (Solow, 1956; ACMS, 1961), evidencia empírica sobre σ; anexo de σ con n factores (Allen-Uzawa, Morishima) | Las demandas de la versión de utilidad (3.A.8) |
| 3.A.8 | Elasticidad de sustitución en el consumo | resumen | Versión de utilidad $U(x)$ con pesos $a_i$; tres casos y gráfico; derivación en anexo | La discusión de rendimientos a escala |
| 3.A.18 | Preferencia por la variedad (Dixit-Stiglitz) | resumen | Agregador simétrico $y=[\sum_i x_i^{\rho}]^{1/\rho}$, σ>1 entre variedades, mark-up σ/(σ−1) | Los casos límite |
| 3.A.44 | Crecimiento endógeno (Jones-Manuelli) | mención | σ>1 permite crecimiento sostenido sin progreso técnico; remitir a 3.A.11 | La forma funcional completa |

## Divergencias encontradas en el temario actual
- Pesos $s_i$ y casos exactos en 3.A.11: resueltos en la revisión del 13/10/2026 ($a_i$, límites).
- 3.A.8 escribe la CES sin ν (grado 1, utilidad): no es divergencia, ν solo hace falta en producción.
- Agregador en 3.A.18 llamado V en el inventario y y en el texto: usar $y$ (o $X$ si hay numerario $x_0$) y no V (V es la FIU).
- 3.A.11 escribe la Leontief con $q=\min\{z_K/a; z_L/b\}$: canon igual, en 3.A.8 con $x_1,x_2$.
