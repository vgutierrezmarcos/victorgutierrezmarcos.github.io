# Negociación: solución de Nash (1950), Rubinstein (1982) y Binmore, Rubinstein y Wolinsky (1986)

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.14** (Teoría de juegos; revisado el 19/10/2026, II.3.1, con el anexo `anexo:rubinstein`) — desarrolla con a)-d) el programa de Nash: el camino axiomático, el estratégico y su unión. Ficha creada a raíz de esa revisión (C3; propuesta del 3.A.17 y de `informe-repaso.md` § 13; D5 del 3.A.14, aplicada con la opción recomendada, pendiente de que Víctor la confirme). La alternativa era la referencia en el 3.A.27 («modelos de negociación» en su título): el 3.A.27 aplica la solución a la negociación salarial y remite aquí los axiomas y Rubinstein.
- **Temas que lo usan:** 3.A.14 (desarrollo; hecho, 19/10/2026), 3.A.17 (resumen aplicado; hecho, 17/10/2026: monopolio bilateral con la Nash generalizada (U_S − U_S^0)^γ(B − B^0)^{1−γ}, Rubinstein y BRW con γ = ρ_B/(ρ_S + ρ_B); ficha `monopolio-bilateral`), 3.A.21 (mención; hecho, 14/10/2026: Edgeworth con 2 agentes, Nash simétrico con la dotación como desacuerdo, 4 axiomas en nota, Rubinstein), 3.A.27 (resumen aplicado: negociación salarial, derecho a gestionar y contratos eficientes, con la misma notación; hoy desarrolla Nash y Rubinstein en extenso con otra notación), 3.A.23 (mención: negociación de Coase), 3.A.1 (mención: ultimátum en la economía conductual).
- **Manuales de referencia:** Nash (1950), «The Bargaining Problem», *Econometrica*; Rubinstein (1982), *Econometrica*; Binmore, Rubinstein y Wolinsky (1986), *RAND Journal*; Osborne y Rubinstein (1990), *Bargaining and Markets*; Mas-Colell, Whinston y Green (1995), cap. 9 (apéndice) y 22; Güth, Schmittberger y Schwarze (1982) (ultimátum).

## Presentación de referencia (3.A.14, II.3.1)

Pregunta: cuando 2 partes ganan con un acuerdo, ¿cuál de los acuerdos eficientes se alcanza? Conclusión: el que reparte el excedente según las alternativas de cada uno (punto de desacuerdo) y su paciencia relativa; los caminos cooperativo y no cooperativo llegan al mismo sitio (**programa de Nash**).

- **a) Idea**: resolver la indeterminación de Edgeworth (3.A.21) y de Bowley (3.A.17).
- **b) Modelo.** i) Supuestos: 2 jugadores, conjunto $\mathcal U$ de pagos alcanzables (convexo y compacto), **punto de desacuerdo** $(u_1^0,u_2^0)$. ii) Desarrollo: **camino axiomático** (Nash, 1950): eficiencia, simetría, invariancia a transformaciones afines e independencia de las alternativas irrelevantes ⇒ maximizar el producto de las ganancias; sin simetría, **solución de Nash generalizada** con poder de negociación $\gamma\in(0,1)$ del jugador 1 (`\funcionclave` `eq:nash-negociacion`):
$$\max_{u_1,u_2}\ \big(u_1-u_1^0\big)^{\gamma}\big(u_2-u_2^0\big)^{1-\gamma}\quad\text{s.a.}\quad (u_1,u_2)\in\mathcal U,\ u_1\geq u_1^0,\ u_2\geq u_2^0;$$
  con los 4 axiomas, γ = ½; con utilidad transferible, cada uno recibe su desacuerdo más su parte (γ, 1 − γ) del excedente neto. **Camino estratégico** (Rubinstein, 1982): ofertas alternadas para repartir 1 euro, factores de descuento por ronda $\beta_1,\beta_2<1$; único ENPS con acuerdo inmediato y
$$x^*=\frac{1-\beta_2}{1-\beta_1\beta_2}$$
  (gana el más paciente; el que propone tiene ventaja). **Unión** (Binmore, Rubinstein y Wolinsky, 1986): con $\beta_i=e^{-\rho_i\Delta}$ y Δ → 0, el reparto converge a la Nash generalizada con
$$\gamma=\frac{\rho_2}{\rho_1+\rho_2}$$
  (poder de negociación = **paciencia relativa**). iii) Implicaciones: mejorar la opción externa o poder esperar más da poder de negociación; aplicaciones: monopolio bilateral (3.A.17), negociación salarial (3.A.27), caja de Edgeworth (3.A.21).
- **c) Evidencia**: juego del ultimátum (Güth *et al.*, 1982): repartos cercanos a la mitad y rechazos de ofertas bajas (3.A.1).
- **d) Valoración**: axiomas discutibles (sobre todo la independencia de las alternativas irrelevantes); con información privada aparecen retrasos y rupturas; con más de 2 jugadores, coaliciones (ficha `nucleo-shapley`).

**Gráfico de referencia:** ninguno propio en el 3.A.14 (en la pizarra, el producto de Nash recuadrado y γ = ρ_2/(ρ_1 + ρ_2) debajo). En las aplicaciones: `3A17/graficos/monopolio-bilateral.tex` y la caja `3A21/graficos/caja-intercambio-nucleo.tex`.

**Notación:** $u_i$, $u_i^0$ (desacuerdo, superíndice 0; en el 3.A.17, $U_S^0$ y $B^0$; en el 3.A.21, $U_A^0$, $U_B^0$), $\mathcal U$, γ (poder de negociación del jugador 1, o del oferente: el sindicato en el 3.A.17), β_1, β_2 (factores por ronda; nunca δ, la de los manuales), ρ_1, ρ_2 (tasas de descuento; en el 3.A.17, ρ_S y ρ_B), $x^*$. γ es aquí el poder de negociación; en Barro-Gordon, el peso de la inflación (no conviven: el 3.A.14 cuenta Barro-Gordon de palabra).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.14 | Negociación como juego | desarrollo (hecho, 19/10/2026) | Todo lo anterior; derivación de Rubinstein y su límite en el anexo B | Las aplicaciones al mercado de trabajo |
| 3.A.17 | Monopolio bilateral | resumen aplicado (hecho, 17/10/2026) | Nash generalizada sobre U_S y B: cantidad competitiva y salario que reparte el excedente; Rubinstein y BRW en una línea con γ = ρ_B/(ρ_S + ρ_B) y remisión a 3.A.14 | Los axiomas |
| 3.A.21 | Indeterminación de Edgeworth | mención (hecho, 14/10/2026) | Nash simétrico (γ = ½) con la dotación como desacuerdo; 4 axiomas en nota con las mismas palabras; Rubinstein | — |
| 3.A.27 | Negociación salarial | resumen aplicado | Nash generalizada con γ para el sindicato, $U_S$, $v(L)$ o el salario de reserva y los puntos de desacuerdo con superíndice 0, derecho a gestionar y contratos eficientes (McDonald y Solow, 1981); remitir aquí los axiomas y Rubinstein, y al 3.A.17 el monopolio bilateral | Los axiomas y la derivación de Rubinstein |
| 3.A.23 | Externalidades | mención | La negociación de Coase como negociación bilateral | — |
| 3.A.1 | Economía conductual | mención | El ultimátum: la equidad pesa | — |

## Divergencias encontradas en el temario actual
- 3.A.27 (sin revisar): desarrolla Nash axiomático ($f(N,d)$, $u^N$, $d$) y Rubinstein en extenso con otra notación: al revisarlo, resumen aplicado con $u_i^0$, γ, ρ y remisión aquí (D5 del 3.A.14).
- 3.A.17 (revisado): usa γ, $U_S^0$, $B^0$ y ρ_S, ρ_B: **coherente** (no cambia de texto).
- 3.A.21 (revisado): «un único equilibrio perfecto en subjuegos» (l. 695) → «de Nash perfecto en subjuegos» (`pendientes-coherencia.md`, opcional).

Autor: Víctor Gutiérrez Marcos
