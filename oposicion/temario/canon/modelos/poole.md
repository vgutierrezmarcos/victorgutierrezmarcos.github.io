# Elección del instrumento de la política monetaria: Poole (1970)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.36** (Política monetaria (I). El diseño y la instrumentación; revisado el 4/11/2026: II.3.2 `sec:poole` con a)-e), gráfico `poole`, y anexo C `anexo:poole`, paso a paso con la regla mixta), **[decidir]** (CC1 y D6 de la coherencia del 3.A.36). Motivo: la elección entre fijar la cantidad de dinero o el tipo de interés es la pregunta de la instrumentación, que está en el título; el 3.A.5 lo cita en la contracrítica al monetarismo y el 3.A.35 y el 3.A.37 lo mencionan. Ficha creada en la fase canon del 3.A.36 (el id ya estaba en la lista del tema y en `_inventario/areas.json`, sin ficha).
- **Temas que lo usan:** 3.A.36 (desarrollo; hecho, 4/11/2026), 3.A.5 (mención; hecho, 3/11/2026: III.2, l. 580, en la valoración del monetarismo junto a la ley de Goodhart: «si las perturbaciones vienen de la demanda de dinero, estabiliza mejor fijar el tipo de interés», `Poole1970Optimal`, `\vertema{3.A.36}`), 3.A.35 (mención: la estabilidad de la demanda de dinero decide el instrumento; sin revisar), 3.A.37 (mención: por qué el instrumento es un tipo de interés; sin revisar). Relacionadas: `is-lm` (el modelo de partida, con $b$, $k$, $h$ del 3.A.5), `monetarismo` (los objetivos monetarios de los 70 y la ley de Goodhart), `taylor` (la regla de tipos que sucede a la del k %), `objetivo-inflacion`.
- **Manuales de referencia:** Poole (1970), «Optimal Choice of Monetary Policy Instruments in a Simple Stochastic Macro Model», *QJE* 84(2) (`Poole1970Optimal`); Walsh (2017), *Monetary Theory and Policy*, cap. 11 (`Walsh2017Monetary`); Romer (2019), cap. 12; Mishkin, Matthews y Giuliodori (2013) (`MishkinMatthewsGiuliodori2013`); Sargent y Wallace (1975) para la indeterminación con el tipo fijo (`SargentWallace1975Rational`).

## Presentación de referencia (3.A.36, II.3.2 y anexo C)

**Pregunta:** ¿qué debe fijar el banco central, la cantidad de dinero o el tipo de interés, si tiene que decidir antes de ver las perturbaciones del periodo?

**a) Idea:** depende de dónde vengan las perturbaciones: del mercado de bienes (reales) o del de dinero (monetarias).

**b) Modelo. i) Supuestos:** el banco central decide **antes** de ver las perturbaciones: ve enseguida el tipo, pero la producción con retraso (nota con la analogía del precio que sube sin ver la cantidad); minimiza **$\mathbb{E}[y_t^2]$**, la varianza de la producción en torno a su objetivo normalizado a cero (**nunca** «$\mathbb{E}[y_t]^2$», como el Word); IS-LM con precios fijos, en logaritmos y desviaciones, con las letras del IS-LM del 3.A.5:

$$y_t=-b\,i_t+\varepsilon^{\mathrm{IS}}_t\ \ \text{(IS)},\qquad m_t=k\,y_t-h\,i_t+\varepsilon^{\mathrm{LM}}_t\ \ \text{(LM)},$$

$\varepsilon^{\mathrm{IS}}_t$ perturbación real (demanda de bienes) y $\varepsilon^{\mathrm{LM}}_t$ monetaria (demanda de dinero), independientes, de media cero, varianzas $\sigma^2_{\mathrm{IS}}$ y $\sigma^2_{\mathrm{LM}}$ (superíndices en redonda).

**ii) Desarrollo:**
- **Tipo fijo** ($i_t=0$, su nivel $\bar\imath$ en desviaciones): LM horizontal, el dinero se adapta; $y_t=\varepsilon^{\mathrm{IS}}_t$ y $\mathbb{E}[y_t^2]_i=\sigma^2_{\mathrm{IS}}$.
- **Cantidad fija** ($m_t=0$): $i_t=(k\,y_t+\varepsilon^{\mathrm{LM}}_t)/h$ y
  $$y_t=\frac{h\,\varepsilon^{\mathrm{IS}}_t-b\,\varepsilon^{\mathrm{LM}}_t}{h+b\,k},\qquad \mathbb{E}[y_t^2]_M=\frac{h^2\sigma^2_{\mathrm{IS}}+b^2\sigma^2_{\mathrm{LM}}}{(h+b\,k)^2}.$$
- **Gráficamente** (`poole`, 4 paneles): perturbaciones reales (IS$^+$/IS$^-$) con la cantidad fija (a) y con el tipo fijo (b); monetarias (LM$^+$/LM$^-$) con la cantidad fija (c) y con el tipo fijo (d); el tramo rojo del eje es lo que varía la producción.

**iii) Implicaciones:** fijar el tipo es mejor si y solo si

$$\frac{\sigma^2_{\mathrm{LM}}}{\sigma^2_{\mathrm{IS}}}>k^2+\frac{2\,h\,k}{b}$$

(la misma que la $k(2h/b+k)$ de la coherencia): cuanto más pesan las perturbaciones monetarias y, para un cociente dado, cuanto menor es $h$ (LM más inclinada) y mayor $b$ (IS más plana). **Con varianzas iguales y $k\geq1$, fijar la cantidad nunca es peor** (el umbral supera $k^2\geq1$): decide el peso relativo de las perturbaciones, no las pendientes solas (el Word decía lo contrario). Pegatina del 3.A.36: «perturbación real, fija la cantidad; monetaria, fija el tipo».

**c) Extensiones:** la **regla mixta** (anexo C, derivación propia con la notación del tema, A36-14): $m_t=\mu\,i_t$ ($\mu=0$ cantidad fija, $\mu\to\infty$ tipo fijo; **μ y $H\equiv h+\mu$ locales del anexo**, avisados: μ no es aquí el margen), $\mathbb{E}[y_t^2]=(H^2\sigma^2_{\mathrm{IS}}+b^2\sigma^2_{\mathrm{LM}})/(H+bk)^2$ y

$$H^*=\frac{b\,\sigma^2_{\mathrm{LM}}}{k\,\sigma^2_{\mathrm{IS}}}:$$

la LM óptima es más plana cuanto más pesan las perturbaciones monetarias, y nunca es un extremo si existen las 2.

**d) Evidencia:** objetivos monetarios en los 70 (Reserva Federal y Banco de Canadá desde 1975, Banco de Inglaterra con objetivos publicados desde **1976** —nunca «desde 1973»—, Bundesbank hasta el euro; Hotson, 2010); la innovación financiera hizo inestable la demanda de dinero (más $\varepsilon^{\mathrm{LM}}_t$) y se abandonaron (Reserva Federal, otoño de 1982; Banco de Canadá, 1982, con la frase de Bouey: «no abandonamos los agregados monetarios: ellos nos abandonaron a nosotros», `Bouey1982Statement`).

**e) Valoración:** explica por qué los grandes bancos centrales fijan hoy un tipo de interés; pero es estático, con precios fijos y sin expectativas: con expectativas racionales, un tipo fijo que no responde a la inflación deja indeterminado el nivel de precios (Sargent y Wallace, 1975): de ahí el principio de Taylor (ficha `taylor`).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A36/graficos/poole.tex` (**imprescindible** en el cante del 3.A.36, al menos la fila de perturbaciones reales y el panel d): 4 paneles en el plano $(y,i)$, LM horizontal en $\bar\imath$ con el tipo fijo, IS$^+$/IS$^-$ y LM$^+$/LM$^-$, la variación de la producción en rojo sobre el eje. Los temas que lo resuman lo copian sin cambios.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.36 | Instrumentación: qué fija el banco central | desarrollo (hecho, 4/11/2026) | II.3.2 a)-e) en 2′30″ con el gráfico por paneles; anexo C con las varianzas, la condición y la regla mixta | — |
| 3.A.5 | Valoración del monetarismo | mención (hecho, 3/11/2026) | Una frase junto a Goodhart: con perturbaciones de la demanda de dinero, mejor fijar el tipo; `\vertema{3.A.36}` | El modelo |
| 3.A.35 | Demanda de dinero | mención | Si la demanda de dinero es inestable, el instrumento es el tipo de interés; `\vertema{3.A.36}` | La derivación |
| 3.A.37 | Transmisión | mención | Por qué la transmisión empieza en un tipo a muy corto plazo; `\vertema{3.A.36}` | — |

## Divergencias encontradas en el temario actual

- **Resuelto en el 3.A.36 (4/11/2026)**: el Word escribía la función objetivo «$\mathbb{E}[y_t]^2$», con $y=-\alpha i+u$, $m=y-c\,i+v$ (α es la de Barro-Gordon y $c$ la propensión a consumir; $u_t$ es la de costes de la NEK en el mismo tema) y la implicación falsa «con varianzas iguales, el tipo es mejor cuanto más empinada la LM y más plana la IS»; la imagen venía del tema de un preparador; el Reino Unido con objetivos «desde 1973».
- **3.A.35 y 3.A.37 (sin revisar)**: si lo citan, con esta notación ($\varepsilon^{\mathrm{IS}}_t$, $\varepsilon^{\mathrm{LM}}_t$; nunca las $u_t$, $v_t$ de Walsh, que chocan con la $u_t$ de costes) y `\vertema{3.A.36}`.

Autor: Víctor Gutiérrez Marcos
