# Progresividad impositiva: medidas locales y globales

- **Área:** sector público · **Tema de referencia:** 4.B.9 — el título pide «medidas de progresividad impositiva» (hoy ausentes en la fuente). 4.B.16 la aplica a la tarifa del IRPF.
- **Temas que lo usan:** 4.B.9 (debería ser desarrollo; hoy falta), 4.B.3 (resumen: impacto redistributivo), 4.B.7 (resumen: clases de impuestos), 4.B.4 (resumen: elasticidad de la recaudación), 4.B.12 (resumen), 4.B.16 (desarrollo previsto, sin fuente: tarifa del IRPF), 4.A.3 (mención: distribución de la renta en España)
- **Manuales de referencia:** Lambert, *The Distribution and Redistribution of Income* (3.ª ed., 2001), cap. 7-8; Musgrave y Thin (1948), *JPE*; Kakwani (1977), *EJ*; Reynolds y Smolensky (1977); Suits (1977), *AER*; Rosen y Gayer, cap. 14; Albi et al., *Economía pública I*.

## Presentación de referencia
**Pregunta:** ¿cómo se mide si un impuesto (o un sistema) es progresivo y cuánto redistribuye?

**Definiciones (notación canónica: $T(Y)$, $t_{me}=T/Y$, $t_{mg}=T'(Y)$):** un impuesto es progresivo si el tipo medio crece con la renta, $\frac{d(T/Y)}{dY}>0\iff t_{mg}>t_{me}$. Regresivo si decrece; proporcional si es constante.

**Medidas locales (en un punto de la tarifa):**
- progresividad del tipo medio: $\frac{d(T/Y)}{dY}$;
- progresividad de la cuota (elasticidad recaudación-base): $\varepsilon_{T,Y}=\frac{t_{mg}}{t_{me}}>1$;
- progresividad de la renta neta: $\varepsilon_{Y-T,Y}=\frac{1-t_{mg}}{1-t_{me}}<1$.

Ejemplo de referencia: impuesto lineal con mínimo exento o con deducción fija en cuota, $T(Y)=t\,Y-R$: $t_{mg}=t$ constante, $t_{me}=t-R/Y$ creciente; progresivo en tipo medio aunque el marginal sea constante.

**Medidas globales:** Kakwani $\Pi^K=C_T-G_Y$ (concentración de la cuota menos Gini de la renta antes de impuestos); Suits (análogo con curva de concentración relativa); efecto redistributivo de Reynolds-Smolensky $\Pi^{RS}=G_Y-C_{Y-T}$ (ficha `reynolds-smolensky`); Musgrave-Thin $\frac{1-G_{Y-T}}{1-G_Y}$. Relación: $\Pi^{RS}=\frac{t}{1-t}\Pi^K$ (sin reordenación; $t$ = tipo medio efectivo del sistema).

**Gráfico de referencia:** $T(Y)$ convexa con rectas desde el origen (tipo medio) y tangentes (tipo marginal); curva de Lorenz de la renta antes y después de impuestos y curva de concentración de la cuota. No hay `.tex` todavía.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.9 | Medidas de progresividad | Desarrollo (hay que escribirlo) | Todo lo anterior | — |
| 4.B.7 | Clases de impuestos | Resumen | Definición por tipo medio y marginal y el ejemplo $T=tY-R$ | Medidas globales |
| 4.B.3 | Impacto redistributivo del presupuesto | Resumen | Reynolds-Smolensky y Kakwani aplicados (lado de ingresos y de gastos) | Las medidas locales |
| 4.B.4 | Estabilizadores | Resumen | $\varepsilon_{T,BI}=t_{mg}/t_{me}$ como componente de $\varepsilon_{T,Y}$ | La definición de progresividad |
| 4.B.12 | Imposición directa | Resumen | Progresividad como característica del IRPF; impuesto dual y tipo único | — |
| 4.B.16 | IRPF en España | Desarrollo previsto | Tarifa estatal y autonómica, mínimos, base del ahorro; índices calculados por la AEAT/IEF | — |

## Divergencias encontradas en el temario actual
- **Falta el epígrafe en 4.B.9** («Medidas de progresividad impositiva» no aparece ni en el Word ni en el PDF); hoy lo poco que hay está en 4.B.7 (local) y 4.B.3 (Reynolds-Smolensky, epígrafe vacío). **Propuesta [decidir]:** escribirlo en 4.B.9 y que 4.B.3, 4.B.7 y 4.B.12 remitan.
- 4.B.3 y 4.B.12 escriben la elasticidad sobre la base ($\varepsilon_{T,BI}$) y 4.B.7 la mezcla con la elasticidad base-renta («$\varepsilon_{T,Y}>1$ por el mínimo exento»). Propuesta: progresividad = $\varepsilon_{T,BI}$ (tarifa); $\varepsilon_{BI,Y}$ es otra cosa (amplitud de la base).
- 4.B.3 usa $T/Y$ y $BI$ indistintamente; $R$ es «reducción» en 4.B.3 y «deducción en cuota» en 4.B.7: con $T=tY-R$, $R$ es una **deducción en la cuota**.
- 4.B.12 dice que el IRPF es progresivo porque «se aplicará un mayor porcentaje de retención»: confunde tipo de gravamen con retención.
