# Modelo de Harrod-Domar (Harrod 1939; Domar 1946)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.43** (crecimiento I) — revisado el 31/10/2026: antecedente en I.1 a) «Idea: de Harrod y Domar a Solow» (1′30″, 2 ideas y el puente $s/v^*=n+g+\delta$) y desarrollo completo en el anexo A (`anexo:harrod-domar`), que funde los anexos 2 y 3 del Word. Desde el título de 2023 ya no está en el título del 3.A.43 (D090: «antecedente breve»), pero es el único tema que lo desarrolla y el que lo necesita para contar Solow. Ficha creada en la fase canon del 3.A.43 (CC1 de sus propuestas de coherencia; C55 de las de contenido; **[decidir]**, con DK1 y DK9: Víctor está fuera hasta el 9/11). El id ya estaba en `mapa.yaml` (lista del 3.A.43) sin ficha.
- **Temas que lo usan:** 3.A.43 (desarrollo en anexo; hecho, 31/10/2026), 3.A.34 (mención; hecho, 31/10/2026: «la misma $v$ del modelo de Harrod y Domar \vertema{3.A.43}», con $I_t=v\,\Delta Y_t$, ficha `acelerador`), 3.A.42 (mención: Harrod, 1936 y 1939, y el multiplicador-acelerador), 3.A.4 (mención; hecho, 4/11/2026: III.1 c), la tasa garantizada $s/v$ frente a la natural y el «filo de la navaja», sin el modelo, como paso a Kaldor y Pasinetti; ficha `postkeynesianos`), 3.B.28 (mención; hecho, 3/11/2026: el «modelo de la brecha de financiación» como implicación de Rostow, $I/Y=v\,\bar\gamma_Y$ y brecha $v\,\bar\gamma_Y-s$, que critica Easterly; ficha `rostow`)
- **Manuales de referencia:** Harrod (1939), *EJ*; Domar (1946), *Econometrica*; Domar (1957); Solow (1956), pp. 65-66; Barro y Sala i Martín (2004), cap. 1; Sala i Martín (2000), cap. 2; Easterly (2001; trad. 2003), cap. 2; Levačić y Rebmann (1982).
- **Decisión D009 (13/10/2026):** ¿Cómo se escribe la sensibilidad de la inversión al tipo de interés en IS-LM y Mundell-Fleming? b (I = Ī − b·i), como Dornbusch-Fischer-Startz; v queda solo para la relación capital-producto (acelerador, Harrod-Domar)
- **Decisión D090 (13/10/2026):** Modelo teórico de MRW en 3.A.43 (con Harrod-Domar como antecedente breve) y estimación y evidencia en 3.A.45

## Presentación de referencia (3.A.43, I.1 a) y anexo A)

**Pregunta:** ¿puede una economía crecer de forma equilibrada y con pleno empleo cuando la tecnología es de coeficientes fijos y el ahorro es proporcional a la renta?

**Idea.** Llevar a Keynes al largo plazo (énfasis en la demanda, acelerador, desequilibrios persistentes). Mensaje: el crecimiento resulta de la acumulación de capital, pero es muy difícil que siga una senda equilibrada.

**Harrod: supuestos.** Economía cerrada sin Estado, un bien, $S_t=I_t$ en equilibrio pero sin tipo de interés que lo garantice; Leontief con **$a_L$** (DK9, **[decidir]**):
$$Y_t=\min\left\{\frac{K_t}{v},\ \frac{L_t}{a_L}\right\},\qquad v\equiv K/Y,\quad a_L\equiv L/Y$$
($a_L$ requerimiento unitario de trabajo, local del anexo, como el $a_{Lj}$ ricardiano del 3.A.21; nunca $u$, que es la fracción de Uzawa-Lucas, ni $\overline y$); $S_t=s\,Y_t$; población a n; acelerador simple con expectativas estáticas, $I_t=v\,\Delta Y_t$ (`eq:acelerador` del 3.A.34, `\vertema{3.A.34}`).

**Desarrollo.**
- *Tasa garantizada*: $s\,Y_t=v\,\Delta Y_t\Rightarrow\Delta Y_t/Y_t=s/v$; **inestable** (principio de inestabilidad: sendas implosiva y explosiva); el **«filo de la navaja» es la expresión de Solow (1956, p. 65)**, no de Joan Robinson.
- *Tasa natural*: $n$ (más el progreso técnico, si lo hay); pleno empleo exige $s/v=n$, una casualidad (s, v y n independientes).
- *Implicación*: economía de mercado inestable; política fiscal anticíclica.
- *Domar*: doble naturaleza de la inversión, demanda $\Delta Y^D_t=\Delta I_t/s$ y capacidad $\Delta Y^{\mathrm{cap}}_t=I_t/v$ (**$1/v$** en lugar de la σ de Domar, que en el temario es la elasticidad de sustitución); igualarlas da la tasa garantizada.
- *Versión de Barro y Sala i Martín* (sin progreso técnico, con δ y $k\equiv K/L$, porque aquí g = 0): $y_t=\min\{k_t/v,\ 1/a_L\}$; con $k<v/a_L$ **sobra trabajo** (paro) y con $k>v/a_L$ **sobra capital** (el original lo tenía al revés); $\dot k=s\,y-(n+\delta)k$; 3 casos: $s/v>n+\delta$ (capital ocioso en el estado estacionario, $k^*=s/[a_L(n+\delta)]$), $s/v<n+\delta$ (paro creciente) y $s/v=n+\delta$ (pleno empleo solo si $k_0=v/a_L$). La A y la B de Barro y Sala i Martín pasan a $1/v$ y $1/a_L$.
- *2 salidas*: v variable con una función neoclásica (Solow, 1956) o ahorro endógeno (Kaldor, 1957; Pasinetti, 1962; o la optimización del RCK).

**Valoración.** No explica el crecimiento sostenido desde la Revolución Industrial (5 supuestos difíciles, Sala i Martín, 2000); superado, pero influyó en los postkeynesianos (`\vertema{3.A.4}`) y, en la versión de Domar, en la «brecha de financiación» de las instituciones financieras internacionales; Domar (1957) renegó de su uso como modelo de crecimiento (como cuenta Easterly, 2003, cap. 2; A43-10). Es la base de Solow: **Harrod-Domar es el caso límite de Solow con elasticidad de sustitución nula**, no al revés.

**Gráficos de referencia** (`oposicion/temario/fuentes/3A43/graficos/`): `hd-produccion.tex` (y frente a k con el codo en $v/a_L$), `hd-caso1.tex`, `hd-caso2.tex` y `hd-caso3.tex` (los 3 casos en el plano de tasas); tabla `tab:leontief-inada` (la Leontief frente a las propiedades de una función neoclásica, con ✓ y ×). En el cante del 3.A.43 no hay gráfico: «$s/v$ frente a $n$» en la esquina de la pizarra, completado con $s/v^*=n+g+\delta$.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.43 | Crecimiento I: de dónde sale Solow | desarrollo en anexo (hecho, 31/10/2026); en el cuerpo, antecedente (1′30″) | Cuerpo: tasas garantizada y natural, filo de la navaja, puente $s/v^*=n+g+\delta$; anexo A completo con Domar, los 3 casos y la caja de Easterly | — |
| 3.A.34 | Inversión | mención (hecho, 31/10/2026) | La misma $v$ y el acelerador simple $I_t=v\,\Delta Y_t$ | El modelo `\vertema{3.A.43}` |
| 3.A.42 | Ciclo | mención | Harrod y el multiplicador-acelerador: inestabilidad | El modelo |
| 3.A.4 | Keynes y postkeynesianos | mención (hecho, 4/11/2026) | III.1 c): Harrod (1939) lleva la demanda efectiva al crecimiento; $s/v$ frente a la natural; el «filo de la navaja», con `\vertema{3.A.43}`; la salida de Cambridge (Kaldor, Pasinetti) frente a la de Solow | El modelo |
| 3.B.28 | Desarrollo | mención (hecho, 3/11/2026) | Implicación de Rostow (II.3.1): la brecha de financiación, $I/Y=v\,\bar\gamma_Y$ y brecha $v\,\bar\gamma_Y-s$, con la versión de Domar y `\vertema{3.A.43}`; su fracaso y Domar renegando de ese uso (Easterly, 1999; 2003, cap. 2), las mismas palabras que el anexo A del 3.A.43 (ficha `rostow`) | El modelo |

## Divergencias encontradas en el temario actual
- «Poskeynesiano» → «**postkeynesiano**», la ortografía del título oficial del 3.A.4 (`notacion.md` § 14): corregido en esta ficha (4/11/2026); el 3.A.43 escribe «pensamiento poskeynesiano» (l. 1047): cosmético, `pendientes-coherencia.md`.
- 3.A.43 (Word): apartado I entero aunque ya no está en el título; factor ocioso al revés; σ de Domar; A y B de Barro y Sala i Martín; ecuación de Domar mal escrita; «filo de la navaja» de Robinson; «Solow es un caso particular de Harrod»; coeficiente de trabajo $u$. **Resuelto** (31/10/2026).
- `notacion.md` § 7 decía «L/Y sin abreviar» para el coeficiente de trabajo; desde el 3.A.43, $a_L\equiv L/Y$ local del anexo (**[decidir]**, DK9): $\min\{K_t/v,\ L_t/(L/Y)\}$ es circular. Alternativa: escribir L/Y sin letra.

Autor: Víctor Gutiérrez Marcos
