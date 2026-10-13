# Función CES (elasticidad de sustitución constante)

- **Área:** consumidor-producción · **Tema de referencia:** 3.A.11 (Teoría de la producción) — el título incluye «elasticidad de sustitución» y es donde se desarrolla la forma funcional con sus casos límite; 3.A.8 la presenta como utilidad (ya revisado, sirve de modelo de redacción).
- **Temas que lo usan:** 3.A.11 (desarrollo), 3.A.8 (resumen), 3.A.18 (resumen), 3.A.44 (mención)
- **Manuales de referencia:** Arrow, Chenery, Minhas y Solow (1961); Mas-Colell, Whinston y Green (1995), cap. 3 y 5; Varian, *Análisis microeconómico*, cap. 1; Dixit y Stiglitz (1977) para el agregador de variedades.

## Presentación de referencia
Pregunta: ¿cómo representar una tecnología (o unas preferencias) con una facilidad de sustitución entre factores que no cambia con la proporción en que se usan?
Supuestos: dos o más factores (bienes), pesos positivos, σ constante.

$$q=A\left[\sum_{i=1}^{n}a_i\,z_i^{\frac{\sigma-1}{\sigma}}\right]^{\frac{\sigma}{\sigma-1}},\qquad A,a_i>0,\qquad \rho\equiv\frac{\sigma-1}{\sigma}$$
$$\sigma\equiv\frac{d\ln(z_K/z_L)}{d\ln RMST_{LK}}$$
Casos límite (son **límites**, no casos exactos): σ→0 Leontief $q=\min\{z_K/a;\,z_L/b\}$; σ→1 Cobb-Douglas; σ→∞ lineal (sustitutivos perfectos). Rendimientos constantes a escala (homogénea de grado 1); con exponente ν/ρ, grado ν.
Gráfico de referencia: isocuantas (curvas de indiferencia en 3.A.8) para σ=0, σ=1, σ=∞ y un valor intermedio en el mismo plano. Ya existe la versión de utilidad: `oposicion/temario/fuentes/3A08/graficos/ces-curvas-indiferencia.tex`; para 3.A.11 basta reetiquetar ejes ($z_L, z_K$) e isocuantas.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.11 | Caracterizar la tecnología; elasticidad de sustitución | desarrollo | Forma general, σ, casos límite (como límites, con la derivación por L'Hôpital), rendimientos, ACMS (1961) | — |
| 3.A.8 | Elasticidad de sustitución en el consumo | resumen | Versión de utilidad $U(x)$ con pesos $a_i$; tres casos y gráfico; derivación en anexo | La discusión de rendimientos a escala |
| 3.A.18 | Preferencia por la variedad (Dixit-Stiglitz) | resumen | Agregador simétrico $y=[\sum_i x_i^{\rho}]^{1/\rho}$, σ>1 entre variedades, mark-up σ/(σ−1) | Los casos límite |
| 3.A.44 | Crecimiento endógeno (Jones-Manuelli) | mención | σ>1 permite crecimiento sostenido sin progreso técnico; remitir a 3.A.11 | La forma funcional completa |

## Divergencias encontradas en el temario actual
- Pesos: $a_i$ (3.A.8 revisado) frente a $s_i$ (3.A.11). $s_i$ es la participación en el gasto en 3.A.8 y en el canon: **usar $a_i$**.
- 3.A.11 presenta σ=0 y σ=1 como casos exactos: corregir a límites.
- Agregador en 3.A.18 llamado V en el inventario y y en el texto: usar $y$ (o $X$ si hay numerario $x_0$) y no V (V es la FIU).
- 3.A.11 escribe la Leontief con $q=\min\{z_K/a; z_L/b\}$: canon igual, en 3.A.8 con $x_1,x_2$.
