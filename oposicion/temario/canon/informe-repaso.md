# Informe del repaso general del temario (consolidación del canon)

Para Víctor. 13 oct. 2026. Resultado de la consolidación inicial del canon (`/revisartema --canon`): inventario de los 146 temas, fichas de modelos, notación por áreas y mapa de conexiones. Las decisiones están en `decisiones.json` (ids `D001`…`D139`); aquí se agrupan por áreas y se remite a esos ids.

**Estado (13/10/2026): Víctor ha aprobado las 133 decisiones**, todas con la opción recomendada salvo **D088** (RBC con política fiscal: tema de referencia **3.A.38**, no 4.B.4) y **D069, D075, D094 y D120**, que se desarrollan **en los dos ejercicios** (efectos no keynesianos: 3.A.39 y 4.B.4; curva de Lorenz e índice de Atkinson: 3.A.24 y 4.B.3; recuento de Borda: 3.A.24 y 4.B.2), cada tema completo para su examen. Con ellas entra un criterio nuevo (`CRITERIOS.md` § 6): **el 3.er y el 4.º ejercicio son exámenes distintos**; el tema de referencia de un modelo teórico es, siempre que se pueda, del 3.º; los del 4.º lo aplican y resumen lo imprescindible, y ningún tema depende de estudiar el otro ejercicio. Ya están aplicadas al canon (`notacion.md`, `_notacion/`, `modelos/`, `mapa.yaml`; resumen en `cambios.md`). Las propuestas nuevas de la § 12 (D134-D139) también están **aprobadas** (13/10/2026) y aplicadas al canon.

Autor: Víctor Gutiérrez Marcos

## 1. Resumen en cifras

| Concepto | Cifra |
|---|---|
| Temas del temario | 146 (3.A: 45; 3.B: 45; 4.A: 30; 4.B: 26) |
| Temas revisados | 1 (3.A.8) |
| Temas con fuente que corresponde al título | 72 |
| Temas con fuente parcial (incompleta o con restos del título anterior) | 5 (3.A.12, 3.A.14, 3.A.22, 3.A.23, 4.A.16) |
| Temas cuyo Word es de otro número (renumerados en el 4.º) | 20 |
| Temas cuyo Word es del título antiguo | 16 |
| Temas **sin fuente** (hay que escribirlos) | 33 |
| Modelos, escuelas, políticas e instituciones compartidos (2+ temas) | 211 en el mapa; 231 fichas en `modelos/` |
| Referencias «[ver tema …]» inventariadas | 1.172: 947 bien, **208 a corregir**, **17 sobran** (en 74 temas) |
| Referencias que faltan (sobre todo al tema de referencia de cada modelo) | 731 |
| Incoherencias internas detectadas en los inventarios | 357 |
| Marcas [decidir] en fichas y tablas de notación | ≈ 250, deduplicadas en **133 decisiones** (la 133, el orden de revisión): **todas aprobadas el 13/10/2026** y aplicadas al canon |
| Decisiones por tipo | notación 61 · tema de referencia 36 · reparto de contenido 23 · otras 13 (más D134-D139, aprobadas después: tema de referencia 4, reparto 1, otras 1) |
| Decisiones que cambian el 3.A.8 ya revisado | 6 (D001-D006), aprobadas: 19 cambios concretos en `pendientes-coherencia.md` |

## 2. Decisiones aprobadas (13/10/2026), por área (detalle en `decisiones.json`)

Todas aprobadas; las seis primeras son las únicas que obligan a volver sobre el 3.A.8 (ver § 9). Las que no siguieron la recomendación se indican en su sitio.

### 2.1. Transversales (choques de símbolos entre áreas)
- **D001** CRRA = **θ** y ESI = 1/θ; σ solo elasticidad de sustitución y desviación típica. (Cambia 3.A.8: η→θ en la CRRA; σ→θ en KPR, GHH y JR.)
- **D004** Inversa de Frisch **φ**, peso de la desutilidad del trabajo **χ**. (Cambia 3.A.8: GHH θ→φ, ψ→χ.)
- **D002** **W̄** para toda renta o riqueza exógena del consumidor, incluida la renta no laboral; M solo dinero. (Cambia 3.A.8: Becker V→W̄.)
- **D003** Beneficio **B**; π para inflación y probabilidades. (Cambia 3.A.8: Rosen φ(z;π)→φ(z;B).) **D006** Puja de Rosen **Θ**.
- **D007** Tipo impositivo **t** en micro e IS-LM, **τ** en macro dinámica; recaudación T.
- **D008** **δ** solo depreciación: NKPC **κ**, separación **s**, descuento social **r_s**.
- **D009** Sensibilidad de la inversión **b**; v = relación capital-producto.
- **D010** **g** progreso técnico; **γ_Y** crecimiento del PIB (r − γ_Y en la deuda); g = G/Y.
- **D012** γ_X para tasas de variación. **D011** w_L, w_K en teoría de la producción y EG; w, r en los 2×2 de comercio e incidencia.
- **D016** φ solo Melitz (y Frisch en macro): R_A(q_B), a_ij, ν. **D023** M solo dinero: variedades N_t, emparejamiento m(U,V). **D020** λ solo multiplicador: escala t, f(θ), q(θ).
- **D017** Probabilidades **π** (π_s, π(e)). **D034** σ_t para la dispersión de la σ-convergencia. **D044** Ponderaciones ω_i. **D057** U_i para el individuo en la FBS (no convive con la utilidad marginal de 3.A.8).

### 2.2. Consumidor, producción y equilibrio general
- D005 Cobb-Douglas: referencia **3.A.11** (3.A.8 queda como referencia de la variante de utilidad).
- D101 escala t · D102 𝒴 · D035 RMS^A_{XY} positiva · D045 dotación ω · D058 consumidores A, B / i; θ_ij · D081 ϵ de Atkinson · D087 separar la paradoja de Leontief.

### 2.3. Mercados, información y juegos
- D059 𝓛 · D103 CF · D104 tipos t_i · D129 educación y · D066 «mercados impugnables (contestables)».
- Temas de referencia: D070 Stiglitz-Weiss en **3.A.13**; D071 mercados impugnables en **3.A.15**; D091 yardstick en **3.A.17**; D092 captura en **3.A.20**.

### 2.4. Pensamiento y macro cerrada
- D031 Deshacer el cruce de los Word de 3.A.4 y 3.A.5 (IS-LM y Phillips a 3.A.5; desequilibrio a 3.A.4); D111 Patinkin en 3.A.4.
- Notación: D036 Lucas ω y ψ · D105 β-δ de Laibson · D021 regla de Taylor canónica · D037 r^n_t · D060 pendiente a · D061 Cagan α, ζ · D028 i_{t−1}D_{t−1} · D130 Φ(I,K) · D106 γ de Nash · D131 η y α_H · D107 β de MRW · D026 w real, W nominal · D056 θ = V/U.
- Temas de referencia y reparto: D068 Lucas-Rapping en **3.A.25**; D112 input-output en **3.A.31**; D051 estancamiento secular en **3.A.40**; D052 multiplicadores fiscales (teoría en 3.A.40, evidencia en 4.B.4); D053 Barro (1990) en **3.A.38** y D050 versión con optimización; D089 suavización impositiva en **3.A.39**; D090 MRW desarrollado en **3.A.43**; D110 rehacer el ejemplo de trampa de pobreza; D125 AJR entre 3.A.45 y 3.B.28.

### 2.5. Macro abierta, comercio y finanzas
- D013 E, F, e, E^e · D015 q · D038 Y* extranjera · D082 PNCI · D014 Mundell-Fleming en **3.A.32** (sin fuente; se escribe desde 3.B.15).
- D019 NEG: μ peso de manufacturas · D083 φ_τ · D041 un id para la familia NEG · D113 Falvey en **3.B.6** · D114 Haberler en **3.B.5** · D115 Brander-Krugman en 3.B.8.
- D062 ROA = EBIT/AT · D084 g = b·ROE · D063 minúsculas · D085 I_0, FC_t · D108 notación de Hull · D064 Diamond-Dybvig de Freixas-Rochet · D042 referencia **3.B.26** · D116 contango en **3.B.25**.

### 2.6. Historia, organismos y Unión Europea
- D025 Bretton Woods solo en 3.B.20 · D030 «pilares» · D119 G-20 y OCDE a 3.B.19 · D024 cargos fechados · D080 introducción común de la UE.
- Reparto hacia los temas sin fuente: D032 NGEU y SURE en 3.B.45/3.B.37 · D093 MEDE en 3.B.45 · D033 PEC en 3.B.45 · D118 Semestre en 3.B.45 y 4.A.29 · D073 Unión Bancaria y UMC en 3.B.44 · D117 papel del euro en 3.B.43 · D072 MAFC en 3.B.31.

### 2.7. Economía española
- D018 periodización única 4.A.27/4.A.28/4.A.29 · D043 introducción de la BP solo en 4.A.21 · D100 introducción del sistema financiero solo en 4.A.18 · D049 tasa de actividad EPA · D048 N y descomposición en cuatro factores · D039 CF^{BdE} · D065 A = activos · D078 bucle banca-soberano en **4.A.18** · D097 descomposición del PIB per cápita en **4.A.30**.

### 2.8. Sector público
- Notación: D027 W̄ / Y · D046 p_c, p_v · D047 ε con signo · D029 b, b^c, b^{ca}, b^e, b^p y ε · D109 ϕ · D132 «regla de la elasticidad inversa» · D040 0,5 % y 0,4 % · D086 «Programa de Estabilidad» · D067 etapas.
- Reparto: D022 normativa de 4.B.12/4.B.13 como semilla de 4.B.16, 4.B.17, 4.B.19 y 4.B.20 · D079 exceso de gravamen en 4.B.9 · D098 versión 1×2×2×2 · D099 Fisher en 4.B.10 · D126 Harberger solo en 4.B.8 · D127 tamaño del sector público en 4.B.5 · D128 Niskanen en 4.B.2 · D055 4.B.21/4.B.22/4.B.23 · D121 Condorcet y Arrow.
- Temas de referencia: D054 progresividad en **4.B.9** · D094 Atkinson y D075 Lorenz: **dobles**, 4.B.3 (4.º) y 3.A.24 (3.º) · D120 Borda: **doble**, 4.B.2 (4.º) y 3.A.24 (3.º) · D095 Leviatán en **4.B.2** · D076 competencia fiscal en **4.B.14** · D122 financiación autonómica en **4.B.25** · D123 impuesto dual en **4.B.12** · D096 ITF en **4.B.18** · D077 SEC de impuestos en **4.B.7** · D124 rentas mínimas en 4.B.3 e IMV en 4.B.24 · D074 armonización fiscal en **3.B.39** · D069 efectos no keynesianos: **doble**, 3.A.39 (3.º; 3.A.40 lo aplica a 2010-2013) y 4.B.4 (4.º; aplicación a España en 4.B.26) · D088 RBC fiscal en **3.A.38** (elegida por Víctor; la recomendada era 4.B.4), con resumen en 4.B.4.

### 2.9. Segunda tanda, por el criterio del 3.er y el 4.º ejercicio (13/10/2026; § 12)
- **D134** incidencia en equilibrio parcial: **doble**, 3.A.16 y 4.B.8 · **D135** Condorcet: **doble**, 3.A.24 y 4.B.2 (sustituye esa parte de D121) · **D136** bucle banca-soberano: **doble**, mecanismo en 3.B.26 y caso español en 4.A.18 (completa D078) · **D137** votante mediano: **doble**, 3.A.24 y 4.B.2 · **D138** remisiones del 3.º al 4.º solo para ampliar (3.B.27 pasa a 3.B.26) · **D139** resúmenes propios en 4.B.15, 4.B.10, 4.B.11 y 4.B.4.

## 3. Referencias «[ver tema …]» erróneas, por tema

Formato: `apunta a → debería apuntar a` (×n si se repite). La mayoría vienen de la numeración anterior a 2023; en el bloque 4.B, la regla general es 4.B.n viejo → 4.B.(n−1) para 4 ≤ n ≤ 14 (tabla completa en `_notacion/sector-publico.md`, § 7). El detalle con el contexto de cada una está en `mapa.yaml`.

| Tema | A corregir | Correcciones | Sobran |
|---|---|---|---|
| 3.A.1 | 5 | 3.B.15-3.B.16→3.B.14; 3.A.13→3.A.14; 3.A.24→3.A.14 (×3) | — |
| 3.A.4 | 3 | 3.A.26→3.A.27; 3.B.21→3.B.20; 3.A.28→3.A.25 | — |
| 3.A.6 | 2 | 3.A.17→3.A.14; 3.A.19→3.A.14 | — |
| 3.A.7 | 2 | 3.A.38→3.A.40; 3.A.41→3.A.37 | — |
| 3.A.10 | 2 | 3.B.24→3.A.1, 3.B.23; 3.B.17, 3.B.27→3.B.26, 3.B.27 | 3.A.10 (×2) |
| 3.A.11 | 4 | 3.A.9→3.A.11; 3.A.10→3.A.12; 3.A.11, 3.A.14-3.A.17→3.A.15, 3.A.16, 3.A.19; 3.A.23→3.A.22 | — |
| 3.A.12 | 1 | 3.A.9→3.A.8 | — |
| 3.A.13 | 1 | 3.A.7→3.A.10 | — |
| 3.A.16 | 4 | 3.A.14→3.A.16 (×2); 3.A.11→3.A.12 (×2) | — |
| 3.A.17 | 3 | 3.B.4→3.A.15; 3.B.4→3.B.39; 3.A.14→3.A.16 | — |
| 3.A.18 | 2 | 3.A.6→3.A.8; 3.A.10→3.A.14 | — |
| 3.A.19 | 4 | 3.A.10→3.A.14 (×2); 3.A.23→3.A.22; 3.B.4→3.B.39 | — |
| 3.A.21 | 1 | 3.A.22→3.A.23 | — |
| 3.A.22 | 4 | 3.B.8, 3.B.17→3.B.7, 3.B.28; 3.A.23→3.A.22; 3.A.23→3.A.22, 3.A.21, 3.A.16; 3.A.21, 3.A.22, 3.A.23→3.A.21, 3.A.22 | — |
| 3.A.23 | 5 | 3.A.15, 3.A.16, 3.A.17→3.A.17, 3.A.18, 3.A.19, 3.A.20; 3.A.17, 3.A.19→3.A.15, 3.A.16; 3.A.22→3.A.8; 3.A.27→3.A.14; 3.A.16, 3.A.21, 3.A.22, 3.A.23, 3.A.24→3.A.22 | 3.A.23; 3.A.22 |
| 3.A.24 | 1 | 3.A.16, 3.A.21, 3.A.22, 3.A.23, 3.A.24→3.A.22 | — |
| 3.A.25 | 4 | 3.A.6→3.A.8; 3.A.14→3.A.21; 3.A.19→3.A.26; 3.A.12→3.A.29 | — |
| 3.A.29 | 1 | 3.A.23→3.A.22 | — |
| 3.A.35 | 1 | 3.A.4→3.A.5 | 3.A.23 |
| 3.A.38 | 2 | 3.A.37→3.A.33; 3.A.29→3.A.33 | — |
| 3.A.39 | 1 | 3.A.37→3.A.33 | — |
| 3.A.43 | 1 | 3.A.10 y 3.A.11→3.A.11, 3.A.12 | — |
| 3.A.44 | 3 | 3.B.29→3.B.28; 3.A.19→3.A.14; 3.A.43→3.A.11 | 3.A.43 |
| 3.B.3 | 1 | 3.B.26→4.A.20 | — |
| 3.B.4 | 1 | 3.A.13→3.A.15 | — |
| 3.B.7 | 2 | 3.A.23→3.A.22; 3.A.19→3.A.14 | 3.B.7 (×3) |
| 3.B.8 | 2 | 4.A.24→4.A.25; 3.A.23→3.A.22 | 3.B.8 |
| 3.B.9 | 0 |  | 3.B.9 |
| 3.B.10 | 4 | 3.B.17→3.B.16 (×2); 3.B.7→3.B.6; 3.B.42→3.B.41 | — |
| 3.B.11 | 1 | 3.B.34→3.B.18 | — |
| 3.B.12 | 1 | 3.B.13→3.B.14 | 3.B.12 |
| 3.B.16 | 1 | 3.A.17→3.A.18 | — |
| 3.B.20 | 7 | 3.B.23→3.B.22; 3.B.31→3.B.30; 3.B.34, 3.B.35→3.B.33, 3.B.34; 3.B.14→3.B.13; 3.B.13→3.B.12; 3.B.29, 3.B.19, 3.B.23→3.B.29, 3.B.19, 3.B.22; 3.B.28→3.B.27 | — |
| 3.B.22 | 0 |  | 3.B.22 |
| 3.B.27 | 1 | 4.A.20→4.A.19 | — |
| 3.B.33 | 1 | 3.B.33, 3.B.34→3.B.34 | 3.B.33 |
| 3.B.34 | 1 | 3.B.33, 3.B.34→3.B.33 | 3.B.34 (×2) |
| 3.B.35 | 1 | 3.B.7→3.B.10 | — |
| 3.B.39 | 3 | 3.A.45; 3.B.9→3.A.44, 3.B.9; 3.B.38→3.B.37; 3.B.34→3.B.18 | — |
| 3.B.40 | 3 | 3.B.17→3.B.16; 3.B.10→3.B.6 (×2) | — |
| 3.B.41 | 1 | 3.B.8→4.A.25 | — |
| 4.A.1 | 3 | 3.A.26→3.A.30; 3.A.27→3.A.31; 3.B.12→3.B.11 | — |
| 4.A.11 | 2 | 3.A.43→3.A.44; 4.B.9→4.B.8 | — |
| 4.A.12 | 1 | 4.A.10→4.A.15 | — |
| 4.A.14 | 1 | 4.A.23→4.A.25 | — |
| 4.A.15 | 4 | 4.A.18→4.A.27; 4.B.17→4.B.15; 3.A.16→3.A.14; 3.A.25→3.A.20 | — |
| 4.A.17 | 1 | 3.B.40→3.B.39 | — |
| 4.A.18 | 6 | 3.B.25→3.B.23; 3.B.26→3.B.24; 3.B.27→3.B.25; 4.A.17→4.A.16; 3.B.24→3.B.26; 3.B.45→3.B.43 | — |
| 4.A.19 | 4 | 3.B.25→3.B.23; 3.B.26→3.B.24; 3.B.27→3.B.25; 4.B.28→4.B.26 | — |
| 4.A.20 | 7 | 3.B.25→3.B.23; 3.B.26→3.B.24 (×2); 3.B.27→3.B.25; 3.B.28→3.B.27; 3.A.30→3.A.7; 3.A.7→3.A.10 | — |
| 4.A.21 | 2 | 3.B.12→3.B.11; 4.A.23→4.A.25 | — |
| 4.A.22 | 1 | 4.A.23→4.A.25 | — |
| 4.A.23 | 1 | 4.A.14→4.A.11 | — |
| 4.A.24 | 1 | 3.B.43→3.B.41 | — |
| 4.A.25 | 1 | 3.B.43→3.B.41 | — |
| 4.A.27 | 1 | 3.B.29→3.B.28 | — |
| 4.A.29 | 4 | 4.B.25→4.B.24; 4.A.4→4.A.6; 4.B.18-4.B.22→4.B.16, 4.B.17, 4.B.18, 4.B.19, 4.B.20; 4.B.24→4.B.22 | — |
| 4.B.1 | 7 | 3.º ejercicio (genérica)→3.A.36, 3.A.38, 3.A.39, 3.B.7; 4.B.5→4.B.4; 3.A.38→3.A.39; 3.B.12→3.B.11 (×3); 3.A.26→3.A.30 | — |
| 4.B.2 | 4 | 3.A.6→3.A.8; 4.B.15→4.B.14; 3.A.25→3.A.23, 3.A.20; 4.B.2→3.A.24 | — |
| 4.B.3 | 2 | 3.A.37→3.A.29; 4.B.12→4.B.11 | — |
| 4.B.4 | 15 | 3.A.41→3.A.42 (×2); 4.B.4→4.B.3; 3.A.37, 4.B.5→3.A.38, 3.A.40; 3.A.34→3.A.35; 3.A.28, 3.A.38, 4.B.5→3.A.32, 3.A.38; 3.B.20→3.B.19; 3.A.12→3.A.29; 3.A.33→3.A.34; 3.A.29, 3.A.37, 3.A.38, 3.A.2→3.A.33, 3.A.38, 3.A.39, 3.A.2; 3.A.38, 3.A.37→3.A.39, 3.A.38; 3.A.38→3.A.39; 3.A.37→3.A.38; 3.A.30→3.A.7, 3.A.37; 3.A.39→3.A.37 | — |
| 4.B.5 | 3 | 3.A.38→3.A.39; 4.B.3→4.B.21; 4.B.3, 4.B.6→4.B.21, 4.B.5 | — |
| 4.B.6 | 1 | 3.A.7→3.A.10 | — |
| 4.B.7 | 2 | 4.B.12→4.B.11 (×2) | — |
| 4.B.8 | 4 | 4.B.8→4.B.7; 3.A.14→3.A.16 (×2); 4.B.10→4.B.9 | — |
| 4.B.9 | 10 | 3.A.6→3.A.8; 3.A.9→3.A.11; 3.A.18→3.A.25; 3.A.8→3.A.9 (×2); 3.A.38→3.A.39; 4.B.9→4.B.8 (×2); 4.B.11→4.B.10; 4.B.9, 4.B.10→4.B.8, 4.B.9 | — |
| 4.B.10 | 3 | 3.A.18→3.A.25; 3.A.6→3.A.8; 4.B.10, 4.B.9→4.B.9, 4.B.8 | — |
| 4.B.11 | 7 | 4.B.10→4.B.9; 3.A.6→3.A.8; 3.A.9→3.A.11; 3.A.8→3.A.9 (×2); 4.B.10, 4.B.12→4.B.9, 4.B.11; 3.A.39→3.A.41 | — |
| 4.B.12 | 5 | 4.B.8→4.B.7 (×2); 4.B.4→4.B.3; 4.B.5→4.B.4; 4.B.10→4.B.9 | — |
| 4.B.13 | 8 | 4.B.8→4.B.7; 4.B.5→4.B.4 (×2); 4.B.10→4.B.9; 4.B.9→4.B.8 (×2); 4.B.12→4.B.11; 3.B.38→3.B.37 | — |
| 4.B.15 | 3 | 3.A.10→3.A.17; 3.A.15→3.A.20; 3.A.25→3.A.20 | — |
| 4.B.18 | 3 | 3.B.39→3.B.38; 3.B.38→3.B.37 (×2) | — |
| 4.B.21 | 2 | 4.B.5→4.B.4; 4.B.3, 4.B.24→4.B.21 | — |
| 4.B.22 | 1 | 4.B.24→4.B.21 | — |

## 4. Errores de contenido detectados (se corregirán al revisar cada tema)

No incluye los problemas de notación (resueltos por las decisiones de § 2) ni las erratas menores; el detalle está en `_inventario/<tema>.json` (`incoherencias_internas`) y en las fichas.

| Tema | Errores |
|---|---|
| 3.A.6 | Barro-Gordon: CPO con términos al cuadrado y solución π = π* + (α/γ)(Ū − U*)² (es lineal); RBC: W_t y R_t sin (1−α) y α; PTF como suma y como producto a la vez; ln A_t = ρ_A A_{t−1} mezcla niveles y logaritmos |
| 3.A.9 | Ley de Walras atribuida a la «estricta monotonía» (es la insaciabilidad local); Cobb-Douglas α, β llamada «lineal en logaritmos» |
| 3.A.10 | El modelo básico de demanda de seguros con información simétrica se atribuye a Rothschild-Stiglitz (1976); nota 6 confunde certidumbre con competencia perfecta |
| 3.A.11 | Fórmula de la proporcionalidad de escala mal escrita (dz_L/dz_L); σ = 0 y σ = 1 presentados como casos exactos de la CES (son límites) |
| 3.A.12 | Falta el epígrafe de aplicaciones empíricas del título |
| 3.A.14 | Equilibrio de Nash con desigualdad estricta; racionalidad de coaliciones con ≤; pago del segundo precio sin definir j; «EBPS» |
| 3.A.21 | La convexidad estricta del conjunto de producción no implica rendimientos decrecientes; propiedades de las demandas netas copiadas de la oferta |
| 3.A.22 | Utilidades «ordinales» con utilidad marginal decreciente; atribuye a Debreu propiedades de la función de utilidad; «2×2×2» con 10 incógnitas |
| 3.A.23 | Bienes públicos: X fijo y a la vez FPP T(X,G) = 0; externalidad en consumo (analítica) y en producción (gráfica) sin enlazar; Clarke-Groves sin terminar |
| 3.A.24 | Mezcla cardinalidad y comparabilidad interpersonal; problema del planificador vacío; «ley D'Hont» |
| 3.A.36, 3.A.41 | Misma derivación errónea de Barro-Gordon que 3.A.6 |
| 3.A.43 | Regla de oro sin g (∂y/∂k = δ + n); ejemplo de trampa de pobreza que no genera dos estados estacionarios (D110) |
| 3.B.1 | GAO definido sobre el EBIAT (debe ser sobre el EBIT); fórmula de apalancamiento con ROA después de impuestos (D062) |
| 3.B.2-3.B.4 | WACC sin (1 − t_IS) en el coste de la deuda |
| 3.B.3 | Miller (1977): condiciones sobre t_D y t_E invertidas; r_E/(1 + t_IRPF) dudoso en P_0 |
| 3.B.4 | «Múltiplo EBITDA» con la fórmula del EBIT; apartado «¿Qué método utilizar?» duplicado |
| 3.B.9 | El «modelo de Lucas» es de externalidades tipo Romer (1986)/Arrow; «en los endógenos de 1.ª generación el progreso técnico es exógeno» (es un subproducto no buscado) |
| 3.B.12 | «Propensión marginal al consumo, m» (es a importar); BP ≡ R (es ΔR); anexo copiado de 3.B.14 |
| 3.B.13 | ln(1+i) = ln(1+i*)·ln(…) (es suma); margen forward llamado «depreciación esperada»; tipo efectivo como media aritmética |
| 3.B.14 | Implicaciones de la paridad sin expectativa (s_{t+1} en lugar de E_t s_{t+1}); IS-LM-BP en borrador |
| 3.B.15 (y 3.B.19, 4.B.4) | «Movilidad perfecta de capital, β = 0, BP vertical» (es movilidad **nula**) |
| 3.B.23 | β_i = Cov(E[R_i], E[R_M])/Var(R_M) (covarianza de constantes) |
| 3.B.24 | Duración en unidades monetarias = P·r·D^mod (sobra r) |
| 3.B.25 | Pago del futuro S_T − P_ejercicio (es S_T − F_0); binomial descontado con (1 − r_f) en lugar de 1/(1 + r_f); integral de valoración con Xe^{−rT} dentro del máximo y sin medida neutral al riesgo; tramos de la put |
| 3.B.40 | Dice que el margen σ/(σ−1) crece con σ (decrece) y que σ mide la preferencia por la variedad (es al revés); remisiones contradictorias para centro-periferia (3.B.6 y 3.B.10) |
| 4.A.1 | IPC como Laspeyres de base fija y a la vez encadenado; EPF «trimestral» y «anual» |
| 4.A.11 | Medidas del RDL de alquiler de 2019 que son las de la propuesta de 2018 no convalidada |
| 4.A.12 | Fechas contradictorias de la liberalización de las telecomunicaciones; confunde VTC con taxi |
| 4.A.14 | El «poder de los mayoristas» describe el de la gran distribución minorista |
| 4.A.15 | «Regulador de valores (CNMC)» (es la CNMV); Consejo de la CNMC con 10 y con 9 miembros; origen de la autoridad de competencia (1964 o 1989) |
| 4.A.16, 4.A.29 | Tasa de actividad sobre 16-64 con el valor de 16 y más (D049) |
| 4.A.17 | β-convergencia: «la variable dependiente … y la variable dependiente» (la segunda es la independiente); L/POB llamada «tasa de ocupación» |
| 4.A.21-4.A.23 | Saldos de la balanza de bienes incompatibles entre temas («superávit del 2,1 % en 2017»); «84 millones de euros» de turistas; IDE «28,7 % del PIB» con flujos de 8.752 M€ |
| 4.A.24-4.A.25 | Retorno de la promoción 1 → 40 $ y 1 → 15 $; cuotas de exportación distintas; PASE definida de forma circular |
| 4.A.28 | «Euro en 2002» como criterio de Maastricht; «PITVI 2018-2021» (es el Plan Estatal de Vivienda); rescate de 60.000 o 40.000 millones |
| 4.A.30 | Atribuye la reforma del art. 135 CE (2011) al Fiscal Compact (2012) |
| 4.B.1, 4.B.5 | «Índice de Frank» atribuido a Frank Ramsey (es Henry J. Frank, 1959); saldo primario definido como «saldo − servicio de la deuda» |
| 4.B.2 | Fechas de Downs-Hotelling, Nordhaus y Olson; teorema de May mal enunciado; nota sobre Gibbard-Satterthwaite contradictoria; «ilusión de la deuda» atribuida a Niskanen |
| 4.B.3 | Reparto: «n > r_{t+1}» dos veces con conclusiones opuestas; «impuesto negativo sobre la riqueza»; no contributivas «universales»; vacunación «deseable» bajo libre mercado |
| 4.B.4 | Error de signo en el saldo cíclicamente ajustado de España 2022 (−3,8 % y no −5,8 %; estructural −3,6 % y no −6 %); RBC que «no depende de τ_t» sin impuestos distorsionantes; nota 29 «ϕ_π = ϕ_π» |
| 4.B.5 | Redistribución atribuida a Romer-Rosenthal describiendo Meltzer-Richard |
| 4.B.7 | Impuesto específico confundido con el de suma fija; Sucesiones como impuesto estatal; «IVA sobre el tabaco»; etiquetas SEC invertidas |
| 4.B.8 | Demanda perfectamente elástica: «0 % para los productores» (es el 100 %); monopolio: «añadir» el impuesto (es deducir) |
| 4.B.9 | Falta el epígrafe «Medidas de progresividad»; VC y VE atribuidas a «Hicks (1956)… Willings» (Hicks 1939-1942, Willig 1976) |
| 4.B.10 | Restricción «C* + wO* = wO₀ + O» (es + M); precio del ocio sin (1 − τ); condición de Laffer en el IRPF imprecisa |
| 4.B.11 | Exceso de gravamen con signo negativo; lista de las «reglas» de Ramsey corrupta |
| 4.B.12 | Renta fiscal Y = IC + GD (los gastos se restan); progresividad confundida con retenciones; doble imposición económica y jurídica invertidas |
| 4.B.13 | IVA «real» y con sujeto pasivo «personal»; fechas del IVA en la CEE (1967/1970); periodicidad «instantánea» |
| 4.B.15 | Laffont-Tirole: b cambia de sentido entre el texto y el anexo; «Ramsey-Boiteaux» |
| 4.B.18 | Base jurídica con artículos del antiguo TCE (hoy arts. 113 y 115 TFUE); tipos del IS anteriores al pilar 2 |
| 4.B.21 | «4 etapas» del proceso presupuestario con cinco enumeradas; solo clasificación económica de ingresos |
| 4.B.26 | Signo del «efecto bola de nieve» al revés; mezcla tipo real y crecimiento nominal; dos introducciones y dos conclusiones |

## 5. Duplicidades literales entre temas

| Contenido | Temas | Propuesta |
|---|---|---|
| Párrafo de los «tres pilares» de Bretton Woods | 3.B.20, 3.B.21, 3.B.22, 3.B.33, 3.B.34, 3.B.35 | D025 |
| Sección de Bretton Woods y Triffin (≈ 108 líneas) | 3.B.20 → 3.B.21 | D025 |
| Marco jurídico de la OMC (55 líneas) | 3.B.33 → 3.B.34 | Solo en 3.B.33 |
| Introducción a la BP de España y evolución 1939-2019 (212, 72 y 67 líneas entre pares) | 4.A.21, 4.A.22, 4.A.23 | D043, D018 |
| Introducción y «pasivos del crecimiento»; 1973-2000 y convergencia nominal | 4.A.27, 4.A.28, 4.A.30 | D018 |
| Introducción del sistema financiero, renta fija privada, AIAF, MARF | 4.A.18, 4.A.19, 4.A.20 | D100 |
| Bucle banca-soberano | 4.A.18, 4.A.20 | D078 |
| Introducción común de los temas de la UE (Monnet, «germen de la UE») | 3.B.36, 3.B.39, 3.B.40, 3.B.41 | D080 |
| Determinantes de primera y segunda naturaleza (17 líneas) | 3.B.35, 3.B.40 | Solo en 3.B.40 |
| Bloque NEG (siete ecuaciones y el tomahawk) | 3.B.6, 3.B.9, 3.B.10 | Desarrollo en 3.B.6 |
| Equilibrio general del arancel (Meade, arancel óptimo, Johnson) | 3.B.7, 3.B.8 | Arancel óptimo en 3.B.7, guerra arancelaria en 3.B.8 |
| Análisis fundamental (DCF, múltiplos, PER) | 3.B.4, 3.B.23 | Desarrollo en 3.B.4 |
| Estimación de r_E y r_D (WACC) | 3.B.2, 3.B.3 | Desarrollo en 3.B.2 |
| Anexo de expectativas y contango | 3.B.13, 3.B.25 | D116 |
| Demanda de Cagan | 3.A.35, 3.A.39, 3.A.41 | Desarrollo en 3.A.41 |
| Barro-Gordon (con el mismo error algebraico) | 3.A.6, 3.A.36, 3.A.41 | Desarrollo en 3.A.36 |
| Tecnología como bien público, tamaño de la empresa, costes de ajuste | 3.A.43, 3.A.44 | Cada párrafo en un tema |
| Romer (1990) / Grossman-Helpman | 3.A.44, 3.B.9 | Resumen en 3.B.9 |
| Salarios de eficiencia (Solow y Shapiro-Stiglitz) | 3.A.27, 3.A.7 | Desarrollo en 3.A.27 |
| Curva de Phillips | 3.A.4, 3.A.28 | D031 |
| Modelo 2×2×2×2 y TFEB | 3.A.22, 3.A.23 | Solo en 3.A.22 (3.A.23 conserva el título anterior) |
| Delimitación S.13/S.11/S.12 del SEC | 4.B.1, 4.B.5, 4.B.7, 4.B.15 | Solo en 4.B.1 |
| Exceso de gravamen y triángulo de Harberger | 4.B.9, 4.B.11 | D079 |
| Harberger (incidencia) | 4.B.8, 4.B.9 | D126 |
| Efecto renta y sustitución (dos versiones) | 4.B.9 (1.2 y 1.3) | D098 |
| Fisher con impuestos | 4.B.9, 4.B.10 | D099 |
| Indicadores de tamaño y «comodín» del tamaño óptimo | 4.B.1, 4.B.5 | D127 |
| Niskanen (mismo gráfico) | 4.B.2, 4.B.5 | D128 |
| Historia de la consolidación fiscal | 4.B.22, 4.B.26 | D055 |
| COFIDES, FIEM, CESCE e ICEX (tres veces) y Estrategia PASE (dos) | 4.A.24, 4.A.25 | Una vez cada uno |

## 6. Temas sin fuente (33) y Word del 4.º ejercicio cambiados

### 6.1. Sin fuente: hay que escribirlos

| Tema | Material aprovechable en otros temas |
|---|---|
| 3.A.15 | Mercados impugnables (3.A.19), Simon y agencia (3.A.1, 3.A.13) |
| 3.A.20 | Regulación del viejo 4.B.16 (hoy en el Word de 4.B.15), captura y yardstick |
| 3.A.31 | Remisiones y esquema de 3.A.30 |
| 3.A.32 | Mundell-Fleming de 3.B.15 (D014), OA-DA de 3.A.37 |
| 3.A.40 | Estancamiento secular de 3.A.39, multiplicadores de 4.B.4, NEK en el límite inferior |
| 3.B.18 | Trilema y flujos de capital (3.B.15-3.B.17) |
| 3.B.26 | Diamond-Dybvig de 4.A.20 y 3.B.27, crisis de 2008 de 4.A.18 |
| 3.B.29 | Sostenibilidad de la deuda externa (3.B.12), Banco Mundial y FMI |
| 3.B.30 | Ninguno relevante |
| 3.B.31 | MAFC de 3.B.37, Pigou y cap-and-trade de 3.A.23 |
| 3.B.32 | Gravedad y datos de comercio (3.B.9, 4.A.22) |
| 3.B.38 | PAC dispersa en 3.B.37 |
| 3.B.43 | Criterios de convergencia del antiguo 4.A.29, papel internacional del euro de 3.B.42 |
| 3.B.44 | Unión Bancaria de 4.A.18 y UMC de 3.B.39 |
| 3.B.45 | MEDE, NGEU y SURE de 3.B.36-3.B.37; PEC y Semestre dispersos en 4.A y 4.B |
| 4.A.2-4.A.10, 4.A.26 | Ninguno (4.A.10: hay un Word del antiguo 4.A.10, de servicios, que no corresponde) |
| 4.B.14, 4.B.25 | Ninguno (el viejo 4.B.15 y 4.B.26 no están en el repositorio) |
| 4.B.16, 4.B.17, 4.B.19, 4.B.20 | Normativa de los impuestos en 4.B.12 y 4.B.13 (D022) |
| 4.B.23 | COFOG y gasto por funciones del Word de 4.B.22 (D055) |
| 4.B.24 | Pensiones y rentas mínimas de 4.B.3 |

### 6.2. Word del 4.º ejercicio cambiados (avisar en la web)

- **Bloque 4.B (numeración desplazada):** los Word públicos 4B03…4B13 contienen el tema **anterior** (4B0n.docx = viejo 4.B.n, que es el nuevo 4.B.(n−1)). El contenido correcto de cada tema 4.B.n (3 ≤ n ≤ 13) es el viejo 4.B.(n+1): Word oculto «Tema 4.B.(n+1).docx» y PDF público con la cabecera vieja. 4.B.15 = viejo 4.B.17; 4.B.21 = viejo 4.B.24; 4.B.22 = viejo 4.B.23; 4.B.26 = viejos 4.B.27 + 4.B.28 concatenados (dos introducciones y dos conclusiones). 4.B.18 solo tiene el Word oculto del viejo 4.B.18 (armonización), de título distinto.
- **Bloque 4.A sector exterior:** Word público 4A21 = antiguo 4.A.21 (política monetaria), no la BP; PDF 4A21 = antiguo 4.A.24 (BP). 4A22: no hay Word; PDF = antiguo 4.A.25. 4A23.docx = antiguo 4.A.23 (política de internacionalización, que es el nuevo 4.A.24-4.A.25) y PDF = antiguo 4.A.26. 4A24.docx = antiguo 4.A.24 (BP) y PDF = antiguo 4.A.23: **4A23 y 4A24 están cruzados**. 4.A.25 no tiene tema propio.
- **Título antiguo (se aprovecha lo que encaja):** 3.A.4, 3.A.5, 4.A.1, 4.A.11-4.A.15, 4.A.18-4.A.20 (el Word de 4.A.19 es en realidad el nuevo 4.A.20), 4.A.27-4.A.30 (el antiguo 4.A.29 de convergencia pasa a 4.A.30), 4.B.18.

## 7. Contenidos desplazados entre temas

| Contenido | Está en | Va a | Decisión |
|---|---|---|---|
| IS-LM y curva de Phillips (síntesis) | 3.A.4 | 3.A.5 (Phillips: 3.A.28) | D031 |
| Desequilibrio (Patinkin, Clower, Leijonhufvud, Malinvaud) | 3.A.5 | 3.A.4 | D031 |
| Modelo 2×2×2×2 y TFEB | 3.A.23 | 3.A.22 | (título vigente) |
| Criterios de compensación | 3.A.22 | 3.A.24 (resumen) | (título vigente) |
| Mercados impugnables | 3.A.19 | 3.A.15 | D071 |
| Equivalencia ricardiana | 3.A.38 | 3.A.39 (nota del propio autor) | — |
| Estancamiento secular | 3.A.39 | 3.A.40 | D051 |
| MRW | 3.A.45 | 3.A.43 | D090 |
| Mundell-Fleming | 3.B.15 | 3.A.32 | D014 |
| G-20 y OCDE | 3.B.35 | 3.B.19 | D119 |
| Unión de Mercados de Capitales | 3.B.39 | 3.B.44 | D073 |
| Unión Bancaria | 4.A.18 (ap. III) | 3.B.44 y 4.A.19 | D073 |
| Papel internacional del euro | 3.B.42 | 3.B.43 | D117 |
| MEDE, NGEU, SURE | 3.B.36, 3.B.37, 3.B.40 | 3.B.45 | D032, D093 |
| Criterios de convergencia nominal | antiguo 4.A.29 | 3.B.43 y 4.A.27 | — |
| Convergencia real y descomposición del PIB per cápita | antiguo 4.A.29 | 4.A.30 | D097 |
| Mercados de valores (Word de 4.A.19) | 4.A.19 | 4.A.20 | (título vigente) |
| 1973-2000 | 4.A.28 | 4.A.27 | D018 |
| Stiglitz-Weiss y Diamond-Dybvig | 3.B.27, 4.A.20 | 3.A.13 y 3.B.26 | D070, D042 |
| Normativa del IRPF, IS, IP, IVA | 4.B.12, 4.B.13 | 4.B.16, 4.B.17, 4.B.19, 4.B.20 | D022 |
| Armonización fiscal (viejo 4.B.18) | 4.B.18 | 3.B.39, 4.B.18, 4.B.20 | D074 |
| Regulación de la empresa pública (viejo 4.B.16) | Word de 4.B.15 | 3.A.17 y 3.A.20 | D092, D091 |
| Cifras de los PGE / COFOG | 4.B.21 / 4.B.22 | 4.B.22 / 4.B.23 | D055 |
| Input-output | 3.A.30 | 3.A.31 | D112 |

## 8. Problemas de fuente que condicionan la revisión

- **Esquemas, no temas:** 3.A.14 es un esquema ajeno (384 líneas, sin bibliografía); 3.A.5 es un borrador incompleto; 3.A.12 no tiene las aplicaciones empíricas.
- **Notas de trabajo y textos copiados** («Copiar de Sahuquillo», «Ver tema de Juan Luis», «copiado de María Palacios Carrere»): 3.A.13, 3.A.12, 3.A.24, 3.B.9, 4.B.9, 4.A.17, 4.A.21, 4.A.23. En la revisión se reescriben con fuentes propias y se citan.
- **Datos desactualizados o de años mezclados** en casi todo el 4.A (años 2016-2023 en el mismo apartado): se actualizan con `datos/*.csv` al revisar cada tema.

## 9. Cambios aprobados en el 3.A.8 ya revisado

Aprobados el 13/10/2026. La lista exacta (línea, símbolo antiguo → nuevo, gráfico de Rosen, escenas del vídeo, guion y repaso) está en `pendientes-coherencia.md`; se aplica con `/revisartema 3.A.8 --fase coherencia`.

| Decisión | Cambio en 3.A.8 |
|---|---|
| D001 | CRRA u(C) = (C^{1−η} − 1)/(1 − η) → θ; preferencias KPR, GHH y JR: σ → θ |
| D004 | GHH: N^{1+θ}/(1+θ) → N^{1+φ}/(1+φ) y ψ → χ (oferta χN^φ = w); JR: ψN_t^θ → χN_t^{1+φ} |
| D002 | Becker (ec. `becker-restricciones` y `renta-completa`): renta no laboral V → W̄ (renta completa wT + W̄) |
| D003 y D006 | Rosen: función de oferta φ(z;π) → φ(z;B); función de puja θ(z;Ū,W̄) → Θ(z;Ū,W̄), también en el gráfico `funcion-hedonica-rosen` |
| D005 | Remisión a 3.A.11 en la nota de la Cobb-Douglas como función de producción |

Nada más del 3.A.8 cambia: W̄, p, x, U, V, E, h, λ, RMS_{12}, σ (CES), ρ, s_i, ε y la denominación «marshalliana» son el canon.

## 10. Orden de revisión

**Criterio.** (1) **Primero el 3.er ejercicio, después el 4.º**, que son exámenes distintos: los temas del 3.º fijan la forma canónica de los modelos teóricos (sus temas de referencia están en el 3.º siempre que se puede) y los del 4.º se revisan después, aplicándolos y resumiendo lo imprescindible para cantarse sin el 3.º. Dentro del 3.º, por bloques del PowerPoint (`organizacion/estructura_temario.json`), de la teoría a la aplicación: micro del 3.A (el 3.A.8 ya está), macro del 3.A, economía internacional y empresa del 3.B; después el sector público (4.B) y la economía española (4.A). (2) Dentro de cada bloque, **primero el tema del que se depende** (D133: un tema que usa un modelo de otro se revisa después de este, para no rehacer) y, a igualdad, los temas de referencia de más modelos. (3) Los temas sin fuente que son referencia de modelos (3.A.15, 3.A.20, 3.A.31, 3.A.32, 3.A.40, 3.B.26, 3.B.31, 3.B.43, 3.B.44, 3.B.45, 4.B.14, 4.B.25) se escriben en su sitio del orden, a partir del material desplazado, antes de los temas que pasan a resumir ese modelo. Entre paréntesis, la puntuación de referencia del repaso (suma de los temas que usan sus modelos) o el motivo del puesto.

**Fase 1. Microeconomía (3.A)** (D133)

- *Modelo neoclásico básico*: 1. 3.A.9 (10) · 2. 3.A.11 (8; ahora también referencia de la Cobb-Douglas) · 3. 3.A.12 (8) · 4. 3.A.21 (5) · 5. 3.A.16 (3)
- *Información y poder de mercado*: 6. 3.A.17 (12; también yardstick) · 7. **3.A.10** (antes que 3.A.13 y 3.A.14, que usan sus seguros y la utilidad esperada) · 8. 3.A.13 (6; Stiglitz-Weiss en desarrollo) · 9. 3.A.14 (3) · 10. 3.A.18 (1) · 11. 3.A.15 (sin fuente; referencia de los mercados impugnables, se escribe con el material de 3.A.19) · 12. 3.A.19 (pasa a resumir los impugnables)
- *Economía del Bienestar e Intervención del Sector Público*: 13. **3.A.22** (antes que 3.A.23, que se apoya en los teoremas del bienestar) · 14. 3.A.23 (12) · 15. 3.A.24 (referencia del 3.º de Lorenz, Atkinson y Borda, además de Arrow) · 16. 3.A.20 (sin fuente; referencia de la captura del regulador) · 17. 3.B.31 (sin fuente; referencia del MAFC)

**Fase 2. Macroeconomía (3.A)** (mismo criterio de dependencias que D133; es una propuesta de orden, no una decisión nueva)

- *Demanda Agregada y Oferta Agregada*: 18. 3.A.25 (Lucas-Rapping y oferta de trabajo: base del mercado de trabajo) · 19. 3.A.27 · 20. 3.A.26 · 21. 3.A.28 (7) · 22. 3.A.33 (5) · 23. 3.A.34 (4)
- *Crecimiento económico*: 24. 3.A.43 (Solow, RCK y ahora MRW, que usan 3.A.44 y 3.A.45) · 25. 3.A.44 (9) · 26. 3.A.45 (4) · 27. 3.A.29 (4) · 28. 3.B.28 (1)
- *Historia del pensamiento económico* (adelantado: IS-LM, desequilibrio, Lucas y el NEK, que usan los temas de ciclo, tienen aquí su referencia): 29. 3.A.5 (IS-LM, con el bloque trasladado desde 3.A.4) · 30. 3.A.4 (desequilibrio, Patinkin y Malinvaud, con el bloque trasladado desde 3.A.5) · 31. 3.A.7 (NEK) · 32. 3.A.6 (islas de Lucas, crítica de Lucas) · 33. 3.A.3 (2) · 34. 3.A.1 (0) · 35. 3.A.2 (0)
- *Ciclo económico y políticas de demanda*: 36. 3.A.39 (11; restricción del gobierno, suavización impositiva y efectos no keynesianos, referencia del 3.º) · 37. 3.A.36 (Taylor, Barro-Gordon) · 38. 3.A.42 (RBC base, que usa 3.A.38) · 39. 3.A.38 (Barro 1990 con ecuaciones y RBC con política fiscal, D088) · 40. 3.A.40 (sin fuente; estancamiento secular y teoría de los multiplicadores) · 41. 3.A.35 (5) · 42. 3.A.41 (3) · 43. 3.A.37 (1)
- *Contabilidad Nacional*: 44. 3.B.11 (4) · 45. 3.A.31 (sin fuente; input-output, antes que 3.A.30, que lo resume) · 46. 3.A.30

**Fase 3. Economía internacional y empresa (3.B)**

- *Economía abierta*: 47. 3.A.32 (sin fuente; Mundell-Fleming, escrito desde 3.B.15) · 48. 3.B.12 (3) · 49. 3.B.16 (3) · 50. 3.B.14 (2) · 51. 3.B.15 (pasa a resumir Mundell-Fleming) · 52. 3.B.19 (2; recibe el G-20 y la OCDE de 3.B.35) · 53. 3.B.17 (0) · 54. 3.B.18 (sin fuente) · 55. 3.B.29 (sin fuente)
- *Comercio Internacional*: 56. 3.B.6 (17; también Falvey) · 57. 3.B.10 (12) · 58. 3.B.5 (5; Haberler) · 59. 3.B.8 (4) · 60. 3.B.7 (3) · 61. 3.B.9 (3)
- *Economía Corporativa y Financiera*: 62. 3.B.23 (5) · 63. 3.B.4 (3) · 64. 3.B.2 (2) · 65. 3.B.3 (2) · 66. 3.B.25 (contango, antes que 3.B.13) · 67. 3.B.13 (2) · 68. 3.B.26 (sin fuente; Diamond-Dybvig y teoría del bucle banca-soberano, antes que 3.B.27) · 69. 3.B.27 (1) · 70. 3.B.1 (0) · 71. 3.B.24 (0)
- *Historia económica*: 72. 3.B.20 (Bretton Woods, único desarrollo) · 73. 3.B.21 (0) · 74. 3.B.32 (sin fuente)
- *Organismos internacionales*: 75. 3.B.22 (0) · 76. 3.B.33 (0) · 77. 3.B.34 (0) · 78. 3.B.35 (0) · 79. 3.B.30 (sin fuente)
- *Unión Europea*: 80. 3.B.45 (9; sin fuente: PEC, MEDE, NGEU, SURE, Semestre) · 81. 3.B.44 (sin fuente; Unión Bancaria y UMC) · 82. 3.B.43 (sin fuente; papel internacional del euro) · 83. 3.B.39 (armonización fiscal) · 84. 3.B.37 (1) · 85. 3.B.41 (1) · 86. 3.B.36 (0; historia general de la UE) · 87. 3.B.40 (0) · 88. 3.B.42 (0) · 89. 3.B.38 (sin fuente)

**Fase 4. Sector público (4.B)** (después de todo el 3.º: sus modelos teóricos ya estarán en forma canónica y cada tema los resume para su examen)

- *Economía política*: 90. 4.B.2 (Condorcet, votante mediano, Niskanen, Leviatán; Borda como referencia del 4.º)
- *Contabilidad pública y fuentes estadísticas*: 91. 4.B.1 (sin el «comodín» del tamaño óptimo)
- *Gastos y presupuestos*: 92. 4.B.21 (10) · 93. 4.B.23 (sin fuente) · 94. 4.B.5 (3) · 95. 4.B.3 (referencia del 4.º de Lorenz y Atkinson; rentas mínimas) · 96. 4.B.22 (3) · 97. 4.B.26 (1) · 98. 4.B.24 (sin fuente)
- *Política fiscal y estabilización*: 99. 4.B.4 (efectos no keynesianos como referencia del 4.º; resumen del RBC fiscal y de la teoría de los multiplicadores)
- *Inversión pública*: 100. 4.B.6 (2)
- *Impuestos*: 101. 4.B.9 (10; progresividad y exceso de gravamen) · 102. 4.B.7 (clasificación SEC de los impuestos) · 103. 4.B.8 (Harberger) · 104. 4.B.11 (5) · 105. 4.B.10 (Fisher con impuestos) · 106. 4.B.12 (impuesto dual; la normativa del IRPF, IS y patrimonio sirve de semilla) · 107. 4.B.13 (la del IVA, ídem) · 108. 4.B.18 (ITF) · 109. 4.B.16 (sin fuente) · 110. 4.B.17 (sin fuente) · 111. 4.B.19 (sin fuente) · 112. 4.B.20 (sin fuente)
- *Federalismo fiscal y haciendas territoriales*: 113. 4.B.14 (sin fuente; competencia fiscal) · 114. 4.B.25 (sin fuente; financiación autonómica)
- *Empresas públicas*: 115. 4.B.15 (2)

**Fase 5. Economía española (4.A)**

- *Fuentes estadísticas*: 116. 4.A.1 (0)
- *Mercado de trabajo*: 117. 4.A.16 (0) · 118. 4.A.2 (sin fuente)
- *Desigualdad*: 119. 4.A.3 (sin fuente)
- *Sector primario*: 120. 4.A.4 (sin fuente)
- *Sector extractivo y energía*: 121. 4.A.5 (sin fuente)
- *Política medioambiental*: 122. 4.A.6 (sin fuente)
- *Política de ciencia y tecnología*: 123. 4.A.7 (sin fuente)
- *Empresa*: 124. 4.A.8 (sin fuente)
- *Industria y política industrial*: 125. 4.A.9 (sin fuente) · 126. 4.A.10 (sin fuente)
- *Construcción*: 127. 4.A.11 (0)
- *Servicios*: 128. 4.A.12 (0) · 129. 4.A.13 (0) · 130. 4.A.14 (0)
- *Políticas de liberalización*: 131. 4.A.15 (0)
- *Política regional*: 132. 4.A.17 (0)
- *Sector financiero y política monetaria*: 133. 4.A.18 (bucle banca-soberano; introducción común del sistema financiero) · 134. 4.A.19 (0) · 135. 4.A.20 (0)
- *Sector exterior*: 136. 4.A.21 (introducción de la BP) · 137. 4.A.22 (0) · 138. 4.A.23 (0) · 139. 4.A.24 (0) · 140. 4.A.25 (0) · 141. 4.A.26 (sin fuente)
- *Historia económica*: 142. 4.A.30 (descomposición del PIB per cápita, trasladada desde 4.A.29) · 143. 4.A.27 (0) · 144. 4.A.28 (0) · 145. 4.A.29 (0)


## 11. Ideas para reorganizar el PowerPoint del temario (fase `--organizacion`)

1. **3.B.13 (mercado de divisas) a «Economía abierta»**: hoy está en «Economía corporativa y financiera», pero es el tema de referencia de las paridades y del tipo de cambio real que usan 3.B.12-3.B.19. Igual **3.B.11 (balanza de pagos)**, que hoy está en «Contabilidad nacional»: o se dibuja en los dos bloques (como ya se hace con 3.A.16 y 3.A.21) o se mueve.
2. **3.A.10 (riesgo e incertidumbre) junto al consumidor**: es la extensión de 3.A.8-3.A.9 (utilidad esperada, CRRA) y prepara 3.A.13; puede quedarse en «Información y poder de mercado» pero con una flecha desde 3.A.8.
3. **Marcar en cada bloque los temas de referencia** (borde grueso) y añadir flechas de «modelo compartido» para los hilos que cruzan bloques: CRRA y Euler (3.A.29 → 3.A.33, 3.A.43, 3.A.42); IS-LM y Mundell-Fleming (3.A.5 → 3.A.32 → 3.B.15 → 4.B.4); NEK (3.A.7 → 3.A.36-3.A.38 → 4.B.4); NEG (3.B.6 → 3.B.10, 3.B.40 → 4.A.17); deuda pública (3.A.39 → 4.B.26 → 3.B.45 → 4.B.21); impuestos (4.B.7-4.B.13 → 4.B.16-4.B.20 → 3.B.39, 4.B.18); mercado de trabajo (3.A.25-3.A.28 → 4.A.16); sector exterior (3.B.11 → 4.A.21-4.A.23).
4. **Bloque «Gobernanza y política fiscal en la UE»**: 3.B.45, 4.B.21, 4.B.26 y 4.A.30 comparten PEC, marco de 2024, MEDE y NGEU; hoy están en tres bloques distintos y es donde más contenido desplazado hay.
5. **Separar en el 4.B «Teoría de la imposición» (4.B.7-4.B.13) e «Impuestos en España» (4.B.16-4.B.20)**: el bloque «Impuestos» tiene 12 temas y mezcla los dos niveles; la separación hace visible el reparto de D022.
6. **Unir «Contabilidad pública y fuentes» (4.B.1) con «Gastos y presupuestos»** o al menos con 4.B.23 (finanzas de las AAPP en contabilidad nacional), que comparte el SEC.
7. **3.B.28 (desarrollo)** puede estar en «Crecimiento económico» y en «Organismos internacionales» (con 3.B.29 y 3.B.30), y **3.B.31 (cambio climático)** junto a 4.A.6 (política de energía y clima) en el esquema combinado.
8. **Temas sin fuente** con un color o trama propios en el PowerPoint, para ver de un vistazo qué falta por escribir (33).

## 12. Propuestas nuevas por el criterio del 3.er y el 4.º ejercicio (13/10/2026)

Al aplicar las decisiones aprobadas se ha repasado todo `mapa.yaml` con el criterio nuevo de `CRITERIOS.md` § 6. **Aprobadas por Víctor el 13/10/2026 (D134-D139) y aplicadas** a las fichas, `mapa.yaml` y `decisiones.json` (resumen en `cambios.md`). Ninguna afecta al 3.A.8 revisado.

**Modelos teóricos cuyo tema de referencia está solo en el 4.º y que usa algún tema del 3.º**

| Modelo | Referencia hoy | Uso en el 3.º | Propuesta |
|---|---|---|---|
| `incidencia-equilibrio-parcial` (incidencia de un impuesto con elasticidades) | 4.B.8 | 3.A.16, **desarrollo** | **Aprobada (D134): doble.** Propuesta: doble, como Lorenz o Borda: 3.A.16 (3.º: incidencia y pérdida de eficiencia en competencia perfecta) y 4.B.8 (4.º: con Harberger). Alternativa: referencia en 3.A.16 y 4.B.8 en resumen suficiente para su examen. |
| `paradoja-condorcet` | 4.B.2 (D121) | 3.A.24, resumen | **Aprobada (D135): doble.** Propuesta: hacerla doble (3.A.24 y 4.B.2), igual que Borda (D120): en 3.A.24 es la antesala de Arrow y no puede depender de 4.B.2. Si se mantiene D121 tal cual, el resumen de 3.A.24 debe incluir el ciclo de votaciones con su ejemplo. |
| `doom-loop` (bucle banca-soberano) | 4.A.18 (D078) | 3.B.26, resumen (sin fuente); 3.B.44, mención | **Aprobada (D136): doble.** Propuesta: doble: el mecanismo teórico en 3.B.26 (crisis financieras, 3.º) y el caso español de 2010-2012 en 4.A.18 (4.º). Hoy el 3.º solo tendría un resumen de algo cuyo desarrollo está en el 4.º. |
| `votante-mediano`, `buchanan-tullock-mayoria-optima`, `downs-hotelling`, `niskanen` | 4.B.2 | 3.A.24 (resumen o mención), 3.A.18 y 3.A.23 (mención) | Mantener la referencia en 4.B.2 (la elección pública es materia del 4.º) y comprobar al revisar 3.A.24 que su resumen del votante mediano y de la mayoría óptima se entiende sin 4.B.2. No requiere decisión salvo que prefieras hacer doble el votante mediano. **Aprobada (D137): el votante mediano, doble (3.A.24 y 4.B.2)**: comprobado que 3.A.24 ya desarrolla la unimodalidad con su gráfico como salida a Arrow. Buchanan-Tullock, Downs-Hotelling y Niskanen siguen en 4.B.2, con resumen o mención autosuficiente en 3.A.24. |
| `rct` (ensayos aleatorizados) | 4.B.6 | 3.A.1, resumen | Sin cambio: 3.A.1 lo usa como método y basta un resumen propio. |

**Remisiones de temas del 3.º a temas del 4.º** (6 en el inventario). Ninguna debe ser necesaria para entender el tema del 3.º; se dejan solo como «para ampliar». **Aprobado (D138)**: en `mapa.yaml` llevan `uso: ampliar` y una `nota`; la de 3.B.27 sobre pánicos pasa a `corregir -> 3.B.26`, y las que faltan de 3.A.16 a 4.B.8/4.B.9 y de 3.A.24 a 4.B.2 también quedan como ampliación:

- 3.A.8 → 4.B.6 (valoración hedónica en el análisis coste-beneficio, ejemplo del Retiro): es una aplicación; el 3.A.8 ya se entiende sin ella. Sin cambio.
- 3.A.24 → 4.B.2 (nota bajo el criterio de Pareto): con Borda y, si se aprueba, Condorcet desarrollados en 3.A.24, la remisión pasa a ser de ampliación.
- 3.B.3 → 4.A.20 y 3.B.27 → 4.A.19/4.A.20 (financiación no bancaria, pánicos): el contenido teórico va en 3.B.26 (Diamond-Dybvig) y 3.B.27; remitir al 4.A solo para el caso español. (La de 3.B.27 sobre pánicos se corrige a 3.B.26.)
- 3.B.8 → 4.A.24/4.A.25 y 3.B.41 → 4.A.25 (instrumentos españoles de apoyo a la internacionalización): ejemplos de aplicación; sin cambio.

**Temas del 4.º que hoy solo mencionan modelos del 3.º que necesitan para cantarse** (comprobar al revisarlos; es la regla «un tema del 4.º resume lo imprescindible»). **Aprobado (D139) para 4.B.15, 4.B.10, 4.B.11 y 4.B.4**: en `mapa.yaml` y en las fichas su papel pasa a «resumen (hoy mencion)» y se añaden las referencias que faltan a 3.A.15, 3.A.9 y 3.A.36:

- **4.B.15** (empresas públicas y regulación): menciona nueve modelos de 3.A.15, 3.A.17 y 3.A.20 (monopolio natural, Ramsey-Boiteux, *price cap*, Averch-Johnson, Laffont-Tirole, tarifa en dos partes, yardstick, impugnables, captura). Necesita un resumen propio de la regulación del monopolio natural.
- **4.B.10 y 4.B.11**: Slutsky, segundo óptimo, Pigou y equivalencia ricardiana solo mencionados; la imposición óptima necesita al menos el enunciado del segundo óptimo y la descomposición de Slutsky.
- **4.A.24 y 4.A.25** (sector exterior): Melitz, gravedad, Stiglitz-Weiss mencionados; basta una frase de resultado de cada uno.
- **4.B.4**: la regla de Taylor solo se menciona; con el NEK fiscal hace falta su forma canónica.

**Idea para la organización** (§ 11): marcar en el PowerPoint los modelos con referencia doble (efectos no keynesianos, Lorenz, Atkinson, Borda y, desde D134-D137, incidencia en equilibrio parcial, Condorcet, bucle banca-soberano y votante mediano) con un enlace 3.º ↔ 4.º, para que se vea que cada examen tiene su desarrollo completo.
