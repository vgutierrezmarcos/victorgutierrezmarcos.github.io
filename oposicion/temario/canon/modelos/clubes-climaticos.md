# Clubes climáticos (Nordhaus, 2015) y acuerdos autoaplicables (Barrett, 1994)

- **Área:** mercados, información y juegos (aplicación a organismos y acuerdos internacionales) · **Tema de referencia:** **3.B.31** (revisado el 31/10/2026, III.2 «El problema de la cooperación internacional»: el dilema entre países, la paradoja de Barrett y «Los clubes climáticos de Nordhaus» con a)-e)). Ficha creada en la fase canon del 3.B.31 (CC2; duda B31-02 del tema, **[decidir]**: se ha aplicado la opción recomendada, crear la ficha; la alternativa era llevar los clubes a un apartado de la ficha `cbam`).
- **Temas que lo usan:** 3.B.31 (desarrollo; hecho, 31/10/2026), 3.A.23 (mención; hecho, 21/10/2026: conclusión, «para el clima se proponen "clubes" con un arancel a quien no participa», `Nordhaus2015Climate`, «en la línea del MAFC europeo»), 3.B.19 (mención prevista: el Club del Clima del G-7 como foro de coordinación, sin aranceles; el 3.B.31 ya le remite), 3.B.41 (mención prevista: el MAFC frente al club), 3.B.33 (mención prevista: el arancel uniforme del club choca con la nación más favorecida). El 3.A.14 no lo usa: aporta la matriz y el gatillo.
- **Manuales de referencia:** Barrett (1994), *Oxford Economic Papers* (`Barrett1994Self`); Barrett (2003), *Environment and Statecraft*; Carraro y Siniscalco (1993); Nordhaus (2015), «Climate Clubs», *AER* (`Nordhaus2015Climate`); Buchanan (1965) para la teoría de los clubes; declaración del G-7 de 12/12/2022 (`G72022ClimateClub`).

## Presentación de referencia (3.B.31, III.2)

**Pregunta:** ¿cómo se sostiene un acuerdo climático sin un gobierno mundial que lo haga cumplir (el «dilema de Westfalia» de Nordhaus)?

**El dilema entre países** (`tab:dilema-clima`): 2 países, estrategias con palabras, **Reducir / Emitir** (nunca A/B ni C/D), con **los mismos pagos que la guerra de precios del 3.A.14** (`tab:dilema-prisionero`: 5, 6, 0, 1), mejores respuestas subrayadas y el equilibrio sombreado:

| | Reducir | Emitir |
|---|---|---|
| **Reducir** | (5, 5) | (0, 6) |
| **Emitir** | (6, 0) | **(1, 1)** |

Emitir es dominante; (Emitir, Emitir) es el único equilibrio de Nash: la versión de 2 países del equilibrio $E^{\mathrm N}$ del gráfico de las emisiones óptimas (`fig:emisiones-optimas`, ficha `samuelson-bienes-publicos`). Repetido sin fin, el gatillo sostiene Reducir si $\beta\ge(u^{\mathrm D}-u^{\mathrm C})/(u^{\mathrm D}-u^{\mathrm N})=(6-5)/(6-1)=1/5$ (`eq:gatillo` del 3.A.14), pero con el clima la amenaza es poco creíble (casi 200 países, castigar daña al que castiga, gobiernos que no verán los beneficios).

**Acuerdos autoaplicables (Barrett, 1994):** a ningún firmante le compensa salir ni a ningún país de fuera entrar; esos acuerdos solo reúnen a muchos cuando lo que se gana es poco (**paradoja de Barrett**; Carraro y Siniscalco, 1993). Contraejemplo: el Protocolo de Montreal (pocos productores, sustitutos baratos, fondo y restricciones comerciales a los no firmantes).

**El club, con a)-e):**
- a) **Idea**: Buchanan (1965): un club se sostiene si su ventaja es excluible; el clima no lo es, el comercio sí. El club ata el comercio sin trabas a la reducción.
- b) **Modelo**: precio mínimo común del carbono y **arancel de castigo uniforme** a todas las importaciones de los no miembros. En el ejemplo, quien emite paga un arancel de 3 al exportar a quien reduce; solo cambian las 2 celdas de fuera de la diagonal (`tab:club-clima`):

| | Reducir | Emitir |
|---|---|---|
| **Reducir** | **(5, 5)** | (0, 3) |
| **Emitir** | (3, 0) | **(1, 1)** |

  El dilema pasa a ser un **juego de coordinación** con 2 equilibrios de Nash; basta con que un grupo grande empiece. El castigo es creíble porque no pasa por el clima. En nota: si el que reduce se quedara con lo recaudado (0 → 3), Reducir sería dominante (D6 del 3.B.31: el club no se queda el arancel, el caso prudente).
- c) **Extensiones (C-DICE, Nordhaus, 2015)**: sin sanciones, ninguna coalición estable reduce mucho; con 12,5 o 25 $/t, un arancel ≥ 2 % basta para que participen todos; con 50 $/t, un arancel ≥ 5 % logra más del 90 % de la ganancia; con 100 $/t, poco. Funciona con precios moderados.
- d) **Evidencia**: ningún club con aranceles en funcionamiento; Montreal es lo más cercano; el «Club del Clima» del G-7 (12/12/2022) es un foro sin aranceles.
- e) **Valoración**: la propuesta más influyente de la década; choca con la nación más favorecida de la OMC (`\vertema{3.B.33}`) y se presta a represalias. **El MAFC no es un club** (ficha `cbam`): comparte la lógica (acceso al mercado a cambio de pagar el carbono), pero solo iguala el precio del carbono de unos pocos bienes y no castiga la no participación como tal.

**Gráfico de referencia:** las 2 tablas en LaTeX (`tab:dilema-clima` y `tab:club-clima` del 3.B.31). En la pizarra se escribe la primera y, para el club, se tachan y reescriben las 2 celdas de fuera de la diagonal (no se dibuja una segunda tabla).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.31 | Acuerdos internacionales | desarrollo (hecho, 31/10/2026) | Dilema con los pagos del 3.A.14, gatillo, Barrett y Montreal, club con a)-e) y su tabla, comparación con el MAFC | — |
| 3.A.23 | Bienes públicos globales | mención (hecho, 21/10/2026) | Clubes con un arancel a quien no participa (Nordhaus, 2015); remisión al MAFC con `\vertema{3.B.31}` (hoy remite al 4.A.6: `pendientes-coherencia.md`) | Las tablas |
| 3.B.19 | Coordinación internacional (G-20, OCDE) | mención | El Club del Clima del G-7 como foro sin aranceles; el club de Nordhaus como forma de coordinación; `\vertema{3.B.31}` | Las tablas |
| 3.B.41 | Política comercial de la UE | mención | El MAFC frente al club: iguala el precio del carbono, no castiga la no participación | El juego |
| 3.B.33 | OMC | mención | El arancel uniforme del club frente a la nación más favorecida y al art. XX | El juego |

## Divergencias encontradas en el temario actual
- **Tebar** (referencia de estructura del 3.B.31): el MAFC «es un arancel… fundado en los clubes de Nordhaus»; pagos del dilema 2, 3, −1, 0 con A y B. Corregido en el 3.B.31: el MAFC es un ajuste que iguala el precio del carbono, y el dilema usa los pagos y las palabras del 3.A.14.
- Las cifras del C-DICE que daban los apuntes (50 $ y 5 %) son solo uno de los casos; las 4 del 3.B.31 están comprobadas en el resumen de la *AER*.

Autor: Víctor Gutiérrez Marcos
