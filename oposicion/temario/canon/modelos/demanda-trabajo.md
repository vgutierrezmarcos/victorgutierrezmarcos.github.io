# Demanda de trabajo neoclásica (demanda derivada; Hicks, 1932): valor del producto marginal, corto y largo plazo

- **Área:** macro cerrada (mercado de trabajo) · **Tema de referencia:** **3.A.25** (teoría neoclásica del mercado de trabajo; revisado el 31/10/2026, I.2 `sec:demanda` y anexo `anexo:demanda-largo-plazo`) — la desarrolla con la función clave del corto plazo, la evidencia y, en el anexo B, el largo plazo, las cuasidemandas y las reglas de Marshall-Hicks. La teoría general de la demanda de factores (Hotelling, dualidad) es del 3.A.12 (ficha `dualidad-produccion`), que remite aquí para la de trabajo. Ficha creada en la fase canon del 3.A.25 (propuestas de coherencia § 7.8; **[decidir]**).
- **Temas que lo usan:** 3.A.25 (desarrollo; hecho, 31/10/2026), 3.A.12 (mención; hecho, 14/10/2026: «estas demandas [no condicionadas, sin factores Giffen] son la base de la demanda derivada de trabajo»), 3.A.17 (mención; hecho, 17/10/2026: el $\mathrm{VPMg}_L$ como curva de demanda en competencia frente al monopsonio), 3.A.26 (desarrollo de la variante dinámica: costes de ajuste; parte de la demanda estática), 3.A.27 (mención: la demanda como curva del «derecho a gestionar» del sindicato), 3.A.28 (mención: la curva de fijación de precios PS), 4.A.16 (resumen aplicado: salario mínimo, elasticidad de la demanda en España).
- **Manuales de referencia:** Hicks (1932), *The Theory of Wages*; Marshall (1890), libro V, cap. VI; Hamermesh (1993), *Labor Demand*; Cahuc, Carcillo y Zylberberg (2014), cap. 3; Borjas (2020), cap. 3; Mas-Colell, Whinston y Green (1995), cap. 5.

## Presentación de referencia (3.A.25, I.2)

Pregunta: ¿cuántos trabajadores contrata una empresa y cómo responde al salario? Conclusión: contrata hasta que el valor del producto marginal iguala el salario; la demanda es decreciente (no hay factores Giffen), más elástica a largo plazo y menos la de mercado.

- **a) Idea**: **demanda derivada** (Hicks, 1932): se quiere trabajo para producir. Es la demanda no condicionada $z_L(p,\vec w)$ del 3.A.12 (lema de Hotelling), escrita $L^D(w)$.
- **b) Modelo**. i) Supuestos: empresa precio-aceptante en el bien ($p$) y en los factores ($w_L$ salario nominal, $w_K$ coste de uso del capital), que maximiza su beneficio $B$; $q=F(L,K)$ con productividades marginales positivas y decrecientes; corto plazo con $\overline{K}$. ii) Desarrollo: $\max_L B(L)=p\,F(L,\overline{K})-w_L L-w_K\overline{K}$, sin restricciones (condición de primer orden simple, no Kuhn-Tucker); `\funcionclave` (`eq:demanda-corto`):
$$\mathrm{VPMg}_L\equiv p\cdot F_L(L,\overline{K})=w_L\ \Longleftrightarrow\ F_L(L,\overline{K})=\frac{w_L}{p}\equiv w$$
CSO $p\,F_{LL}<0$ (productividad marginal decreciente; **ninguna condición sobre los rendimientos a escala** a corto plazo). Gráfico: $L^D(w)$ es el tramo decreciente del $\mathrm{VPMg}_L$ (en términos reales, de la $\mathrm{PMg}_L$). iii) Implicaciones: decrece con el salario real y se desplaza con la productividad (capital, tecnología) y el precio del bien; **nunca crece con el salario** (sin efecto renta, no hay factores Giffen; 3.A.12); a largo plazo es **más elástica** (principio de Le Chatelier, Samuelson); la de mercado es **menos** elástica que la suma de las individuales (cuasidemandas: al contratar todas, baja el precio del bien).
- **Anexo (largo plazo)**: $\max_{L,K} pF(L,K)-w_LL-w_KK$, CPO $pF_L=w_L$, $pF_K=w_K$, $\mathrm{RMST}_{LK}=w_L/w_K$; CSO: $F$ **estrictamente cóncava** (con $F(\vec 0)=0$ implica rendimientos decrecientes; la cuasiconcavidad basta solo en la minimización del coste, 3.A.12); en 2 etapas (coste mínimo y escala) con efecto sustitución y efecto escala; demanda de mercado como suma de cuasidemandas (de $A$ a $C$, no a $B$); **reglas de Marshall-Hicks** y fórmula de Hicks-Allen con 2 factores y rendimientos constantes: $\varepsilon_{L^D,w_L}=-(1-s_L)\sigma-s_L|\varepsilon_{q,p}|$ ($s_L$ participación del trabajo en los costes; un aumento de $s_L$ la hace más elástica si y solo si $|\varepsilon_{q,p}|>\sigma$: «la importancia de no ser importante» matizada por Hicks).
- **c) Evidencia**: Hamermesh (1993), elasticidad con la producción constante entre 0,15 y 0,75 en valor absoluto, central 0,3, mayor para los poco cualificados; inmigración como desplazamiento de la oferta: Card (1990), éxodo del Mariel (≈ 125.000 cubanos, +7 % de la población activa de Miami) sin efectos apreciables, frente a Borjas (2017).
- Con poder de mercado no hay curva de demanda (monopsonio; ficha `monopsonio`) y con monopolio en el bien la regla es $\mathrm{IPMg}_L=w_L$ (anexo D del 3.A.25; 3.A.17).

**Gráficos de referencia** (`oposicion/temario/fuentes/3A25/graficos/`): `demanda-corto.tex` (**imprescindible**; es la primera capa de `equilibrio-trabajo.tex`, que añade la oferta, $(w^c,L^c)$ y el salario mínimo con el paro involuntario); en el anexo, `minimizacion-coste.tex`, `demanda-lp-cp.tex` (la de largo plazo, más plana) y `demanda-agregada.tex` (cuasidemandas).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.25 | Mercado de trabajo neoclásico | desarrollo (hecho, 31/10/2026) | Corto plazo con su función clave y evidencia en el cuerpo; largo plazo, mercado y Marshall-Hicks en el anexo B | — |
| 3.A.12 | Demanda de factores | mención (hecho) | La demanda no condicionada por Hotelling es la base de la demanda derivada de trabajo; sin factores Giffen | La demanda de trabajo concreta |
| 3.A.17 | Monopsonio | mención (hecho) | En competencia, la demanda es el $\mathrm{VPMg}_L$; con monopsonio no hay curva de demanda | — |
| 3.A.26 | Costes de ajuste y dinámica de la demanda | desarrollo de la variante dinámica | Parte de `eq:demanda-corto` y añade costes de ajuste (suavización del empleo); $L^D(w)$, $\mathrm{VPMg}_L$ con la misma notación | La demanda estática y el largo plazo |
| 3.A.27 | Negociación salarial | mención | La demanda $w^D(L)=\mathrm{VPMg}_L$ como curva del derecho a gestionar y del sindicato monopolista | La derivación |
| 3.A.28 | Tasa natural, WS-PS | mención | La curva PS como demanda de trabajo con competencia imperfecta en el bien | — |
| 4.A.16 | Mercado de trabajo en España | resumen (aplicado) | Elasticidad de la demanda y salario mínimo (con monopsonio, ficha `monopsonio`), sin depender del 3.º | La derivación |

## Divergencias encontradas en el temario actual
- 3.A.25 original: «Kuhn-Tucker» en un problema sin restricciones de desigualdad; CSO «estrictamente cóncava (rendimientos decrecientes a escala)» a corto plazo y «estrictamente cuasicóncava (rendimientos decrecientes)» a largo; $P$, $Y$, $W$, $R$, $\Pi$, $L^D=L(W/P,F'(L))$; las imágenes 7, 9 y 10 con «Fuente: Sahuquillo». **Resuelto** en la revisión (31/10/2026): $p$, $q$, $w_L$, $w_K$, $B$, $w\equiv w_L/p$ (D-P64, **[decidir]**).
- 3.A.26 (sin revisar): la caja de dinámica de la demanda es suya (el 3.A.25 la reduce a una frase con remisión); al revisarlo, partir de `eq:demanda-corto` con esta notación.

Autor: Víctor Gutiérrez Marcos
