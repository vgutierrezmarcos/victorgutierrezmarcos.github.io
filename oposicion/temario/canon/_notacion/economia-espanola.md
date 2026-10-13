# Notación: economia-espanola (4.A)

El 4.A es descriptivo; la notación aparece en las identidades contables, las tasas del mercado de trabajo, la descomposición del PIB per cápita, la convergencia y los indicadores de competitividad. Fichas: `descomposicion-pib-per-capita`, `epa`, `ipc`, `balanza-pagos-espana`, `doom-loop`, `sistema-financiero-espanol`, `historia-economica-espana`, `instrumentos-apoyo-internacionalizacion` (y, de otras áreas, `convergencia-beta-sigma`, `identidad-balanza-pagos`, `indices-precios`, `tipo-cambio-real`).

## Tabla de símbolos

| Símbolo | Significado | Alternativas en el temario (temas) | Propuesta | Motivo |
|---|---|---|---|---|
| $Y$ | PIB real (renta total) | $X$ (4.A.1, producción) | $Y$ | Canon macro; $X$ es exportaciones |
| $N$ | Población total | $POB$ (4.A.17), $N$ (4.A.29) | **[decidir]** $N$ | Manuales y área macro; $POB$ no es un símbolo |
| $P_{16}$ | Población de 16 y más años | no existe; se mezcla con población total y con 16-64 (4.A.16, 4.A.17, 4.A.29) | $P_{16}$ (y $P_{16\text{-}64}$ si se usa) | Definición EPA |
| $A$ | Población activa | $A$ (4.A.29); $A$ también población (4.A.29, según el inventario) y cuota de amortización (4.A.20) | $A$ = activos; la cuota de amortización en 4.A.20 con otra letra ($a_t$) | Choque dentro del área |
| $L$ | Ocupados | $L$ (4.A.17, 4.A.29); a veces «población» (4.A.29) | $L$ | Canon macro (trabajo) |
| $U$, $u$ | Parados y tasa de paro $u=U/A$ | sin símbolo | $U$, $u$ | Canon del área de mercado de trabajo (3.A.26-3.A.28) |
| $PAT$ | Productividad aparente del trabajo $Y/L$ | igual en 4.A.17, 4.A.22, 4.A.29 | $PAT=Y/L$ | Ya común |
| $y$ | PIB per cápita $Y/N$ | $y$ (4.A.17); $Y/N$ | $y=Y/N$ | Canon de crecimiento |
| $\gamma_X$ | Tasa de crecimiento de $X$ | $\gamma$ (4.A.17, 4.A.22, 3.A.45) | $\gamma_X$ | Ya común con 3.A.45 |
| $\sigma_t$ | Dispersión (desviación típica) de $\ln y$ entre regiones | $\sigma^2_{y,t}$ (4.A.17, 3.B.40) | **[decidir]** $\sigma_t$ de $\ln y$ (Sala-i-Martín) | Ficha `convergencia-beta-sigma` |
| $CC, CK, CF, EO$ | Cuentas corriente, de capital, financiera; errores y omisiones | igual (4.A.1, 4.A.21-4.A.23, 3.B.11) | Igual | Ya común |
| $CF^{\text{exc. BdE}}$, $CF^{\text{BdE}}$ | Cuenta financiera sin y con el Banco de España | $SNC^{*}$ / $SNC$ (4.A.1: «sin/con BdE»; 4.A.21: «sin/con reservas») y $\Delta R$ | **[decidir]** $CF^{\text{exc. BdE}}$ y $CF^{\text{BdE}}$ (incluye TARGET2) | En la UEM el BdE no es solo reservas |
| $S_{nac}$, $I_{nac}$ | Ahorro e inversión nacionales | $S_{NAC}$, $I_{NAC}$ (4.A.21, 4.A.22) | La del área macro-abierta (3.B.11) | Un solo canon |
| $PIIN$ | Posición de inversión internacional neta | «Posición Inversora Internacional» (4.A.21) | $PIIN$ («de Inversión») | Denominación del BdE |
| $X_i$, $M_i$ | Exportaciones e importaciones del sector o producto $i$ | $X$, $M$ (4.A.1, 4.A.13, 4.A.22); $IE$ (4.A.13) | $X_i$, $M_i$ | Canon de comercio |
| $GL$ | Índice de Grubel-Lloyd $GL=1-\frac{\sum_i\lvert X_i-M_i\rvert}{\sum_i(X_i+M_i)}$ | igual (4.A.22) | $GL$ | Teoría en 3.B.6; desarrollo aplicado en 4.A.22 |
| $IE$ / $VCR$ | Índice de especialización (ventaja comparativa revelada de Balassa) | $IE$ (4.A.13) | $VCR_i=\frac{X_i/X}{X_i^{UE}/X^{UE}}$ | Nombre estándar; desarrollo en 4.A.22 |
| $SCR_i$ | Saldo comercial relativo $\frac{X_i-M_i}{X_i+M_i}$ | igual (4.A.22) | $SCR_i$ | — |
| $ITC$, $TCER$ | Índice de Tendencia de Competitividad / tipo de cambio efectivo real (subida = pérdida de competitividad en el ITC del Ministerio) | ponderaciones $\beta_i$ (4.A.22) | Ponderaciones $\omega_i$ | $\beta$ choca con la convergencia y el factor de descuento |
| $CLU$ | Coste laboral unitario $w/PAT$; $\gamma_{CLU}=\gamma_w-\gamma_{PAT}$ | $w_{nom}$ (4.A.22) | $w$ salario nominal por ocupado | Canon: $w$ salario |
| $\omega_{i,t-1}$ | Ponderación del bien $i$ en el IPC | $w_{i0}$ (4.A.1) | $\omega_{i,t-1}$ | $w$ es salario (ficha `indices-precios`) |
| $r$ | Tipo de interés | $\hat r$, $r_1$, $r_2$, $r^d$ con significados distintos en cada modelo (4.A.20) | Aceptable con aviso; seguir las fichas `stiglitz-weiss` y `diamond-dybvig` | — |

## Definiciones que hoy cambian de un tema a otro
- **Tasa de actividad**: activos/(población 16-64) en 4.A.16 y 4.A.29 (con valores de 16 y más) frente a la EPA (16 y más). Propuesta: EPA.
- **Tasa de ocupación/empleo**: $L/N$ en 4.A.17 frente a $L/P_{16}$ en la EPA. Propuesta: «ocupados por habitante» para $L/N$.
- **Descomposición del PIB per cápita**: dos factores (4.A.17) frente a tres (4.A.29). Propuesta: cuatro factores (ficha).

## Choques con otras áreas
- $A$ (activos) frente a $A$ (productividad total de los factores en crecimiento, 3.A.43-3.A.45): en 4.A.17/4.A.30 se usan juntas si se combina con contabilidad del crecimiento. **[decidir]** mantener $A$ = activos en el 4.A (es la notación de los manuales de economía española) y escribir la PTF como $PTF$ cuando aparezcan juntas.
- $\beta$ y $\sigma$: ver `_notacion/union-europea.md`.
- $X$ (producción en 4.A.1, factor de eficiencia en 4.A.12) frente a $X$ exportaciones: quitar los dos primeros usos.
