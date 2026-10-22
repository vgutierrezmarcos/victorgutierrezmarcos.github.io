# Equilibrio de Lindahl: precios personalizados del bien público (Wicksell, 1896; Lindahl, 1919)

- **Área:** equilibrio general y bienestar · **Tema de referencia:** **3.A.23** (Bienestar II: bienes públicos; revisado el 21/10/2026, II.2.3 `sec:provision-publica`, «Según el beneficio: los precios de Lindahl», con a)-c)). Motivo: es una de las 3 respuestas a cómo financiar el bien público (capacidad de pago, beneficio, mecanismo), justo después de la condición de Samuelson.
- **Temas que lo usan:** 3.A.23 (desarrollo; hecho, 21/10/2026), 4.B.7 (resumen: el principio del beneficio como principio impositivo y su límite, la revelación), 3.A.24 (mención; hecho, 22/10/2026: la unanimidad de Wicksell en III.2.4, con `\vertema{3.A.23}`), 4.B.2 (mención: provisión de bienes públicos por decisión colectiva).
- **Manuales de referencia:** Wicksell (1896), *Finanztheoretische Untersuchungen*; Lindahl (1919), *Die Gerechtigkeit der Besteuerung*; Samuelson (1954), *REStat*; Mas-Colell, Whinston y Green, cap. 11.C (ejercicio) y 16.G; Atkinson y Stiglitz, *Lectures on Public Economics*, lección 16; Johansen (1963).

## Presentación de referencia

**Pregunta:** ¿se puede financiar el bien público de modo que cada uno pague según lo que lo valora y se alcance el óptimo de Samuelson?

**Supuestos:** los del modelo de Samuelson (ficha `samuelson-bienes-publicos`): 2 consumidores $A$, $B$, bien privado $X$, bien público puro $G$, FPP $T(X,G)=0$; en la versión de equilibrio parcial (Bowen), utilidad cuasilineal y $\mathrm{RMS}^i_{GX}(G)$ como disposición marginal a pagar.

**Ecuaciones (notación canónica):** precio personalizado $p^i_G$ por unidad de $G$. Un **equilibrio de Lindahl** es un nivel $G^*$ y unos precios $p^A_G$, $p^B_G$ tales que
$$\mathrm{RMS}^i_{GX}(G^*)=p^i_G\quad(i=A,B),\qquad p^A_G+p^B_G=\mathrm{RMT}_{GX}\ (=\mathrm{CMg}_G).$$
Sumando, $\mathrm{RMS}^A_{GX}+\mathrm{RMS}^B_{GX}=\mathrm{RMT}_{GX}$: cumple la condición de Samuelson y es óptimo de Pareto.

**Valoración:** eficiente y justo según el principio del beneficio (nadie paga por lo que no valora); pero el precio depende de lo que cada uno declara (vuelve el polizón) y cada consumidor es el único demandante de «su» mercado, así que no tiene sentido que acepte el precio como dado (Samuelson, 1954). No resuelve la revelación de preferencias: por eso hacen falta los mecanismos (ficha `clarke-groves`).

**Gráfico de referencia:** el de Bowen (suma vertical de las disposiciones marginales a pagar): $\mathrm{RMS}^A_{GX}(G)$, $\mathrm{RMS}^B_{GX}(G)$ y su suma vertical cortando a $\mathrm{CMg}_G$ en $G^*$; los precios de Lindahl, $p^A_G$ y $p^B_G$, son la altura de cada curva en $G^*$, con un hilo que une $p^A_G+p^B_G=\mathrm{CMg}_G$ con $G^*$ (en la misma figura, sin redibujar). Ruta: `oposicion/temario/fuentes/3A23/graficos/bowen.tex`.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.23 | Provisión pública de bienes públicos | desarrollo (hecho, 21/10/2026) | Wicksell y Lindahl; definición del equilibrio con $p^i_G$; cumple Samuelson; ventaja (beneficio) y problemas (revelación, precio-aceptación); sobre el gráfico de Bowen | — |
| 4.B.7 | Principios impositivos | resumen | El principio del beneficio llevado al límite: precios personalizados que suman el coste marginal; por qué no se aplica (revelación, polizón); `\vertema{3.A.23}` | La derivación |
| 3.A.24 | Elección colectiva | mención (hecho, 22/10/2026) | Unanimidad de Wicksell (protege a cada uno pero da poder de veto) y Lindahl como solución «de mercado» frente a la votación; `\vertema{3.A.23}` | El equilibrio |
| 4.B.2 | Elección pública | mención | Decisión colectiva sobre el bien público; Bowen y Lindahl solo nombrados con remisión | El gráfico |

## Divergencias encontradas en el temario actual
- Original del 3.A.23: precios $\widetilde{p_G^i}$ (la tilde es ahora lo **declarado**, `notacion.md` § 5): canon $p^i_G$, $p^A_G$, $p^B_G$ (resuelto en la revisión, 21/10/2026).
- `mapa.yaml` listaba `lindahl` en el 3.A.23 sin ficha (corregido el 21/10/2026).
