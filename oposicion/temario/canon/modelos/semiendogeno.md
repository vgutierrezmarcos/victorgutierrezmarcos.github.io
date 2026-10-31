# Crecimiento semiendógeno: efecto escala y rendimientos decrecientes de las ideas (Jones 1995)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.44** (crecimiento endógeno: rendimientos crecientes) — es el apartado III nuevo, «Rendimientos crecientes y efecto escala: el crecimiento semiendógeno» (`sec:semiendogeno`, 6′ en el cante: III.1 idea, III.2 modelo de Jones, `sec:jones`, III.3 evidencia y política) y el anexo E paso a paso (`anexo:jones`); revisado el 1/11/2026. Es la **segunda función clave** del tema. Ficha creada en la fase canon del 3.A.44 (CC4; **[decidir]**). Alias: `jones-1995`, `crecimiento-semiendogeno`, `efecto-escala`.
- **Temas que lo usan:** 3.A.44 (desarrollo; hecho, 1/11/2026), 3.A.45 (mención: las ideas cada vez más caras, Bloom et al., 2020, que su Word cita, con `\vertema{3.A.44}`; la convergencia condicional encaja con los semiendógenos), 3.A.43 (mención; hecho, 31/10/2026: Jones, 2023, en la idea final, «parte de ese impulso no puede durar siempre»), 4.A.7 (previsto: política de I+D con efectos de nivel), 4.A.2 (previsto: población e investigadores)
- **Manuales de referencia:** Jones (1995), *JPE* («R&D-Based Models of Economic Growth»); Jones (1995), *QJE*; Jones (2005), *Handbook of Economic Growth*; Jones (2022, 2023); Kremer (1993), *QJE*; Bloom, Jones, Van Reenen y Webb (2020), *AER*; Acemoglu (2009), cap. 13; Romer (2019), cap. 3.

## Presentación de referencia (3.A.44, III y anexo E)

**III.1 Idea: no rivalidad y efecto escala.** Una idea la pueden usar todos a la vez: con rendimientos constantes en los factores rivales, hay rendimientos crecientes en factores e ideas juntos (Romer, 1990; Jones, 2005). La renta por habitante depende de las ideas **totales**: más personas, más investigadores, más ideas. En Romer, Aghion-Howitt y las externalidades con E = K, el tamaño de la población sube la **tasa** de crecimiento (efecto escala). **A muy largo plazo los datos lo apoyan** (Kremer, 1993: el crecimiento de la población mundial aumentó con su tamaño hasta la transición demográfica; las regiones aisladas al final de la glaciación); **en la posguerra, no**: en EE. UU., los investigadores se han duplicado desde 1991 y el gasto real en I+D se ha multiplicado casi por 5 desde 1981, sin aceleración de la PTF (≈ 2 % en los 50-60; 0,9 % de media desde 1970; Fernald, FRBSF, y OCDE, MSTI; gráfico `efecto-escala`).

**III.2 a) Idea.** Si el esfuerzo crece y el crecimiento no, la producción de ideas no puede ser lineal en las ideas existentes: las fáciles se encuentran primero.

**b) i) Supuestos.** Los de Romer (ficha `romer-1990`, con $N_t$, $L_I$, $\eta_I$) salvo la producción de ideas:
$$\dot N_t=\eta_I\,L_{I,t}^{\lambda}\,N_t^{\phi},\qquad 0<\lambda\leq1,\ \phi<1\qquad(\texttt{eq:jones-ideas})$$
**λ y φ locales**, las letras del artículo (A44-06; avisado en nota: λ sin subíndice no es el coestado $\lambda_{K,t}$, $\lambda_{H,t}$ ni la tasa de llegada $\lambda_I$, ni aquí la velocidad de convergencia del 3.A.43; φ no es la inversa de Frisch, que no sale en el tema). λ < 1: duplicación de esfuerzos; φ > 0: las ideas pasadas ayudan («a hombros de gigantes»); φ < 0: las fáciles ya se han encontrado; **Romer es el caso límite λ = φ = 1**. La población y los investigadores crecen a **n**, con una fracción constante $s_I$ (local) en la I+D.

**b) ii) Desarrollo.** $\gamma_N=\eta_IL_I^{\lambda}N^{\phi-1}$ constante exige $\lambda\gamma_{L_I}=(1-\phi)\gamma_N$; con $\gamma_{L_I}=n$:
$$\gamma_N=\frac{\lambda\,n}{1-\phi}\qquad(\texttt{eq:jones},\ \text{función clave})$$
y la renta por habitante crece igual (con λ = 1, $\gamma_N=n/(1-\phi)$). Gráfico: $\gamma_N$ decreciente en $N$ si φ < 1; converge a $\lambda n/(1-\phi)$ (anexo E: $\dot\gamma_N/\gamma_N=\lambda n-(1-\phi)\gamma_N$, estable); más investigadores desplazan la curva: el crecimiento sube un tiempo y vuelve a la misma tasa con más ideas. En Romer, $\gamma_N=\eta_IL_I$ es una horizontal que sube para siempre. Nivel en la senda (anexo E): $N_t=\left[(1-\phi)\eta_I/(\lambda n)\right]^{1/(1-\phi)}L_{I,t}^{\lambda/(1-\phi)}$, proporcional a $(s_IL)^{\lambda/(1-\phi)}$: **el efecto escala pasa al nivel**.

**b) iii) Implicaciones.** El crecimiento a largo plazo depende del crecimiento de la población (por eso «semiendógeno»: lo determina un parámetro exógeno, $n$); la política (subvenciones a la I+D, $s_I$) tiene **efectos de nivel**, no de tasa, pero duran décadas; hay transición y convergencia condicional; el equilibrio no es óptimo (`tab:resumen-modelos`).

**c) Extensiones.** Young (1998) y Peretto (1998): modelos «totalmente endógenos» sin efecto escala (al crecer la economía, la I+D se reparte entre más variedades y cada una avanza al mismo ritmo; la política vuelve a cambiar la tasa); Jones (2022): una población que deje de crecer o decrezca frenaría las ideas; la IA como más «buscadores» de ideas.

**III.3 Evidencia y política.** Bloom et al. (2020): el esfuerzo investigador se ha multiplicado por 23 desde los 30 y su productividad se ha dividido por 41 (≈ −5 % anual); para mantener la ley de Moore hacen falta más de 18 veces más investigadores. Política: el rendimiento social de la I+D supera al privado (Jones y Williams, 1998): subvenciones, incentivos fiscales (Bloom, Van Reenen y Williams, 2019), investigación básica; patentes (Nordhaus, 1969; `\vertema{3.A.15}`); educación (`\vertema{3.A.25}`); competencia (`\vertema{4.A.15}`); apertura (`\vertema{3.B.9}`); gasto e impuestos (`\vertema{3.A.38}`); instituciones (Mokyr; `\vertema{3.A.45}`). España: I+D en el 1,50 % del PIB (2024; UE 2,26 %) y objetivo de financiación pública del 1,25 % en 2030 (Ley 17/2022; `\vertema{4.A.7}`).

**Gráficos de referencia:** `oposicion/temario/fuentes/3A44/graficos/jones.tex` (γ_N frente a N: Romer horizontal, Jones decreciente y su desplazamiento al crecer $L_I$; por capas en el cante); `efecto-escala.tex` (investigadores y gasto en I+D de EE. UU. frente al crecimiento de la PTF, 1950-2025, gráfico de datos); `gasto-id-pib.tex` (I+D en % del PIB, España, UE, EE. UU., Corea y China). Fila de Jones (salmón) en `tab:resumen-modelos`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.44 | Rendimientos crecientes y efecto escala | desarrollo (hecho, 1/11/2026) | Lo de arriba; `eq:jones` recuadrada como 2.ª función clave | — |
| 3.A.45 | Evidencia del crecimiento y convergencia | mención | Ideas cada vez más caras (Bloom et al., 2020) en una línea; la convergencia condicional encaja con los semiendógenos; el residuo de Solow cae pese al esfuerzo en I+D | El modelo `\vertema{3.A.44}` |
| 3.A.43 | Crecimiento exógeno | mención (hecho, 31/10/2026) | Jones (2023): el crecimiento del 2 % de EE. UU. no puede durar siempre | El modelo |
| 4.A.7 | Política de ciencia y tecnología | previsto | No rivalidad, efecto de nivel de las subvenciones a la I+D, objetivo del 1,25 % (Ley 17/2022) | El modelo |
| 4.A.2 | Población y mercado de trabajo | previsto | Población e investigadores como motor de las ideas (Jones, 2022) | El modelo |

## Divergencias encontradas en el temario actual
- 3.A.44 (Word): «a la versión de Romer se le denomina semiendógena» (el semiendógeno es **Jones, 1995**), ϕ como coste de la invención en Romer (ϕ queda para Jones), captura de Jones (2023) con enlace t.co, y sin apartado propio para los rendimientos crecientes del título. **Resuelto** (1/11/2026): III nuevo (DK1).
- La propuesta de coherencia escribía $\dot N=\eta_IL_NN^{\phi}$ y $\gamma_N=n/(1-\phi)$: el tema usa **$L_I$** (DK12) y el exponente λ del artículo, con $\gamma_N=\lambda n/(1-\phi)$; con λ = 1 coincide.

Autor: Víctor Gutiérrez Marcos
