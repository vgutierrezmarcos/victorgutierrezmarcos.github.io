# Dualidad en la teoría del consumidor (minimización del gasto, función de gasto, Shephard y Roy)

- **Área:** consumidor-producción · **Tema de referencia:** **3.A.9** (Demanda II: «Dualidad e integrabilidad de las preferencias»; revisado el 13/10/2026, bloque I) — lo tiene en el título y lo desarrolla. Ficha creada a raíz de esa revisión; recoge también el id `minimizacion-gasto` (problema de minimización del gasto), que solo aparece en 3.A.9.
- **Temas que lo usan:** 3.A.9 (desarrollo; hecho), 3.A.8 (resumen: anuncia el dual, Roy por la envolvente y Shephard en la derivación de Slutsky; hecho), 3.A.12 (resumen: la misma dualidad en la empresa, $C(w,q)$ y demandas condicionadas), 4.B.9 y 4.B.11 (mención: la función de gasto mide el exceso de gravamen).
- **Manuales de referencia:** Mas-Colell, Whinston y Green, §3.D-§3.G; Jehle y Reny (2011), cap. 1-2; Varian, cap. 7; Deaton y Muellbauer (1980), cap. 2. Historia: Hotelling (1932), Hicks (1939), Roy (1947), Shephard (1953), McKenzie (1957), Uzawa (1964), Diewert (1974).

## Presentación de referencia
Pregunta: ¿qué se gana al «dar la vuelta» al problema del consumidor y buscar la forma más barata de alcanzar un nivel de utilidad?

- **Ingredientes comunes**: mismas preferencias (axiomas de 3.A.8, con insaciabilidad local), mismos precios $p\gg 0$; los papeles de objetivo y restricción se intercambian (tabla `tab:ingredientes`).
- **Primal (PMU)** (ficha `pmu`): $\max_xU(x)$ s.a. $p\cdot x\le\overline W$ → $x(p,\overline W)$, $V(p,\overline W)$, multiplicador $\lambda$, $\lambda^*=\partial V/\partial\overline W$; identidad de Roy $x_i=-\frac{\partial V/\partial p_i}{\partial V/\partial\overline W}$.
- **Dual (PMG)**: $\min_{\vec h} \vec p\cdot\vec h$ s.a. $U(\vec h)\ge\overline U$, $\vec h\ge 0$, con $\overline U>U(0)$; lagrangiana $\mathcal L^D=\vec p\cdot\vec h+\mu\big(\overline U-U(\vec h)\big)$ (μ, como en el tema original; Víctor, 13/10/2026). Solución interior $\frac{p_1}{U_1}=\dots=\frac{p_n}{U_n}=\mu$, $RMS_{12}=U_1/U_2=p_1/p_2$; $\mu^*=\partial E/\partial\overline U=1/\lambda^*$ (coste marginal de la utilidad). Existencia: MWG prop. 3.E.1; la restricción se satura por la continuidad de $U$.
- **Demanda hicksiana** $h(p,\overline U)$: homogénea de grado cero en $p$ ($h(kp,\overline U)=h(p,\overline U)$), sin exceso de utilidad, ley de la demanda compensada $(p'-p)\cdot\big(h(p',\overline U)-h(p,\overline U)\big)\le 0$.
- **Función de gasto** $E(p,\overline U)=p\cdot h(p,\overline U)$: continua; homogénea de grado uno en $p$; estrictamente creciente en $\overline U$ y no decreciente en $p$; **cóncava en $p$** (plano tangente: $E(p',\overline U)\le p'\cdot h(p,\overline U)$); **lema de Shephard** $h_i=\partial E/\partial p_i$. De ahí la matriz de Slutsky $S=D^2_pE$ (ficha `slutsky`).
- **Relaciones de dualidad** (MWG prop. 3.E.1; `eq:dual-valor` y `eq:dual-demanda`):
$$E\big(p,V(p,\overline W)\big)=\overline W,\quad V\big(p,E(p,\overline U)\big)=\overline U,\quad x(p,\overline W)=h\big(p,V(p,\overline W)\big),\quad h(p,\overline U)=x\big(p,E(p,\overline U)\big)$$
- **Condiciones de segundo orden**: hessiano orlado en los dos problemas; son la misma condición (anexo A de 3.A.9, con Sarrus). Roy y Shephard, por la envolvente y por dualidad o concavidad (anexo B). Hessiana, concavidad y cuasiconcavidad (anexo C, propuesto como versión común con 3.A.8 y 3.A.12).
- **Para qué sirve**: estimar demandas sin resolver optimizaciones (ficha `sistemas-demanda`), recuperar las preferencias (ficha `integrabilidad`), derivar Slutsky (ficha `slutsky`) y medir el bienestar en dinero (fichas `vc-ve` e `indices-precios`).
- **Dual en sentido estricto y amplio**: en la empresa, minimizar costes es dual de la tecnología; maximizar beneficios no es el dual estricto (incluye ingresos) [3.A.12].

Gráficos de referencia (3.A.9): `oposicion/temario/fuentes/3A09/graficos/primal-dual.tex` (dos paneles, misma tangencia; capa final con $\overline W=E^*$, $\overline U=U^*$), `esquema-dualidad.tex` (problemas, soluciones, funciones valor y relaciones), `concavidad-fg.tex` (concavidad y Shephard), `cuasiconvexidad-fiu.tex` (profundización). Tablas: `tab:ingredientes`, `tab:pares-duales`, `tab:kt`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.9 | Dualidad | desarrollo (hecho, 13/10/2026) | Todo lo anterior: primal en resumen, dual desarrollado, tablas de ingredientes y pares duales, esquema, ejemplo Cobb-Douglas de inversión de $V$ en $E$; anexos A-C | Axiomas, solución de esquina y teoremas de existencia del primal (3.A.8) |
| 3.A.8 | Demanda marshalliana | resumen (hecho) | Anuncio del dual; Roy por la envolvente; Shephard y $E$ en la derivación de Slutsky (anexo) | El desarrollo del dual (remitir a 3.A.9) |
| 3.A.12 | Dualidad de la empresa | resumen | Misma estructura: $C(w,q)$ cóncava y homogénea de grado uno en $w$, Shephard $z_i(w,q)=\partial C/\partial w_i$, recuperar la tecnología; remitir a 3.A.9 para las demostraciones idénticas | Las demostraciones del consumidor |
| 4.B.9, 4.B.11 | Exceso de gravamen | mención | La función de gasto y la VE miden el EG ($\mathrm{EG}=-\mathrm{VE}-T$) | La dualidad |

## Divergencias encontradas en el temario actual
- 3.A.9 original: variable de elección $h$ y multiplicador μ en el PMG; λ y μ «relacionados de forma inversa»; $h(\theta p,\overline U)$; «matriz de primeras derivadas»; concavidad de $E$ explicada como subida «menos que proporcional»; $RMS$ negativa; cuadro resumen con errores (Shephard con signo menos). Resuelto en la revisión.
- 3.A.12 tiene en sus anexos las mismas capturas en inglés sobre hessiana y concavidad que tenía el 3.A.9: usar la versión del anexo C de 3.A.9 adaptada a $C(w,q)$ (ver `mapa.yaml`, contradicciones de 3.A.9).
