# *Insiders* y *outsiders* (Lindbeck y Snower, 1986, 1988)

- **Área:** macro cerrada (mercado de trabajo) · **Tema de referencia:** **3.A.27** (revisado el 31/10/2026: III.3 `sec:contratos-implicitos-extensiones`, como extensión de los contratos implícitos, y anexo E `anexo:insiders` con el programa y los 3 casos) — es el único tema que lo desarrolla con su modelo; el 3.A.28 lo usa como mecanismo de la histéresis (ficha `histeresis`, referencia 3.A.28). Ficha creada en la fase canon del 3.A.27 (propuestas de coherencia § 5.4.6; **[decidir]**). En `_inventario/areas.json` estaba en economía española (por el 4.A.16): pasa a macro cerrada, como su tema de referencia.
- **Temas que lo usan:** 3.A.27 (desarrollo; hecho, 31/10/2026), 3.A.28 (resumen: mecanismo de la histéresis, Blanchard y Summers, 1986; hoy «con otras palabras»), 4.A.16 (resumen aplicado: dualidad indefinidos-temporales, costes de despido y reformas en España; hoy mención como «primer problema estructural de la negociación colectiva»), 3.A.25 (mención; hecho, 31/10/2026: la formación específica, III.2 c, «una de las raíces del poder de los *insiders*», y la fila 7 de `tab:supuestos-trabajo`), 1D01 (mención; hecho, 24/10/2026: histéresis con *insiders-outsiders* y pérdida de capital humano).
- **Manuales de referencia:** Lindbeck y Snower (1986), *AER P&P*; Lindbeck y Snower (1988), *The Insider-Outsider Theory of Employment and Unemployment*, MIT Press; Blanchard y Summers (1986), *NBER Macroeconomics Annual*; Cahuc, Carcillo y Zylberberg (2014), cap. 7; Bentolila, Dolado y Jimeno (2012) para España.

## Presentación de referencia (3.A.27, III.3 y anexo E)

Pregunta: ¿quién soporta el ajuste por el empleo y por qué los parados no pueden ofrecerse por menos? Conclusión: los que ya tienen empleo (*insiders*) se apropian de los costes de rotación; los de fuera (*outsiders*) quedan en paro involuntario, y el paro persiste tras un *shock*.

- **a) Idea**: *insiders* (con empleo, negocian el salario) frente a *outsiders* (parados o precarios, sin voz). Su poder nace de los **costes de rotación** (despedir, contratar, formar); la formación específica es una de sus raíces (`\vertema{3.A.25}`, ficha `becker-capital-humano`); también la afiliación, la protección del empleo o negarse a cooperar con los nuevos.
- **b) Modelo**. i) Supuestos: la empresa empieza con $\overline L_I$ *insiders*; misma productividad (con $F(a\,L_I+L_O)$, $a>1$, si fueran más productivos; aquí $a=1$); despedir cuesta $c_D$ y contratar $c_C$; los *outsiders* cobran su salario de reserva $w_O=w^R$; juego en 2 etapas (los *insiders* negocian $w_I$, la empresa elige $L_I$ y $L_O$). ii) Desarrollo (anexo E, con `\optim`):
  $$\max_{L_I,L_O}\ B=A\,F(L_I+L_O)-w_I L_I-w_O L_O-c_D(\overline L_I-L_I)-c_C L_O\quad\text{s.a.}\ L_I\le\overline L_I,\ L_I,L_O\ge 0$$
  CPO $A\,F'(L)-w_I+c_D=0$ y $A\,F'(L)-w_O-c_C=0$; salario máximo de los *insiders* (`eq:insiders`, función clave **sin recuadro**):
  $$w_I=w_O+c_D+c_C$$
  Segundo límite: $A\,F'(L)+c_D\ge w_I$. Con $A\,F'(L_1)=w_O+c_C$ y $A\,F'(L_2)+c_D=w^R$, 3 casos: **A** pocos ($\overline L_I<L_1$; contrata *outsiders* hasta $L_1$, $w_I$ máximo), **B** intermedio ($L_1\le\overline L_I\le L_2$; ni contrata ni despide, $w_I=A\,F'(\overline L_I)+c_D$), **C** muchos ($\overline L_I>L_2$; despide hasta $L_2$, $w_I=w^R$). iii) Implicaciones: paro involuntario de los *outsiders*; **histéresis** (en el caso B el empleo es el número de *insiders* que hubiera: depende de la historia); dualidad; el salario que baja con el número de *insiders* es solo el caso B (no es la predicción central: «salario real contracíclico» era un error del original).
- **c) Evidencia y caso español**: la Gran Recesión recayó sobre los temporales (Bentolila et al., 2012); España como mercado de *insiders* y *outsiders* y sus reformas (Bentolila, Dolado y Jimeno, 2012).
- **d) Política económica**: bajar los costes de rotación, cláusulas de descuelgue, formación de los parados, subvenciones a su contratación.

**Gráfico de referencia** (`oposicion/temario/fuentes/3A27/graficos/`): `insiders.tex` (salario máximo de los *insiders* según cuántos sean, casos A, B y C), en el anexo E: **no se canta** (el bloque III va sin gráfico).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.27 | Determinación de salarios: contratos implícitos y sus extensiones | desarrollo (hecho, 31/10/2026) | a)-b) con `eq:insiders` en el cuerpo (III.3, comodín que se acorta si falta tiempo); programa, CPO, 3 casos y gráfico en el anexo E | — |
| 3.A.28 | Persistencia del desempleo | resumen | Mecanismo de la histéresis (ficha `histeresis`): tras un *shock*, los despedidos salen de la mesa y los *insiders* que quedan no fijan salarios para que vuelvan; `\vertema{3.A.27}` | El programa y los 3 casos |
| 4.A.16 | Mercado de trabajo en España | resumen (aplicado) | Dualidad indefinidos-temporales, costes de despido, convenios y descuelgue, reformas de 2012 y 2021, con datos; completo para el 4.º sin depender del 3.º | El modelo formal |
| 3.A.25 | Mercado de trabajo neoclásico, capital humano | mención (hecho, 31/10/2026) | La formación específica como raíz del poder de los *insiders*; fila 7 de `tab:supuestos-trabajo` | El modelo |
| 1D01 | Dictamen de coyuntura | mención (hecho) | Paro de larga duración e histéresis | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.27 original: al final de I.2 (sindicatos), con $N_I$, $d$, $c$ y la idea central «un modelo en el que el salario real es contracíclico». **Resuelto** (31/10/2026): en III.3 como extensión de los contratos implícitos (A27-04, **[decidir]**), con $\overline L_I$, $c_D$, $c_C$ ($c$ es el coste de la vacante en la curva salarial del DMP) y lo central en el paro de los *outsiders* y su persistencia.
- 3.A.28 (sin revisar): resume a los *insiders* con otras palabras: al revisarlo, la frase de la histéresis con esta ficha y remisión al 3.A.27.
- 4.A.16 (sin revisar): usa el modelo sin remitir: al revisarlo, `\vertema{3.A.27}` solo para ampliar.

Autor: Víctor Gutiérrez Marcos
