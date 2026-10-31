# Función de ingresos de capital humano (ecuación de Mincer, 1958, 1974)

- **Área:** macro cerrada (mercado de trabajo) · **Tema de referencia:** **3.A.25** («Función de ingresos de capital humano y evidencia empírica» en el título; revisado el 31/10/2026, III.3 `sec:mincer` y anexo `anexo:ben-porath`) — la deriva (escolarización en el cuerpo, experiencia con Ben-Porath en el anexo E) y reúne la evidencia (MCO, variables instrumentales, gemelos, España). Ficha creada en la fase canon del 3.A.25 (propuestas de coherencia § 7.8; **[decidir]**).
- **Temas que lo usan:** 3.A.25 (desarrollo; hecho, 31/10/2026), 3.A.43 (mención: Hall y Jones, 1999, $h=e^{\phi(S)}$ con los rendimientos de Mincer; capital humano en MRW), 3.A.44 (mención: rendimiento privado frente a social), 4.A.2 (resumen aplicado: rendimientos de la educación en España), 4.A.16 (resumen aplicado: salarios por estudios y edad), 4.A.3 (mención: educación y desigualdad salarial).
- **Manuales de referencia:** Mincer (1958), *JPE*; Mincer (1974), *Schooling, Experience, and Earnings*; Ben-Porath (1967), *JPE*; Heckman, Lochner y Todd (2006), *Handbook of the Economics of Education*; Card (1999, 2001); Psacharopoulos y Patrinos (2018); Borjas (2020), cap. 6; Cahuc, Carcillo y Zylberberg (2014), cap. 4.

## Presentación de referencia (3.A.25, III.3)

Pregunta: ¿cuánto sube el salario con un año más de estudios y con la experiencia? Conclusión: alrededor de un 9 % por año de estudio, con un perfil cóncavo en la experiencia; el rendimiento es en buena parte causal.

- **a) Idea**: convierte la teoría de Becker en una ecuación estimable con salarios, años de estudio y experiencia; su coeficiente de la escolaridad es una de las cifras mejor medidas de la economía.
- **b) Modelo**. i) Supuestos (escolarización, Mincer 1958): estudiar solo cuesta el salario al que se renuncia; vida laboral igual para todos y muy larga; mismo $r$ para todos; solo difieren en $S$. Experiencia: se sigue invirtiendo en el trabajo, cada vez menos. ii) Desarrollo: igualación del valor presente para todo $S$, $w(S)e^{-rS}/r=w(0)/r$ ⟹ (`eq:mincer-escolarizacion`) $\ln w(S)=\ln w(0)+rS$; experiencia con Ben-Porath, $\dot h=a[1-u]h$ y fracción de formación lineal en la experiencia ⟹ término cuadrático. `\funcionclave` (`eq:mincer`):
$$\ln w_i=\beta_0+\beta_1S_i+\beta_2X_i+\beta_3X_i^2+\varepsilon_i,\qquad \beta_1\approx r,\ \beta_2>0,\ \beta_3<0$$
($w_i$ salario real, $S_i$ años de estudios, $X_i$ años de experiencia, $\varepsilon_i$ perturbación; locales con nota, β con subíndice = coeficientes, § 1). iii) Implicaciones: $\beta_1$ = rendimiento **privado** de un año de estudio; perfil cóncavo con máximo en $X=-\beta_2/(2\beta_3)$; en logaritmos, la diferencia en euros crece con la edad.
- **Anexo (Ben-Porath, 1967)**: $\max_{u(t)}\int_0^T e^{-rt}\omega u h\,dt$ s.a. $\dot h=a[1-u]h$, con ω salario por unidad de capital humano y de tiempo trabajado y $a>0$ la aptitud (locales); hamiltoniano lineal en $u$ ⟹ especialización (estudiar a tiempo completo hasta $S^*$ y después trabajar); `eq:ben-porath-s`: $S^*=T+\frac1r\ln(1-r/a)$, $a>r$; $\ln w(S)=\ln(\omega h_0)+aS$ con $\beta_1=a\approx r$; con $k(X)=k_0(1-X/T)$ (fracción de formación) y $E(X)=\omega h(X)$ (ingresos potenciales), $\ln w(X)\approx \ln(\omega h_0)-k_0+aS+k_0(a+1/T)X-\frac{ak_0}{2T}X^2$; con depreciación δ, $\beta_2=k_0(a+1/T)-\delta$ y el máximo se adelanta. Misma ecuación de acumulación que el sector educativo de Uzawa-Lucas (ficha `uzawa-lucas`).
- **c) Extensiones**: descomposición de Oaxaca-Blinder (ficha `oaxaca-blinder`); brecha de género actual, Goldin y la penalización por hijos (Kleven, Landais y Søgaard, 2019); habilidades no cognitivas (Heckman, Stixrud y Urzua, 2006).
- **d) Evidencia**: MCO, ≈ 9 % por año de media mundial y 8 % en renta alta (Psacharopoulos y Patrinos, 2018), superior ≈ 15 % (Montenegro y Patrinos, 2014); **sesgo de habilidad** (sobreestima) y error de medida (subestima; Griliches, 1977); experimentos naturales (Nobel 2021): trimestre de nacimiento (Angrist y Krueger, 1991: 7-10 %), distancia a la universidad (Card, 1995: un 25-60 % mayor que MCO), gemelos (Ashenfelter y Krueger, 1994: 12-16 %), LATE (Imbens y Angrist, 1994); VI ≥ MCO (Card, 1999, 2001); instrumentos débiles (Bound, Jaeger y Baker, 1995). España: EES 2022, a partir de 55 años los universitarios largos ganan un 86 % más que la 2.ª etapa de secundaria.
- **e) Valoración**: describe bien los salarios; el coeficiente solo es una tasa de rendimiento con supuestos fuertes (Heckman, Lochner y Todd, 2006: efecto título, no linealidad); rendimiento privado frente a social (3.A.43, 3.A.44); señal frente a productividad (Spence, 3.A.13).

**Gráficos de referencia** (`oposicion/temario/fuentes/3A25/graficos/`): `perfiles-edad.tex` (el mismo de `becker-capital-humano`), `ees-edad-estudios.tex` (datos de la EES 2022, pgfplots; actualizar con la EES 2026 cuando se publique, previsiblemente en 2028; A25-04) y `ben-porath.tex` (anexo: fracción de formación e ingresos potenciales y observados, con $S+T$ en el eje).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.25 | Función de ingresos y evidencia | desarrollo (hecho, 31/10/2026) | Todo lo anterior | — |
| 3.A.43 | Crecimiento exógeno con capital humano | mención | Hall y Jones (1999): $h=e^{\phi(S)}$ con $\phi'$ = rendimientos de Mincer por tramos; remitir al 3.A.25 para la ecuación | La derivación y la evidencia micro |
| 3.A.44 | Crecimiento endógeno con capital humano | mención | El rendimiento social puede superar al privado de Mincer (externalidades) | La ecuación |
| 4.A.2 | Capital humano en España | resumen (aplicado) | La ecuación en una línea, el rendimiento medio y el de España (EES), sin depender del 3.º | Ben-Porath y la identificación |
| 4.A.16 | Mercado de trabajo en España | resumen (aplicado) | Perfiles por edad y estudios con la EES; rendimiento de la educación | La derivación |
| 4.A.3 | Distribución de la renta en España | mención | Educación como determinante de la desigualdad salarial | — |

## Divergencias encontradas en el temario actual
- 3.A.25 original: ecuación sin derivar ($\ln W=\dots$); «5-8 %» y «1-20 %» sin fuente; Francia 14 % y EE. UU. 7,5 % sin fuente; $\dot h=\theta\sigma h$ (θ es la CRRA y σ la elasticidad de sustitución, § 1); Murillo et al. «2016» y «20,1/12,4/7,7 %». **Resuelto** en la revisión (31/10/2026).

Autor: Víctor Gutiérrez Marcos
