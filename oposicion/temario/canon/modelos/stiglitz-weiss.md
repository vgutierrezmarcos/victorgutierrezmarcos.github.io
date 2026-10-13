# Racionamiento del crédito (Stiglitz y Weiss, 1981)

- **Área:** mercados-información-juegos · **Tema de referencia:** **[decidir]** hoy 3.A.13 (Economía de la información) en `mapa.yaml`, que solo lo resume (dos gráficos, sin ecuaciones), mientras 3.B.27 y 4.A.20 lo desarrollan. **Propuesta: mantener 3.A.13 como referencia y ampliarlo allí** (supuestos, ecuaciones y los dos gráficos, con la versión de 3.B.27/4.A.20), porque el modelo es la aplicación canónica de selección adversa *y* riesgo moral a la vez, que es justo el título de 3.A.13; 3.B.27 y 4.A.20 pasan a resumen y lo aplican (regulación bancaria; financiación de pymes). Alternativa: hacer 3.B.27 tema de referencia (ya lo desarrolla), con 3.A.13 en resumen; peor, porque 3.B.27 lo necesita solo como fundamento.
- **Temas que lo usan:** 3.A.13 (resumen → desarrollo), 3.B.27 (desarrollo → resumen), 4.A.20 (desarrollo → resumen), 3.A.7, 3.B.28, 4.A.24, 4.A.25 (mención); 3.B.26 (crisis financieras) debería citarlo.
- **Manuales de referencia:** Stiglitz y Weiss (1981), *AER*; Freixas y Rochet, *Microeconomics of Banking*, cap. 5; Mas-Colell, Whinston y Green, cap. 13 (selección adversa); Jaffee y Russell (1976).

## Presentación de referencia
Pregunta: ¿por qué el mercado de crédito puede quedar en equilibrio con exceso de demanda, sin que el tipo de interés suba?
Supuestos: prestatarios con proyectos de igual rendimiento medio y distinto riesgo; responsabilidad limitada; el banco no observa el riesgo (selección adversa) ni la elección del proyecto (riesgo moral) y solo fija el tipo $\hat r$.
Mecanismo: al subir $\hat r$, (i) abandonan los prestatarios seguros (efecto selección adversa) y (ii) los que quedan eligen proyectos más arriesgados (efecto incentivo). La probabilidad de repago cae con $\hat r$:
$$\mathbb E[B_{banco}]=(1+\hat r)\,\Pr(\text{repago}\mid\hat r),\qquad \frac{\partial\Pr}{\partial\hat r}<0$$
El rendimiento esperado es creciente hasta $\hat r^*$ y decreciente después: el banco no presta por encima de $\hat r^*$.
Resultado: equilibrio con **racionamiento** (demanda > oferta a $\hat r^*$); la oferta de crédito se dobla hacia atrás; justifica garantías, relaciones banca-cliente, avales públicos y políticas de crédito a pymes y exportadores.
Gráficos de referencia: (1) rendimiento esperado del banco frente a $\hat r$, máximo en $\hat r^*$; (2) mercado de préstamos con demanda decreciente, oferta que se dobla hacia atrás desde $\hat r^*$ y exceso de demanda.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.13 | Selección adversa y riesgo moral a la vez | desarrollo (propuesto) | Modelo completo, dos efectos, dos gráficos | — |
| 3.B.27 | Fundamentos de la regulación financiera | resumen | Fallo de información en el crédito; garantías, supervisión | Derivación (remitir a 3.A.13) |
| 4.A.20 | Financiación no bancaria | resumen | Racionamiento de las pymes ⇒ diversificar fuentes (mercados, capital riesgo) | Derivación |
| 3.A.7 | Nueva economía keynesiana | mención | Imperfecciones del crédito como fuente de rigidez y amplificación | — |
| 3.B.28 | Desarrollo | mención | Microcréditos y responsabilidad conjunta como respuesta | — |
| 4.A.24, 4.A.25 | Apoyo financiero a la internacionalización | mención | Fallo de mercado que justifica CESCE, FIEM, COFIDES | — |

## Divergencias encontradas en el temario actual
- 3.B.27 y 4.A.20 escriben $E[B]=\hat r\cdot\Pr(\text{repago})(\hat r)$: el rendimiento bruto es $(1+\hat r)$; y $E$ choca con $E(p,\overline U)$ (función de gasto) y con $E$ (educación, éxito) de 3.A.13: canon $\mathbb E[\cdot]$ para la esperanza.
- 3.A.13 lo presenta como comodín al final; el inventario de 3.A.13 no remite a 3.B.26/3.B.27.
