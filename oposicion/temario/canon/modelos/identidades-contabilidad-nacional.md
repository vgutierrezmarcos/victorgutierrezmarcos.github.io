# Sucesión de cuentas del SEC 2010 e identidades macroeconómicas

- **Área:** macro-cerrada (contabilidad nacional) · **Tema de referencia:** **3.A.30** («Magnitudes macroeconómicas y contabilidad nacional»), **revisado el 11/11/2026**: lo tiene en el título, es del 3.er ejercicio (CRITERIOS § 6.3) y es el único que desarrolla la sucesión **general** de cuentas, sus saldos y las identidades que salen de ellas (I.1.1 magnitudes y flujo circular; II, las 6 partes de la sucesión con un patrón fijo de 4 rótulos por cuenta; anexo `anexo:sucesion` con las 11 cuentas en T). El 4.B.1 la aplica al S.13 (ficha `sec-2010`) y el 3.B.11 desarrolla la cara exterior (ficha `identidad-balanza-pagos`). Ficha creada en la fase canon del 3.A.30 (CC1, D-15 de contenido, **[decidir]**: el id estaba en el mapa sin fichero).
- **Temas que lo usan:** 3.A.30 (desarrollo; hecho, 11/11/2026), 3.B.11 (resumen; hecho, 5/11/2026: `eq:rndb`, `eq:cc-ahorro-inversion`, la cuenta del resto del mundo con el signo cambiado, `tab:mbp6-sec2010`), 1D01 (uso; hecho: `sec:pib`, 3 vías, RNB y RNDB, PIB frente a RNB), 3.A.31 (resumen; hecho, 11/11/2026: `eq:pib-io` y el cuadre por las 3 vías), 4.B.1 (aplicación: sucesión de cuentas del S.13 y B.9 = déficit), 4.A.1 (resumen: operaciones estadísticas), 4.A.21 (uso: CC = S − I por sectores), 3.A.33 (mención; hecho: gasto en consumo final, vivienda = FBCF), 3.A.34 (mención; hecho: FBC con 3 partidas), 3.A.39 (mención; hecho: B.9 de las AAPP), 3.A.45 (mención; hecho: RA y renta mixta), 3.A.4 (mención; hecho: los agregados de Keynes), 3.A.1 (mención; hecho: la medición), 3.B.28 (mención; hecho: RNB per cápita).
- **Manuales de referencia:** Reglamento (UE) n.º 549/2013 (SEC 2010; clave común **`SEC2010`**), anexo A, caps. 1-3, 8, 9, 10, 11 y 13; Naciones Unidas *et al.*, SCN 2008 y SCN 2025; Lequiller y Blades, *Understanding National Accounts* (OCDE, 2.ª ed.; `LequillerBlades2018` en el 3.A.30); Eurostat, *Handbook on quarterly national accounts* (2013, `Eurostat2013QNA`); Blanchard, *Macroeconomics*, cap. 2; Muñoz Cidad *et al.* (`MunozCidadEtAl2020`, la del 3.A.31).

## Presentación de referencia

**Pregunta:** ¿cómo se pasa de lo que se produce a la renta, al ahorro y a la financiación, y qué magnitud mide cada paso?

**Supuestos (principios):** flujos y *stocks*; unidades institucionales y UAE locales (las del 3.A.31); **5 sectores** S.11 sociedades no financieras, S.12 instituciones financieras, S.13 AAPP (4 subsectores), S.14 hogares, S.15 ISFLSH, y el resto del mundo S.2 (gráfico `sectores-sec`); **partida cuádruple**, **devengo** (también los impuestos: caja ajustada en el tiempo), **valoración** a precios de mercado (precios básicos, de productor y de adquisición, con las palabras del 3.A.31; FOB en el comercio exterior), **residencia** (centro de interés económico predominante, con las 2 correcciones del 3.B.11: sucursales con producción significativa residentes; organismos internacionales, de ninguna economía). Los principios se formulan una vez frente al MBP6 en `tab:mbp6-sec2010` del 3.B.11; el 3.A.30 los ordena igual (registro, momento, valoración, residencia) y remite.

**Ecuaciones (notación canónica, `notacion.md` § 7, «Contabilidad nacional»):**
- Flujo circular (I.1.1): $Y\equiv\sum\mathrm{VAB}$, $Y\equiv\mathrm{RA}+\mathrm{EBE}$, $Y\equiv C+I$; $S\equiv Y-C\Rightarrow S\equiv I$ en la economía cerrada sin sector público.
- **`eq:cadena-agregados`** (función clave): $\mathrm{PIB}\xrightarrow{+\mathrm{RP}}\mathrm{RNB}\xrightarrow{+\mathrm{RS}}\mathrm{RNDB}\xrightarrow{-(C+G)}S\xrightarrow{-I+\mathrm{CK}}$ capacidad (+) o necesidad (−) de financiación. «Son identidades, no teorías.»
- `eq:valoracion`: $\mathrm{PIB}_{\mathrm{pm}}=\sum\mathrm{VAB}_{\mathrm{pb}}+(\text{impuestos}-\text{subvenciones})_{\text{productos}}$.
- **`eq:pib-tres-vias`** (función clave; la forma de la 1D01 con RA y los impuestos en palabras): $\mathrm{PIB}=\sum\mathrm{VAB}+(\text{imp.}-\text{subv.})_{\text{productos}}=\mathrm{RA}+\mathrm{EBE}+\mathrm{RMB}+(\text{imp.}-\text{subv.})_{\text{prod. e import.}}=C+I+G+(X-M)$; $C$ hogares e ISFLSH, $I$ = FBC (FBCF + existencias + objetos valiosos), $G$ consumo final de las AAPP (la inversión pública en $I$).
- `eq:rndb` (la del 3.B.11): $\mathrm{RNB}=\mathrm{PIB}+\mathrm{RP}$, $\mathrm{RNDB}=\mathrm{RNB}+\mathrm{RS}$; netos = brutos − CCF ($\mathrm{PIN}=\mathrm{PIB}-\mathrm{CCF}$).
- $S=\mathrm{RNDB}-C-G$; **`eq:ahorro-inversion`** (función clave): $S-I=(S_P-I_P)+(S_G-I_G)=\mathrm{CC}$, con nota frente al $(T-G)$ del 3.B.11; con transferencias de capital, B.9 de la nación $=\mathrm{CC}+\mathrm{CK}$; B.9 de las AAPP = déficit (PDE salvo *swaps*).
- Cuenta financiera: B.9F $=\mathrm{VNA}-\mathrm{VNP}$; la diferencia con el B.9 de la cuenta de capital es la discrepancia estadística (no hay «controversia»: SEC 2010, § 5.17 y § 1.126).
- `eq:balance` (en palabras): patrimonio neto$_t$ = patrimonio neto$_{t-1}$ + ahorro y transferencias de capital netas + otras variaciones; para el total, riqueza nacional neta $=K+\mathrm{PIIN}$ (sin letra; ficha `enfoque-hoja-balance`).
- Cuentas del resto del mundo con el **signo cambiado**: V.I (B.11 $=M-X$), V.II (B.12 $=-\mathrm{CC}$), V.III.1 (B.9 $=-(\mathrm{CC}+\mathrm{CK})$), V.III.2 (`tab:resto-mundo`).

**La sucesión** (II del 3.A.30, cada cuenta con 4 rótulos: qué registra, empleos y recursos, saldo, qué mide y para qué sirve): cuenta 0 de bienes y servicios (equilibrio entre oferta y usos, sin saldo; va antes de las corrientes) → producción (B.1g VAB/PIB) → explotación (B.2g EBE, B.3g RMB) → asignación de la renta primaria (B.5g saldo de rentas primarias; RNB en el total; B.4g renta empresarial) → distribución secundaria (B.6g RDB; RNDB en el total) → redistribución en especie (B.7g renta disponible ajustada bruta, RDBA; en el total, igual a la RNDB) → utilización de la renta (B.8g ahorro) → capital (B.9) → financiera (B.9F) → otras variaciones → balances (B.90 patrimonio neto). Cuadro sinóptico en `tab:sinoptica` del 3.A.30.

**Datos de referencia (España, 2025; los mismos en los temas que los usan):** PIB 1.690.012 millones (las 3 vías cuadran); RNB > PIB en un 0,2 %; RNDB 1.679.739 millones; ahorro nacional 25,0 % del PIB; capacidad de la nación 4,3 % (72.218 millones; por la cuenta financiera, 85.151), hogares 2,8, IF 2,7, SNF 1,2, AAPP −2,4 (2007: −9,0); participación del trabajo 48,4 % y 56,6 % ajustada (claves `INE2026CNA2025`, `Eurostat2026nasa10nftr`, `Eurostat2026nasa10ftr`, `CE2026AMECO`).

**Gráficos de referencia:** la **cascada de la sucesión de cuentas**, `fuentes/3A30/graficos/sucesion-cuentas.tex` (por capas, con la columna del resto del mundo con el «−»), y el **triángulo de las 3 vías**, `fuentes/3A30/graficos/triangulo-pib.tex`; de apoyo, `sectores-sec.tex` (árbol de sectores), `valoracion-precios.tex` (el mismo `.tex` que el 3.A.31), `capacidad-financiacion-sectores-espana.tex` (datos) y, en el 3.B.11, `fuentes/3B11/graficos/cuentas-nacionales-bp.tex` (de la absorción a la RNDB).

## Cómo se adapta en cada tema

| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.30 | Magnitudes y contabilidad nacional | Desarrollo (hecho, 11/11/2026) | Todo lo anterior | — |
| 3.B.11 | Balanza de pagos | Resumen (hecho) | `eq:rndb`, `eq:cc-ahorro-inversion` con $(T-G)$ y su aviso (C1, **[decidir]**), cuenta del resto del mundo con el signo cambiado, `cuentas-nacionales-bp` | La sucesión de cuentas |
| 1D01 | Dictamen de coyuntura | Uso (hecho) | 3 vías (con RA, no $W$: C2), RNB y RNDB, PIB frente a RNB, cómo leer sus diferencias | Los principios y las cuentas |
| 3.A.31 | Tablas *input-output* | Resumen (hecho) | `eq:pib-io` y el cuadre por las 3 vías en las tablas de origen y destino | La sucesión de cuentas |
| 4.B.1 | Sector público según el SEC | Aplicación | Delimitación del S.13 y su sucesión; B.9 = déficit; `\vertema{3.A.30}` para la general (ficha `sec-2010`) | Las cuentas de los demás sectores, las imágenes de la sucesión general |
| 4.A.1 | Fuentes estadísticas | Resumen | Operaciones del INE (CNA, CNTR, revisiones; la base actual, **[verificar]** al revisarlo: el Word dice «base 2010») | La derivación |
| 4.A.21 | Sector exterior de España | Uso | CC = S − I por sectores con datos de España | La derivación |
| 3.A.33 / 3.A.34 | Consumo / inversión | Mención (hechos) | $C$ y FBC del SEC; vivienda = FBCF | Las cuentas |
| 3.A.39 | Déficit y deuda | Mención (hecho) | B.9 de las AAPP = déficit del PDE | Las cuentas |
| 3.A.45 | Distribución factorial | Mención (hecho) | RA, renta mixta, participación ajustada | Las cuentas |

## Divergencias encontradas en el temario actual

- **Resueltas en el 3.A.30 (11/11/2026)**: el Word daba VAB y PIB «a precios de adquisición», 2 definiciones contradictorias de precios básicos, «Salarios (W) + Rentas (O.I.P.) + Beneficios», «RNBD», la C.II.4.1 mal titulada (RNDB en un sector), FBC sin objetos valiosos, marcas como intangibles producidos, la «controversia» del saldo de la cuenta financiera, la economía sumergida «excluida».
- **3.B.11 y `notacion.md` § 9** (hecho): en `eq:cc-ahorro-inversion`, $G$ es consumo público en $A=C+I+G$ y gasto público total en $(T-G)$; el 3.A.30 escribe $(S_G-I_G)$ con nota (C1, `pendientes-coherencia.md`, **[decidir]**).
- **1D01** (aprobada): $W$ para la remuneración total y $(T-Sub)$ en el PIB por la renta (C2); «RNB < PIB, típico de un deudor neto» (en 2025 España, deudora neta, tiene RNB > PIB) (`pendientes-coherencia.md`).
- **4.B.1** (Word, sin revisar): copia la sucesión general con las mismas imágenes y remite a «3.A.26»: al revisarlo, solo el S.13 y `\vertema{3.A.30}`.
- **3.A.30** (hecho): escribe $Y\equiv\sum\mathrm{VA}$ en I.1.1 (l. 127); el canon dice VAB (pendiente cosmético).

Autor: Víctor Gutiérrez Marcos
