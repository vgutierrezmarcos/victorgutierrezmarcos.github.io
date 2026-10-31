# Acelerador financiero y canal del balance (Bernanke y Gertler 1989, 1995; Bernanke, Gertler y Gilchrist 1999; Kiyotaki y Moore 1997)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.37** (transmisión de la política monetaria; sin revisar), que lo desarrolla como canal del balance (1.10) y fricciones financieras (2.4.1). **[decidir]**: alternativas, el 3.A.34 (que ya da la presentación de equilibrio parcial y la ecuación de BGG) o el 3.A.42 (ciclo financiero). Mientras el 3.A.37 no se revise, la presentación de referencia es la del 3.A.34 (III.4 d). Ficha creada en la fase canon del 3.A.34.
- **Temas que lo usan:** 3.A.37 (desarrollo; sin revisar), 3.A.34 (resumen; hecho, 31/10/2026: III.4, prima de financiación externa con riqueza neta RN, `fig:coste-fondos`, y el acelerador financiero con la ecuación de BGG), 3.A.42 (resumen: enlace entre ciclo financiero y ciclo real)
- **Manuales de referencia:** Bernanke y Gertler (1989, 1995); Bernanke, Gertler y Gilchrist (1999), *Handbook of Macroeconomics*; Kiyotaki y Moore (1997); Gertler y Gilchrist (1994); Romer (2019), cap. 9 (9.8, imperfecciones financieras).

## Presentación de referencia (provisional: 3.A.34, III.4)

**Pregunta:** ¿por qué la inversión depende de los fondos propios de la empresa y las crisis financieras la hunden tanto?

- **Prima de financiación externa**: con información asimétrica y costes de agencia, la financiación externa es más cara que la interna. La empresa tiene una **riqueza neta RN** (sigla en redonda; A34-06, **[decidir]**: N es el número de empresas del modelo de la q; BGG la llaman N); hasta RN invierte al coste $r$ y por encima paga una prima creciente. Oferta de fondos con escalón: más riqueza neta, más inversión, aunque $q$ no cambie («Dinero llama a dinero»).
- **Acelerador financiero** (Bernanke y Gertler, 1989): en una recesión cae la riqueza neta, sube la prima y la inversión cae más: amplifica y prolonga el ciclo. **BGG (1999)**, en equilibrio general:
$$\mathbb E_t\big[R^K_{t+1}\big]=s\Big(\frac{\mathrm{RN}_{t+1}}{q_tK_{t+1}}\Big)R_{t+1},\qquad s'(\cdot)<0,$$
  con **s(·)** la prima (letra de BGG, siempre con argumento; s es la tasa de ahorro y la de separación en el canon) y $R$, $R^K$ rendimientos brutos. Una caída de $q$ reduce RN, sube la prima, frena la inversión y vuelve a bajar $q$.
- **Kiyotaki y Moore (1997)**: lo mismo con las garantías (se presta contra el valor de los activos).
- **Evidencia**: empresas pequeñas más sensibles a las subidas de tipos (Gertler y Gilchrist, 1994); flujo de caja (Fazzari, Hubbard y Petersen, 1988, frente a Kaplan y Zingales, 1997; Erickson y Whited, 2000; Lamont, 1997).
- **Política**: canal del crédito (`\vertema{3.A.37}`), ciclo financiero (`\vertema{3.A.42}`); liquidez y avales en las crisis.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A34/graficos/coste-fondos.tex` (riqueza neta, coste de los fondos con escalón e inversión).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.37 | Transmisión de la política monetaria | desarrollo | Canal del balance y del crédito bancario; acelerador financiero con la ecuación de BGG y la misma notación (RN, s(·), $R^K$); evidencia de Gertler y Gilchrist | Modigliani-Miller y la jerarquía financiera (3.B.3, 3.A.34) |
| 3.A.34 | Teorías de la inversión | resumen (hecho, 31/10/2026) | Prima de financiación externa, gráfico de los fondos, BGG en una ecuación, Kiyotaki-Moore en una frase | La transmisión monetaria |
| 3.A.42 | Teorías del ciclo | resumen | Fricciones financieras como amplificador del ciclo; enlace con el ciclo financiero | El canal monetario |

## Divergencias encontradas en el temario actual
- 3.A.37 (sin revisar): al revisarlo, la riqueza neta con **RN** y la prima con **s(·)**, como el 3.A.34 (o, si se elige N, cambiar también el 3.A.34).

Autor: Víctor Gutiérrez Marcos
