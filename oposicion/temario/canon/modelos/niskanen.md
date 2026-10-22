# Modelo de burocracia de Niskanen (1971)

- **Área:** sector público · **Tema de referencia:** 4.B.2 (producción pública y burocracia) — título; 4.B.5 lo repite con el mismo gráfico.
- **Temas que lo usan:** 4.B.2 (desarrollo), 4.B.5 (hoy desarrollo; debería ser resumen), 3.A.23 (mención), 3.A.24 (mención), 4.B.11 (mención), 4.B.15 (mención: empresa pública), 3.A.15 (mención; hecho, 20/10/2026: en la empresa pública no hay mercado de control y el burócrata maximiza su presupuesto, con `\vertema{3.A.23}`, `\vertema{4.B.2}` y `\vertema{4.B.15}`); 3.A.23 (mención; hecho, 21/10/2026: en los problemas de incentivos, con el gráfico en nota).
- **Manuales de referencia:** Niskanen, *Bureaucracy and Representative Government* (1971); Migué y Bélanger (1974); Mueller, *Public Choice III*, cap. 16.
- **Decisión D128 (13/10/2026):** ¿Dónde se desarrolla Niskanen? En 4.B.2; resumen en 4.B.5

## Presentación de referencia
**Pregunta:** ¿por qué el presupuesto de las agencias públicas tiende a ser mayor que el eficiente?

**Supuestos:** el burócrata maximiza el tamaño de su presupuesto (salario, prestigio, poder); monopolio bilateral con el patrocinador político, pero el burócrata tiene la información sobre costes; el patrocinador conoce el beneficio y acepta cualquier programa con beneficio total al menos igual al coste total.

**Ecuaciones (notación canónica):** eficiente: $BMg(G^*)=CMg(G^*)$; burócrata: $\max G$ s.a. $B(G')=C(G')$, con $G'>G^*$ (hasta el doble con funciones lineales).

**Resultado:** sobreproducción (ineficiencia asignativa) o, en la variante de Migué-Bélanger, holgura presupuestaria (ineficiencia X). Soluciones: competencia entre agencias, externalización, incentivos, presupuesto base cero, evaluación (4.B.6), información del patrocinador.

**Gráfico de referencia:** beneficio total $B(G)$ cóncavo y coste total $C(G)$ convexo; $G^*$ donde la distancia vertical es máxima (pendientes iguales) y $G'$ donde se cortan. Primer `.tex` con la notación canónica: `oposicion/temario/fuentes/3A23/graficos/niskanen.tex` (gráfico en nota del 3.A.23: $B(G)$, $C(G)$, $G^*$, $G'$); el 4.B.2 puede reutilizarlo.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.2 | Burocracia | Desarrollo | Modelo, gráfico, variantes y soluciones | — |
| 4.B.5 | Crecimiento del gasto | Resumen | Resultado como causa del crecimiento del gasto; «[ver tema 4.B.2]» | El gráfico |
| 3.A.24 | Elección pública (anexo D) | mención (hecho, 22/10/2026) | El burócrata maximiza su presupuesto y conoce mejor el coste: presupuesto mayor que el eficiente; `\vertema{3.A.23}`; esquema `oposicion/temario/fuentes/3A24/graficos/eleccion-publica.tex` | El modelo |
| 4.B.11 / 4.B.15 | Fallos del sector público | Mención | — | — |
| 3.A.15 | Agencia sin disciplina de mercado | Mención (hecho, 20/10/2026) | Empresa pública sin mercado de control: el burócrata maximiza el presupuesto, con exceso de tamaño; justificación de privatizaciones y liberalizaciones | El modelo |
| 3.A.23 | Fallos del sector público (incentivos) | Mención (hecho, 21/10/2026) | El burócrata maximiza el presupuesto y, como conoce los costes mejor que el político que lo financia, logra uno mayor que el eficiente; gráfico en nota (`\graficonota`), `\vertema{4.B.2}`; junto a Weber y la ineficiencia X | La derivación y las variantes |

## Divergencias encontradas en el temario actual
- **Duplicación (4.B.2 y 4.B.5)** con el mismo gráfico. Desarrollo en 4.B.2; resumen en 4.B.5.
- 4.B.2: las «soluciones» a la burocracia aparecen dos veces casi idénticas (2.2.3 y 2.4); atribuye la «ilusión de la deuda» a Niskanen (ver `ilusion-fiscal.md`).
