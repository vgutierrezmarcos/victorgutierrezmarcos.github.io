# Curva de Lorenz e índice de Gini (antes y después de impuestos)

- **Área:** sector público · **Tema de referencia:** doble, uno por ejercicio. **4.B.3** (4.º ejercicio): Lorenz y Gini antes y después de impuestos y transferencias, con Reynolds-Smolensky; 4.A.3 la usa con datos. **3.A.24** (3.er ejercicio; **hecho, 22/10/2026**, II.4.1 `sec:atkinson`, `eq:gini` y gráfico `fig:lorenz`): definición de $L(s)$ y del Gini, dominancia de Lorenz y su relación con el bienestar (Atkinson, 1970; Shorrocks, 1983). Cada uno, completo para su examen.
- **Temas que lo usan:** 3.A.24 (desarrollo, 3.er ejercicio; hecho, 22/10/2026, junto al índice de Atkinson), 4.B.3 (desarrollo, 4.º ejercicio; hoy resumen), 4.A.3 (previsto, con datos), 4.B.9 (mención, para Kakwani y Reynolds-Smolensky).
- **Manuales de referencia:** Lambert (2001), cap. 2-3; Atkinson (1970), *JET*; Shorrocks (1983), *Economica*; Cowell, *Measuring Inequality* (3.ª ed., 2011).
- **Decisión D075 (13/10/2026):** ¿Dónde se define la curva de Lorenz? Desarrollo en los dos ejercicios: se desarrolla en 4.B.3 (y 4.A.3 lo usa con datos) y también en 3.A.24, lo bastante para que quien estudia el 3.er ejercicio lo entienda.

## Presentación de referencia

**Pregunta:** ¿cómo representar y medir la desigualdad, y cuánto la cambian los impuestos y transferencias?

**Definiciones (3.A.24):** $L(s)$, $s\in[0,1]$: parte de la renta total que recibe la fracción $s$ más pobre de la población; con igualdad perfecta, la diagonal. **Índice de Gini, IG** (en redonda, `\mathrm{IG}`; **nunca $G$**, que en el bloque del bienestar es el bien público: D9 del 3.A.24, **[decidir]** pendiente de Víctor; aplicada IG), el doble del área entre la diagonal y la curva:
$$\mathrm{IG}=1-2\int_0^1L(s)\,ds,\qquad 0\le\mathrm{IG}\le1\qquad(\texttt{eq:gini})$$
En el texto se da también en la escala de 0 a 100 (España, 30,8; UE-27, 29,2; ficha `atkinson-indice`).

**Dominancia de Lorenz** (Atkinson, 1970): si la curva de una distribución $\vect y$ está siempre por encima de la de otra $\vect y'$ con la misma media, $L_{\vect y}(s)\ge L_{\vect y'}(s)$ para todo $s$, **toda** FBS utilitarista con utilidad creciente y cóncava prefiere $\vect y$. Con medias distintas, la curva de Lorenz **generalizada**, $\overline y\,L(s)$ (Shorrocks, 1983). Si las curvas se cortan, ordenarlas exige elegir una FBS: índice de Atkinson.

**4.B.3 (propuesta, sin cambio):** curva antes de impuestos $L_Y$, después $L_{Y-T}$, y curva de concentración de la cuota $C_T$; Reynolds-Smolensky y Kakwani (ficha `reynolds-smolensky`). Es la misma figura con 2 curvas: en el 3.A.24 son 2 distribuciones cualesquiera, $\vect y$ y $\vect y'$; en el 4.B.3, la renta antes y después del presupuesto.

**Gráfico de referencia:** `oposicion/temario/fuentes/3A24/graficos/lorenz.tex` (3.A.24, 22/10/2026). Cuadrado unitario, ejes $s$ («fracción de la población, de más pobre a más rica») y $L(s)$ («fracción de la renta»); capas: 1) ejes y cuadrado; 2) diagonal de igualdad perfecta; 3) $L_{\vect y}(s)=s^{2,2}$ (IG = 0,375); 4) área sombreada $\mathrm{IG}/2$; 5) curva dominada $L_{\vect y'}(s)=s^3$ (IG = 0,5). **Rótulos de las curvas: $L_{\vect y}$ y $L_{\vect y'}$ (2 distribuciones), no $L_A$ y $L_D$ (antes y después de impuestos)** como decía la presentación anterior de esta ficha: el 3.A.24 compara distribuciones, no el efecto del presupuesto. El 4.B.3 reutilizará el mismo `.tex` cambiando solo los rótulos a $L_Y$ y $L_{Y-T}$ (y, si lo necesita, una capa con $C_T$). En la pizarra del 3.A.24: cuadrado, diagonal, curva y área.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 4.B.3 | Impacto redistributivo | desarrollo (referencia del 4.º) | Lorenz antes/después ($L_Y$, $L_{Y-T}$, $C_T$) sobre el gráfico `lorenz.tex`, IG con `eq:gini`, Reynolds-Smolensky; `\vertema{3.A.24}` para la dominancia y la FBS | Axiomas de los índices |
| 4.A.3 | Distribución de la renta en España | previsto | Datos (ECV, INE; Eurostat) con IG en la escala 0-100 | La definición |
| 3.A.24 | Bienestar y desigualdad | desarrollo (referencia del 3.º; hecho, 22/10/2026) | $L(s)$, IG, dominancia de Lorenz con $L_{\vect y}(s)\ge L_{\vect y'}(s)$, teorema de Atkinson (1970), Lorenz generalizada (Shorrocks, 1983), gráfico `lorenz` | La aplicación al presupuesto |
| 4.B.9 | Progresividad | mención | La curva de concentración de la cuota con remisión al 4.B.3 | La definición |

## Divergencias encontradas en el temario actual
- La ficha escribía el Gini como $G$: choca con el bien público $G$ del bloque (3.A.23, 3.A.24; Bowen en el mismo bloque III del 3.A.24). Canon **IG** (D9 del 3.A.24, pendiente de Víctor; IG es también lo que usaba el 4.B.3 original).
- La ficha decía que no había `.tex`: lo creó el 3.A.24 (`lorenz.tex`).
- Notación $CL_A$, $CL_D$ (4.B.3) e IG = 2 × área (coherente con IG); propuesta para el 4.B.3: $L_Y$, $L_{Y-T}$ y $C_T$ (concentración de la cuota), sobre el gráfico del 3.A.24.
