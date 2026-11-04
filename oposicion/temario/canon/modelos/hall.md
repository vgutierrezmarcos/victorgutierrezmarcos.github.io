# Paseo aleatorio del consumo (Hall, 1978), su contrastación (Flavin, 1981; Campbell y Mankiw, 1989; Deaton, 1987) y las salidas

- **Área:** macro cerrada · **Tema de referencia:** **3.A.33** (revisado el 31/10/2026: II.1 `sec:hall`, II.2 `sec:contrastacion`, II.3 `sec:salidas`; derivaciones en el anexo C `anexo:hall-ccapm`) — único tema que lo desarrolla, con su contrastación; la Euler estocástica es la base del C-CAPM (ficha `ccapm`).
- **Temas que lo usan:** 3.A.33 (desarrollo; hecho, 31/10/2026), 3.A.10 (mención; hecho, 19/10/2026: con cuadrática, u‴ = 0 y sin precaución, `\vertema{3.A.33}`), 3.A.6 (mención; hecho, 4/11/2026: I.2 iii, el consumo como paseo aleatorio, Hall, 1978; II.2.3 iii, la Euler no depende de la política y se estima directamente, Hall, 1978, y Hansen y Singleton, 1983; `\vertema{3.A.33}`), 3.A.39 (mención: λ de Campbell y Mankiw entre las razones del incumplimiento de la equivalencia ricardiana), 3.A.42 (hecho, 4/11/2026, ver la tabla; mención: hábitos en los EGDE), 1D01 (mención aplicada; hecho: «otro enfoque», l. 428).
- **Manuales de referencia:** Hall (1978), *JPE*; Flavin (1981), *JPE*; Campbell y Mankiw (1989), *NBER Macro Annual*; Campbell y Deaton (1989), *REStud*; Deaton (1987, 1992); Romer (2019), cap. 8; Blanchard y Fischer (1989), cap. 6; Jappelli y Pistaferri (2017), *The Economics of Consumption*.

## Presentación de referencia (3.A.33, II)

Pregunta: ¿qué implica la renta permanente con incertidumbre y expectativas racionales para la dinámica del consumo? Conclusión anticipada: solo las noticias cambian el consumo, que sigue un paseo aleatorio; los datos no lo confirman del todo y las salidas devuelven a la renta corriente parte del papel que le daba Keynes.

- **II.1 Hall** (a)-c)). Supuestos: horizonte indefinido, utilidad esperada (`\vertema{3.A.10}`), expectativas racionales (`\vertema{3.A.6}`), aditiva con β ≡ 1/(1+ρ), **cuadrática u(C_t) = C_t − (b/2)C_t², b > 0** (nota: b no es b_t), un activo sin riesgo, no-Ponzi y β(1+r) = 1. Problema (`eq:problema-hall`, con `\optim`):
$$\max_{\{C_t\}}\ \mathbb{E}_0\Big[\sum_{t=0}^{\infty}\beta^t u(C_t)\Big]\quad\text{s.a.}\quad b_{t+1}=(1+r)\,b_t+Y_t-C_t,\qquad \lim_{T\to\infty}\frac{b_T}{(1+r)^T}\ge0,\qquad b_0\ \text{dado}$$
  **Euler estocástica** (`\funcionclave` `eq:euler-estocastica`, la `eq:euler` de Fisher con esperanzas):
$$u'(C_t)=\beta\,(1+r)\,\mathbb{E}_t\big[u'(C_{t+1})\big]$$
  en 3 pasos: u′ martingala (β(1+r) = 1); u′ lineal, 𝔼_t[C_{t+1}] = C_t; error de predicción:
$$C_{t+1}=C_t+\varepsilon_{t+1},\qquad \mathbb{E}_t[\varepsilon_{t+1}]=0\qquad(\texttt{eq:hall})$$
  (nota: martingala frente a paseo aleatorio y AR(1)). Solución cerrada con T finito y r = ρ = 0 en el anexo C: C_t − C_{t−1} es la revisión de las expectativas de renta repartida entre los periodos que quedan. Implicaciones: el cambio del consumo no se predice (se contrasta sin modelizar la renta); solo importan las sorpresas (una medida mueve el consumo al anunciarse); las permanentes pesan más; crítica de Lucas (`\vertema{3.A.6}`). Valoración: la cuadrática (u′ puede ser negativa, IARA, u‴ = 0) y los demás supuestos.
- **II.2 Contrastación**: exceso de sensibilidad (Hall, 1978; Flavin, 1981); **Campbell y Mankiw** (`eq:campbell-mankiw`):
$$\Delta C_t=\mu+\lambda\,\Delta Y_t+\varepsilon_t,$$
  λ fracción de la renta de hogares que consumen su renta corriente (avisada: no es un multiplicador), λ ≈ 0,5 (0,35-0,7) con VI; **exceso de suavidad o paradoja de Deaton** (cambios **inesperados**; la renta permanente varía casi el doble que la corriente; Campbell y Deaton, 1989; Deaton, 1987, 1991); datos de hogares (Shea, 1995; Parker, 1999; Souleles, 1999; Hsieh, 2003, Alaska; cheques de 2001 y 2008; *hand-to-mouth*); España (Núñez Carrasco, Basso y Gómez-García, Bover, deducción de 400 euros de 2008, tasa de ahorro de 2020).
- **II.3 Salidas**, sobre la Euler de la pizarra, numeradas (plan de pizarra de Víctor, `notaopositor`): 1) la utilidad: **prudencia** (ficha `ahorro-precaucion`) y **hábitos**, u(C_t − hC_{t−1}), con X_t ≡ C_t − hC_{t−1} martingala y ΔC_{t+1} = hΔC_t + ε_{t+1} (exceso de suavidad; h ≈ 0,6 agregado y ≈ 0,1 en hogares, Havranek *et al.*, 2017); 2) el tipo: **r ≠ ρ** con CRRA, C_2/C_1 = [β(1+r)]^{1/θ}, ESI = 1/θ, efectos sustitución, renta y riqueza sobre el gráfico de Fisher (ficha `fisher-intertemporal`), y **C-CAPM** (ficha `ccapm`); 3) la restricción: **liquidez** (ficha `restricciones-liquidez`) y renta endógena (`\vertema{3.A.25}`); 4) el agente: hogares heterogéneos y HANK; 5) la optimización: economía conductual (reglas prácticas, descuento cuasihiperbólico en nota, ficha `descuento-hiperbolico`; cuentas mentales). Cierra con Mankiw (1982), puente a los duraderos (ficha `bienes-duraderos`).
- **Síntesis de implicaciones de todo el tema**: `tab:implicaciones` (III.3 c): por teoría, de qué depende el consumo y el efecto de una rebaja transitoria, de una medida anunciada y del tipo de interés.

**Gráficos de referencia** (`oposicion/temario/fuentes/3A33/graficos/`): ninguno propio de Hall (en la pizarra, el problema y la Euler estocástica, que se quedan hasta el final de II); las salidas usan `fisher-tipo-interes.tex`, `fisher-liquidez.tex` y `precautorio.tex`; datos: `tasa-ahorro-hogares.tex`.

**Notación:** C_t mayúscula; 𝔼_t (§ 0); u minúscula y U_0 la intertemporal; **b** de la cuadrática (como el 3.A.10, `tab:prudencia`) frente a b_t activos, avisado (DC5/A33-05, **[decidir]**); ε_{t+1}; λ y μ de Campbell y Mankiw locales y avisados; h de los hábitos local (h es capital humano en el 3.A.25; no conviven); θ y 1/θ (D001).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.33 | Teorías del consumo | desarrollo (hecho, 31/10/2026) | Todo lo anterior: II.1 en 3′, II.2 en 2′30″, II.3 en 5′30″ | — |
| 3.A.10 | Incertidumbre y aversión al riesgo | mención (hecho, 19/10/2026) | Con u cuadrática no hay ahorro precautorio y el consumo de Hall sigue un paseo aleatorio sin motivo precaución; con u‴ > 0, sí | Derivación |
| 3.A.6 | Nueva macroeconomía clásica | mención (hecho, 4/11/2026) | Expectativas racionales aplicadas al consumo (paseo aleatorio, I.2); la Euler como respuesta a la crítica de Lucas, con Hansen y Singleton (1983) (II.2.3); `\vertema{3.A.33}` | El modelo |
| 3.A.39 | Déficit | mención (hecho, 4/11/2026) | λ de Campbell y Mankiw entre las razones del incumplimiento de la equivalencia ricardiana, con `\vertema{3.A.33}`; el tipo impositivo de la suavización sigue un paseo aleatorio «como el consumo de Hall» | — |
| 3.A.42 | Ciclos | mención (hecho, 4/11/2026; II.2.3, hábitos en los modelos medianos con `\vertema{3.A.33}`; la ESI cerca de cero con Hall, 1988, en la valoración del ciclo real) | Hábitos en los EGDE (Christiano, Eichenbaum y Evans, 2005) | — |
| 1D01 | Dictamen | mención aplicada (hecho) | Paseo aleatorio como «otro enfoque» | — |

## Divergencias encontradas en el temario actual
- 3.A.33 original: ecuación al revés (C_t = C_{t+1} + ε′) y horizonte mezclado; cuadrática con a; tabla sin Kimball; implicaciones vacías; Deaton con cambios «no inesperados»; «Mankiw y Campbell». **Resuelto** (31/10/2026): cuadrática con **b** (cambia la ficha, que decía a), `eq:problema-hall` con no-Ponzi, Euler estocástica como función clave, Kimball y la redacción del 3.A.10.
- 3.A.38 (sin revisar): Campbell y Mankiw sin λ ni remisión al 3.A.33. **3.A.39 resuelto** (4/11/2026).

Autor: Víctor Gutiérrez Marcos
