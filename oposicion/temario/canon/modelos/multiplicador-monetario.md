# Creación del dinero y multiplicador del dinero (de la base)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.36** (Política monetaria (I). El diseño y la instrumentación; revisado el 4/11/2026: II.1 `sec:creacion-dinero` con «los préstamos crean depósitos» y `tab:creacion-dinero`, II.2 `sec:balances` con `eq:multiplicador-dinero`, y anexo A `anexo:multiplicador`, balances y expansión banco a banco), **[decidir]** (CC2 y D6 de la coherencia del 3.A.36; *alternativa* de id: `creacion-dinero`, que queda como alias). Motivo: el proceso de creación del dinero es parte de la instrumentación, que está en el título; el 3.A.5 usa los cocientes en la Gran Contracción y los temas de economía abierta, de historia y de la UE lo mencionan. Ficha creada en la fase canon del 3.A.36 (el id ya estaba en la lista del tema, en `_inventario/areas.json` y en `notacion.md` § 1, filas M y e, sin ficha).
- **Temas que lo usan:** 3.A.36 (desarrollo; hecho, 4/11/2026), 3.A.5 (mención; hecho, 3/11/2026: III.1.4, l. 547, la Gran Contracción con los cocientes depósitos/efectivo 10,8 → 4,4 y depósitos/reservas 13,1 → 9,1, sin letras, `\vertema{3.A.36}`; ficha `historia-monetaria-friedman-schwartz`), 3.A.35 (mención: la oferta de dinero frente a la demanda; sin revisar), 3.A.37 (mención: las compras de activos crean reservas, no préstamos; sin revisar), 3.B.12 y 3.B.20 (mención: hoy «multiplicador igual a uno, i.e. q = 1»; sin revisar), 3.B.43 (mención: el SEBC y sus instrumentos; sin fuente), 4.A.19 (mención: las entidades de crédito y las reservas; sin revisar). **No lo usa** el 3.A.39 (revisado), donde $M_t$ es la base monetaria en la restricción del sector público y el señoreaje, sin bancos (lo dice el tema, l. 105): no hay choque, porque allí no hay depósitos. Relacionadas: `historia-monetaria-friedman-schwartz`, `is-lm` (el otro «multiplicador monetario», $dY/dM$), `teoria-cuantitativa`, `monetarismo`.
- **Manuales de referencia:** McLeay, Radia y Thomas (2014), «Money Creation in the Modern Economy», *Bank of England Quarterly Bulletin* Q1 (`McLeayRadiaThomas2014Money`; nunca «McLeay y Radia»); Mishkin, Matthews y Giuliodori (2013), *The Economics of Money, Banking and Financial Markets* (`MishkinMatthewsGiuliodori2013`); Friedman y Schwartz (1963) (`FriedmanSchwartz1963Monetary`) para la Gran Contracción; Walsh (2017), cap. 11.

## Presentación de referencia (3.A.36, II.1, II.2 y anexo A)

**Pregunta:** ¿quién crea el dinero y qué controla de verdad el banco central?

1. **Cómo se crea el dinero hoy** (II.1; McLeay, Radia y Thomas, 2014): la mayor parte del dinero son depósitos, y **los préstamos crean depósitos**: al conceder un préstamo nacen a la vez un activo y un pasivo del banco (`tab:creacion-dinero`, 2 cuentas en T, banco y hogar; el balance del banco central no cambia); el dinero se destruye al devolver el préstamo; las reservas se adaptan a los préstamos y no al revés: el banco central fija su **precio**. Tres límites: rentabilidad y riesgo (con capital y liquidez, `\vertema{3.B.27}`), lo que hacen hogares y empresas, y el tipo del banco central. **El dinero es endógeno.** Cifras: depósitos, el 97 % del dinero amplio **en el Reino Unido**; efectivo, el 9 % de M3 en la zona del euro (septiembre de 2026).
2. **El multiplicador** (II.2), con siglas en redonda y cocientes con subíndice:

$$\mathrm{BM}=\mathrm{Ef}+\mathrm{Res},\qquad M=\mathrm{Ef}+\mathrm{Dep},\qquad c_E\equiv\frac{\mathrm{Ef}}{\mathrm{Dep}},\quad c_R\equiv\frac{\mathrm{Res}}{\mathrm{Dep}},\qquad M=\frac{1+c_E}{c_E+c_R}\;\mathrm{BM}\quad\texttt{(eq:multiplicador-dinero)}$$

**El multiplicador no lleva letra** (se escribe la fracción); $c_R$ recoge las reservas mínimas y las voluntarias. Es una **identidad contable**: cae si el público quiere más efectivo ($\partial/\partial c_E<0$) o los bancos más reservas ($\partial/\partial c_R<0$; derivadas en el anexo A). **Se llama «multiplicador del dinero» (de la base)** y el tema avisa de que no es el multiplicador de la política monetaria del IS-LM del 3.A.5 (`eq:multiplicador-monetario`, $\partial Y^*/\partial(M/P)$, ficha `is-lm`).
3. **La Gran Contracción** (1929-1933, Friedman y Schwartz, 1963): la base subió un 17,5 % y el dinero cayó en torno a un tercio, porque el multiplicador pasó de **6,5 a 3,6** (un 44 %): $c_E$ de 0,093 a 0,227 (depósitos/efectivo 10,8 → 4,4) y $c_R$ de 0,076 a 0,110 (depósitos/reservas 13,1 → 9,1), las mismas cifras que el 3.A.5 (ficha `historia-monetaria-friedman-schwartz`).
4. **Identidad, no mecanismo**: con reservas abundantes y un sistema de suelo, el banco central presta las reservas que se le piden al tipo que fija; la cantidad la decide la demanda de crédito. En la zona del euro, las reservas mínimas son del 1 % desde el 18/1/2012 y se remuneran al 0 % desde el 20/9/2023.
5. **Anexo A**: balances del banco central, de los bancos y del sistema monetario consolidado (`tab:balances`: al consolidar se cancelan las reservas y los préstamos del banco central; el pasivo de los bancos frente al banco central son esos préstamos); la expansión banco a banco sin efectivo, $\mathrm{Dep}=\mathrm{BM}/c_R$ (`tab:expansion`, con $c_R=10$ %), y con efectivo; por qué no describe hoy la realidad.

**Notación que no se usa** (`notacion.md` § 1 y § 8): **ni** $q$ (producción, tipo de cambio real), **ni** $e$ (logaritmo del tipo de cambio), **ni** $E$ (función de gasto, tipo de cambio), **ni** $R$ y $D$ (puntos de Barro-Gordon en el mismo tema, deuda pública), **ni** $b\equiv1/q$ (sensibilidad de la inversión del IS-LM, que usa Poole en el mismo tema), **ni** $H$ (*high-powered money*, que choca con la $H$ de la regla mixta de Poole), **ni** $M_0$, $M_1$ en cursiva: los agregados se escriben **M1, M2, M3** en redonda (anexo B del 3.A.36, `tab:agregados`, sin M4, que es del Reino Unido).

**Gráfico de referencia:** ninguno; tablas de referencia `tab:creacion-dinero` (cuentas en T, **la que se dibuja en la pizarra**), `tab:balances` y `tab:expansion` del 3.A.36.

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.36 | Instrumentación | desarrollo (hecho, 4/11/2026) | II.1 (1′30″, la tabla en T y los 3 límites), II.2 (1′, `eq:multiplicador-dinero` de palabra, la Gran Contracción en una frase, identidad y no mecanismo); anexos A y B | — |
| 3.A.5 | Monetarismo: la Gran Depresión | mención (hecho, 3/11/2026) | Los 2 cocientes y la base que no cae, en palabras; `\vertema{3.A.36}` | La fórmula |
| 3.A.35 | Demanda de dinero | mención | La oferta de dinero, endógena, con `eq:multiplicador-dinero` en una línea si hace falta; `\vertema{3.A.36}` | Los balances |
| 3.A.37 | Transmisión | mención | Las compras de activos crean reservas; el dinero de hogares y empresas solo crece si los bancos prestan más (anexo E del 3.A.36) | — |
| 3.B.12, 3.B.20 | Ajuste de la balanza de pagos (enfoque monetario); patrón oro y sistema internacional hasta Bretton Woods | mención | Con esta notación (sin $q$): el ajuste automático con reservas que mueven la base y el dinero; `\vertema{3.A.36}` | — |
| 3.B.43, 4.A.19 | El origen del euro; entidades de crédito en España | mención | Reservas mínimas (1 % desde 2012, 0 % de remuneración desde el 20/9/2023), exceso de liquidez; `\vertema{3.A.36}` | El multiplicador |

## Divergencias encontradas en el temario actual

- **Resuelto en el 3.A.36 (4/11/2026)**: el Word escribía el multiplicador con $E$, $e$, $q$, $b$, $M_0$, CI, AG, ASP, RI, decía «el pasivo representa M1» y que el pasivo de los bancos frente al banco central eran «activos frente al sector privado»; «reservas legales remuneradas y voluntarias no remuneradas»; el «97 % de M4» sin decir que era el Reino Unido, con una tabla de agregados con M4; «McLeay y Radia (2014)».
- **3.B.12 y 3.B.20 (sin revisar)**: llaman $q$ al multiplicador («igual a uno, i.e. q = 1») y remiten al 3.A.36: al revisarlos, esta notación (sin letra para el multiplicador).
- **3.A.5 (revisado)**: `eq:multiplicador-monetario` es allí el multiplicador de la política monetaria del IS-LM ($dY/dM$), no el del dinero. No es un error; el 3.A.36 dice «multiplicador del dinero» y avisa de la diferencia, y la ficha `is-lm` lo anota. Sin cambio en el 3.A.5.

Autor: Víctor Gutiérrez Marcos
