# Centralización de la negociación colectiva: Bruno y Sachs (1985) y la joroba de Calmfors y Driffill (1988)

- **Área:** macro cerrada (mercado de trabajo) · **Tema de referencia:** **3.A.27** (revisado el 31/10/2026, anexo D `anexo:centralizacion`: la teoría con el gráfico `joroba`, la evidencia posterior y el caso español) — es teoría de la negociación salarial y, por `CRITERIOS.md` § 6, su referencia va en el 3.er ejercicio; el 3.B.16 y el 4.A.16 la resumen para su pregunta, cada uno completo para su examen. Ficha creada en la fase canon del 3.A.27 (propuestas de coherencia § 5.4.6; **[decidir]**). En `_inventario/areas.json` estaba en economía española (por el 4.A.16): pasa a macro cerrada, como su tema de referencia.
- **Temas que lo usan:** 3.A.27 (desarrollo en anexo; hecho, 31/10/2026), 3.B.16 (resumen: centralización y *shocks* asimétricos en una unión monetaria; hoy copia casi literal del anexo 1 antiguo del 3.A.27 con la figura escaneada), 4.A.16 (resumen aplicado: estructura de la negociación en España, reformas de 2012 y 2021; hoy copia el mismo anexo), 1D01 (mención; hecho, 24/10/2026: la negociación de nivel intermedio, sectorial, transmite peor los *shocks* a los precios, con `CalmforsDriffill1988`, la misma clave que reutiliza el 3.A.27).
- **Manuales de referencia:** Bruno y Sachs (1985), *Economics of Worldwide Stagflation*; Calmfors y Driffill (1988), *Economic Policy* 6; Flanagan (1999), *JEL*; OCDE, *Employment Outlook* 2017 (cap. 4) y 2018 (cap. 3), y *Negotiating Our Way Up* (2019); Jimeno y Thomas (2013), *European Economic Review* 59.

## Presentación de referencia (3.A.27, anexo D)

Pregunta: ¿a qué nivel conviene negociar los salarios (empresa, sector o país)? Conclusión: la teoría predice una joroba (lo peor, el nivel sectorial); con datos recientes lo que importa es la **coordinación**, más que el grado de centralización.

- **Bruno y Sachs (1985)**: ante un *shock* de oferta (petróleo, años 70), un sistema centralizado interioriza que pedir más salario nominal solo trae inflación y modera; en uno descentralizado cada sindicato pesa poco en la inflación y todos acaban pidiendo más (nota del estadio de fútbol).
- **Calmfors y Driffill (1988)**: añaden el extremo descentralizado: con negociación de empresa, una subida excesiva cuesta empleo en la propia empresa y también modera. **Hipótesis de la joroba**: el salario real y el paro, frente al grado de centralización, en U invertida; lo peor, el nivel sectorial (ni interioriza la inflación ni la pérdida de empleo de la empresa). Los países de los extremos resistieron mejor los *shocks* de los 70 y 80. Sin ecuación: se cuenta con el gráfico.
- **Evidencia posterior**: la joroba no resiste con más países y años (Flanagan, 1999); la OCDE (2017-2019) no la encuentra y asocia mejores resultados (empleo, paro, inclusión, desigualdad) a la **coordinación** entre niveles; los centralizados sin coordinación quedan en medio.
- **España**: Jimeno y Thomas (2011 DT; 2013 EER): con búsqueda y *shocks* idiosincrásicos, la negociación sectorial da un paro unos 5 puntos mayor que la de empresa en su calibración, y el descuelgue elimina la diferencia; propuesta de FEDEA (2009); Ley 3/2012 (prioridad del convenio de empresa en salarios, ultraactividad de 1 año, descuelgue) y RDL 32/2021 (el sectorial vuelve a mandar en salarios, ultraactividad indefinida, se mantiene el descuelgue); datos de la CCT (7,4 % de trabajadores con convenio de empresa en 2025 frente al 10,7 % de 2013; descuelgues: 295 inaplicaciones con 13.723 trabajadores en enero-septiembre de 2026, frente a 2.512 y 159.550 en 2013). Caja de la cobertura: OCDE 92,1 % (2024), OIT 80,1 % (2018), cociente propio 69 % (2024) (A27-06).
- **Unión monetaria**: sin tipo de cambio, la forma de negociar decide cómo responden los salarios a los *shocks* asimétricos (`\vertema{3.B.16}`, solo para ampliar).

**Gráfico de referencia** (`oposicion/temario/fuentes/3A27/graficos/`): `joroba.tex` (salario real y paro frente al grado de centralización, U invertida, con empresa, sector y nacional en el eje). Sustituye a la figura escaneada que copian el 3.B.16 y el 4.A.16. Los datos de cobertura y afiliación por países están en `fuentes/3A27/_trabajo/datos/cobertura-afiliacion-ocde.csv` para un gráfico de datos del 4.A.16 (A27-05).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.27 | Determinación de salarios | desarrollo en el anexo D (hecho, 31/10/2026; no se canta) | Bruno y Sachs, joroba con su gráfico, evidencia de la OCDE, Jimeno y Thomas, reformas y datos; en el cuerpo, una línea con remisión al anexo | — |
| 3.B.16 | Ajuste en una unión monetaria | resumen | La centralización y la coordinación salarial ante *shocks* asimétricos sin tipo de cambio: la joroba en una frase con el gráfico `joroba` y la conclusión de la OCDE; `\vertema{3.A.27}` | Bruno y Sachs en detalle y el caso español |
| 1D01 | Dictamen de coyuntura | mención (hecho) | Negociación sectorial y transmisión a los precios | El modelo |
| 4.A.16 | Mercado de trabajo en España | resumen (aplicado) | Estructura de la negociación en España (sectorial), Jimeno y Thomas, reformas de 2012 y 2021, descuelgues y cobertura con datos; completo para el 4.º, con `\vertema{3.A.27}` solo para ampliar | La teoría completa |

## Divergencias encontradas en el temario actual
- 3.A.27 original: anexo 1 con Bruno y Sachs y Calmfors y Driffill, figura escaneada, una lista de políticas atribuida a «(Dolado, Jansen, Conde-Ruiz)» y Jimeno y Thomas (2011) sin título. **Resuelto** (31/10/2026): gráfico `joroba` en TikZ, la lista atribuida a FEDEA (2009) (A27-11, **[decidir]**: conviene cotejarla con el documento original), versión publicada de Jimeno y Thomas (EER, 2013), evidencia de la OCDE en paráfrasis (A27-12, **[decidir]**).
- 3.B.16 y 4.A.16 (sin revisar): copian casi literalmente el anexo 1 antiguo con la figura escaneada (el comentario P16 del Word del 3.A.27 pide coordinarlos): al revisarlos, resumir con esta ficha y remitir al anexo D del 3.A.27 (en el 4.A.16, solo para ampliar).

Autor: Víctor Gutiérrez Marcos
