# Rendimientos a escala globales y locales

- **Área:** consumidor-producción · **Tema de referencia:** **3.A.11** (Teoría de la producción, II.2) — lo tiene en el título («Rendimientos locales y globales a escala») y lo desarrolla (revisado el 13/10/2026). Ficha creada a raíz de esa revisión: el concepto lo usan al menos seis temas, varios con la notación vieja (λ, $Q$, $\varepsilon_{Q,\lambda}$).
- **Temas que lo usan:** 3.A.11 (desarrollo), 3.A.12 (resumen: economías de escala), 3.A.16 (mención: tamaño indeterminado y oferta de largo plazo), 3.A.43 (mención: rendimientos constantes y empresa representativa), 3.A.44 (mención: rendimientos crecientes y crecimiento endógeno), 3.B.6 (mención: rendimientos crecientes y comercio intraindustrial); también 3.A.17 (monopolio natural, con id `monopolio-natural`).
- **Manuales de referencia:** Mas-Colell, Whinston y Green (1995), §5.B; Jehle y Reny (2011), cap. 3 (def. 3.3-3.4); Varian, cap. 1; Frisch (1965); Hanoch (1975); evidencia: Basu y Fernald (1997).

## Presentación de referencia
Pregunta: ¿cómo responde la producción cuando todos los factores varían en la misma proporción (largo plazo)?

- **Elasticidad de escala** (escala $t$, nunca λ; `notacion.md` §3):
$$\varepsilon_{q,t}\equiv\frac{dq/q}{dt/t}=\left.\frac{d\ln F(tz)}{d\ln t}\right|_{t=1}$$
Rendimientos crecientes, constantes o decrecientes según $\varepsilon_{q,t}\gtreqless 1$.
- **Globales** (toda la tecnología): para todo $z$ y $t>1$, $F(tz)\gtreqless tF(z)$. En el conjunto: constantes si $\mathcal Y$ es un cono; no crecientes con divisibilidad; no decrecientes con aditividad (MWG §5.B).
- **Homogéneas de grado $k$**: $F(tz)=t^kF(z)$; $\varepsilon_{q,t}=k$ en todo punto; PMg homogéneas de grado $k-1$ y RMST de grado 0; Euler $\sum_iPMg_iz_i=kF(z)$ (con $k=1$, el pago según la PMg agota el producto). Cobb-Douglas: $k=\alpha+\beta$.
- **Homotéticas**: $F(z)=g(h(z))$, $h$ homogénea de grado uno, $g$ creciente; RMST constante a lo largo de cada rayo, isoclinas y senda de expansión rectas por el origen; $\varepsilon_{q,t}(z)=g'(h)h/g(h)$, que depende solo de $q$.
- **Locales** (en un punto): $$\varepsilon_{q,t}(z)\equiv\left.\frac{d\ln F(tz)}{d\ln t}\right|_{t=1}=\frac{\sum_iPMg_i\,z_i}{F(z)}=\sum_i\varepsilon_{q,z_i},\qquad \varepsilon_{q,z_i}=\frac{PMg_i}{PMe_i}$$
($\mu(z)$ en Jehle y Reny, solo en nota). Ejemplo de rendimientos variables (*ultra passum*, Frisch): $q=\kappa/(1+z_L^{-a}z_K^{-b})$, $\varepsilon_{q,t}(z)=(a+b)(1-q/\kappa)$: homotética, no homogénea, en S.
- **Rendimientos frente a economías de escala**: tecnología frente a costes; a lo largo de la senda de mínimo coste $\varepsilon_{q,t}=CMe/CMg=1/\varepsilon_{C,q}$ (Hanoch, 1975).
- **Rendimientos constantes**: el tamaño de la empresa queda indeterminado (la tecnología fija solo las proporciones).
- **Evidencia**: industria típica de EE. UU., constantes o ligeramente decrecientes; aumentan al agregar (Basu y Fernald, 1997).

Gráficos de referencia (3.A.11): `oposicion/temario/fuentes/3A11/graficos/rendimientos-escala-isocuantas.tex` (isocuantas sobre un rayo), `rendimientos-escala-r3.tex` (tres homogéneas en $\mathbb R^3$), `productividad-rendimientos.tex` (eje frente a rayo), `rendimientos-locales.tex` (función en S y elasticidad local). Tabla de referencia: `tab:rendimientos` (crecientes, constantes, decrecientes, variables).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.11 | Tecnología a largo plazo | desarrollo (hecho, 13/10/2026) | Todo lo anterior: elasticidad de escala, homogéneas y homotéticas, Euler, globales y locales, ejemplo en S, causas, indeterminación del tamaño, evidencia | Las economías de escala en detalle (3.A.12) |
| 3.A.12 | Costes y economías de escala | resumen | Economías de escala con $\varepsilon_{C,q}$; relación $\varepsilon_{q,t}=CMe/CMg$ con homotéticas; tecnología en S detrás de los costes medios en U; remitir a 3.A.11 | La definición de rendimientos y la elasticidad de escala como suma de elasticidades-producto (hoy la copia con λ, $Q$, $\varepsilon_{Q,\lambda}$) |
| 3.A.16 | Competencia perfecta | mención | Con rendimientos constantes, tamaño indeterminado y oferta de largo plazo horizontal | — |
| 3.A.43 | Solow | mención | Rendimientos constantes: empresa representativa y forma intensiva $y=f(k)$; remitir a 3.A.11 y 3.A.12 | — |
| 3.A.44 | Crecimiento endógeno | mención | Rendimientos crecientes (externalidades, AK) | — |
| 3.B.6 | Nueva teoría del comercio | mención | Rendimientos crecientes internos y comercio intraindustrial; FPP convexa | — |

## Divergencias encontradas en el temario actual
- 3.A.12: copia la elasticidad de escala del 3.A.11 original con λ como escala, $Q$, $f(\vec z)$ y $\varepsilon_{Q,\lambda}$; canon $t$, $q$, $F(z)$, $\varepsilon_{q,t}$ y $\varepsilon_{q,t}(z)$.
- 3.A.11 original: grado de homogeneidad $t$ (chocaba con la escala) y errata $\frac{dz_L}{dz_L}$: resuelto el 13/10/2026 ($k$ y $dz_L/z_L=dt/t$).
