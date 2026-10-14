# Sistemas completos de demanda (Cobb-Douglas, LES, Rotterdam, translog, AIDS, QUAIDS)

- **Área:** consumidor-producción · **Tema de referencia:** **3.A.9** (Demanda II: «Sistemas de demanda utilizados en estudios empíricos»; revisado el 13/10/2026, bloque II) — lo tiene en el título y lo desarrolla. Ficha creada a raíz de esa revisión.
- **Temas que lo usan:** 3.A.9 (desarrollo; hecho), 3.A.8 (resumen: anexo `anexo:sistemas` con las mismas ecuaciones, y la agregación PIGLOG en I.3; hecho), 3.A.12 (resumen: la translog de costes con sus ecuaciones de participación es el IV.1; hecho), 4.B.11 (mención: elasticidades compensadas cruzadas para la imposición indirecta óptima y la reforma del IVA).
- **Manuales de referencia:** Deaton y Muellbauer (1980a, *AER*; 1980b, *Economics and Consumer Behavior*); Deaton (1997); Stone (1954); Klein y Rubin (1947); Geary (1950); Barten (1964, 1967, 1969); Theil (1965); Christensen, Jorgenson y Lau (1975); Banks, Blundell y Lewbel (1997); Strotz (1957), Gorman (1959); Aguilar y Mateos (2015, BICE 3070).

## Presentación de referencia
Pregunta: ¿cómo se estima la demanda de todos los bienes a la vez de forma coherente con la teoría?

- **Fines**: medir elasticidades; contrastar la teoría (integrabilidad, ficha `integrabilidad`); valorar el bienestar (ficha `vc-ve`). **Requisitos**: coherencia con la teoría, flexibilidad, agregación, sencillez de estimación. La dualidad lo hace practicable: se especifica $E$ o $V$ y se deriva por Shephard o Roy.
- **Cinco pasos**: forma funcional, sistema completo ($\sum_is_i=1$; separabilidad débil y presupuestación en dos etapas), datos (EPF anual desde 2006, unos 24.000 hogares, panel de dos años; antes la ECPF, 1985-2005), especificación (covarianzas singulares, se quita una ecuación; gasto endógeno; censura; variables demográficas) y resultados (elasticidades y contrastes).
- **Formas** (notación canónica, letras locales en `notacion.md` § 2):
  - Cobb-Douglas: $U(x)=\sum_i\alpha_i\ln x_i$, $\sum\alpha_i=1$; $s_i=\alpha_i$, $\ln x_i=\ln\alpha_i+\ln\overline W-\ln p_i$ (ficha `cobb-douglas`).
  - LES (Stone-Geary): $U(x)=\sum_i\alpha_i\ln(x_i-\gamma_i)$; $p_ix_i=p_i\gamma_i+\alpha_i\big(\overline W-\sum_jp_j\gamma_j\big)$; aditiva: sin inferiores ni complementarios **netos** (con $\gamma_j>0$ puede haber complementariedad bruta).
  - Rotterdam (Barten, 1964; Theil, 1965): $\bar s_i\,d\ln x_i=b_i\,d\ln Q+\sum_jc_{ij}\,d\ln p_j$, $b_i=p_i\partial x_i/\partial\overline W$, $c_{ij}=p_ip_jS_{ij}/\overline W$; restricciones lineales ($\sum b_i=1$, $\sum_ic_{ij}=\sum_jc_{ij}=0$, $c_{ij}=c_{ji}$); aproximación local sin función de gasto.
  - Translog indirecta (Christensen, Jorgenson y Lau, 1975): $\ln V=\alpha_0+\sum_i\alpha_i\ln\frac{p_i}{\overline W}+\frac12\sum_i\sum_j\beta_{ij}\ln\frac{p_i}{\overline W}\ln\frac{p_j}{\overline W}$; participaciones por Roy; estimación no lineal.
  - **AIDS** (Deaton y Muellbauer, 1980): $\ln E=(1-\overline U)\ln a(p)+\overline U\ln b(p)$ (PIGLOG), con $a(p)$ translog y $\ln b(p)=\ln a(p)+\beta_0\prod_kp_k^{\beta_k}$;
$$s_i=\alpha_i+\sum_j\gamma_{ij}\ln p_j+\beta_i\ln\frac{\overline W}{P},\qquad \ln P=\ln a(p);$$
restricciones lineales (agregación $\sum\alpha_i=1$, $\sum_i\gamma_{ij}=\sum_i\beta_i=0$; homogeneidad $\sum_j\gamma_{ij}=0$; simetría $\gamma_{ij}=\gamma_{ji}$); curvas de Engel de Working-Leser ($\beta_i>0$ lujo, $<0$ necesario); $\varepsilon_{x_i,\overline W}=1+\beta_i/s_i$; agregación exacta; LA-AIDS con el índice de Stone $\ln P^*=\sum_ks_k\ln p_k$.
  - QUAIDS (Banks, Blundell y Lewbel, 1997): añade $\frac{\vartheta_i}{b(p)}\big[\ln\frac{\overline W}{a(p)}\big]^2$, $b(p)=\prod_kp_k^{\beta_k}$, $\sum\vartheta_i=0$ (Engel cuadráticas).
- **Resultados**: con datos agregados se rechazó a menudo la homogeneidad (Barten; Deaton, 1974; Deaton y Muellbauer, 1980); Deaton lo atribuye a la rigidez, la dinámica y sobre todo la agregación; con microdatos y formas flexibles, mejor; contrastes no paramétricos (Blundell, Browning y Crawford, 2003). Nobel de Deaton (2015) «por su análisis del consumo, la pobreza y el bienestar». Ejemplo español: AIDS con la EPF para el IVA (Sanz-Sanz y Romero-Jordán, 2012).
- **Usos**: imposición indirecta óptima y reforma del IVA [4.B.11, para ampliar], incidencia distributiva, índices de coste de la vida por hogares, escalas de equivalencia y pobreza.

Tabla de referencia: `tab:sistemas` de 3.A.9 (punto de partida, flexibilidad, agregación, linealidad y límite de cada sistema). Sin gráfico.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.9 | Sistemas de demanda en estudios empíricos | desarrollo (hecho, 13/10/2026) | Todo lo anterior (5 minutos en el cante) | Las demandas de la Cobb-Douglas (3.A.8) y su historia (3.A.11) |
| 3.A.8 | Demanda marshalliana | resumen (hecho) | Anexo `anexo:sistemas` (no se canta) con las mismas ecuaciones; agregación PIGLOG y consumidor representativo (I.3) | El desarrollo (remitir a 3.A.9) |
| 3.A.12 | Aplicaciones empíricas de costes | resumen (hecho, 14/10/2026) | La misma translog aplicada a $C(\vec w,q)$ (Christensen, Jorgenson y Lau, 1973; Christensen y Greene, 1976): $\ln C=\alpha_0+\alpha_q\ln q+\tfrac12\beta_{qq}(\ln q)^2+\sum_i\alpha_i\ln w_i+\tfrac12\sum_i\sum_j\beta_{ij}\ln w_i\ln w_j+\sum_i\beta_{iq}\ln w_i\ln q$; participaciones por Shephard $s_i=\alpha_i+\sum_j\beta_{ij}\ln w_j+\beta_{iq}\ln q$; restricciones de homogeneidad y simetría; Allen-Uzawa; casos anidados; Leontief generalizada (Diewert, 1971); Berndt y Wood (1975). Remite a 3.A.9 | Los sistemas del consumidor |
| 4.B.11 | Imposición óptima | mención | De dónde salen las elasticidades compensadas que piden Ramsey y la elasticidad inversa | La estimación |

## Divergencias encontradas en el temario actual
- 3.A.8 (revisado), anexo `anexo:sistemas`: escribe la utilidad en minúscula, $u(x)=\sum_i\alpha_i\ln x_i$ y $u(x)=\sum_i\alpha_i\ln(x_i-\gamma_i)$ (canon $U(x)$; $u$ es la de Bernoulli), y dice que el LES no admite «complementarios» (son los **netos**). Anotado en `pendientes-coherencia.md`.
- 3.A.9 original: Stone-Geary como «forma log-lineal», translog directa con «−ln u(x)» sin autores, Rotterdam como «versión generalizada del LES», ECPF como fuente vigente, nota 29 copiada del BICE. Resuelto en la revisión.
