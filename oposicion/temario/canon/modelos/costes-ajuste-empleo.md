# Costes de ajuste del empleo y dinámica de la demanda de trabajo (Oi, 1962; Holt *et al.*, 1960; Nickell, 1986; Bentolila y Bertola, 1990; Hamermesh, 1993)

- **Área:** macro cerrada (mercado de trabajo) · **Tema de referencia:** **3.A.26** (revisado el 31/10/2026: bloque III `sec:costes-ajuste`, con III.2 `sec:ajuste-modelo` y el anexo D `anexo:ajuste-derivacion`) — «Costes de ajuste y dinámica de la demanda de trabajo» está en su título. Ficha creada en la fase canon del 3.A.26 (C6 de sus propuestas de coherencia; DK4/A26-04, DK7/A26-07 y A26-18, **[decidir]**).
- **Temas que lo usan:** 3.A.26 (desarrollo; hecho, 31/10/2026), 3.A.25 (mención; hecho, 31/10/2026: fila 7 de `tab:supuestos-trabajo`, «movilidad perfecta, sin costes de ajuste», y en II.3 la demanda intertemporal son los costes de ajuste, con remisión), 3.A.34 (mención; hecho, 31/10/2026: II.1, el mismo problema con el capital, Φ(I) y $(\phi/2)I^2$, q_t como «el λ_t del capital»; III.1, costes quebrados con las **mismas letras φ_c, φ_d**, banda `eq:banda-inaccion-q` $1-\phi_d\le q\le1+\phi_c$, que es la del empleo dividida por r, y `tab:costes-ajuste-inversion` con las mismas filas y columnas que `tab:costes-ajuste`; remisión recíproca hecha), 3.A.29 (mención: ya remite, «Bentolila y Bertola, 1990; Hamermesh, 1993»; hamiltoniano), 3.A.27 (mención; hecho, 31/10/2026: los costes de despido y de contratación $c_D$, $c_C$ de los *insiders* y la búsqueda con costes de ajuste en la introducción), 4.A.16 (resumen aplicado: costes de despido, dualidad, reforma de 2021, ERTE).
- **Manuales de referencia:** Oi (1962), *JPE*; Holt, Modigliani, Muth y Simon (1960), *Planning Production, Inventories, and Work Force*; Nickell (1986), *Handbook of Labor Economics*, cap. 9; Bentolila y Bertola (1990), «Firing Costs and Labour Demand», *Review of Economic Studies*; Bertola (1990), *EER*; Hamermesh (1989), *AER*, y (1993), *Labor Demand*; Hamermesh y Pfann (1996), *JEL*; Cooper, Haltiwanger y Willis (2015); Cahuc, Carcillo y Zylberberg (2014), cap. 2.

## Presentación de referencia (3.A.26, III)

Pregunta: ¿cómo ajusta una empresa su plantilla si contratar y despedir cuesta? Conclusión: la demanda de trabajo deja de ser estática y pasa a ser una decisión de inversión; según la forma de los costes, la empresa ajusta a saltos (fijos), no ajusta dentro de una banda (lineales) o ajusta poco a poco (cuadráticos). Los costes de ajuste estabilizan el empleo; su efecto sobre el empleo medio es ambiguo.

- **a) Idea** (III.1): punto de partida, la demanda de trabajo a corto plazo del 3.A.25, $F_L=w$ (`eq:demanda-corto`, ficha `demanda-trabajo`); el trabajo como **factor cuasifijo** (Oi, 1962); tipos de costes: internos/externos, brutos/netos, de contratación/de despido; es la q de Tobin con trabajadores (3.A.34). Levanta el supuesto 7 de `tab:supuestos-trabajo`.
- **b) Modelo** (III.2). i) Supuestos: empresa precio-aceptante (precio del bien = 1, $w_t$ salario **real**), un solo factor, $F(L_t)$ creciente y cóncava; problema (`eq:problema-ajuste`, con `\optim`):
$$\max_{\{L_t\}}\int_0^\infty e^{-rt}\big[F(L_t)-w_tL_t-\Phi(\dot L_t)\big]dt,\qquad L_0\ \text{dado},\quad \Phi(0)=0;$$
  formas: **fijo** $\Phi_0$ si $\dot L\neq0$; **lineal** $\phi_c\dot L$ si $\dot L>0$ y $-\phi_d\dot L$ si $\dot L<0$ (simétrico $\phi_c=\phi_d$, asimétrico $\phi_d>\phi_c$); **cuadrático** $\tfrac{\phi}{2}\dot L^2$. ii) Desarrollo, en el orden del original (sin costes, fijos, lineales con los asimétricos dentro, cuadráticos; A26-07):
  - sin costes: $F_L(L_t)=w_t$ cada periodo, salto a $L^*$;
  - fijos: **todo o nada**, sin CPO (no derivable en $\dot L=0$): ajusta si $\frac1r\{[F(L^*)-wL^*]-[F(L_0)-wL_0]\}>\Phi_0$ (`eq:ajuste-fijo`);
  - lineales: **banda de inacción** (`\funcionclave` `eq:banda-inaccion`; Bentolila y Bertola, 1990), con $\underline L$ y $\overline L$ sus bordes alrededor de $L^*$:
$$w-r\phi_d\ \le\ F_L(L)\ \le\ w+r\phi_c;$$
    fuera de la banda ajusta de inmediato **solo hasta el borde**; asimétricos: banda más ancha por el lado del despido, y el despido caro frena también la contratación; pegatina «Más vale malo conocido que bueno por conocer»;
  - cuadráticos: hamiltoniano en valor corriente con **$\lambda_t$, valor sombra de un trabajador más** («la q de Tobin del trabajo»), `\funcionclave` `eq:valor-sombra-empleo`:
$$\phi\,\dot L_t=\lambda_t,\qquad r\lambda_t=F_L(L_t)-w_t+\dot\lambda_t,$$
    y la **ecuación de Euler** en $L$ (`eq:euler-empleo`, una línea sin recuadro):
$$F_L(L_t)=w_t+r\phi\dot L_t-\phi\ddot L_t;$$
    ajuste **gradual**, más lento cuanto mayor φ; se anticipa a las perturbaciones anunciadas ($t_a$); pegatina «Vísteme despacio, que tengo prisa».
  iii) Implicaciones: sendas ante perturbaciones permanentes y transitorias (`sendas-ajuste.tex`, `tab:costes-ajuste`, 5 filas); las decisiones se encadenan; **atesoramiento de trabajo** y productividad procíclica (Oi, 1962); política: costes de despido (menos volatilidad, nivel medio ambiguo; Bentolila y Bertola, 1990; Bertola, 1990), de contratación, dualidad.
- **c) Evidencia** (III.3): la forma cuadrática simétrica la rechazan los datos de empresa (Hamermesh y Pfann, 1996): ajustes a saltos, componente fijo (Hamermesh, 1989), costes asimétricos y no convexos (Cooper, Haltiwanger y Willis, 2015); creación y destrucción brutas (Davis y Haltiwanger, 1992); España: Bentolila *et al.* (2012), en torno al 45 % del aumento del paro evitable con la protección del empleo de Francia; temporalidad del 25,6 % (4T 2021) al 15,4 % (3T 2026) tras el RDL 32/2021.
- **d) Extensiones** (III.4): horas frente a trabajadores (ERTE); grupos con costes distintos (Bentolila, Dolado y Jimeno, 2012); incertidumbre (con cuadráticos, toda la senda esperada; con lineales, valor de opción de esperar, como la inversión irreversible del 3.A.34).
- **e) Valoración** (III.5): explican la persistencia del empleo y la productividad procíclica, no el paro de equilibrio (hace falta la búsqueda); la forma de los costes es empírica; puente a la histéresis (3.A.28).
- **Anexo D**: hamiltoniano con control $x_t\equiv\dot L_t$ y transversalidad; linealización con la raíz estable **sin letra** (A26-17: κ y ν ya tienen dueño); diagrama de fases en $(L,\lambda)$ con los loci $\dot L=0$ ($\lambda=0$) y $\dot\lambda=0$ ($\lambda=[F_L(L)-w]/r$) y la perturbación anunciada; banda por 2 vías (valor del trabajador marginal y hamiltoniano con $\lambda_t\in[-\phi_d,\phi_c]$); incertidumbre de palabra (las ecuaciones de 2 estados de Cahuc *et al.*, pp. 132-134, no se publican sin comprobar, A26-14); costes fijos.

**Gráficos de referencia** (`oposicion/temario/fuentes/3A26/graficos/`): `sendas-ajuste.tex` (**imprescindible**: $L_t$ ante una perturbación permanente y una transitoria, por capas: sin costes y fijos → lineales → cuadráticos), `banda-inaccion.tex` (construido sobre `fuentes/3A25/graficos/demanda-corto.tex`, la recta del $\mathrm{VPMg}_L$ con las 2 horizontales $w+r\phi_c$ y $w-r\phi_d$; en el vídeo puede reutilizar su código) y, en el anexo, `fases-empleo.tex` (no se canta; es el mismo diagrama que el de la q de Tobin del 3.A.34).

**Notación:** $\Phi(\dot L)$ con $\Phi(0)=0$ (amplía D130: la Φ de la q de Tobin), $\Phi_0$ fijo, $\phi_c$, $\phi_d$ lineales, φ cuadrático (no choca con la inversa de Frisch, que no sale en el tema), $\lambda_t$ valor sombra (§ 7), $F_L$ (no $F'$; A26-15), $w$ real, $r$, $L^*$, $\underline L$, $\overline L$ (bordes de la banda, locales), $t_a$ anuncio. Nunca $c$ para el coste de ajuste ($c$ es el coste de la vacante en el DMP) ni $F$ para el coste fijo ($F(L)$ es la producción).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.26 | Dinámica de la demanda de trabajo | desarrollo (hecho, 31/10/2026) | Todo lo anterior, 8′ en el cante | — |
| 3.A.25 | Mercado de trabajo neoclásico | mención (hecho, 31/10/2026) | Supuesto 7 de `tab:supuestos-trabajo` y la demanda intertemporal en una frase con `\vertema{3.A.26}` | El modelo |
| 3.A.34 | Teorías de la inversión | mención (hecho, 31/10/2026) | El mismo problema con el capital: Φ (no $C(I)$), λ_t/q_t, costes asimétricos e irreversibilidad = banda de inacción; remisión recíproca y la misma tabla de tipos de costes | La banda del empleo |
| 3.A.29 | Modelización dinámica | mención | Ejemplo de hamiltoniano (ya remite); con $w$ real como el 3.A.25 (no $P_t$, $W_t$ nominales) | El modelo |
| 3.A.27 | Determinación de salarios | mención (hecho, 31/10/2026) | Costes de rotación $c_D$, $c_C$ como raíz del poder de los *insiders* | La dinámica |
| 4.A.16 | Mercado de trabajo en España | resumen aplicado | Costes de despido y dualidad (Bentolila *et al.*, 2012), reforma de 2021 y temporalidad, ERTE como margen de horas; `\vertema{3.A.26}` solo para ampliar | La derivación |

## Divergencias encontradas en el temario actual
- 3.A.26 original: $P_tF(L_t)-W_tL_t-c(\dot L_t)$ con $F$ también para el coste fijo; CPO «igual que sin costes» con costes fijos; caso lineal «ajusta de manera inmediata hasta que la productividad marginal iguale al coste marginal»; cuadrático con valores absolutos e implicaciones copiadas del lineal; asimétricos solo con el título. **Resuelto** en la revisión (31/10/2026).
- 3.A.34: coste de ajuste $C(I)$ y 3.4 «costes de ajuste asimétricos» sin modelo. **Resuelto** (31/10/2026): Φ, φ_c, φ_d, banda en q, misma tabla y remisión recíproca (ficha `q-tobin`, sección de los costes no convexos).
- 3.A.29 (sin revisar): $P_t$ y $W_t$ nominales: $w$ real al revisarlo.

Autor: Víctor Gutiérrez Marcos
