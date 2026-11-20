# Requisitos de capital de Basilea III

- **Área:** finanzas-empresa · **Tema de referencia:** 3.B.27 (Regulación financiera bancaria y no bancaria) — único desarrollo.
- **Temas que lo usan:** 3.B.27 (desarrollo; hecho, 13/11/2026: funciones clave `eq:ratio-capital`, `eq:lcr`, `eq:nsfr`), 3.B.1 (mención; hecho, 13/11/2026: caja gris, el paralelo con la ratio de financiación propia, con APR, nunca RWA), 3.B.26 (mención; hecho, 12/11/2026: el capital por riesgo de mercado con el VaR de 1996 y la ES del FRTB, ficha `var-expected-shortfall`; el IRB con PD, LGD, EAD y la fórmula de Vasicek en el anexo C, ficha `riesgo-credito`; LCR, NSFR e IRRBB nombrados; `\vertema{3.B.27}`); relacionado con 3.B.44 (Unión Bancaria) y 4.A.19-4.A.20 (sistema financiero español), 1D01 (uso: III.2 y `tab:basilea`, mínimos con APR)
- **Manuales de referencia:** BCBS, *Basel III: A global regulatory framework* (2010, rev. 2011) y *Basel III: Finalising post-crisis reforms* (2017); Reglamento (UE) 575/2013 (CRR) y Directiva 2013/36/UE (CRD IV), con CRR3/CRD VI (2024); Freixas y Rochet, cap. 9.

## Presentación de referencia
**Pregunta:** ¿cuánto capital debe tener un banco y por qué?

**Ecuaciones (notación canónica):** $APR$ = activos ponderados por riesgo.
$$\frac{CET1}{APR} \ge 4{,}5\,\%, \qquad \frac{Tier\,1}{APR} \ge 6\,\%, \qquad \frac{\text{capital total}}{APR} \ge 8\,\%$$
más colchones (conservación 2,5 %, anticíclico 0-2,5 %, sistémicos 0-3,5 %; P2R), ratio de apalancamiento $Tier\,1/\text{exposición total} \ge 3\,\%$ (más el recargo de los G-SIB, hasta 1,75), LCR y NSFR; suelo de *output* del 72,5 % (2017). Tramos G-SIB: 1/1,5/2/2,5/3,5 % (no hay del 3 %).

**Calendario (3.B.27, 13/11/2026):** BCBS desde el 1/1/2023 (suelo del 50 % que sube al 72,5 % en 2028); UE: CRR3 desde el 1/1/2025 (suelo gradual hasta 2030, transitorios hasta 2032), transposición de la CRD VI el 10/1/2026, FRTB el 1/1/2027 con alivios hasta 2030 (Reglamento Delegado 2026/1221); Reino Unido, 1/1/2027; EE. UU., propuesta del 19/3/2026.

**Resultado:** el capital absorbe pérdidas y corrige el riesgo moral creado por el seguro de depósitos; los colchones dan dimensión macroprudencial.

**Gráfico de referencia:** `oposicion/temario/fuentes/3B27/graficos/requisitos-capital.tex` (barras apiladas: CET1 4,5, AT1 1,5, T2 2, P2R ilustrativo, conservación 2,5, anticíclico 0-2,5, sistémico 0-3,5; apalancamiento 3 + G-SIB hasta 1,75) (pasada final, nov. 2026).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.27 | Regulación financiera | desarrollo (hecho, 13/11/2026) | Pilares, ratios, colchones, liquidez, Basilea III final y evidencia | — |
| 3.B.1 | Análisis financiero de la empresa | mención (hecho, 13/11/2026) | Caja gris: 4,5/6/8 %, apalancamiento 3 % y APR como paralelo de la ratio de financiación propia | Los colchones y la liquidez |
| 1D01 | Dictamen de coyuntura | Uso | Mínimos 4,5/6/8 % + conservación = 7/8,5/10,5 %, colchones, P2R y apalancamiento ≥ 3 % (es solvencia); LCR y NSFR ≥ 100 %; separar los mínimos de las referencias orientativas de la ABE (ficha `indicadores-bancarios`) | La justificación teórica |
| 3.B.26 | Gestión de riesgos | mención (hecho, 12/11/2026) | El capital cubre la pérdida inesperada; VaR 99 %, 10 días, × 3 (1996) y ES 97,5 % (FRTB, sin fecha en la UE); IRB al 99,9 % con un factor (Vasicek, 2002; Gordy, 2003; ρ = 0,15 en hipotecas, anexo C); LCR y NSFR; atípico en IRRBB con el 15 % del nivel 1 | Pilares, colchones, mínimos (3.B.27) |

## Divergencias encontradas en el temario actual
- Sin divergencias de notación. Comprobar en la revisión las cifras y el calendario (aplicación de CRR3 en la UE desde 2025) con la normativa vigente.

Autor: Víctor Gutiérrez Marcos
