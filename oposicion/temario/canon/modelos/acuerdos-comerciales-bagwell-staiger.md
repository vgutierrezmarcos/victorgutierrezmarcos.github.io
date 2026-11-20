# Teoría de los acuerdos comerciales (Bagwell y Staiger, 1999) y economía de las salvaguardias (Bagwell y Staiger, 1990)

- **Área:** comercio · **Tema de referencia:** **3.B.33** (La OMC… El GATT y los acuerdos sobre el comercio de mercancías; revisado el 14/11/2026: I.1.2 en el cuerpo, anexo `anexo:acuerdos` con la función clave `eq:bagwell-staiger`, y las salvaguardias en II.1.3 con el anexo de la economía de las salvaguardias y `eq:incentivos`). Ficha creada en la pasada final del canon (noviembre de 2026) a propuesta del 3.B.33. **Decisión de la pasada final:** la propuesta `proteccion-administrada` (Bagwell y Staiger, 1990) va como **segunda parte de esta ficha** (alias), porque es el mismo modelo con volumen de comercio aleatorio y hoy solo la usa el 3.B.33 (CRITERIOS § 6: ficha para lo que sale en 2 o más temas). **[decidir]**
- **Temas que lo usan:** 3.B.33 (desarrollo; hecho, 14/11/2026), 3.B.8 (mención; hecho, 5/11/2026: la salida cooperativa, `sec:cooperacion`, remite al 3.B.33 con `BagwellStaiger1999Economic`), 3.B.41 (mención posible: la reciprocidad en los acuerdos de la UE; la ficha `nash-negociacion` recoge su negociación con Estados Unidos), 3.B.10 (mención posible: NMF y art. XXIV), 3.B.7 (mención posible: salvaguardias).
- **Manuales de referencia:** Bagwell y Staiger (1999), «An Economic Theory of GATT», *AER*; Bagwell y Staiger (2002), *The Economics of the World Trading System*; Bagwell y Staiger (1990), «A Theory of Managed Trade», *AER*; Maggi (2014), *Handbook of International Economics*, vol. 4.

## Presentación de referencia (3.B.33)

**Pregunta:** ¿para qué sirve un acuerdo comercial si cada gobierno puede bajar sus aranceles por su cuenta?

**Supuestos:** 2 países grandes y simétricos, $A$ (importa $X$) y $B$ (importa $Y$); competencia perfecta; aranceles $t$ y $t^*$ (el asterisco, el extranjero); el gobierno puede no maximizar el bienestar nacional, solo se exige que prefiera una RRI mejor a igualdad de precios internos. Ejemplo lineal-cuadrático: $W=\pi t-\tfrac12t^2+\alpha(t-t^*)$, con π el peso de los grupos de presión y α la externalidad de la RRI.

**Desarrollo:** Nash con estrategia dominante, $t^N=\pi+\alpha$; aranceles **políticamente óptimos** (sin la externalidad de la RRI), $t^{\mathit{PO}}=\pi$:
$$t^N=\pi+\alpha>t^{\mathit{PO}}=\pi$$
(`eq:bagwell-staiger`), con $W^{\mathit{PO}}-W^N=\tfrac12\alpha^2$; curva de contrato $(\pi+\alpha-t)(\pi+\alpha-t^*)=\alpha^2$; las rebajas **recíprocas** llevan de $N$ al óptimo político por la diagonal sin mover la RRI; la NMF evita que los acuerdos bilaterales trasladen la externalidad a terceros. Como dilema del prisionero (`tab:dilema-arancel`, ficha `dilema-prisionero`), el acuerdo se sostiene si es autoejecutable (gatillo).

**Salvaguardias (protección administrada, 1990):** con volumen de importaciones θ aleatorio y $\pi=0$, la cooperación exige `eq:incentivos`, $\tfrac12(\alpha\theta-t^c)^2\le\frac{\beta}{1-\beta}V\equiv K$: libre comercio si $\theta\le\bar\theta\equiv\sqrt{2K}/\alpha$ y, si no, $t^c(\theta)=\alpha\theta-\sqrt{2K}$, por debajo del arancel de Nash: la cláusula de escape es la válvula que hace sostenible el acuerdo.

**Gráficos de referencia:** `oposicion/temario/fuentes/3B33/graficos/bagwell-staiger.tex` (`fig:bagwell-staiger`, mejores respuestas $R_A$, $R_B$, $N$, óptimo político y curva de contrato, con π = 1 y α = 2) y `clausula-escape.tex` (`fig:escape`).

**Notación (locales del 3.B.33, `notacion.md` § 10):** π peso de los grupos de presión (en macro, π es la inflación: local, avisada), α externalidad de la RRI, θ volumen de importaciones, $K$, $t^{\mathit{PO}}$, $t^N$, $t^c$; β factor de descuento (canon).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.33 | OMC y GATT | desarrollo (hecho, 14/11/2026) | La teoría de los acuerdos en I.1.2 y en el anexo; las salvaguardias en II.1.3 y su anexo | — |
| 3.B.8 | Represalias y cooperación | mención (hecho, 5/11/2026) | La salida cooperativa a la guerra de Johnson: reciprocidad y reglas multilaterales, `\vertema{3.B.33}` | El modelo |
| 3.B.41, 3.B.10, 3.B.7 | Política comercial de la UE; integración; salvaguardias | mención (posible) | Reciprocidad, NMF y art. XXIV; la cláusula de escape | El modelo |

## Divergencias encontradas en el temario actual
- Ninguna.

Autor: Víctor Gutiérrez Marcos
