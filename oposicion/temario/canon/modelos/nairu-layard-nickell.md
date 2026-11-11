# NAIRU: fijación de salarios y precios (Layard, Nickell y Jackman, 1991)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.28** (La tasa natural de paro y la NAIRU; revisado el 31/10/2026: III.3 `sec:nairu` con a)-d) en 6′, anexo B `anexo:tnp-nairu`, anexo C `anexo:nairu-lineal` y anexo D `anexo:demanda-pasos`) — está en el título.
- **Temas que lo usan:** 3.A.28 (desarrollo; hecho, 31/10/2026), 3.A.7 (resumen; hecho, 4/11/2026: I.2.3, WS, PS y NAIRU con las mismas etiquetas, `eq:ws`, `eq:ps` y `eq:nairu`, sin `\funcionclave`; conflicto distributivo; NIRU de Modigliani y Papademos, 1975, y «aproximadamente un sinónimo» de Ball y Mankiw, 2002; `ws-ps.tex` copiado del 3.A.28 sin cambios como apoyo, A07-03, **[decidir]**), 1D01 (mención: III.1 y II.2), 3.A.27 (mención; hecho, 31/10/2026: I.3, la negociación con derecho a gestionar da la WS, `eq:ws`, $W/P^e=F(U,Z)\cdot\mathrm{PAT}^e$ con $F_U<0$, como en esta ficha, y la CNE de Shapiro y Stiglitz como otra WS decreciente en el paro; evidencia de Blanchflower y Oswald, 1994; remisión al 3.A.28), 3.A.36 (mención; hecho, 4/11/2026: I.1.2, la tasa natural como guía con mucha incertidumbre; I.2.3 e), la NAIRU detrás de la brecha con Staiger, Stock y Watson, 1997, sin cifra; `\vertema{3.A.28}`), 4.B.4 (mención: la NAWRU en el saldo estructural). También 3.A.5 (mención; hecho, 3/11/2026: II.2.2, una línea: «de ahí el nombre de NAIRU…; su versión con fijación de salarios y precios es posterior», con `\vertema{3.A.28}`). También 3.A.32 (la cuña exterior y las políticas de oferta; hecho, 11/11/2026).
- **Manuales de referencia:** Modigliani y Papademos (1975), la NIRU; Tobin (1980), pp. 24-25, el acrónimo NAIRU; Layard y Nickell (1985); Layard, Nickell y Jackman (1991), *Unemployment* (`LayardNickellJackman1991Unemployment`); Blanchard, *Macroeconomics*, cap. 7-8; Carlin y Soskice (2015), cap. 2; Cahuc, Carcillo y Zylberberg (2014), cap. 9; Ball y Mankiw (2002); Estrella y Mishkin (1999), en Taylor (ed.), *Monetary Policy Rules* (`EstrellaMishkin1999NAIRU`; **no** `EstrellaMishkin1998`, que es el de las recesiones y la curva de tipos de la 1D01).

## Presentación de referencia (3.A.28, III.3)

**Pregunta:** ¿qué tasa de paro hace compatibles el salario real que piden los trabajadores y el que dejan las empresas, sin que se acelere la inflación?

**a) Idea:** NIRU de Modigliani y Papademos (1975), concepto empírico; NAIRU (Tobin, 1980); modelo de fijación de salarios y precios de Layard y Nickell (1985) y Layard, Nickell y Jackman (1991), para el paro europeo de los 70 y los 80. Nunca «la introdujeron autores de la NEK desde los 80».

**b) Modelo.** *Supuestos:* población activa dada, $\overline L$, y $U=(\overline L-L)/\overline L$; salarios fijados (negociación o eficiencia) antes de conocer los precios, con $P^e$ y $\mathrm{PAT}^e$; empresas en competencia monopolística con margen μ sobre el CLU (3.A.18); $\mathrm{PAT}=Y/L$ (productividad **media**) que no depende del empleo; a corto plazo la demanda fija el empleo, a medio plazo las 2 curvas.

$$\text{WS (\texttt{eq:ws}, idéntica a la del 3.A.27):}\quad \frac{W}{P^e} = F(U, Z)\cdot \mathrm{PAT}^e,\qquad F_U < 0,\ F_Z>0$$

$$\text{PS (\texttt{eq:ps}):}\quad P = (1+\mu)\frac{W}{\mathrm{PAT}} \ \Longrightarrow\ \frac{W}{P} = \frac{\mathrm{PAT}}{1+\mu}$$

con Z factores institucionales (prestaciones, poder sindical, protección del empleo, impuestos sobre el trabajo), CLU = WL/Y = W/PAT. Con $P^e=P$ y $\mathrm{PAT}^e=\mathrm{PAT}$, la **NAIRU** (`\funcionclave` `eq:nairu`):
$$F(U^n,Z)=\frac{1}{1+\mu}.$$
Interpretación: **conflicto distributivo** (los trabajadores reclaman $F(U,Z)$ de lo producido y las empresas $\mu/(1+\mu)$; el paro modera las pretensiones hasta que encajan). PS horizontal; su pendiente posible (rendimientos decrecientes, margen contracíclico de Rotemberg y Woodford, 1991, y la productividad procíclica de los datos), en nota.

*Implicaciones:* paro **involuntario de equilibrio**; políticas de oferta ($Z$, μ y defensa de la competencia, cuña fiscal; el **nivel** de la productividad, una vez esperado, no mueve $U^n$, solo las sorpresas; la formación la baja por el emparejamiento); política de demanda con la lectura aceleracionista (si $U_t<U^n$, la WS queda por encima de la PS y $\Delta\pi_t=-a(U_t-U^n)$; vuelta a $U^n$ por saldos reales o por el banco central, con más inflación; la secuencia paso a paso en el anexo D); perturbaciones de oferta (Bruno y Sachs, 1985).

**Forma lineal (anexo C; letra *a*, [decidir] A28-04/K21):** $F(U,Z)=1-a\,U+Z$, $a>0$:
- paso 1: $U^n=\frac{1}{a}\left(\frac{\mu}{1+\mu}+Z\right)\approx\frac{\mu+Z}{a}$;
- paso 2: $\pi_t\approx\pi^e_t+\mu+Z-a\,U_t-\varepsilon^{\mathrm{PAT}}_t$, $\varepsilon^{\mathrm{PAT}}_t\equiv\ln(\mathrm{PAT}_t/\mathrm{PAT}^e_t)$; sin sorpresas, $\pi_t\approx\pi^e_t-a(U_t-U^n)$: **la curva aumentada con la misma pendiente *a*** (por eso la misma letra; ficha `phillips`);
- paso 3, con $P^e=P$ y $\mathrm{PAT}^e\neq\mathrm{PAT}$: $F(U^n,Z)=\dfrac{\mathrm{PAT}}{(1+\mu)\,\mathrm{PAT}^e}$ (**no al revés**: una productividad mayor que la esperada baja la NAIRU) y $U^n=\frac1a\big(1+Z-\frac{\mathrm{PAT}}{(1+\mu)\mathrm{PAT}^e}\big)$;
- paso 4, WS sin productividad esperada, $W/P^e=1-aU+Z$: $U^n=\frac1a\big(1+Z-\frac{\mathrm{PAT}}{1+\mu}\big)$: el nivel de la productividad baja la NAIRU (por eso los manuales ponen $\mathrm{PAT}^e$ en la WS). Nota al opositor del test: leer qué WS da el enunciado.

**c) Evidencia:** Europa frente a EE. UU. (Blanchard, 2006): perturbaciones con salarios rígidos (Bruno y Sachs, 1985), instituciones (Nickell, 1997; Calmfors y Driffill, 1988), perturbaciones × instituciones (Blanchard y Wolfers, 2000); EE. UU. en los 90 (Ball y Mankiw, 2002); medida incierta (Staiger, Stock y Watson, 1997: 4,3 %-7,3 % al 95 %; Estrella y Mishkin, 1999); España, NAWRU de la Comisión (AMECO ZNAWRU, `CE2026AMECO`, método en `Havik2014Potencial`): 13,4 % (2005), 16,9 % (2013), 12,1 % (2025), zona del euro 6,6 %; desde 2023 el paro está por debajo.

**d) Valoración:** aportación (paro involuntario de equilibrio, ordena las políticas de oferta, referencia para bancos centrales y Comisión; une NAIRU y Phillips); críticas: se estima mal (Jimeno, 2018, «¡La NAIRU ha muerto! ¡Larga vida a la NAIRU!»), expectativas y dinámica simples (NEK de 2.ª generación), se mueve con el paro (puente a la histéresis), puede no ser única (Farmer, 2010 y 2013: *belief function*, equilibrios múltiples; ficha `hosios` y `dmp`).

**Tasa natural frente a NAIRU** (anexo B, `tab:tnp-nairu`, gráfico `tn-nairu.tex` en $(L,W/P)$): Ball y Mankiw (2002), «aproximadamente un sinónimo»; Friedman incluye las imperfecciones en la tasa natural (p. 8): la diferencia está en el modelo que la explica, no en el concepto; nunca «la NAIRU es mayor por la competencia imperfecta» ni «paro keynesiano» para el paro involuntario de equilibrio. En el plano $(L,W/P)$ las distancias son el **número** de parados, $U^n\overline L$, no tasas.

**Gráficos de referencia** (`oposicion/temario/fuentes/3A28/graficos/`):
- `ws-ps.tex` (**imprescindible**, por capas: ejes → WS → PS → E y $U^n$ → brecha con $U<U^n$): plano $(U,W/P)$, WS decreciente y convexa $g(U)=1+5{,}2e^{-0{,}3U}$, PS horizontal en PAT/(1+μ), corte en $U^n=4$. Código base común de los 3 siguientes.
- `ws-ps-desplazamientos.tex` (2 paneles, que en el vídeo son 2 capas más sobre `ws-ps`): a) sube Z → WS′ arriba → $U^n$ sube (al revés, la reducción del subsidio); b) sube μ → PS′ abajo → $U^n$ sube.
- `paro-nawru-espana.tex` (datos, apoyo en pantalla): paro y NAWRU de España y de la zona del euro, 1980-2027 (AMECO, 3/6/2026).
- `tn-nairu.tex` (anexo B) y `nairu-demanda-pasos.tex` (anexo D, con el panel b en la aceleracionista): no se cantan.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.28 | Tasa natural y NAIRU | desarrollo (hecho, 31/10/2026) | Todo lo anterior: III.3 con a)-d) (6′), anexos B, C y D; $U^n$ para la tasa natural y la NAIRU con la nota estándar | — |
| 3.A.7 | NEK de 1.ª generación | resumen (hecho, 4/11/2026) | El modelo agregado del paro de la rama europea: WS y PS con `eq:ws`, `eq:ps`, `eq:nairu` y $U^n$ (sin recuadro), Layard y Nickell (1985) y Layard, Nickell y Jackman (1991), conflicto distributivo, políticas sobre $Z$ y μ, NIRU (1975) y Ball y Mankiw (2002); gráfico `ws-ps` copiado sin cambios como apoyo (A07-03, **[decidir]**: la ficha decía sin gráfico); `\vertema{3.A.28}` | Los determinantes, la forma lineal, la secuencia de demanda |
| 3.A.27 | Determinación de salarios | mención (hecho, 31/10/2026) | Microfundamentos de la WS: negociación (derecho a gestionar) y salarios de eficiencia; `eq:ws` con esta notación | La PS y la NAIRU |
| 3.A.36 | Política monetaria | mención (hecho, 4/11/2026) | La NAIRU como guía (y su incertidumbre: Staiger, Stock y Watson), con `\vertema{3.A.28}` | El modelo |
| 4.B.4 | Saldo estructural | Mención | La NAWRU de la Comisión en el empleo potencial (Havik *et al.*, 2014) | El modelo WS-PS |
| 1D01 | Dictamen de coyuntura | Mención | NAIRU (y NAWRU de la Comisión) como referencia del paro estructural; paro con brecha ≈ 0 | El modelo WS-PS |
| 3.A.5 | Síntesis y monetarismo | mención (hecho, 3/11/2026) | Una línea en II.2.2: la NAIRU como nombre de la tasa que no acelera la inflación; el WS-PS es posterior, `\vertema{3.A.28}` | El modelo WS-PS |
| 3.A.32 | OA abierta y políticas de oferta | resumen de la variante abierta (hecho, 11/11/2026) | I.2: `eq:nairu-abierta` $F(U^n,Z)=1/[(1+\mu)q^{\alpha}]$, la `eq:nairu` con la cuña exterior (Layard, Nickell y Jackman, 1991; Bruno y Sachs, 1985), función clave; III.3: las políticas que bajan la NAIRU en una viñeta, `\vertema{3.A.28}` | La lista WS-PS completa |

## Divergencias encontradas en el temario actual

- **Resuelto en el 3.A.28 (31/10/2026)**: SRN y SRP por WS y PS; $U_n$, $\overline U$ y TNP por $U^n$; la forma lineal con α (ahora *a*); $L^T$ por $\overline L$; «la NAIRU es mayor que la tasa natural por la competencia perfecta»; «paro keynesiano» en el anexo; la formación que bajaba la NAIRU con $\mathrm{PAT}^e$ en la WS; la nota 22 con la PS por la WS; «el *mark-up* depende inversamente de la demanda»; «Layard y Nickell (1985)» como inventores de la NAIRU; el **desarrollo invertido** con el 3.A.7 queda resuelto del lado del 3.A.28. La propuesta de coherencia K21 traía el paso 3 al revés ($\mathrm{PAT}^e/[(1+\mu)\mathrm{PAT}]$): corregido al integrar.
- **3.A.7 (**resuelto** al revisarlo, 4/11/2026; antes)**: copia palabra por palabra el texto viejo del 3.A.28 (SRN/SRP, $U_n$, α, «Layard y Nickell, 1985», «Blanchard y Summers, 1987»): al revisarlo, resumen con esta ficha y remisión.
- **3.A.41 (sin revisar)**: NAIRU como $\overline U$ (canon $U^n$).
- Notación: $W$ nominal y $W/P$ real en la macro (D026); μ margen (D106).

Autor: Víctor Gutiérrez Marcos
