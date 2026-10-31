# Monopsonio (Robinson, 1933): el espejo del monopolio en el mercado de factores

- **Área:** mercados-información-juegos · **Tema de referencia:** **3.A.17** («Monopsonio» en el título; revisado el 17/10/2026, III.1) — lo desarrolla con a)-e), su `\funcionclave` y la tabla de los 4 casos. Ficha creada a raíz de esa revisión.
- **Temas que lo usan:** 3.A.17 (desarrollo; hecho, 17/10/2026), 3.A.25 (resumen; hecho, 31/10/2026: en I.4 `sec:valoracion-neoclasica`, la fórmula `eq:monopsonio` con la misma etiqueta, sin paro involuntario, el salario mínimo «al revés que en competencia» y Card y Krueger; los gráficos `monopsonio.tex` y `salario-minimo.tex` copiados sin cambios; en el anexo D `anexo:poder-mercado-trabajo`, el caso general con $\mathrm{IPMg}_L=\mathrm{GMg}_L$, los 4 casos en una frase y el salario mínimo por tramos), 3.A.12 (mención: con poder de monopsonio las isocostes dejan de ser rectas; opinión; hecho), 3.A.27 (mención prevista: punto de partida del monopolio bilateral y del sindicato; ficha `monopolio-bilateral`), 4.A.14 y 3.B.39 (mención: poder de compra de la distribución en la cadena alimentaria, prácticas comerciales desleales).
- **Manuales de referencia:** Robinson (1933), *The Economics of Imperfect Competition*; Manning (2003), *Monopsony in Motion*; Varian (1992), cap. 14; Card y Krueger (1994), *AER*; Yeh, Macaluso y Hershbein (2022), *AER*; Deb et al. (2022), *JEEA*.

## Presentación de referencia (3.A.17, III.1)

Pregunta: ¿qué pasa cuando el poder de mercado está del lado del comprador? Conclusión: el monopsonista compra menos y paga menos de lo que vale el factor en el margen, sin paro involuntario.

- **a) Idea**: un único comprador (o con poder para influir en el precio de lo que compra): la gran empresa de una comarca, un hospital público frente a la enfermería, la gran distribución frente a pequeños productores. Para comprar más debe **subir** el precio de todas las unidades. Robinson (1933) acuña el término.
- **b) Modelo**. i) Supuestos: precio-aceptante en el bien (precio p; se levanta después), q = F(L) con el resto de factores fijos, único demandante de trabajo frente a una **oferta inversa** w_L(L), w_L' > 0, elasticidad ε_{L,w_L} = (dL/dw_L)(w_L/L) > 0, un solo salario para todos. ii) Desarrollo:
$$\max_L\ B(L)=p\,F(L)-w_L(L)\,L\quad\text{s.a. } L\ge 0$$
`\funcionclave` (`eq:monopsonio`), el **índice de poder de monopsonio**, espejo de Lerner:
$$\mathrm{VPMg}_L=\mathrm{GMg}_L=w_L(L)\Big(1+\frac{1}{\varepsilon_{L,w_L}}\Big)\ \Longleftrightarrow\ \frac{\mathrm{VPMg}_L-w_L}{w_L}=\frac{1}{\varepsilon_{L,w_L}}$$
con VPMg_L = p·PMg_L y GMg_L = w_L(L) + w_L'(L)L (siglas de `notacion.md` § 0, provisionales: D8 del 3.A.17). Gráfico: el GMg_L queda **por encima** de la oferta (con oferta lineal, misma ordenada en el origen y doble pendiente); L^M donde GMg_L = VPMg_L y w^M = w_L(L^M) sobre la **oferta**; competencia en L^c, w^c (VPMg_L = w_L). No hay curva de demanda de trabajo. **Isocostes curvas**: C̄ = w_L(L)L + w_KK, pendiente −GMg_L/w_K, mínimo coste con RMST_{LK} = GMg_L/w_K (cumple lo que anuncia la opinión del 3.A.12). Con monopolio en el bien, IPMg_L = IMg·PMg_L < VPMg_L: se suman las 2 brechas.
- **Tabla de los 4 casos** (`tab:cuatro-casos`, con colores; anexo `anexo:cuatro-casos`): (1) competencia en los 2, VPMg_L = w_L (verde, empleo y salario máximos); (2) monopsonio, VPMg_L = GMg_L (azul, explotación monopsonística); (3) monopolio en el bien, IPMg_L = w_L (dorado, explotación monopolística); (4) los 2, IPMg_L = GMg_L (rojo, mínimos). **En ninguno hay paro involuntario**: se contrata sobre la oferta; solo aparece con un sindicato o con un salario mínimo superior a w^c.
- iii) **Implicaciones**: L^M < L^c, w^M < w^c, sin paro; pérdida = triángulo entre VPMg_L y la oferta de L^M a L^c; transferencia (w^c − w^M)L^M de los trabajadores a la empresa (explotación monopsonística). **Salario mínimo** w̲ (oferta y GMg horizontales hasta L^S(w̲)): si w̲ ≤ w^M, no afecta; si w^M < w̲ ≤ w^c, el empleo **sube** (máximo en w̲ = w^c); si w̲ > w^c, empleo L^D(w̲) y paro involuntario, aunque mayor que L^M mientras w̲ no supere VPMg_L(L^M).
- **c) Extensiones**: monopsonio dinámico (Manning, 2003: fricciones, el poder no exige un único empleador); monopsonio en los bienes (cadena alimentaria, 3.B.39).
- **d) Evidencia**: Card y Krueger (1994), 410 restaurantes de Nueva Jersey (de 4,25 a 5,05 $/h el 1/4/1992) frente a Pensilvania, sin caída del empleo; Yeh, Macaluso y Hershbein (2022): IPMg 53 % por encima del salario en la planta manufacturera media de EE. UU. (65 centavos por dólar); Deb et al. (2022): estancamiento salarial de 1997-2016, 75 % monopolio y 25 % monopsonio; SMI 2026: 1.221 €/mes en 14 pagas (17.094 €/año), +3,1 % (RD 126/2026).
- **e) Valoración**: explica por qué el salario mínimo no siempre destruye empleo; deja fuera la respuesta organizada de los trabajadores: el monopolio bilateral.

**Gráficos de referencia** (`oposicion/temario/fuentes/3A17/graficos/`): `monopsonio.tex` (**imprescindible**, por capas: oferta w_L(L), GMg_L, VPMg_L, w^M-L^M, w^c-L^c, pérdida en rojo al 30 %, transferencia en dorado; sobre él se construye `monopolio-bilateral.tex`) y `salario-minimo.tex`. Test: con oferta lineal w_L = α + βL (letras locales del anexo C), GMg_L = α + 2βL.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.17 | Monopsonio | desarrollo (hecho, 17/10/2026) | Todo lo anterior | — |
| 3.A.25 | Mercado de trabajo neoclásico | resumen (hecho, 31/10/2026) | En I.4 (45″ de cante, el supuesto 4 que se levanta): `eq:monopsonio` sin recuadro, $L^M<L^c$ y $w^M<w^c$ sin paro involuntario, el salario mínimo entre $w^M$ y $w^c$ que sube salario y empleo, Card y Krueger (1994) y Manning (2003); `monopsonio.tex` y `salario-minimo.tex` copiados (apoyo). Anexo D: problema general $\max_L p(q)q-w_L(L)L-w_K\overline K$ con $\mathrm{IPMg}_L=\mathrm{GMg}_L$ y $\lvert\varepsilon_{q,p}\rvert$, los 4 casos en una frase (DK4), `monopsonio-monopolio.tex` (local del 3.A.25) y el salario mínimo por tramos; remite a 3.A.17 | La tabla de los 4 casos y las isocostes |
| 3.A.12 | Costes | mención (hecho) | Con poder de monopsonio las isocostes dejan de ser rectas (opinión), remite a 3.A.17 | — |
| 3.A.27 | Negociación salarial | mención (prevista) | La empresa monopsonista como uno de los extremos del monopolio bilateral | El modelo |
| 4.A.14, 3.B.39 | Distribución comercial; mercado único | mención | Poder de compra de la gran distribución y prácticas comerciales desleales | La teoría |

## Divergencias encontradas en el temario actual
- 3.A.17 original: monopsonio vacío en el cuerpo; anexo 1 con «el GMg, i.e. la curva de oferta de trabajo» y «paro involuntario» con monopsonio; W, R, Π, IMgF, GMgF. **Resuelto** en la revisión (17/10/2026): GMg_L por encima de la oferta, sin paro, w_L(L), w_K, B, VPMg_L, IPMg_L, GMg_L.
- 3.A.25 original: su anexo copiaba el anexo 1 del 3.A.17 original con los mismos errores (GMg = oferta, «IMgF, i.e. la curva de demanda», paro involuntario, nota 36) y usaba W, Π, IMgF, GMgF. **Resuelto** en la revisión del 3.A.25 (31/10/2026): resumen en I.4 y anexo D con esta notación, sin la tabla de los 4 casos.

Autor: Víctor Gutiérrez Marcos
