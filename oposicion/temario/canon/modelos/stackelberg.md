# Oligopolio de Stackelberg (1934): competencia secuencial en cantidades

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.19** (Teoría del oligopolio…; revisado el 20/10/2026, I.3 `sec:stackelberg`, con el anexo `anexo:stackelberg-lineal`) — lo desarrolla con a)-c) como ENPS sobre el mismo gráfico de Cournot. Ficha creada a raíz de esa revisión (K31 de coherencia).
- **Temas que lo usan:** 3.A.19 (desarrollo; hecho, 20/10/2026), 3.A.14 (mención; hecho, 19/10/2026: juegos en 2 etapas y «el liderazgo de Stackelberg» como ENPS, l. 355), 3.A.15 (mención; hecho, 20/10/2026: la ventaja del primero es de compromiso, como en el compromiso de capacidad de Dixit; ficha `disuasion-entrada`), 3.A.18 (mención; hecho, 19/10/2026: con complementos estratégicos la ventaja es del segundo, Gal-Or, 1985), 3.B.8 (mención: Brander-Spencer, el subsidio hace creíble el liderazgo; ficha `brander-spencer`).
- **Manuales de referencia:** von Stackelberg (1934), *Marktform und Gleichgewicht*; Mas-Colell, Whinston y Green (1995), cap. 9 y § 12.C; Tirole (1988), cap. 8; Gibbons (1992), § 2.1.B; Gal-Or (1985).

## Presentación de referencia (3.A.19, I.3)

Pregunta: ¿qué pasa si una empresa decide antes que la otra? Conclusión: la líder produce la cantidad de monopolio y gana más; la ventaja es de **compromiso**, no de información, y exige una decisión irreversible.

- **a) Idea**: una empresa establecida (**líder**) elige su cantidad primero, de forma irreversible, y la **seguidora** la observa.
- **b) Modelo. i) Supuestos**: los de Cournot con 2 empresas, salvo el orden; juego dinámico con información perfecta en 2 etapas, por inducción hacia atrás (3.A.14). **ii) Desarrollo**: 2.ª etapa, $q_2=R_2(q_1)$ (responde a lo que ya ha hecho la líder); 1.ª etapa, el problema de Cournot con la **restricción adicional** $q_2=R_2(q_1)$ (Víctor, 20/10/2026: que se vea como algo añadido a Cournot), `\optim{\max}{q_1,\,q_2}{B_1=p\big(q_1+q_2\big)\,q_1-C_1(q_1)}{q_2=R_2(q_1)\\ q_1\geq 0}`, y sustituyendo la restricción, con
$$p(Q)+p'(Q)\,q_1\,\big[1+R_2'(q_1)\big]=\mathrm{CMg}_1(q_1)$$
  (variación conjetural negativa y correcta); lineal con costes iguales: $q_1^S=(a-c)/2b$ (la de monopolio), $q_2^S=(a-c)/4b$, $p^S=(a+3c)/4$, beneficios $(a-c)^2/8b$ y $(a-c)^2/16b$ frente a $(a-c)^2/9b$; gráficamente, el punto S de tangencia del isobeneficio de la líder con $R_2$, a la derecha y por debajo de C. **iii) Implicaciones**: es un **ENPS** (el resultado de Cournot también es EN con la amenaza no creíble de producir $q^C$); **ventaja del primero en mover, de compromiso** (si pudiera rectificar, volvería a $R_1$: la disuasión de Dixit, 3.A.15); con complementos estratégicos la ventaja es del segundo (Gal-Or, 1985; 3.A.18); bienestar $Q^S=3(a-c)/4b>Q^C$.
- **c) Valoración**: explica la ventaja de las establecidas, pero el orden es exógeno; y supone cantidades (de ahí Bertrand).

**Gráfico de referencia:** `oposicion/temario/fuentes/3A19/graficos/stackelberg.tex`, **gráfico propio** (Víctor, 20/10/2026), que parte del de Cournot dejado en la pizarra: $R_1$, C y el isobeneficio $B_1^C$ en gris, $R_2$ como restricción y el isobeneficio $B_1^S$ tangente en S. El gráfico de Cournot ya no lleva S. En la tabla `tab:comparacion`: producción 3/4, margen 1/4, PIE 1/32.

**Notación** (`notacion.md` § 4): $q_1^S$, $q_2^S$, $Q^S$, $p^S$ (superíndice S en cursiva: Stackelberg; no se usa $q^S$ para otra cosa en el bloque: el maximizador de ventas de Baumol es $q^B$ en el 3.A.15); $R_2(q_1)$, $R_2'$.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.19 | Soluciones no cooperativas | desarrollo (hecho, 20/10/2026; 1′30″ en el cante) | Todo lo anterior | La definición de ENPS (3.A.14) |
| 3.A.14 | ENPS | mención (hecho, 19/10/2026) | El liderazgo como juego en 2 etapas resuelto por inducción hacia atrás; remite al 3.A.19 | Las cantidades y el gráfico |
| 3.A.15 | Compromiso de capacidad | mención (hecho, 20/10/2026) | La capacidad comprometida antes da a la instalada la ventaja del líder | — |
| 3.A.18 | Precios con diferenciación | mención (hecho, 19/10/2026) | Con precios, ventaja del segundo (Gal-Or, 1985) | — |
| 3.B.8 | Política comercial estratégica | mención | Brander-Spencer: el subsidio a la exportación lleva a la empresa nacional al punto de Stackelberg (hace creíble el liderazgo); remitir al 3.A.19 | La derivación |

## Divergencias encontradas en el temario actual
- 3.A.19 original: φ_2(q_1) y π para el beneficio; $q_2^e$ esperada. **Resuelto** (20/10/2026): $R_2(q_1)$, $B_1$, sin superíndice de expectativas.
- 3.B.8 (sin revisar): su remisión a «la teoría general del oligopolio [3.A.19]» para el liderazgo de Stackelberg es correcta; usar $R_A(q_B)$.

Autor: Víctor Gutiérrez Marcos
