# Incidencia impositiva en equilibrio parcial

- **Área:** sector público · **Tema de referencia:** 4.B.8 (traslación e incidencia) — lo tiene en el título («mercados competitivos y monopolistas; enfoque de equilibrio parcial»). 3.A.16 hace la estática comparativa del impuesto en competencia perfecta.
- **Temas que lo usan:** 4.B.8 (desarrollo), 3.A.16 (desarrollo como ejercicio de estática comparativa), 4.B.13 (mención: IVA), 4.A.11 (mención: subvención a la vivienda), 4.B.20 (mención prevista: traslación del IVA)
- **Manuales de referencia:** Rosen y Gayer, cap. 14; Stiglitz y Rosengard, cap. 18; Gruber, cap. 19; Fullerton y Metcalf (2002); Mas-Colell, Whinston y Green, cap. 10.C (impuesto en equilibrio parcial). Evidencia: Benzarti, Carloni, Harju y Kosonen (2020) sobre la asimetría del IVA.
- **Decisión D046 (13/10/2026):** ¿Cómo se escriben los precios con impuesto (consumidor y vendedor)? p_c y p_v (p_c = p_v + t o (1 + t)p_v); en 4.B.11 se admite q_i = p_i + t_i diciendo que q es el precio al consumidor

## Presentación de referencia
**Pregunta:** ¿quién soporta económicamente un impuesto (incidencia efectiva) con independencia de quién lo paga legalmente (incidencia legal)?

**Supuestos:** mercado competitivo de un bien, preferencias cuasilineales (sin efectos renta), oferta $q(p)$ y demanda $x(p)$; impuesto unitario $t$ (o *ad valorem*); análisis local con elasticidades constantes.

**Ecuaciones (notación canónica de 3.A.16: $p_c=p_v+t$):**
$$x(p_v+t)=q(p_v),\qquad \frac{dp_c}{dt}=\frac{\varepsilon_S}{\varepsilon_S+\lvert\varepsilon_D\rvert},\qquad \frac{dp_v}{dt}=-\frac{\lvert\varepsilon_D\rvert}{\varepsilon_S+\lvert\varepsilon_D\rvert}.$$
Proporción soportada por los consumidores: $\varepsilon_S/(\varepsilon_S+\lvert\varepsilon_D\rvert)$; por los productores: $\lvert\varepsilon_D\rvert/(\varepsilon_S+\lvert\varepsilon_D\rvert)$.

**Resultados:** (i) la incidencia no depende de quién paga legalmente el impuesto; (ii) **ley de Dalton**: la carga recae sobre el lado más inelástico; (iii) casos extremos: demanda perfectamente inelástica o oferta perfectamente elástica → consumidores 100 %; **demanda perfectamente elástica u oferta perfectamente inelástica → productores 100 %, consumidores 0 %**; (iv) en monopolio, con demanda lineal y CMg constante el precio sube la mitad del impuesto y con demanda isoelástica sube más que el impuesto (sobretraslación); (v) unitario frente a *ad valorem*: en competencia son equivalentes; en monopolio, el *ad valorem* recauda más para el mismo precio; (vi) capitalización de impuestos sobre activos de oferta fija (suelo, vivienda).

**Gráfico de referencia:** eje horizontal cantidad, vertical precio; oferta desplazada verticalmente en $t$ (o demanda hacia abajo), cuña fiscal entre $p_c$ y $p_v$, rectángulo de recaudación repartido arriba y abajo del precio inicial, triángulo de exceso de gravamen. Paneles para los casos extremos. No hay `.tex` todavía.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.8 | Incidencia | Desarrollo | Todo lo anterior, monopolio, oligopolio, capitalización y evidencia | — |
| 3.A.16 | Competencia perfecta: estática comparativa | Desarrollo (como ejercicio) | Desplazamiento del equilibrio por $t$ y fórmula de reparto; «[ver tema 4.B.8]» para la incidencia | Monopolio, capitalización, evidencia |
| 4.B.13 / 4.B.20 | Quién soporta el IVA | Mención | Traslación según elasticidades; asimetría subidas/bajadas (Benzarti et al.) | Gráficos |
| 4.A.11 | Vivienda | Mención | Con oferta inelástica a corto plazo, la deducción por vivienda se traslada al precio | — |

## Divergencias encontradas en el temario actual
- **Error en 4.B.8 (casos extremos):** dice «demanda perfectamente elástica: porcentaje del impuesto que recaerá sobre los productores: 0 %»; es al revés: **productores 100 %**, consumidores 0 %. El anexo 1 del mismo tema lo da bien. **Corregir.**
- 4.B.8, monopolio: «al precio que recibe del consumidor habrá que añadirle el impuesto» → **deducirle**.
- Fórmulas de reparto como imagen vacía en el Word de 4.B.8.
- Notación: $P_C$, $P_V$ (4.B.8) frente a $\hat p_m$, $\hat p_i$ (3.A.16). Canon: $p_c$, $p_v$ en ambos.
- La ley de Dalton se aplica en 4.B.8 a la oferta perfectamente elástica en monopolio con un razonamiento confuso: en monopolio no hay curva de oferta; usar la condición $IMg=CMg$.
