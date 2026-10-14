# Modelo de Heckscher-Ohlin-Samuelson y sus teoremas (H-O, igualación del precio de los factores, Stolper-Samuelson, Rybczynski)

- **Área:** comercio · **Tema de referencia:** **3.B.5** (Teoría del comercio internacional (I); sin revisar) — lo desarrolla con sus cuatro teoremas. Ficha creada el 14/10/2026 a raíz de la revisión del 3.A.21, que fija la **estática comparativa del 2×2 cerrado** (álgebra de Jones) en su anexo E.
- **Temas que lo usan:** 3.B.5 (desarrollo), 3.A.21 (resumen: anexo E, Stolper-Samuelson y Rybczynski como estática comparativa del 2×2×2×2 con rendimientos constantes; hecho, 14/10/2026), 3.B.9 (resumen: Rybczynski aplicado al crecimiento; id `rybczynski`, fusionado aquí), 3.B.7 y 3.B.8 (mención: efectos redistributivos del arancel por Stolper-Samuelson, con remisión a 3.B.5), 3.B.10 (mención: efectos redistributivos y Haberler), 4.B.8 (mención: 2×2 con intensidades factoriales, análogo del impuesto selectivo de Harberger).
- **Fusiones (14/10/2026):** `rybczynski` (3.B.9) pasa a alias de este id (`_inventario/alias.json`).
- **Manuales de referencia:** Heckscher (1919); Ohlin (1933); Stolper y Samuelson (1941); Samuelson (1948, 1949); Rybczynski (1955); Jones (1965), «The structure of simple general equilibrium models»; Feenstra (2016), cap. 1-3; Krugman, Obstfeld y Melitz, cap. 5; Mas-Colell, Whinston y Green (1995), § 17.G; Martínez-Giralt (2008), cap. 4.
- **Decisión D011 (13/10/2026):** precios de los factores w y r (renta del capital, diciendo que r no es el tipo de interés) en los 2×2 de comercio e incidencia; w_L, w_K cuando el 2×2 se cuenta como equilibrio general (3.A.21, avisando de w, r).

## Presentación de referencia
Pregunta (3.B.5): ¿explican las dotaciones relativas de factores el patrón de comercio y qué efectos distributivos tiene? Pregunta (3.A.21): ¿cómo cambia el equilibrio del 2×2 con rendimientos constantes cuando cambian precios o dotaciones?

**Supuestos:** 2 países, 2 bienes X, Y, 2 factores L, K (orden (L, K), `notacion.md` § 5); tecnologías idénticas entre países con rendimientos constantes; sin reversión de intensidades factoriales; especialización incompleta (se producen los 2 bienes); competencia perfecta; factores móviles entre sectores e inmóviles entre países.

**Ecuaciones (álgebra de Jones, 3.A.21 anexo E):** coste unitario c_j(w_L,w_K) y requerimientos unitarios a_{Lj}(w⃗) = ∂c_j/∂w_L, a_{Kj} = ∂c_j/∂w_K (Shephard, 3.A.12). Equilibrio de la producción:
$$p_X=c_X(w_L,w_K),\quad p_Y=c_Y(w_L,w_K)\ \ (\text{beneficio nulo});\qquad a_{LX}X+a_{LY}Y=\overline L,\quad a_{KX}X+a_{KY}Y=\overline K\ \ (\text{pleno empleo}).$$
Con tasas de variación x̂ ≡ dx/x, participaciones en el coste s_{Lj} = w_La_{Lj}/p_j y fracciones del factor empleadas ℓ_{Lj} = a_{Lj}q_j/L̄ (θ_{ij} y λ_{ij} en Jones: aquí θ es la CRRA y λ la escala):
$$\hat p_X=s_{LX}\hat w_L+s_{KX}\hat w_K,\quad \hat p_Y=s_{LY}\hat w_L+s_{KY}\hat w_K;\qquad \hat{\overline L}=\ell_{LX}\hat X+\ell_{LY}\hat Y,\quad \hat{\overline K}=\ell_{KX}\hat X+\ell_{KY}\hat Y.$$
- **Stolper-Samuelson** (1941), con el **efecto magnificación** de Jones: si X es intensivo en trabajo (s_{LX} > s_{LY}) y p̂_X > p̂_Y, entonces ŵ_L > p̂_X > p̂_Y > ŵ_K.
- **Rybczynski** (1955): a precios de los bienes constantes, si $\hat{\overline L}>\hat{\overline K}$, entonces $\hat X>\hat{\overline L}>\hat{\overline K}>\hat Y$.
- **H-O** e **igualación del precio de los factores** (Samuelson, 1948-1949): los de 3.B.5 (con w, r); reciprocidad ∂w_m/∂p_i = ∂x_i/∂z_m.
- **Valoración:** dependen de la especialización incompleta y de la ausencia de reversión; con más bienes que factores o al revés, solo versiones débiles (Jones, 1965).

Gráficos de referencia (3.A.21): `oposicion/temario/fuentes/3A21/graficos/costes-unitarios.tex` (curvas de coste unitario en el plano (w_L, w_K) y efecto de una subida de p_X) y `rybczynski.tex` (aumento de L̄ a precios constantes). 3.B.5 debe reutilizarlos (con w, r si lo avisa) y añadir el teorema H-O y Rybczynski en la caja de Edgeworth y en el plano de bienes.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.5 | Determinantes del comercio y efectos distributivos | desarrollo | Los cuatro teoremas, con w, r (D011) y el álgebra de Jones con s_{Lj}, ℓ_{Lj}, x̂; paradoja de Leontief (id `paradoja-leontief`) | — |
| 3.A.21 | Estática comparativa del equilibrio general | resumen (hecho, 14/10/2026) | Anexo E: teorema de la función implícita, principio de correspondencia, y en el 2×2 con rendimientos constantes las 4 ecuaciones, Stolper-Samuelson con el efecto magnificación y Rybczynski, con w_L, w_K y remisión a 3.B.5 | El comercio (3.B.5) |
| 3.B.9 | Crecimiento y comercio | resumen | Rybczynski aplicado a la acumulación de un factor (crecimiento sesgado), con remisión a 3.B.5 | La derivación |
| 3.B.7, 3.B.8 | Política comercial | mención | Efectos redistributivos del arancel (Stolper-Samuelson), con remisión a 3.B.5 | — |
| 3.B.10 | Política comercial (II) | mención | Efectos redistributivos y Haberler, con remisión a 3.B.5 | — |
| 4.B.8 | Incidencia | mención | 2×2 con intensidades factoriales: análogo del impuesto selectivo de Harberger (ficha `harberger-incidencia`); resumen propio, sin depender del 3.º | — |

## Divergencias encontradas en el temario actual
- 3.B.9 usa Rybczynski y Stolper-Samuelson sin remitir a 3.B.5; 3.B.5 usa la caja de Edgeworth y el equilibrio general sin remitir a 3.A.21 (`mapa.yaml`).
- 3.A.21 original tenía la estática comparativa en un anexo sin notación común; resuelto (14/10/2026) con el álgebra de Jones y la notación de `notacion.md` § 5 y § 10.

Autor: Víctor Gutiérrez Marcos
