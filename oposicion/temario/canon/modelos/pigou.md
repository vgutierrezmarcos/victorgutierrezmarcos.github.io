# Externalidades e impuesto pigouviano (Pigou, 1920)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** **3.A.23** (Bienestar II: externalidades; revisado el 21/10/2026, II.1: definición y clasificación, asignación competitiva frente a óptima con a)-c), e intervención: instrumentos pigouvianos, estándares, Coase, mercados de derechos, integración y comparación; anexo `anexo:externalidad-eg`). Recoge el id `externalidades-equilibrio-general` (alias desde el 21/10/2026).
- **Temas que lo usan:** 3.A.23 (desarrollo; hecho, 21/10/2026), 4.B.13 (resumen: impuestos especiales, fiscalidad verde y doble dividendo), 4.A.13, 4.B.7, 4.B.9 (mención), 4.B.10, 4.B.11 (resumen; hoy mención; D139), 4.A.6 (mención prevista: precio del carbono), 3.A.16 (mención; hecho, 17/10/2026: economías externas tecnológicas frente a pecuniarias, `\vertema{3.A.23}`), 3.A.22 (mención; hecho, 21/10/2026: monopolio contaminante como aplicación del *second best*, $t^*=\mathrm{CMgE}-p/\lvert\varepsilon_{q,p}\rvert$), 3.B.31 (resumen; hecho, 31/10/2026: $t^*=\mathrm{DMg}(E^*)=\mathrm{CSC}$ sobre el gráfico de las emisiones óptimas, el CSC como $\mathrm{CMgE}$ de una tonelada, y en el DICE $t^*_t=\mathrm{CSC}_t$, `eq:csc-impuesto`).
- **Manuales de referencia:** Pigou (1912, 1920); Meade (1952); Viner (1931) y Scitovsky (1954) para las pecuniarias; Buchanan y Stubblebine (1962); Baumol y Oates (1988), cap. 4; Mas-Colell, Whinston y Green, cap. 11; Rosen y Gayer, cap. 5.

## Presentación de referencia

**Equilibrio general (3.A.23, II.1.2 a)-b), anexo B):** externalidad en el consumo, $U_B(X_B,Y_B,X_A)$; el óptimo exige (`eq:externalidad`)
$$\mathrm{RMS}^A_{XY}+\frac{\partial U_B/\partial X_A}{\partial U_B/\partial Y_B}=\mathrm{RMS}^B_{XY},$$
mientras que el mercado iguala las RMS privadas a $p_X/p_Y$: no es óptimo. Impuesto pigouviano en EG, $t=-p_Y\,(\partial U_B/\partial X_A)/(\partial U_B/\partial Y_B)$ en el óptimo. En la producción (anexo B, acería $X=F_X(L_X,K_X)$ y piscifactoría $Y=F_Y(L_Y,K_Y,X)$ con $\partial F_Y/\partial X<0$): $\mathrm{RMS}=\mathrm{RMT}_{XY}+\lvert\partial F_Y/\partial X\rvert$ (`eq:externalidad-produccion`). Con utilidad cuasilineal, la RMS es la disposición marginal a pagar y se pasa al equilibrio parcial (nota al opositor).

**Equilibrio parcial: el ejemplo del río (acería y piscifactoría), el mismo en todo el tema y en Coase.** La acería es competitiva y precio-aceptante al precio dado $\overline p$; el coste marginal social suma al privado el **coste marginal externo** (`\funcionclave` `eq:cmgs`):
$$\mathrm{CMgS}(q)=\mathrm{CMgP}(q)+\mathrm{CMgE}(q).$$
Mercado: $\overline p=\mathrm{CMgP}(q^c)$; óptimo: $\overline p=\mathrm{CMgS}(q^*)$; $q^c>q^*$ (sobreproducción), pérdida = triángulo $E$. **Impuesto pigouviano** por unidad igual al daño marginal en el óptimo (`eq:pigou`): $t^*=\mathrm{CMgE}(q^*)$; la acería maximiza $\overline pq-C(q)-t^*q$ y produce $q^*$. Recauda $B+C=t^*q^*$ (doble dividendo, 4.B.13). Subvención simétrica a la externalidad positiva. **Estándar**: $\overline q=q^*$ (la oferta se quiebra en $\overline q$); misma información que el impuesto, caro con varias empresas. Con poder de mercado, el impuesto óptimo es menor que el daño marginal (Buchanan, 1969; *second best*, `\vertema{3.A.22}`). Externalidades tecnológicas (fallo de mercado) frente a pecuniarias (Viner, 1931; Scitovsky, 1954; 3.A.16). La contaminación óptima no suele ser cero.

**Gráficos de referencia** (el mismo gráfico que crece por capas: base → áreas → $\mathrm{CMgP}+t^*$ → $\overline q$):
- `oposicion/temario/fuentes/3A23/graficos/externalidad.tex` (II.1.2: $\overline p$ horizontal, $\mathrm{CMgP}$, $\mathrm{CMgS}$, $q^*$, $q^c$, triángulo $E$);
- `oposicion/temario/fuentes/3A23/graficos/externalidad-intervencion.tex` (II.1.3: áreas $B$, $C$, $D$, $E$ y, bajo $\mathrm{CMgE}$, $B'$, $C'$, $D'$, $E'$; $\mathrm{CMgP}+t^*$; estándar $\overline q$), con las tablas de bienestar `tab:pigou-bienestar` y `tab:estandar-bienestar`;
- comparación de los 5 mecanismos en `tab:instrumentos` (información que necesita el Estado y reparto).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.23 | Externalidades | desarrollo (hecho, 21/10/2026) | EG (consumo, con la condición y el impuesto) y EP con el ejemplo del río; impuesto, subvención, estándar con tablas de bienestar; comparación de los 5 mecanismos; derivaciones en el anexo B | — |
| 3.A.22 | *Second best* | mención (hecho, 21/10/2026) | Monopolio contaminante: el pigouviano reduce aún más la producción; $t^*=\mathrm{CMgE}(q^*)-p(q^*)/\lvert\varepsilon_{q,p}\rvert$ | El modelo |
| 3.A.16 | Competencia perfecta | mención (hecho, 17/10/2026) | Economías externas tecnológicas frente a pecuniarias | El modelo |
| 3.B.31 | Cambio climático | resumen (hecho, 31/10/2026) | $t^*=\mathrm{DMg}(E^*)$, la misma idea que $t^*=\mathrm{CMgE}(q^*)$, en el gráfico de las emisiones (`fig:emisiones-optimas`, ficha `samuelson-bienes-publicos`); es el coste social del carbono de la senda óptima (`eq:csc`, `eq:csc-impuesto`, ficha `dice`); la acería con $\mathrm{CMgS}=\mathrm{CMgP}+\mathrm{CMgE}$ en una viñeta; doble dividendo con `\vertema{4.B.13}` | El gráfico del mercado del bien |
| 4.B.13 | Imposición indirecta | resumen | Fundamento de los impuestos especiales (alcohol, tabaco, hidrocarburos), la fiscalidad verde y el doble dividendo, con $\mathrm{CMgS}=\mathrm{CMgP}+\mathrm{CMgE}$ y $t^*=\mathrm{CMgE}(q^*)$ | Gráfico de mercado completo |
| 4.A.6 | Política climática | mención | Precio del carbono: impuesto frente a RCDE (Weitzman) | — |
| 4.B.7, 4.B.9 | Principios, exceso de gravamen | mención | Excepción: impuesto que mejora la eficiencia | — |
| 4.B.10, 4.B.11 | Incentivos, imposición óptima | resumen (hoy mención; D139) | Impuesto igual al daño marginal en el óptimo; doble dividendo e interacción con la imposición óptima | El desarrollo |
| 4.A.13 | Turismo | mención | Externalidades y bienes comunes (tasas turísticas; ficha `tragedia-comunes`) | — |

## Divergencias encontradas en el temario actual
- **Cantidad de mercado:** $q^c$ en el canon (§ 4, como el 3.A.17), también en Coase (la ficha `coase` escribía $q'$): resuelto el 21/10/2026 (CC1 del 3.A.23).
- Resueltas en el 3.A.23 (21/10/2026): la externalidad en el consumo (EG) y en la producción (EP) sin enlazar (ahora mismo ejemplo de la acería en el anexo B y en EP); «CMg privado/social» → $\mathrm{CMgP}$, $\mathrm{CMgS}$, $\mathrm{CMgE}$ en redonda; $Q_{\max}$ → $\overline q$.
- 4.B.7 (sin revisar) usa el ejemplo de la acería y la piscifactoría: mantener $q$, $\overline p$, $\mathrm{CMgE}$ y decir que $\mathrm{DMg}\equiv\mathrm{CMgE}$.
