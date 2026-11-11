# Modelo de sobrerreacción del tipo de cambio (Dornbusch, 1976)

- **Área:** macro-abierta · **Tema de referencia:** 3.B.14 (Teorías de la determinación del tipo de cambio), **revisado el 11/11/2026**: único tema que lo desarrolla, con a)-e), 4 ecuaciones, la función clave `eq:sobrerreaccion`, 3 gráficos y el anexo `anexo:dornbusch` con el diagrama de fases y la θ racional.
- **Temas que lo usan:** 3.B.14 (desarrollo; hecho, 11/11/2026), 3.A.32 (mención; hecho, 11/11/2026), 3.B.13 (mención; hecho, 8/11/2026), 3.B.15 (mención), 3.B.43 (mención).
- **Manuales de referencia:** Dornbusch (1976), *JPE* (`Dornbusch1976Expectations`); Rogoff (2002), «Dornbusch's Overshooting Model After Twenty-Five Years» (`Rogoff2002Dornbusch`); Obstfeld y Rogoff, *Foundations…*, cap. 9 (`ObstfeldRogoff1996Foundations`); Krugman, Obstfeld y Melitz, cap. 15 (`KrugmanObstfeldMelitz2022International`); Wilson (1979) para la expansión anunciada (`Wilson1979Anticipated`); Frankel (1979) para el diferencial de intereses reales (`Frankel1979Mark`); Eichenbaum y Evans (1995) para la sobrerreacción retardada (`EichenbaumEvans1995`).

## Presentación de referencia (3.B.14, II.1.2)

**Pregunta:** ¿por qué el tipo de cambio es mucho más volátil que los precios y que sus fundamentos, y por qué el tipo real se mueve casi como el nominal?

**Supuestos:** país pequeño ($i^*$ dado, $p^*=0$); renta de pleno empleo $\bar y$; movilidad y sustituibilidad perfectas (PNCI); **precios rígidos a corto plazo** y PPA a largo; la demanda de dinero del enfoque monetario (`eq:demanda-dinero-log`, $k$ y $h$ de la LM del 3.A.35, en logaritmos); **expectativas regresivas** a velocidad θ, que con el θ adecuado son racionales.

**Ecuaciones (logaritmos en minúsculas salvo los tipos de interés; $e=\ln E$, $E$ directo):**
$$i=i^{*}+\dot e^{\,e}\quad(\texttt{eq:dornbusch-pnci}),\qquad \dot e^{\,e}=\theta\,(\bar e-e),\ \theta>0\quad(\texttt{eq:dornbusch-expectativas}),$$
$$m-p=k\,\bar y-h\,i\quad(\texttt{eq:dornbusch-dinero}),\qquad \dot p=\psi\,(d-\bar y),\quad d=\bar a+\nu\,(e-p)-b\,i\quad(\texttt{eq:dornbusch-precios}).$$
- $\dot e^{\,e}$, la depreciación esperada (la $\gamma E^e$ de la PNCI en logaritmos y tiempo continuo); **θ local y avisada** («la letra de Dornbusch: aquí no es la aversión al riesgo»); **ψ** velocidad de ajuste de los precios (no π, que es la inflación); **ν** sensibilidad de la demanda al tipo real (la misma ν de $XN=xY^*-mY+\nu q$, 3.A.32; no δ, que es la depreciación); **$\bar a$** demanda autónoma (no $u$, que es la perturbación de costes); **$b$** la sensibilidad al tipo de interés de la IS (en el cuerpo y en el anexo, para que coincidan con el diagrama de fases).
- Largo plazo: $\bar p=m-k\bar y+h\,i^*$ y $\bar e=\bar p+(\bar y+b\,i^*-\bar a)/\nu$ (neutralidad: $d\bar p/dm=d\bar e/dm=1$).
- Mercados de activos: $e=\bar e-\dfrac{1}{h\theta}(p-\bar p)$ (`eq:dornbusch-activos`).
- **Función clave** `eq:sobrerreaccion`: $\dfrac{de}{dm}=1+\dfrac{1}{h\,\theta}>1$ (mayor cuanto **menor** es $h$ y θ).
- Con previsión perfecta (anexo B): $\dot e=0$ vertical en $p=\bar p$; $\dot p=0$: $e-\bar e=\big(1+\tfrac{b}{\nu h}\big)(p-\bar p)$; θ racional `eq:theta-racional`, $\theta=\tfrac{\psi}{2}\big(\nu+\tfrac bh\big)+\sqrt{\tfrac{\psi^2}{4}\big(\nu+\tfrac bh\big)^2+\tfrac{\psi\nu}{h}}$; la curva de los activos es la senda de silla.

**Resultado:** ante $\uparrow m$ permanente y no anticipado, $\bar e$ y $\bar p$ suben en $dm$; en el impacto $p$ no se mueve, $i$ cae y la PNCI exige una apreciación esperada: $e$ salta por encima de $\bar e$ y después se aprecia mientras suben los precios. Con precios flexibles saltaría de una vez a $\bar e$. Una expansión **anunciada** deprecia al anunciarse (menos), sigue depreciando hasta aplicarse y luego aprecia (Wilson, 1979). Con producción variable puede no haber sobrerreacción.

**Extensiones y evidencia (3.B.14):** Frankel (1979), `eq:frankel`: un $i$ más alto aprecia si es restrictivo con precios rígidos y deprecia si refleja inflación esperada; NOEM: sin sobrerreacción con PCP, con ella con LCP (Betts y Devereux, 2000); evidencia: Mussa (1986) a favor del mecanismo, sobrerreacción **retardada** (Eichenbaum y Evans, 1995; Faust y Rogers, 2003). La extensión de la PPA solo para los comerciables va **sin autor** (el Wolff de 1987 trata de predicción; V18 del 3.B.14).

**Gráficos de referencia** (todos en `oposicion/temario/fuentes/3B14/graficos/`):
- **`dornbusch-trayectorias.tex`** (el de referencia, imprescindible en el cante): 4 paneles apilados con el mismo eje de tiempo ($m$, $i$, $p$, $e$) tras $\uparrow m$ en $t_0$; en el de $e$, la trayectoria de Dornbusch (salto por encima de $\bar e_1$ y apreciación gradual) y en discontinua la de precios flexibles (salto a $\bar e_1$).
- **`dornbusch-mercados.tex`** (variante, de KOM, cap. 15): 2 paneles; arriba la PNCI en el plano **$(i,E)$ con $i$ en abscisas** (el mismo plano que Branson), abajo el mercado de dinero con los saldos reales hacia abajo; puntos $A$ (inicial), $B$ (impacto, $E_1$), $C$ (largo plazo, $E_2$), tipos $i_0$, $i_1$.
- **`dornbusch-fases.tex`** (anexo B): plano $(p,e)$ con $\dot p=0$, $\dot e=0$, la recta de la PPA, las sendas de silla $SS_0$ y $SS_1$ y los puntos $A$, $B$, $C$.
- **`dornbusch-anticipado.tex`** (nota al pie, `\graficonota`): la trayectoria de $e$ con el anuncio en $t_0$ y la expansión en $t_1$.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.14 | Determinación del tipo de cambio | desarrollo (hecho, 11/11/2026) | II.1.2 con a)-e), las 4 ecuaciones, `eq:dornbusch-activos`, `eq:sobrerreaccion`, `dornbusch-mercados` y `dornbusch-trayectorias`; anexo B con `dornbusch-fases`, θ racional, anunciada y producción variable; volatilidad como coste de la flotación `\vertema{3.B.15}` | — |
| 3.A.32 | OA-DA abierta | mención (hecho, 11/11/2026) | l. 184 y 472: la sobrerreacción en una línea, `\vertema{3.B.14}` | El modelo |
| 3.B.13 | Mercado de divisas | mención (hecho, 8/11/2026) | l. 864 y 1114: la PNCI como pieza central de Dornbusch, `\vertema{3.B.14}` | El modelo |
| 3.B.15 | Regímenes cambiarios e intervención | mención | La volatilidad excesiva como coste de la flotación en 1-2 líneas `\vertema{3.B.14}`; su Word copia el bloque del Word del 3.B.14 con la errata («flexibles a corto plazo») y la frase sin fuente sobre el SME: quitar | Supuestos, ecuaciones y trayectorias |
| 3.B.43 | SME y euro | mención | Una línea como argumento de estabilidad cambiaria, solo con fuente (el 3.B.14 la quitó por no tenerla) | — |

## Divergencias encontradas en el temario actual
- **Resuelto en el 3.B.14 (11/11/2026)**: el Word escribía la PNCI en tasas ($\gamma E^e\cong i-i^*$) y las trayectorias en niveles; ahora en logaritmos con $\dot e^{\,e}$. La ficha anterior usaba φ, λ, π, δ, $u$ y $de/dm=1+1/(\lambda\theta)$: ahora **$k$, $h$, ψ, ν, $\bar a$** y $1+1/(h\theta)$ (CC1 del 3.B.14, D-2, **[decidir]**; *alternativa*: las letras de Dornbusch, 1976, con aviso del cambio frente al 3.A.35). Desaparece el choque de λ con la NEG.
- **Errata del Word** (también en el Word del 3.B.15): «precios fijos a corto plazo y flexibles a corto plazo» → flexibles **a largo** plazo; la nota 31 daba el efecto de $h$ al revés.
- 3.B.15 resume el *overshooting* sin remitir a 3.B.14 (`faltan` del mapa).

Autor: Víctor Gutiérrez Marcos
