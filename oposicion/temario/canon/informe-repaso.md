# Informe del repaso general del temario (consolidación del canon)

Para Víctor. 13 oct. 2026. Resultado de la consolidación inicial del canon (`/revisartema --canon`): inventario de los 146 temas, fichas de modelos, notación por áreas y mapa de conexiones. Las decisiones están en `decisiones.json` (ids `D001`…`D139`); aquí se agrupan por áreas y se remite a esos ids.

**Estado (13/10/2026): Víctor ha aprobado las 133 decisiones**, todas con la opción recomendada salvo **D088** (RBC con política fiscal: tema de referencia **3.A.38**, no 4.B.4) y **D069, D075, D094 y D120**, que se desarrollan **en los dos ejercicios** (efectos no keynesianos: 3.A.39 y 4.B.4; curva de Lorenz e índice de Atkinson: 3.A.24 y 4.B.3; recuento de Borda: 3.A.24 y 4.B.2), cada tema completo para su examen. Con ellas entra un criterio nuevo (`CRITERIOS.md` § 6): **el 3.er y el 4.º ejercicio son exámenes distintos**; el tema de referencia de un modelo teórico es, siempre que se pueda, del 3.º; los del 4.º lo aplican y resumen lo imprescindible, y ningún tema depende de estudiar el otro ejercicio. Ya están aplicadas al canon (`notacion.md`, `_notacion/`, `modelos/`, `mapa.yaml`; resumen en `cambios.md`). Las propuestas nuevas de la § 12 (D134-D139) también están **aprobadas** (13/10/2026) y aplicadas al canon.

Autor: Víctor Gutiérrez Marcos

## 1. Resumen en cifras

| Concepto | Cifra |
|---|---|
| Temas del temario | 146 (3.A: 45; 3.B: 45; 4.A: 30; 4.B: 26) |
| Temas revisados | 20 (3.A.8, 3.A.9 y 3.A.11 el 13/10/2026; 3.A.12 y 3.A.21 el 14/10/2026; 3.A.16 el 17/10/2026, con el que queda revisado todo el bloque del modelo neoclásico básico; 3.A.17 el 17/10/2026, el primero del bloque de información y poder de mercado; 3.A.13 y 3.A.10 el 19/10/2026, cerrados en paralelo con la notación común del seguro; 3.A.18 y 3.A.14 el 19/10/2026, también en paralelo; 3.A.15 y 3.A.19 el 20/10/2026, en paralelo, con lo que queda revisado el bloque de información y poder de mercado salvo el 3.A.20; 3.A.22 y 3.A.23 el 21/10/2026, en paralelo, los 2 primeros del bloque del bienestar; 3.A.24 el 22/10/2026, con lo que queda revisado el bloque del bienestar salvo el 3.B.31; 3.A.20 el 22/10/2026, sin original, que cierra el bloque de información y poder de mercado y pasa a ser la referencia de la regulación con información asimétrica, P21-02; 3.B.31 el 31/10/2026, sin original, con el que queda revisado todo el bloque del bienestar, referencia del MAFC, del DICE y de los clubes climáticos, § 22; 3.A.25 el 31/10/2026, el primero del bloque de demanda y oferta agregadas, referencia de la oferta y la demanda de trabajo, de Lucas-Rapping, de Becker, de Mincer y de Oaxaca-Blinder, § 23; 3.A.27 el 31/10/2026, referencia de la negociación colectiva, los salarios de eficiencia, los contratos implícitos, los *insiders* y la centralización de la negociación, § 24); además, la guía del primer ejercicio **1D01** (dictamen de coyuntura) el 24/10/2026, que fija la notación de la macro aplicada a los datos (§ 21) |
| Temas con fuente que corresponde al título | 72 |
| Temas con fuente parcial (incompleta o con restos del título anterior) | 5 (3.A.12, 3.A.14, 3.A.22, 3.A.23, 4.A.16; el 3.A.12, el 3.A.14, el 3.A.22 y el 3.A.23 ya revisados: el 3.A.14 se escribió desde cero, y el 3.A.22 y el 3.A.23 se reorganizaron para el título de 2023) |
| Temas cuyo Word es de otro número (renumerados en el 4.º) | 20 |
| Temas cuyo Word es del título antiguo | 16 |
| Temas **sin fuente** (hay que escribirlos) | 33 (escritos ya: el 3.A.20, 22/10/2026, y el 3.B.31, 31/10/2026; el 3.A.15 resultó tener fuente) |
| Modelos, escuelas, políticas e instituciones compartidos (2+ temas) | 211 en el mapa y 231 fichas en la consolidación; hoy (31/10/2026) 280 en el mapa y 300 fichas en `modelos/` (las 3 últimas, del 3.A.27: `sindicato-monopolista`, `insiders-outsiders` y `calmfors-driffill`; las 4 anteriores, del 3.A.25: `becker-capital-humano`, `demanda-trabajo`, `mincer` y `oaxaca-blinder`; las 2 anteriores, del 3.B.31: `dice` y `clubes-climaticos`; las 9 anteriores, de la 1D01: `brecha-produccion`, `okun`, `hechos-estilizados-ciclo`, `indicadores-bancarios`, `marshall-lerner`, `brecha-credito-pib`, `adecuacion-reservas`, `policy-mix` y `contribuciones-crecimiento`) (las de los temas revisados, entre ellas `monopolio`, `discriminacion-precios`, `monopolio-multiproducto`, `monopsonio` y `monopolio-bilateral` del 3.A.17, `akerlof-lemons`, `spence-senalizacion`, `rothschild-stiglitz`, `principal-agente` y `diseno-mecanismos` del 3.A.13 y `utilidad-esperada-vnm`, `aversion-riesgo-arrow-pratt` y `demanda-seguros` del 3.A.10, `dixit-stiglitz`, `hotelling`, `salop`, `shaked-sutton` y `oligopolio-diferenciado` del 3.A.18 y `equilibrio-nash`, `nucleo-shapley` y `nash-negociacion` del 3.A.14, `disuasion-entrada`, `costes-transaccion`, `contratos-incompletos`, `estructura-conducta-resultado` y `modelos-gerencialistas` del 3.A.15 y `cournot`, `bertrand`, `stackelberg` y `cartel` del 3.A.19, `criterios-compensacion` del 3.A.22, `lindahl` y `tragedia-comunes` del 3.A.23 y `sen-liberal`, `may` y `logrolling` del 3.A.24) |
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
| 3.A.10 | 0 | ~~3.B.24→3.A.1, 3.B.23; 3.B.17, 3.B.27→3.B.26, 3.B.27~~: corregidas; las 2 autorreferencias desaparecen; añadidas 3.A.1, 3.A.11 (Sandmo), 3.A.12, 3.A.14, 3.A.34 y 3.A.35; revisado el 19/10/2026 (15 temas de destino, todos `ok`) | — |
| 3.A.11 | 4 | 3.A.9→3.A.11; 3.A.10→3.A.12; 3.A.11, 3.A.14-3.A.17→3.A.15, 3.A.16, 3.A.19; 3.A.23→3.A.22 | — |
| 3.A.12 | 0 | ~~3.A.9→3.A.8~~: desfasada, la remisión de Slutsky a 3.A.9 es la correcta (D139); revisado el 14/10/2026 | — |
| 3.A.13 | 0 | ~~3.A.7→3.A.10~~ (pie de las imágenes 4-6: desaparece, la fuente pasa a MWG); ~~3.A.20~~ de Laffont-Tirole → 3.A.17; las notas privadas (3.A.23 ×2, autorreferencia, «comodín») no se publican; las 5 que faltaban (3.A.14, 3.A.15, 3.A.25, 3.B.26, 3.A.23) y otras nuevas añadidas (3.A.16, 3.A.17, 3.A.21, 3.B.3, 3.B.28, 3.A.1…; 4.A.24, 4.B.2 y 4.B.11 solo para ampliar); revisado el 19/10/2026 | — |
| 3.A.15 | 0 | Sin fuente en la consolidación; escrito desde el Word del antiguo 3.A.11 de Víctor: sus remisiones antiguas (3.A.9→3.A.11; 3.A.10→3.A.12; 3.A.14-3.A.17→3.A.16-3.A.19; 3.A.15 y 3.A.25→3.A.17, 3.A.20; 3.A.17→3.A.18; 3.A.24→3.A.23) traducidas y 13 añadidas (3.A.1, 3.A.14, 3.A.18-3.A.20, 3.A.22, 3.A.23, 3.A.44, 3.B.18, 3.B.39; 4.A.12, 4.A.15, 4.B.2 y 4.B.15 solo para ampliar); revisado el 20/10/2026 | — |
| 3.A.16 | 0 | ~~3.A.14→3.A.16 (×2)~~: eran notas privadas, no se publican; ~~3.A.11→3.A.12 (×2)~~: corregidas; la telaraña remitida a 3.A.10 pasa a 3.A.6 y 3.A.5; revisado el 17/10/2026 | — |
| 3.A.17 | 0 | ~~3.B.4→3.A.15~~ y ~~3.B.4→3.B.39~~: corregidas; ~~3.A.14→3.A.16~~ y la nota de 3.A.23 (von Mises, Lange, Hayek, Hurwicz): eran comentarios privados, no se publican; 13 referencias que faltaban añadidas (3.A.9, 3.A.13, 3.A.14, 3.A.21, 3.A.25, 3.A.27…); revisado el 17/10/2026 | — |
| 3.A.18 | 0 | ~~3.A.6→3.A.8; 3.A.10→3.A.14~~: corregidas; la frase «σ > 1 implícito en curvas convexas» corregida (remite a 3.A.8 por la convexidad, σ > 0); las 5 que faltaban (3.A.14, 3.A.17, 3.A.20, 3.A.22, 3.A.11) y otras nuevas añadidas (3.A.7, 3.A.13, 3.A.15, 3.A.19, 3.A.44, 3.B.39…; 4.B.2 solo para ampliar); revisado el 19/10/2026 | — |
| 3.A.19 | 0 | ~~3.A.10→3.A.14 (×2); 3.A.23→3.A.22; 3.B.4→3.B.39~~: corregidas; las 4 que faltaban (3.A.14, 3.A.17, 3.A.20, 4.A.15 solo para ampliar) y otras nuevas añadidas (3.A.13, 3.A.15, 3.A.16, 3.A.22, 3.B.6, 3.B.8, 3.B.27); la remisión «las barreras se van al nuevo 3.A.15» es ahora la de III.3; revisado el 20/10/2026 | — |
| 3.A.20 | 0 | Sin fuente en la consolidación: escrito desde cero el 22/10/2026 (Tebar y el DCE 3.A.18 de Cabado como estructura, sin copiar texto), con 24 remisiones `\vertema`, todas `ok` (las del 4.º, solo para ampliar); cumple lo que le prometen el 3.A.12, 3.A.15, 3.A.16, 3.A.17, 3.A.18, 3.A.19, 3.A.22 y 3.A.23 | — |
| 3.A.21 | 0 | ~~3.A.22→3.A.23~~ (nota de las externalidades): corregida; revisado el 14/10/2026 | — |
| 3.A.22 | 0 | ~~3.B.8, 3.B.17→3.B.7, 3.B.28~~: la propuesta era errónea (el 3.B.8 es el de la industria naciente); quedan 3.B.8, 3.B.28 y 3.B.17 por separado; ~~3.A.23→3.A.22~~ («no desarrollarlo con demostraciones»: comentario privado, fuera); ~~3.A.23→3.A.21, 3.A.16~~ y ~~3.A.21, 3.A.22, 3.A.23~~: corregidas; las que faltaban (3.A.21, 3.A.16, 4.B.11, 4.B.3, 3.A.14, 3.A.23, 3.A.17) y otras nuevas añadidas (3.A.11, 3.A.13, 3.A.15, 3.A.18, 3.A.19, 3.A.20, 3.B.10, 4.B.9); revisado el 21/10/2026 | — |
| 3.A.23 | 0 | ~~3.A.15, 3.A.16, 3.A.17→3.A.17-3.A.20; 3.A.17, 3.A.19→3.A.15, 3.A.16; 3.A.22→3.A.8; 3.A.27→3.A.14; anexo 1→3.A.22~~: corregidas (los supuestos remiten al 3.A.16, nota 12 al 3.A.21; la 2.ª ley de Gossen sale con el apartado); las notas de coordinación eran comentarios internos; nuevas: 3.A.36, 3.A.39, 4.B.6, 4.B.13-4.B.15, 4.B.21; revisado el 21/10/2026 | ~~3.A.23; 3.A.22~~ |
| 3.A.24 | 0 | ~~3.A.16, 3.A.21, 3.A.22, 3.A.23, 3.A.24→3.A.22~~: el anexo de relación pasa a «Qué estudia cada tema del bloque» (`anexo:bloque`); las que faltaban (4.B.2, 3.A.23, 3.A.1, 4.A.3, 4.B.3, 4.B.11, 4.B.6, 3.A.18 y Gibbard-Satterthwaite al **3.A.14**, no al 3.A.13) añadidas, y nuevas: 3.A.16, 3.A.20, 3.A.21, 3.B.31; revisado el 22/10/2026 | — |
| 3.A.25 | 0 | ~~3.A.6→3.A.8~~; ~~3.A.14→3.A.21~~; ~~3.A.19→3.A.26~~; ~~3.A.12→3.A.29~~ (con 3.A.33): corregidas; las que faltaban, añadidas (3.A.4, 3.A.6, 3.A.9, 3.A.11, 3.A.12, 3.A.13, 3.A.17, 3.A.22, 3.A.26-3.A.29, 3.A.33, 3.A.34, 3.A.42-3.A.44 y, para ampliar, 4.A.2, 4.A.16, 4.B.10): 23 en total, todas `ok`; revisado el 31/10/2026 | — |
| 3.A.27 | 0 | Las 10 del original estaban bien; se quitan las de 3.A.8 y 3.A.9 (notas que desaparecen) y se añaden las que faltaban (3.A.4, 3.A.7, 3.A.14, 3.A.17, 3.A.21 y, para ampliar, 3.B.16 y 4.A.16), y 3.A.26 y 3.A.28 ganan remisiones en I.3, III.3 y la conclusión: 13 destinos, todos `ok`; revisado el 31/10/2026 | — |
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
| 3.A.10 | Resuelto el 19/10/2026 (unos 40 errores): la demanda de seguros con información simétrica atribuida a Rothschild-Stiglitz (es Mossin, 1968), con A = (p_1, p_2; W, W − P) y la pendiente con el signo cambiado; axiomas sobre ℝⁿ₊ y «independencia de alternativas irrelevantes»; vNM «ordinal» por admitir «transformaciones lineales crecientes»; «ESI ≡ σ = 1/θ»; la aversión como «condición necesaria» del ahorro precautorio; media-varianza por el teorema central del límite; crítica de los casinos atribuida a Friedman-Savage (es de Markowitz); Savage con la independencia de Anscombe-Aumann; Schmeidler confundido con Quiggin; criterio de Savage como suma de pesares; *Theory of Games* «de 1994»; FGD «vía presupuestos» y Grecia con 50.000 M€ |
| 3.A.11 | Fórmula de la proporcionalidad de escala mal escrita (dz_L/dz_L); σ = 0 y σ = 1 presentados como casos exactos de la CES (son límites) |
| 3.A.12 | Falta el epígrafe de aplicaciones empíricas del título (resuelto el 14/10/2026: bloque IV nuevo) |
| 3.A.14 | Resuelto el 19/10/2026 (tema escrito desde cero): equilibrio de Nash con desigualdad estricta; núcleo con ≤ y sin eficiencia; pago del segundo precio sin definir j; «EBPS»; inducción hacia atrás como «tipo de equilibrio»; equivalencia de ingresos mal atribuida; Milgrom «siempre»; abiertas «secuenciales» |
| 3.A.15 | Resuelto el 20/10/2026 (unos 30 errores del Word del antiguo 3.A.11 y del bloque de barreras del 3.A.19): mercados impugnables con 6 condiciones («rendimientos constantes», «costes de menú», «la demanda se adapta instantáneamente»); Coase con la frontera en totales; Williamson «alumno de Coase» y frecuencia que «encarece» la transacción; Grossman y Hart «1985»; «la empresa crece hasta hacerse con todos los derechos residuales»; Baumol sin beneficio mínimo; Williamson (1964) sin definir la restricción; *saltwater/freshwater* para Harvard y Chicago; pérdida del ECR como ineficiencia productiva; índices mal escritos y umbrales del HHI mezclados; Olivencia «1999» y «Código Conthe» de 2015; motivación del Nobel de Williamson mal traducida; juego de disuasión con π «unitarios» y precio límite «por debajo de los costes medios de todas las empresas» |
| 3.A.19 | Resuelto el 20/10/2026: φ para la función de reacción; Nash «desarrolla la forma extensiva y los repetidos» (son Kuhn y Aumann); $P_1=\mathrm{CMg}_2-\varepsilon$; π «beneficios unitarios»; 6 condiciones de impugnabilidad y notas de las aerolíneas y Pepephone (pasan corregidas al 3.A.15); anexo de teoría de juegos que repetía el 3.A.14; la mitad cooperativa del título en unas 250 palabras. Queda **[decidir]** la escala del IHH (§ 17) |
| 3.A.20 | Sin original. No pasan al tema los errores de las referencias externas (Tebar: «GAFAM», ψ′(e) = q con un proyecto de tamaño dado, monopolio natural «fuerte/débil», óptimos «de 1.er y 2.º orden», umbrales del 40 % y del 30 % sin fuente; Cabado: la potencia b con la convención contraria). Resuelto el 22/10/2026 |
| 3.A.18 | Resuelto el 19/10/2026 (unos 25 errores): Dixit-Stiglitz sin renta, *mark-up* que dependía «negativamente» de la preferencia por la variedad, σ > 1 «por convexidad», demanda de la empresa 2 con localizaciones generales, costes «cuadráticos» por lineales en la existencia del equilibrio, Salop con n° > n*, corto plazo de Chamberlin sin beneficios, atribución de Shaked-Sutton |
| 3.A.21 | Supone a la vez convexidad estricta del conjunto de producción (que con la inacción sí implica rendimientos decrecientes) y rendimientos no crecientes, y usa después rendimientos constantes; propiedades de las demandas netas copiadas de la oferta; núcleo definido en la caja de la producción (resuelto el 14/10/2026: conjunto convexo, no estricto; núcleo en la caja de intercambio) |
| 3.A.22 | ~~Utilidades «ordinales» con utilidad marginal decreciente; atribuye a Debreu propiedades de la función de utilidad; «2×2×2» con 10 incógnitas~~ (resuelto el 21/10/2026; también μ negativo, RMT con signo menos, isoclina con homotéticas, el ultimátum como ENPS para cualquier reparto, Dupuit 1884, Little con los puntos 2 y 6 y la montaña «de Meade») |
| 3.A.23 | ~~Bienes públicos: X fijo y a la vez FPP T(X,G) = 0; externalidad en consumo (analítica) y en producción (gráfica) sin enlazar; Clarke-Groves sin terminar~~ (resuelto el 21/10/2026; también los «seis supuestos» del 1TFEB, el RCDE como «sistema de Coase» y Pareto con el título de su manual equivocado) |
| 3.A.24 | ~~Mezcla cardinalidad y comparabilidad interpersonal; problema del planificador vacío; «ley D'Hont»~~ (resuelto el 22/10/2026; también la IAI sobre las preferencias individuales, el dictador con preferencia débil, Borda «cardinal», los costes de Buchanan-Tullock cambiados, Harsanyi «neutral al riesgo», el ultimátum de Thaler, el dictador al 50 % y Gibbard-Satterthwaite sin sobreyectividad) |
| 3.A.13 | Resuelto el 19/10/2026 (más de 25 errores): «distorsión en la cumbre» atribuida a los buenos conductores (es al revés: no hay distorsión arriba); «Arrow-Hahn» por Arrow-Debreu; principio de revelación «de Myerson (1979)» como base de un modelo de 1976; programa del agente con PC e IC (es el del principal); w(e) con esfuerzo inobservable; «equilibrio aunador» en Akerlof; pendiente del seguro con el signo cambiado; Stiglitz-Weiss con proyectos «muy rentables y arriesgados», E[B] = r̂ × Pr y «oferta cóncava»; QE que desplaza la oferta «hacia arriba»; dato de efectivo del S&P 500 sin fuente; riesgo moral sin resolver (caso c con «[…]», soluciones y valoración vacías) |
| 3.A.17 | Resuelto el 17/10/2026 (más de 25 errores): regla de Ramsey-Boiteux con λ al revés («cuanto mayor λ, menor el margen»); Lerner multiproducto con la elasticidad cruzada equivocada; 1.er grado «con ineficiencia asignativa»; 3.er grado como «mejora de Pareto»; economías de alcance como definición del monopolio natural multiproducto; pruebas de subsidios cruzados como condición suficiente; monopsonio con «paro involuntario» y GMg = oferta; tarifa de punta CF/n + CMg·q; Laffont-Tirole mal contado; Mill, Marshall, Olson y Shleifer mal fechados o escritos |
| 3.B.27, 4.A.20 | Stiglitz-Weiss con «2 tipos de clientes muy rentables y arriesgados / menos rentables y menos arriesgados», «criterios medios», E[B] = r̂ × Pr(repago) y «oferta cóncava» (el modelo supone igual media y distinto riesgo; 𝔼[B_banco] = (1 + r̂)·Pr; la oferta se dobla hacia atrás; ficha `stiglitz-weiss`) |
| 3.A.25 | Resuelto el 31/10/2026 (más de 35 errores, tabla en `fuentes/3A25/revision.md`): anexo copiado del 3.A.17 original (GMg = oferta, paro involuntario con monopsonio, W y Π); efectos renta y sustitución al revés; restricción y holgura de Kuhn-Tucker; CSO de la demanda; «unicidad y estabilidad» por la competencia; oferta normal de Marshall decreciente; Lucas-Rapping sin β, «lim B_t = 0» y el permanente «en la misma proporción»; Frisch y neutralidad al riesgo; Becker 1962/1964; «teorema de Acemoğlu y Autor» por Fisher; «Gardener»; rendimientos de Mincer sin fuente |
| 3.A.27 | Resuelto el 31/10/2026 (más de 25 errores, tabla en `fuentes/3A27/revision.md`): los contratos implícitos «generan paro involuntario» (es al revés: explican la rigidez, no el paro); axiomas de Nash («transformaciones lineales», simetría como poder), Rubinstein de horizonte finito; «ENPS» en el derecho a gestionar; pendiente de la isobeneficio invertida; «zona de Malinvaud»; Shapiro y Stiglitz sin la prima en la demanda y el caso $s=0$ desde la demanda; $e(w)/w$ y $\varepsilon_{w,e}$ en Solow; escaqueo como «teorías sociológicas (Akerlof)» y rotación de «Milgram»; *insiders* con salario contracíclico como idea central; contratos fuertemente eficientes con una comparación sin fuente (EE. UU. frente a Europa); paro «de tipo clásico» sin efectos de la demanda; Nobel de Hicks, Nash y Pissarides mal citados. **El 3.A.7 copia varios de estos errores** (contradicciones del 3.A.27 en `mapa.yaml`) |
| 3.A.36, 3.A.41 | Misma derivación errónea de Barro-Gordon que 3.A.6 |
| 3.A.43 | Regla de oro sin g (∂y/∂k = δ + n); ejemplo de trampa de pobreza que no genera dos estados estacionarios (D110) |
| 3.B.1 | GAO definido sobre el EBIAT (debe ser sobre el EBIT); fórmula de apalancamiento con ROA después de impuestos (D062) |
| 3.B.2-3.B.4 | WACC sin (1 − t_IS) en el coste de la deuda |
| 3.B.3 | Miller (1977): condiciones sobre t_D y t_E invertidas; r_E/(1 + t_IRPF) dudoso en P_0 |
| 3.B.4 | «Múltiplo EBITDA» con la fórmula del EBIT; apartado «¿Qué método utilizar?» duplicado; copia el bloque de costes de transacción del antiguo 3.A.11 con sus errores (Coase en totales, frecuencia, «contratos incompletos de Williamson», título de Penrose, Marris en la agencia; detectado en la revisión del 3.A.15, `mapa.yaml`) |
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
| 4.B.15 | Laffont-Tirole: b cambia de sentido entre el texto y el anexo; «Ramsey-Boiteaux»; tarifa de punta CF/n + CMg·q (es p_p = b + β, ya corregido en el 3.A.17); subaditividad remitida a 3.A.10 (es 3.A.17); Averch-Johnson con r y P |
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
| Salarios de eficiencia (Solow y Shapiro-Stiglitz) y contratos implícitos, con los mismos errores | 3.A.27, 3.A.7 | Desarrollo en 3.A.27 (hecho, 31/10/2026); el 3.A.7, resumen con remisión |
| Bruno y Sachs y Calmfors y Driffill (anexo 1 del Word del 3.A.27, con la misma figura escaneada) | 3.A.27, 3.B.16, 4.A.16 | Desarrollo en el anexo D del 3.A.27 (hecho, 31/10/2026, con `joroba.tex`); resumen en 3.B.16 y 4.A.16 (ficha `calmfors-driffill`) |
| Axiomas de Nash | 3.A.14, 3.A.27, 3.A.26 (nota 32) | Desarrollo en 3.A.14 (D5); el 3.A.27 los deja en su anexo A con remisión (hecho); el 3.A.26, remisión |
| Curva de Phillips | 3.A.4, 3.A.28 | D031 |
| Modelo 2×2×2×2 y TFEB | 3.A.22, 3.A.23 | Solo en 3.A.22 (hecho, 21/10/2026: el 3.A.23 resume en 1′ y deja un anexo corto de recordatorio, A23-01) |
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
| 3.A.15 | ~~Mercados impugnables (3.A.19), Simon y agencia (3.A.1, 3.A.13)~~ Resuelto el 20/10/2026: había fuente, el Word del antiguo 3.A.11 de Víctor, que él había puesto al día con el título nuevo (`fuente_disponible: renumerado`); barreras e impugnables del 3.A.19 |
| 3.A.20 | ~~Regulación del viejo 4.B.16 (hoy en el Word de 4.B.15), captura y yardstick~~ Escrito el 22/10/2026 sin original (CRITERIOS § 5), con el anexo A del 3.A.17, las fichas del canon y los temas de Tebar y de Cabado (DCE) como base |
| 3.A.31 | Remisiones y esquema de 3.A.30 |
| 3.A.32 | Mundell-Fleming de 3.B.15 (D014), OA-DA de 3.A.37 |
| 3.A.40 | Estancamiento secular de 3.A.39, multiplicadores de 4.B.4, NEK en el límite inferior |
| 3.B.18 | Trilema y flujos de capital (3.B.15-3.B.17) |
| 3.B.26 | Diamond-Dybvig de 4.A.20 y 3.B.27, crisis de 2008 de 4.A.18 |
| 3.B.29 | Sostenibilidad de la deuda externa (3.B.12), Banco Mundial y FMI |
| 3.B.30 | Ninguno relevante |
| 3.B.31 | ~~MAFC de 3.B.37, Pigou y cap-and-trade de 3.A.23~~ Escrito el 31/10/2026 sin original (CRITERIOS § 5), con la estructura de Tebar, las fichas del canon y los temas revisados del bloque (§ 22) |
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
| Modelo 2×2×2×2 y TFEB | 3.A.23 | 3.A.22 (hecho, 21/10/2026: bloques I y II, con demostración) | (título vigente); A23-01 |
| Criterios de compensación | 3.A.22 (cuerpo, bloque 2) | 3.A.22 (anexo `anexo:compensacion`, hecho, 21/10/2026) y 3.A.24 (resumen, hecho, 22/10/2026) | (título vigente); A22-01, opción a (Víctor; D1 del 3.A.22, § 18) |
| Curva de Lorenz e índice de Gini | 4.B.3 (resumen); 3.A.24 (no salía) | 3.A.24 (desarrollo del 3.º, hecho, 22/10/2026: II.4.1, `eq:gini`, `lorenz.tex`) y 4.B.3 (desarrollo del 4.º) | D075 |
| Índice de Atkinson | 3.A.24 y 4.B.3 (mención, sin fórmula) | 3.A.24 (desarrollo del 3.º, hecho, 22/10/2026: `eq:atkinson` con la ϵ de la isoelástica) y 4.B.3 (desarrollo del 4.º) | D094 |
| Mercados impugnables | 3.A.19 | 3.A.15 (hecho, 20/10/2026: III.3 con los 3 supuestos canónicos; el 3.A.19, resumen en III.3) | D071 |
| Barreras de entrada: precio límite, juego de disuasión en 3 etapas, predación (bloque 3 del Word) | 3.A.19 | 3.A.15 (hecho, 20/10/2026: III.2, ficha `disuasion-entrada`); el 3.A.19 las resume en III.3 y su III pasa a ser «Soluciones cooperativas» | D1 del 3.A.19, provisional |
| Anexo 1 «Teoría de juegos» | 3.A.19 | Fuera; remisiones al 3.A.14 donde se usa (hecho, 20/10/2026) | K22 del 3.A.19 |
| Austriacos y Schumpeter | Cuerpo del antiguo 3.A.11 | Anexo A del 3.A.15 con una nota en Chicago (hecho, 20/10/2026) | D3 del 3.A.15, provisional |
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
| Stiglitz-Weiss y Diamond-Dybvig | 3.B.27, 4.A.20 | 3.A.13 (Stiglitz-Weiss: bloque III, hecho, 19/10/2026) y 3.B.26 | D070, D042 |
| Diamond-Dybvig (anexo de ≈ 3.000 palabras y 4 gráficos, más largo que el del 3.B.27) | Anexo 3 del 3.A.10 | Anexo C del 3.A.10 resumido (hecho, 19/10/2026; decisión de Víctor A10-01), con la notación del canon y un gráfico que puede reutilizar el 3.B.26; la regulación, al 3.B.26 y el 3.B.27 | D042 |
| Caja de finanzas conductuales (prima de las acciones, volatilidad, disposición, dividendos) | 3.A.10 y 3.B.23 (casi literal) | Anotación del 3.A.10 que no se canta (hecho, con cifras con fuente); el 3.B.23 desarrolla la eficiencia y resume o remite la explicación conductual (ficha `emh`) | — |
| Empresa aversa al riesgo (Sandmo, 1971) y demanda de un activo con riesgo (Arrow) | Remisión del 3.A.11 y comentario de Víctor (P10) | I.2.2 y I.2.3 del 3.A.10, «no se canta» (hecho; A10-03 sin contestar: alternativa, a un anexo) | — |
| «Implicaciones sobre la eficiencia» (bloque 0 del Word) | Primer bloque del 3.A.13 | Contextualización teórica de la introducción del 3.A.13 (hecho, 19/10/2026; D1 de esa revisión, provisional) | — |
| Juegos de señalización, criterio intuitivo y diseño de mecanismos | Notas del 3.A.13 | 3.A.14 (hecho, 19/10/2026: II.2 y III.2; ficha `diseno-mecanismos` con referencia en el 3.A.14, provisional, § 14 y § 16) | D9 del 3.A.13, D3 del 3.A.14 |
| Bertrand y Cournot con producto diferenciado; publicidad y proliferación de marcas (anexo 7) | Nota 13 del 3.A.19; anexo del 3.A.18 | Cuerpo del 3.A.18 (hecho, 19/10/2026: II.2 y III.2; ficha `oligopolio-diferenciado`); el 3.A.19 resume y remite | D2 y D4 del 3.A.18 |
| Teorema de tradición oral (*folk theorem*) | 3.A.19 (ficha `dilema-prisionero`) | Concepto en el 3.A.14 (hecho, 19/10/2026: I.3.2, gatillo con β ≥ 1/5); aplicación a la colusión en el 3.A.19 | D4 del 3.A.14 |
| Subastas del Tesoro | Word guardado como 4.A.19 (numeración antigua) | 4.B.26 (política de financiación del Tesoro), con la nota de terminología del 3.A.14 | D8 del 3.A.14 |
| Normativa del IRPF, IS, IP, IVA | 4.B.12, 4.B.13 | 4.B.16, 4.B.17, 4.B.19, 4.B.20 | D022 |
| Armonización fiscal (viejo 4.B.18) | 4.B.18 | 3.B.39, 4.B.18, 4.B.20 | D074 |
| Regulación de la empresa pública (viejo 4.B.16) | Word de 4.B.15 | 3.A.17 y 3.A.20 | D092, D091 |
| Regulación y control del monopolio (bloque 4 del Word) | Cuerpo del 3.A.17 | Anexo A del 3.A.17 (hecho, 17/10/2026); en el cuerpo, solo la regulación básica del monopolio natural (II.2.3) | D1 del 3.A.17 (P21-02, 21/10/2026) |
| Averch-Johnson, *price cap*, Laffont-Tirole y *yardstick* (y Loeb-Magat, Baron-Myerson, captura) | Anexo A del 3.A.17 | 3.A.20, revisado el 22/10/2026 (tema de referencia); el 3.A.17 pasa a mención con su anexo A resumido cuando Víctor apruebe el 3.A.20 (`pendientes-coherencia.md`, «Pendiente del 3.A.20») | D1 del 3.A.17 (P21-02, opción a, 21/10/2026) |
| Monopsonio en el mercado de trabajo (anexo 1 del Word) | Anexo del 3.A.17 y copia en el anexo del 3.A.25 | Cuerpo del 3.A.17 (III.1, hecho); el 3.A.25 lo resume en I.4 y en su anexo D, y remite (hecho, 31/10/2026) | — |
| Cifras de los PGE / COFOG | 4.B.21 / 4.B.22 | 4.B.22 / 4.B.23 | D055 |
| Input-output | 3.A.30 | 3.A.31 | D112 |

## 8. Problemas de fuente que condicionan la revisión

- **Esquemas, no temas:** 3.A.14 era un esquema ajeno (384 líneas, sin bibliografía; resuelto el 19/10/2026: escrito desde cero con los manuales, sin copiar el Word ni citar a preparadores); 3.A.5 es un borrador incompleto; 3.A.12 no tiene las aplicaciones empíricas.
- **Notas de trabajo y textos copiados** («Copiar de Sahuquillo», «Ver tema de Juan Luis», «copiado de María Palacios Carrere»): 3.A.13 (resuelto el 19/10/2026: redactado de nuevo desde Laffont-Martimort y MWG; fuera el escaneo de un manual de preparador), 3.A.10 (resuelto el 19/10/2026: fuera los nombres de preparadores y «Tema Juan Luis Cordero Tarifa», las imágenes de Policonomics, Yemshanov y Neuroprofiler, los enlaces rotos y la tabla de la nota 43 sin fuente, rehecha citando cada obra; 12 gráficos en TikZ), 3.A.12, 3.A.24 (resuelto el 22/10/2026: el tramo copiado de las pp. 25-28 redactado de nuevo; fuera las capturas de Inman, Gaertner, Jehle y Reny y Varian, el correo de un preparador, «según José Luis» y los temas de preparadores de la bibliografía; las 12 capturas del anexo, una demostración propia), 3.B.9, 4.B.9, 4.A.17, 4.A.21, 4.A.23. En la revisión se reescriben con fuentes propias y se citan.
- **3.A.15 y 3.A.19 (resueltos el 20/10/2026):** párrafos marcados como «copiados tal cual» de otro preparador y de Policonomics, imágenes sin fuente, «Apuntes Sahuquillo», «Apuntes ICEX-CECO» y «Tema Juan Luis Cordero Tarifa» en la bibliografía, 10 páginas escaneadas de Cerdá *et al.*: todo redactado de nuevo desde las obras originales y los manuales (Tirole, 1988; Vives, 1999; Motta, 2004); el material de ICEX-CECO y de otros preparadores solo se usó para contrastar.
- **3.A.22 y 3.A.23 (resueltos el 21/10/2026):** Word con el título de 2023 y el contenido del anterior (el 3.A.23 desarrollaba el 2×2×2×2 y los teoremas, y el 3.A.22 los solo mencionaba); capturas de MWG, de Maté y Pérez y de otros preparadores, imágenes de Wikipedia y un manuscrito: todo redactado de nuevo con los manuales y las obras originales, con 24 gráficos TikZ nuevos o reutilizados (15 y 9) y las tablas en LaTeX; las imágenes de otros preparadores pasan a «elaboración propia a partir de» las obras originales.
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

- *Modelo neoclásico básico*: 1. 3.A.9 (10) · 2. 3.A.11 (8; ahora también referencia de la Cobb-Douglas) · 3. 3.A.12 (8) · 4. 3.A.21 (5; revisado el 14/10/2026) · 5. 3.A.16 (3; revisado el 17/10/2026, con la ficha nueva `telarana`)
- *Información y poder de mercado*: 6. 3.A.17 (12; también yardstick; revisado el 17/10/2026, con 5 fichas nuevas: `monopolio`, `discriminacion-precios`, `monopolio-multiproducto`, `monopsonio` y `monopolio-bilateral`) · 7. **3.A.10** (revisado el 19/10/2026, en paralelo con el 3.A.13 y con la notación común del seguro, con 3 fichas nuevas: `utilidad-esperada-vnm`, `aversion-riesgo-arrow-pratt` y `demanda-seguros`; antes que 3.A.14, que usa la utilidad esperada) · 8. 3.A.13 (6; revisado el 19/10/2026, con Stiglitz-Weiss en desarrollo y 4 fichas nuevas: `akerlof-lemons`, `spence-senalizacion`, `rothschild-stiglitz` y `principal-agente`) · 9. 3.A.14 (3; revisado el 19/10/2026, en paralelo con el 3.A.18, con 3 fichas nuevas: `equilibrio-nash`, `nucleo-shapley` y `nash-negociacion`) · 10. 3.A.18 (1; revisado el 19/10/2026, con 5 fichas nuevas: `dixit-stiglitz`, `hotelling`, `salop`, `shaked-sutton` y `oligopolio-diferenciado`) · 11. 3.A.15 (revisado el 20/10/2026, desde el Word del antiguo 3.A.11, en paralelo con el 3.A.19; referencia de los mercados impugnables y de 5 fichas nuevas: `disuasion-entrada`, `costes-transaccion`, `contratos-incompletos`, `estructura-conducta-resultado` y `modelos-gerencialistas`) · 12. 3.A.19 (revisado el 20/10/2026; resume los impugnables y es referencia de 4 fichas nuevas: `cournot`, `bertrand`, `stackelberg` y `cartel`)
- *Economía del Bienestar e Intervención del Sector Público*: 13. **3.A.22** (antes que 3.A.23, que se apoya en los teoremas del bienestar; revisado el 21/10/2026, con la ficha nueva `criterios-compensacion`) · 14. 3.A.23 (12; revisado el 21/10/2026, en paralelo con el 3.A.22, con las fichas nuevas `lindahl` y `tragedia-comunes`) · 15. 3.A.24 (referencia del 3.º de Lorenz, Atkinson y Borda, además de Arrow; revisado el 22/10/2026, con las fichas nuevas `sen-liberal`, `may` y `logrolling`) · 16. 3.A.20 (sin fuente; revisado el 22/10/2026, escrito desde cero: referencia de la captura del regulador y, por la P21-02, de Averch-Johnson, Laffont-Tirole con Baron-Myerson, el *price cap*, el *yardstick* con Loeb-Magat y la regulación con información asimétrica; fichas nuevas `mercado-relevante`, `competencia-por-mercado` y `precio-acceso`, [decidir]) · 17. 3.B.31 (sin fuente; revisado el 31/10/2026, escrito desde cero: referencia del MAFC, en desarrollo, y de las fichas nuevas `dice` y `clubes-climaticos`, [decidir]; con él queda revisado todo el bloque del bienestar)

**Fase 2. Macroeconomía (3.A)** (mismo criterio de dependencias que D133; es una propuesta de orden, no una decisión nueva)

- *Demanda Agregada y Oferta Agregada*: 18. **3.A.25** (Lucas-Rapping y oferta de trabajo: base del mercado de trabajo; revisado el 31/10/2026, con 4 fichas nuevas: `becker-capital-humano`, `demanda-trabajo`, `mincer` y `oaxaca-blinder`; § 23) · 19. **3.A.27** (revisado el 31/10/2026, con 3 fichas nuevas: `sindicato-monopolista`, `insiders-outsiders` y `calmfors-driffill`; § 24) · 20. 3.A.26 · 21. 3.A.28 (7) · 22. 3.A.33 (5) · 23. 3.A.34 (4)
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
2. **3.A.10 (riesgo e incertidumbre) junto al consumidor**: es la extensión de 3.A.8-3.A.9 (utilidad esperada, CRRA) y prepara 3.A.13; puede quedarse en «Información y poder de mercado» pero con una flecha desde 3.A.8. Revisado (19/10/2026), confirma que es un nudo: de él salen la utilidad esperada (3.A.13, 3.A.14, 3.A.24, 3.A.27, 3.B.23), la aversión y la prudencia (3.A.29, 3.A.33, 3.A.35) y la economía conductual (3.A.1, 3.B.23) (§ 15).
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

## 13. Decisiones abiertas tras la revisión del 3.A.17 (17/10/2026)

El coordinador aplicó la opción recomendada mientras Víctor no conteste en el artifact de dudas; el canon las recoge como provisionales.

- **[decidido 21/10/2026: P21-02, opción a; aplicado al canon el 22/10/2026 con la revisión del 3.A.20, § 20] D1 · Referencia de la regulación con información asimétrica.** Víctor aprueba la propuesta: la referencia pasa al 3.A.20 cuando se revise (también Loeb-Magat); el 3.A.17 queda en mención con su anexo A resumido y `\vertema{3.A.20}`, y las remisiones del 3.A.13 y el 3.A.14 pasan al 3.A.20 en ese momento (`pendientes-coherencia.md`, «Decisiones de Víctor del 21/10/2026»; fichas `laffont-tirole`, `price-cap`, `averch-johnson`, `yardstick`). Planteamiento original: Hoy Averch-Johnson, *price cap*, Laffont-Tirole y *yardstick* tienen su referencia en el anexo A del 3.A.17 (D091, D139). Propuesta: cuando se redacte el 3.A.20 (sin fuente; su título dice «desarrollos en presencia de información asimétrica»), pasarle esa referencia, con la presentación y los gráficos del anexo A del 3.A.17, y dejar el 3.A.17 en mención; el monopolio natural, Ramsey-Boiteux y la tarifa en dos partes se quedan en el 3.A.17. Si se aprueba, quedan bien las remisiones del 3.A.13 (Laffont-Tirole) y del 4.A.12 (*price cap*) al 3.A.20, que hoy figuran como contradicciones. Alternativa: dejar el anexo A del 3.A.17 como referencia definitiva y que el 3.A.20 la resuma.
- **[decidir] D8 · Siglas VPMg, IPMg y GMg** (valor e ingreso del producto marginal y gasto marginal del factor, con el subíndice del factor, en redonda): aplicadas en el 3.A.17 y registradas en `notacion.md` § 0. Alternativa: escribir siempre p·PMg_L e IMg·PMg_L (peor para la pizarra). Si se rechaza, solo cambia el 3.A.17; el 3.A.11 y el 3.A.12 lo dicen en palabras.
- **[decidir] τ o t para el impuesto *ad valorem* en el monopolio.** El canon propone t, como el 3.A.16 (`pendientes-coherencia.md`); la alternativa es dejar τ en la anotación del 3.A.17 y registrarlo como local.
- Las demás dudas del 3.A.17 (D2-D7: título del bloque I, orden de II, bienestar en I.3, 1.er grado como capa, frase de Joan Robinson, enganche con refrán) no tocan el canon: si Víctor cambia alguna, el canon solo actualiza la fila del 3.A.17 en las fichas.
- **Propuestas para cuando se revisen otros temas**: ficha `nash-negociacion` con el 3.A.14 como referencia (Nash, Rubinstein, Binmore-Rubinstein-Wolinsky; usuarios 3.A.17, 3.A.21 y 3.A.27) y, si el 3.A.15 la desarrolla, `doble-marginalizacion` (Spengler, 1950).

**Ideas para la organización** (§ 11): el 3.A.17 reparte con el 3.A.20 la regulación del monopolio y con el 3.A.25 y el 3.A.27 el mercado de trabajo con poder de mercado; conviene que en el PowerPoint el 3.A.17 enlace con el 3.A.20 (regulación) y con el bloque del mercado de trabajo (3.A.25 y 3.A.27), y que el 3.A.20 se escriba justo después del 3.A.17 si se aprueba D1, para que la presentación de los 4 modelos se traslade sin cambios.

## 14. Decisiones abiertas tras la revisión del 3.A.13 (19/10/2026)

El coordinador aplicó la opción recomendada mientras Víctor no conteste en el artifact de dudas (A13-01 a A13-03 y las de la integración); el canon las recoge como provisionales.

- **[decidir] D5 y D6 del 3.A.13 · Tipos A/B y proporción ν.** Aplicado: A y B en redonda como mnemónicos de alto y bajo en los 3 modelos (productividad, riesgo, esfuerzo) y ν para la proporción del tipo bueno (`notacion.md` § 1 y § 4). Alternativa: 1/2 como el 3.A.17 (t_1 < t_2), perdiendo el mnemónico.
- **[decidido 21/10/2026: P21-03, opción B; aplicado en el 3.A.17 el 22/10/2026] Unificar la proporción de tipos en ν.** Víctor elige la opción B: el 2.º grado del 3.A.17 escribe ν y 1 − ν (antes π); la ficha `discriminacion-precios` y `notacion.md` § 1 y § 4 están al día. Matiz: en Laffont-Tirole ν pondera al tipo eficiente y en la autoselección al tipo bajo; léase «proporción del primer tipo». Planteamiento original: El 3.A.13 usa ν (allí π es probabilidad de accidente o de éxito) y el 3.A.17 π en su 2.º grado (y ν en Laffont-Tirole, en el mismo tema). Opción A (recomendada por el guardián): dejarlo así, sin contradicción (no conviven en un apartado). Opción B: pasar el 2.º grado del 3.A.17 a ν (entrada condicional en `pendientes-coherencia.md`).
- **[decidir] D7 del 3.A.13 · Principal neutral en el cuerpo y u_P solo en el anexo A** (aplicado; la alternativa era mantener el principal averso R[·] del original).
- **[decidir] D9 del 3.A.13 · Ficha `diseno-mecanismos`** con referencia en el 3.A.14 (creada; desde la revisión del 3.A.14 (19/10/2026), que la desarrolla en III.2, la ficha y `mapa.yaml` ya no llevan la marca, pero falta la confirmación de Víctor: ya la citan 2 temas revisados, 3.A.13 y 3.A.21, y la usan 3.A.23, 3.A.24, 3.A.17, 4.B.2 y 4.B.15). Alternativa: borrarla y dejar el principio de revelación como mención con el enunciado común de `notacion.md` § 14.
- **D3 del 3.A.13** depende de la D1 del 3.A.17 (§ 13), aprobada el 21/10/2026 (P21-02): las remisiones del 3.A.13 a Laffont-Tirole pasan al 3.A.20 cuando se revise (`pendientes-coherencia.md`, «se aplicará con el 3.A.20»).
- **Notación compartida con el 3.A.10** (no es una decisión abierta, queda fijada): la prima por euro asegurado es **γ** (antes r local en el canon) y la dotación sin seguro **A** = (W̄, W̄ − L) (la propuesta de coherencia del 3.A.13 era D; se eligió A por coordinación con el 3.A.10). `notacion.md` § 1 y § 2.
- Las demás dudas del 3.A.13 (D1 bloque 0 a la introducción, D2 caso 2 cantado con una sola caja, D4 enganche, D8 bibliografía; Fernández de Castro y Tugores, cifras sin segunda comprobación, Reglamento de IA) no tocan el canon.

**Ideas para la organización** (§ 11): el 3.A.13 es el centro de un hilo que cruza bloques: el seguro del 3.A.10 (caja previa, misma notación), la autoselección del 3.A.17 (2.º grado), los juegos y el diseño de mecanismos del 3.A.14, los salarios de eficiencia del 3.A.27 y el 3.A.7, la agencia en la empresa del 3.A.15 y el crédito del 3.B.26-3.B.27 y el 4.A.20. Conviene que en el PowerPoint el 3.A.13 lleve flechas desde el 3.A.10 y hacia el 3.A.14, el 3.A.27 y el 3.B.27, y que el 3.A.14 se revise justo después, porque tiene que desarrollar lo que el 3.A.13 le remite (señalización como juego, criterio intuitivo, diseño de mecanismos).

## 15. Decisiones abiertas tras la revisión del 3.A.10 (19/10/2026)

Víctor decidió durante la revisión el anexo de Diamond-Dybvig **resumido** (A10-01) y el enganche de los 2 refranes con el seguro y la Lotería de Navidad (A10-02). El resto lo aplicó el coordinador con la opción recomendada mientras Víctor no conteste en el artifact de dudas; el canon lo recoge como provisional.

- **[decidir] A10-03 · Demanda de un activo con riesgo (Arrow) y empresa aversa al riesgo (Sandmo).** Aplicado: en el cuerpo (I.2.2 y I.2.3), como bloques «no se canta» con la estructura a)-c); cumple la remisión del 3.A.11. Alternativa: llevarlos a un anexo (basta mover los 2 subapartados; las fichas `tobin-cartera` y `aversion-riesgo-arrow-pratt` solo cambiarían la ubicación).
- **[decidir] Fusión de ids del inventario** (`_inventario/alias.json`): `san-petersburgo` y `allais` en `utilidad-esperada-vnm`, y `crra` (3.A.8) en `aversion-riesgo-arrow-pratt`, como proponía la revisión (K41). Alternativa: mantenerlos como ids propios (solo los usan el 3.A.10 y el 3.A.8; no tendrían ficha).
- **Notación fijada** (no son decisiones abiertas): γ y A del seguro (ya del 3.A.13); 𝓛 conjunto de loterías y τ peso de la mezcla (§ 0); β, λ y δ en la teoría de las perspectivas (no α ni γ de la fuente); a de la CARA, b de la cuadrática, η_0 y η_1 de la HARA; prudencia sin símbolo en el cuerpo; 𝒫 previos múltiples; ν, μ y φ locales de los modelos de ambigüedad (`notacion.md` § 0, § 1, § 2 y § 14). La propuesta ψ para la transformación de Pratt (en lugar de G, que choca con la distribución del mismo apartado) es un pendiente menor del propio 3.A.10.
- Las demás dudas del 3.A.10 (D3 reparto I 13', II 8', III 5'30"; D5 los 3 modelos de ambigüedad; D7 Rabin y Sydnor; D8 título de II.2 en castellano) no tocan el canon, salvo la terminología «teoría de las perspectivas», ya en `notacion.md` § 14. Cifras pendientes de comprobar (Allais y efecto marco en el PDF de 1979, número de DO de la Directiva (UE) 2026/804, Lotería de Navidad sin cifra) en `fuentes/3A10/revision.md`.
- **Para los temas que se revisen después:** 3.A.14 con los pagos esperados de vNM y *Theory of Games* fechada en 1944; 3.A.29 y 3.A.33 con ESI = 1/θ, Kimball y u‴ > 0; 3.A.24 con Harsanyi neutral respecto a la utilidad; 3.B.23 sin repetir la caja de enigmas; 3.B.26 con el gráfico `diamond-dybvig.tex` del 3.A.10 como base (`mapa.yaml`, contradicciones del 3.A.10).

**Ideas para la organización** (§ 11): el 3.A.10 es el arranque del hilo del riesgo, que cruza bloques: utilidad esperada → seguros e información asimétrica (3.A.13) → juegos y subastas (3.A.14) → elección social (3.A.24); aversión y prudencia → elección intertemporal y consumo (3.A.29, 3.A.33) → dinero como activo (3.A.35) → carteras (3.B.23); teoría de las perspectivas → economía conductual (3.A.1) y finanzas conductuales (3.B.23); Diamond-Dybvig → crisis y regulación bancaria (3.B.26, 3.B.27). Conviene que el PowerPoint lleve una flecha de 3.A.8 a 3.A.10 y de 3.A.10 a 3.A.13 y a 3.B.23, y que el 3.A.14 se revise pronto, porque recibe remisiones del 3.A.10 y del 3.A.13.

## 16. Decisiones abiertas tras la revisión del 3.A.18 y del 3.A.14 (19/10/2026)

Revisados en paralelo y coordinados entre sí. El coordinador aplicó la opción recomendada de cada duda mientras Víctor no conteste en el artifact; el canon las recoge como provisionales.

**Del 3.A.14:**

- **[decidir] D3 · Ficha `diseno-mecanismos` con referencia en el 3.A.14** (la D9 del 3.A.13, § 14): aplicada; el 3.A.14 la desarrolla en III.2 con a)-d). Alternativa: borrarla y dejar el principio de revelación como mención con el enunciado común.
- **[decidir] D4 · Teorema de tradición oral**: concepto en el 3.A.14 (gatillo con el dilema del prisionero, β ≥ 1/5) y aplicación a la colusión en el 3.A.19 (fichas `equilibrio-nash` y `dilema-prisionero`). Aplicada.
- **[decidir] D5 · Negociación con referencia en el 3.A.14** (ficha `nash-negociacion`; el 3.A.27, resumen aplicado, aunque hoy su Word la desarrolla en extenso). Alternativa: referencia en el 3.A.27 («modelos de negociación» en su título) y el 3.A.14 en resumen.
- **[decidir] D6 · Fichas `equilibrio-nash` y `nucleo-shapley`**: creadas. Alternativa: quitarlas y dejar la fila del 3.A.14 en `nucleo` y en `dilema-prisionero`.
- **[decidir] D7 · Notación nueva**: π_i y π⃗_i para las mixtas (no p, q ni σ_i), φ_i(v) para Shapley, β en los repetidos y en Rubinstein (no δ, la de los manuales), p^R, I, ψ(v) (`notacion.md` § 1 y § 4). Aplicada. Consecuencia: la ficha `subastas` retira la puja lineal b_i = β_iv_i.
- **[decidir] D8 · Subastas del Tesoro en el 4.B.26** (y 4.A.20 en mención), no en el 4.A.19, cuyo Word es de la numeración antigua. Aplicada en las remisiones y en la ficha `subastas`.
- **D9 · Ejemplo cooperativo**: el del vendedor y los 2 compradores (enlaza con la subasta inglesa) en lugar del juego de los guantes que proponía coherencia. No toca la notación; la ficha `nucleo-shapley` lo registra.
- Las demás dudas del 3.A.14 (D1 estructura, D2 peso de las subastas, D10 enganche; datos con una sola fuente) no tocan el canon.

**Del 3.A.18:**

- **[decidir] α en Dixit-Stiglitz**: aplicado U = x_0^{1−α}y^α con α la parte del gasto en el grupo (como Neary y Foltyn); la propuesta de coherencia y el original lo ponían al otro lado. Es mecánico y solo cambia la ficha `dixit-stiglitz` y `notacion.md` § 1 y § 4.
- **[decidir] D6 · Índice de precios P** (como el 3.A.7, Krugman y Galí) en lugar de p_y. Aplicado.
- **[decidir] D7 · Calidades s_A > s_B en redonda** (mnemónico de alto y bajo del 3.A.13) y θ como valoración de la calidad, excepción local. Alternativa: s_1 < s_2 de Tirole.
- **D2 y D4 · Bertrand-Cournot diferenciados (II.2) y publicidad (III.2) en el cuerpo**: aplicados; dan las fichas `oligopolio-diferenciado` (creada porque el 3.A.19 la usa) y el id `dorfman-steiner` (sin ficha hasta que otro tema lo use: comprobar en el 3.A.15 y el 3.B.4).
- **Duda 10 del 3.A.18**: el Word «3A-18_v11.doc» es el 3.A.18 antiguo (mercado de trabajo, hoy 3.A.25): anotado en las `contradicciones` del 3.A.18 para las fuentes del 3.A.25.
- Las demás dudas del 3.A.18 (D1 tres bloques, D3 Salop en II, D5 enganche con la frase de Joan Robinson, D9 títulos, D10 minutos de Chamberlin; citas sin cotejar; ICEX-CECO sin citar) no tocan el canon. La frase reservada de Joan Robinson (mapa a escala 1:1) se ha usado en la contextualización del 3.A.18.

**Para los temas que se revisen después** (`mapa.yaml`, contradicciones de 3.A.18 y 3.A.14; resumen en `pendientes-coherencia.md`): 3.A.19 (resumir Bertrand diferenciado y remitir al 3.A.18; anexo de juegos reducido a remitir al 3.A.14; colusión con el teorema de tradición oral del 3.A.14; R_i, no φ; misma tabla de supuestos con la fila 4 levantada); 3.B.6 y 3.A.7 (resumir Dixit-Stiglitz con P y μ y remitir); 3.A.27 (negociación como resumen aplicado); 4.B.26 (subastas del Tesoro con la nota de terminología); 3.B.7, 3.B.8, 4.A.15, 3.A.6, 3.A.36, 3.A.41, 3.A.44 (remisiones de juegos al 3.A.14); 3.A.24 y 4.B.2 (Hotelling como base de Downs, 1929 y 1957).

**Ideas para la organización** (§ 11): el 3.A.14 es la caja de herramientas de todo el bloque de mercados (3.A.13, 3.A.15, 3.A.17-3.A.19) y de varios temas de macro y comercio (3.A.36, 3.B.7, 3.B.8, 3.B.17); conviene que en el PowerPoint vaya justo antes del 3.A.18 y el 3.A.19, con flechas hacia ellos y desde el 3.A.10 y el 3.A.13. El 3.A.18 es el puente del bloque de mercados hacia el comercio (3.B.6), la macro (3.A.7) y el crecimiento (3.A.44) por Dixit-Stiglitz, y hacia la elección pública (3.A.24, 4.B.2) por Hotelling: flechas en los dos sentidos. Con el 3.A.18 revisado, el 3.A.19 es el último tema del bloque de estructuras de mercado que falta, y conviene revisarlo pronto (hereda la tabla común, Bertrand diferenciado, el EN y el ENPS, y el teorema de tradición oral).

## 17. Decisiones abiertas tras la revisión del 3.A.15 y del 3.A.19 (20/10/2026)

Revisados en paralelo y coordinados entre sí: el bloque «Barreras de entrada» del 3.A.19 pasa al 3.A.15, y el 3.A.19 gana un bloque de soluciones cooperativas. El coordinador aplicó la opción recomendada de cada duda mientras Víctor no conteste en el artifact; el canon las recoge como provisionales.

**De la fase canon (cruce de los 2 temas):**

- **[resuelto 20/10/2026: IHH en la escala 0-10.000 en los 2 temas] Índice de Herfindahl-Hirschman: sigla y escala.** El 3.A.15 escribe **HHI** en la escala 0-10.000 ($\sum_i(100s_i)^2$); el 3.A.19, **IHH** $\equiv\sum_is_i^2$ (escala 0-1), aunque da la cifra de la CNMC «en una escala de 0 a 10.000». Propuesta: **IHH** (sigla en castellano, la de la CNMC; «HHI» entre paréntesis la primera vez, como MEDE (ESM)) **en la escala 0-10.000** en los 2, con $\sum_is_i\mathcal L_i=\mathrm{IHH}/(10.000|\varepsilon_{Q,p}|)$. Alternativa: Σs_i² (0-1) en la teoría y la cifra multiplicada por 10.000 al citar a las autoridades. Afecta también al 3.B.39, el 4.A.15 y el 3.A.20 cuando se revisen (`notacion.md` § 4; `pendientes-coherencia.md`).
- **[resuelto 20/10/2026: se mantienen los 2, con una nota en III.2 del 3.A.15] $B^D$ (duopolio acomodado, en cursiva) del juego de disuasión del 3.A.15 frente a $B^{\mathrm D}$ (desviarse, en redonda) del 3.A.19 y $u^{\mathrm D}$ del 3.A.14.** Recomendado: dejarlo con una nota en el 3.A.15 (no toca el gráfico). Alternativa: $B^A$ (acomodar) en el 3.A.15.
- **Canon sin decisión (consecuencia de reglas ya aprobadas):** $\varepsilon_{Q,p}$ en el oligopolio (el 3.A.15 escribe $\varepsilon_{q,p}$ en Cowling-Waterson y en la NOIE) y $n$ empresas en el oligopolio (el 3.A.15 escribe $J$): pendientes menores del 3.A.15.

**Del 3.A.15:**

- **[decidir] D1 · Estructura A** (orden del título: tamaño eficiente y límites 7′, costes de transacción 9′30″, TOI 10′), que invierte los bloques del original como pedía la nota de Víctor. Alternativas: B (orden del original) o C (tecnología y costes de transacción juntos).
- **[decidir] D6 · Notación nueva**: $p^L$, $q^L$; $B^M$, $B^D$, $B^G$ y CH; $\underline B$; $q^B$; **$a$** especificidad con $C_{\text{mercado}}(a)$, $C_{\text{híbrida}}(a)$, $C_{\text{jerarquía}}(a)$ (Williamson escribe $k$); $\mathrm{CR}_m$ y el índice de concentración con $s_i\in[0,1]$. Aplicada (`notacion.md` § 1 y § 4).
- **[decidir] D8 · Fichas nuevas**: una sola `disuasion-entrada` con `precio-limite` como alias (aplicada), frente a fichas separadas para el precio límite y el compromiso de capacidad; `modelos-gerencialistas` creada porque el 3.B.4 usa Marris.
- **[decidir] D9 · Tabla de supuestos completa** (`tab:supuestos-impugnables`) con la fila 5 «se levanta» y «se refuerza» y una fila «+» para el supuesto propio de los impugnables. Aplicada; la ficha `competencia-perfecta-equilibrio-parcial` la registra.
- **Árbol de disuasión** (K38): aplicada la forma (sobre el juego de entrada del 3.A.14) con los números de contenido ($B^M=4$, $B^D=1$, $B^G=-1$, CH = 2,5), no los de coherencia, porque salen de una regla explícita.
- Las demás dudas del 3.A.15 (D2 detalle de las barreras en el cuerpo, D3 austriacos al anexo A, D4 plataformas en el anexo E, D5 Williamson, 1964, sin cantar, D7 enganche de Coase y Lenin, D10 gobierno corporativo en el anexo D; datos con una sola fuente) no tocan el canon.

**Del 3.A.19:**

- **[decidir] D1 · Tercer bloque**: «Soluciones cooperativas: el cártel y el reparto de sus ganancias» en lugar de «Barreras de entrada» (que pasan al 3.A.15), con un resumen de las barreras en III.3. Aplicada; da las fichas `cartel`, y `nucleo-shapley` y `nash-negociacion` en «resumen aplicado».
- **[decidir] D4 · Superíndices**: $B^{\mathrm C}$, $B^{\mathrm D}$, $B^{\mathrm N}$ en redonda, como el 3.A.14, sin escribir nunca el beneficio de Cournot como $B^C$. Aplicada. Alternativa: $B^{\mathrm{col}}$.
- **[decidir] D6 · Funciones clave**: `eq:lerner-cournot` y `eq:colusion` (las 2). Aplicadas; las fichas `cournot` y `cartel` las fijan como presentación de referencia.
- **Ejemplo del reparto**: el 3.A.19 usa la función característica con las coaliciones que compiten a la Cournot (1, 16/9, 4) en lugar de la función γ de Chander y Tulkens (1997) que proponía coherencia (K32): la misma idea, más fácil de cantar.
- Las demás dudas del 3.A.19 (D2 «agenda del tema», D3 enganche con Smith y el cártel de camiones, D5 juego de la gallina fuera, D7 bibliografía sin preparadores, D8 liderazgo en precios en el cante) no tocan el canon.

**Para los temas que se revisen después** (`mapa.yaml`, contradicciones de 3.A.15 y 3.A.19; resumen en `pendientes-coherencia.md`): 3.B.4 (resumir costes de transacción, contratos incompletos y gerencialistas con remisión al 3.A.15 y corregir los errores copiados); 3.B.39 y 4.A.15 (clemencia con «\vertema{3.A.14} \vertema{3.A.19}», depredación con \vertema{3.A.15}, el mismo índice de concentración); 4.B.15 (impugnables con los 3 supuestos canónicos; Hart, Shleifer y Vishny); 3.B.8 ($R_A$, Stackelberg y Brander-Spencer remitidos al 3.A.19); 3.B.6, 3.B.27 y 4.B.8 (Cournot con remisión al 3.A.19); 3.A.23 (Coase, 1960, frente a 1937; lista común de supuestos); 3.A.20 (índice de concentración y mercado relevante).

**Ideas para la organización** (§ 11): con el 3.A.15 y el 3.A.19 queda revisado el bloque de información y poder de mercado salvo el 3.A.20. El 3.A.15 es la bisagra del bloque: abre la «caja negra» de la empresa que el 3.A.11, el 3.A.12 y el 3.A.16 dan por cerrada (I y II) y prepara las estructuras de mercado (III: barreras, el supuesto 5 de la lista común); conviene que en el PowerPoint vaya entre el 3.A.12 y el 3.A.16 o justo antes del 3.A.17, con flechas hacia el 3.B.4 (crecimiento de la empresa), el 3.B.18 (multinacionales) y el 3.B.39 y el 4.A.15 (competencia). El 3.A.19 cierra las estructuras de mercado y es el puente hacia el comercio estratégico (3.B.6, 3.B.8) y la defensa de la competencia (3.B.39, 4.A.15); sus fichas `cournot` y `cartel` usan el 3.A.14 como caja de herramientas, así que el orden 3.A.14 → 3.A.17 → 3.A.18 → 3.A.19 → 3.A.20 en el PowerPoint refleja las dependencias. Un mismo gráfico por capas (Cournot, Stackelberg, cártel) cruza los 3 bloques del 3.A.19: buen candidato para un vídeo corto de repaso del bloque.

## 18. Decisiones abiertas tras la revisión del 3.A.22 y del 3.A.23 (21/10/2026)

Revisados en paralelo y coordinados entre sí: el 2×2×2×2 y los teoremas, con su demostración, pasan al 3.A.22 (A23-01, opción a), que gana un bloque II de teoremas y lleva los criterios de compensación a un anexo (A22-01, opción a); el 3.A.23 los resume en 1′ y se centra en externalidades, bienes públicos y fallos del sector público. El coordinador aplicó la opción recomendada de cada duda mientras Víctor no conteste en el artifact; el canon las recoge como provisionales.

**De la fase canon (cruce de los 2 temas):**

- **[resuelto 21/10/2026: opción (a), hecho en el 3.A.23] Tabla de supuestos del 1TFEB en el 3.A.23.** Comprobado el 22/10/2026: `tab:fallos-supuestos` es la de 5 filas del 3.A.22 con la fila 2 «Se levanta» y la frase que une los supuestos 3 y 5 a la lista común del 3.A.16. Planteamiento original: El 3.A.22 fija la de 5 filas (`tab:supuestos-1tfeb`: no saciedad local, mercados completos, precio-aceptantes, precios comunes, información; MWG § 16.C), que proponía que el 3.A.23 copiara (CC2, D6 del 3.A.22). El 3.A.23 usó la lista común de las estructuras de mercado del 3.A.16 más «6. Mercados completos» (como le pedía la contradicción anotada por el 3.A.19), de modo que los 2 temas numeran distinto el mismo supuesto. Recomendado: (a) el 3.A.23 copia la tabla del 3.A.22 con la fila 2 «Se levanta» y una frase que una los supuestos 3 y 5 a la lista común del 3.A.16. Alternativa: (b) dejarla y añadir la equivalencia en su pie. Detalle en `pendientes-coherencia.md`; ficha `teoremas-bienestar`.
- **[decidido 21/10/2026: P21-01, opción a, se deja $\overline q$] menor · Estándar $\overline q$ del 3.A.23** frente a $\overline q$ escala mínima eficiente del 3.A.16 y el 3.A.15 (`notacion.md` § 5). Recomendado: dejarlo (la barra dice «fijado», § 0, y no conviven en un apartado). Alternativa: $q^E$.
- **Canon sin decisión (consecuencia de reglas ya aprobadas):** los multiplicadores de los anexos A y B del 3.A.23 ($\lambda_1$, $\mu_X$, $\mu_Y$, $\nu_L$, $\nu_K$ → $\lambda_U$, $\lambda_X$, $\lambda_Y$, $\lambda_L$, $\lambda_K$, D020), pendiente del 3.A.23.

**Del 3.A.22:**

- **[decidido: A22-01, opción a, de Víctor] D1 · Criterios de compensación en un anexo** (A22-01, opción a), en contra de la regla de conservar los bloques de primer nivel, como pedía la nota inicial de Víctor. Aplicada; la ficha nueva `criterios-compensacion` pone el 3.A.22 (anexo) como referencia y el 3.A.24 en resumen. Alternativa: una subsección breve (30″) al final del bloque II; o el desarrollo en el 3.A.24, y entonces el 3.A.9 remite a los 2.
- **[decidir] D2 · III.3 nueva** (*second best* con información y diseño de mecanismos, 2′30″). Aplicada; da la fila «resumen» del 3.A.22 en `diseno-mecanismos`. Alternativa: 3 viñetas en la valoración del 2TFEB.
- **[decidir] D3 · Un solo problema del planificador** con precios sombra $\lambda_U,\ldots,\lambda_K$ en el cuerpo y los 3 problemas parciales del Word en el anexo `anexo:planificador-general`. Aplicada; fija la notación de `notacion.md` § 5.
- **[decidir] D4 · Ultimátum en nota** (versión de juegos del 3.A.14). Aplicada.
- **[decidir] D6 · Tabla de 5 supuestos** con la información perfecta. Aplicada en el 3.A.22; el choque con el 3.A.23 se resolvió con la opción (a) (arriba).
- Las demás (D5 refrán del enganche «Lo mejor es enemigo de lo bueno», A22-02 frase de Joan Robinson en III.4, que estaba reservada para un tema donde encajara) no tocan el canon.

**Del 3.A.23:**

- **A23-01 (opción a)** · TFEB resumidos con `\vertema{3.A.22}`: aplicada; fichas `teoremas-bienestar` y `equilibrio-general-walras` con el 3.A.23 en «resumen».
- **D1 · Título de I.2** («El equilibrio general competitivo y los teoremas del bienestar») y **D2 · anexo A corto** con el 2×2×2×2: aplicadas, sin efecto en el canon salvo los multiplicadores del anexo (arriba).
- **Fichas (CC5, CC8):** `lindahl` creada (3.A.23 desarrollo; 4.B.7 resumen; 3.A.24 y 4.B.2 mención); `bowen` pasa a alias de `samuelson-bienes-publicos` y `externalidades-equilibrio-general` de `pigou`; `public-choice` sale de la lista del 3.A.23 (lo cubren las fichas de la elección pública, con referencia en el 4.B.2); **`tragedia-comunes` creada** (CC8, opcional): referencia 3.A.23 (anexo de Ostrom), ya la usa el 3.A.15. Provisional: si Víctor no la quiere, se borra y el anexo de Ostrom queda como contenido propio del 3.A.23.
- **CC9 (refranes ya usados):** los del 3.A.23 («Unos por otros, la casa sin barrer», «El que venga detrás, que arree», «Más vale un mal acuerdo que un buen pleito», «Lo que es del común es de ningún», «Hecha la ley, hecha la trampa», «Prometer hasta meter…») y el del 3.A.22 («Lo mejor es enemigo de lo bueno») deben ir a la lista de `CRITERIOS.md` § 8 cuando Víctor los apruebe (no es del canon: lo hace el coordinador).
- Las demás dudas (D3 enganche, D4 hilo del río, D5 sin la DANA de 2024; citas de Kahn, Ostrom y Stern sin página) no tocan el canon.

**Para los temas que se revisen después** (`mapa.yaml`, contradicciones de 3.A.22 y 3.A.23; resumen en `pendientes-coherencia.md`): 3.A.24 (remitir Pareto, teoremas y compensación al 3.A.22; Samuelson con $\mathrm{RMS}^i_{GX}$; Clarke-Groves y Lindahl en mención; ultimátum del 3.A.14); 3.B.37 (RCDE de Dales y Montgomery, no «de Coase»; MAFC transitorio hasta el 31/12/2025); 4.B.2 (Olson, 1965; Bowen en mención; puede reutilizar `niskanen.tex`); 4.A.6 (teoría del *cap and trade* con remisión); 4.B.6, 4.B.9, 4.B.11, 3.B.28 (remisiones al 3.A.22); 4.B.7 y 4.B.13 (la acería con $\overline p$, $\mathrm{CMgE}$; Lindahl con $p^i_G$; doble dividendo).

**Ideas para la organización** (§ 11): el bloque del bienestar queda partido como el título: el 3.A.21 construye el equilibrio, el 3.A.22 dice cuándo es eficiente (teoremas) y qué hacer cuando no se puede tener lo mejor (*second best*), y el 3.A.23 dice por qué falla (externalidades y bienes públicos) y por qué también falla el Estado; el 3.A.24 cerrará con la elección entre los óptimos. En el PowerPoint conviene que el 3.A.22 vaya inmediatamente tras el 3.A.21 y antes del 3.A.23, con la tabla de supuestos del 1TFEB como diapositiva puente que reparte cada supuesto a su tema (3.A.13, 3.A.17-3.A.20, 3.A.23, 4.B.9). El 3.A.23 es el puente hacia el 4.º ejercicio (4.B.2, 4.B.6, 4.B.13-4.B.15, 4.A.6) y hacia el 3.B.31 (bienes públicos globales y clima). El gráfico de la externalidad por capas (base → áreas → impuesto → estándar) y la GFPU por partes (FPP → FPU → envolvente → F, P, Q) son buenos candidatos a vídeos cortos de repaso del bloque.

## 19. Decisiones abiertas tras la revisión del 3.A.24 (22/10/2026)

El 3.A.24 cierra la parte teórica del bloque del bienestar (el 3.A.20 se revisa en paralelo y su fase canon irá después). El coordinador aplicó la opción recomendada de cada duda mientras Víctor no conteste en el artifact; el canon las recoge como provisionales y **no se han llevado a otros temas**.

**Que tocan el canon:**

- **[decidido 23/10/2026: A24-03, opción recomendada] D2 · Letras de las alternativas: $x$, $y$, $z$** (recomendada; votantes 1, 2, 3), como el 3.A.23 revisado, MWG y Sen; en el 3.A.24, $A$ y $B$ son los individuos de la GFPU. Aplicada en el tema y en las fichas `arrow-imposibilidad`, `paradoja-condorcet`, `borda`, `votante-mediano`, `sen-liberal` y `logrolling` (`notacion.md` § 1 y § 5). Alternativa: $A$, $B$, $C$, como el original, el 4.B.2 y las fichas anteriores; entonces cambian el 3.A.24, esas fichas y el 3.A.23 (entrada condicional en `pendientes-coherencia.md`).
- **[decidido 23/10/2026: A24-03, T] N2 · Siglas de Arrow: T (transitividad)**, como la ficha (aplicada), frente a **R (racionalidad)**, como MWG e Inman, que incluye la completitud. Orden U, T, P, I, D (D7, la de la ficha).
- **[decidido 23/10/2026: A24-03, IG] D9 · Índice de Gini como IG** (aplicada; también el 4.B.3 original), para no chocar con el bien público $G$ del bloque III del mismo tema (Bowen). Alternativa: $G$, como la ficha anterior.
- **[decidir] Referencia doble de `logrolling` y de `buchanan-tullock-mayoria-optima`** (propuesta de la fase canon, **sin aplicar**): hoy la referencia es el 4.B.2 y el 3.A.24 los resume con el modelo completo y su gráfico; por el criterio del 3.er ejercicio primero (`CRITERIOS.md` § 6) podrían ser dobles, como Borda, Condorcet y el votante mediano (D120, D135, D137). Si se aprueba, solo cambia el papel en `mapa.yaml` y en las fichas.
- **Canon sin decisión (consecuencias de reglas ya aprobadas):** `fbs-utilitarista` y `juego-ultimatum` pasan a alias (de `funcion-bienestar-social` y `nash-negociacion`); fichas nuevas `sen-liberal` y `may`; `atkinson-indice` con $I$ (no $N$); la pendiente de la CIS sin sigla (no se crea RMSS, CC6); el gráfico de Lorenz con $L_{\vect y}$, $L_{\vect y'}$ (no $L_A$, $L_D$); Gibbard-Satterthwaite y el diseño de mecanismos remiten al 3.A.14, no al 3.A.13.

**Del 3.A.24 (no tocan el canon):**

- **[decidido 23/10/2026: A24-01, el del original] D1 · Orden de los bloques:** el del original (I Arrow, II FBS como primera escapatoria, III levantamiento de los axiomas), con la razón en la «Estructura» (aplicado), frente al orden del título (I FBS con Pareto, II elección colectiva y Arrow, III desarrollos), que evita avisar de que la FBS es anterior a Arrow. Si se cambia, no cambia ninguna ficha: solo las secciones citadas (`sec:…`) en ellas.
- **D3** III.3 nueva (problemas de información), **D5** Pareto en 5 viñetas y anexo, **D6** May en III.1, **D8** hilo de los vecinos: aplicadas con la opción recomendada.
- Refranes (enganche «Nunca llueve a gusto de todos» con el veto del Consejo Europeo de diciembre de 2023; pegatinas «Donde hay patrón no manda marinero», «Cada cabeza es un mundo»; «Cada maestrillo tiene su librillo», junto a Borda, lo quitó Víctor el 23/10/2026): a la lista de `CRITERIOS.md` § 8 cuando Víctor los apruebe (lo hace el coordinador).
- Anexo E (ACB): se conserva corregido o se deja solo la remisión al 4.B.6; Wilson (1972) leído en fuentes secundarias; citas no comprobadas sustituidas o sin cita (`fuentes/3A24/revision.md`, «Dudas abiertas»).

**Para los temas que se revisen después** (`mapa.yaml`, contradicciones de 3.A.24; resumen en `pendientes-coherencia.md`): **4.B.2** (May, Gibbard-Satterthwaite con sobreyectividad, Hotelling 1929 y Downs 1957, Arrow en resumen con la tabla de salidas, los ejemplos de los vecinos de Condorcet y de Borda con las mismas letras, los gráficos `condorcet.tex` y `buchanan-tullock.tex`, *logrolling* con sus 2 lados); **4.B.3** (Rawls con aversión infinita a la incertidumbre; Atkinson con la misma ϵ, $y_{EDE}$, $A_\epsilon$ con $I$; IG; `lorenz.tex` con $L_Y$, $L_{Y-T}$, $C_T$); **3.A.1** (ultimátum de Güth *et al.*, no de Thaler, con las cifras 40 %, 16 % y 28 %; remisiones de los juegos al 3.A.14).

**Ideas para la organización** (§ 11): con el 3.A.24, el bloque del bienestar queda como el título: el 3.A.21 construye el equilibrio, el 3.A.22 dice cuándo es eficiente, el 3.A.23 por qué falla y el 3.A.24 cómo se elige entre los óptimos y cómo decide la sociedad. El 3.A.24 es además el puente con el 4.º ejercicio: el 4.B.2 (reglas de votación, elección pública), el 4.B.3 (Lorenz, Gini, Atkinson y Rawls aplicados al presupuesto) y el 4.B.11 (la FBS en la imposición óptima) deberían revisarse justo después de los temas del 3.º de los que dependen, reutilizando los gráficos `condorcet`, `buchanan-tullock` y `lorenz` y los ejemplos de los vecinos. En el PowerPoint, la tabla `tab:axiomas-salidas` es una buena diapositiva resumen del tema (cada axioma, su salida y dónde se estudia), y la columna U, T, P, I, D de la pizarra, un buen vídeo corto de repaso. El hilo del riesgo de la § 15 (utilidad esperada → seguros → juegos → elección social) se cierra aquí con Harsanyi y Rawls.

## 20. Decisiones abiertas tras la revisión del 3.A.20 (22/10/2026)

El 3.A.20 se ha escrito desde cero (no había original de Víctor) y cierra el bloque de información y poder de mercado. Su fase canon aplica la P21-02: el 3.A.20 es ya el tema de referencia de la regulación con información asimétrica. El coordinador aplicó la opción recomendada de cada duda mientras Víctor no conteste en el artifact; el canon la recoge como provisional, y **lo que cambia en los temas ya revisados (3.A.13, 3.A.14, 3.A.17 y, opcionales, 3.A.12 y 3.A.22) no se aplica hasta que Víctor apruebe el 3.A.20** (`pendientes-coherencia.md`, «Pendiente del 3.A.20»).

**Que tocan el canon:**

- **[decidido 23/10/2026: A20-03, se crean] Fichas nuevas** `mercado-relevante` (SSNIP, pérdida crítica, celofán, SSNDQ; gráfico `ssnip`), `competencia-por-mercado` (Demsetz, Williamson, Laffont y Tirole, 1987) y `precio-acceso` (ECPR, Armstrong, Doyle y Vickers), las 3 con el 3.A.20 de referencia (duda 4 del 3.A.20). Creadas; si Víctor no las quiere, su contenido vuelve a las filas del 3.A.20 de `estructura-conducta-resultado`, `subastas` y `separacion-vertical`.
- **[decidido 23/10/2026: A20-02, dentro de laffont-tirole y en el cuerpo] Baron-Myerson dentro de la ficha `laffont-tirole`** (aplicado; recomendado: es el mismo problema sin esfuerzo, con las mismas letras β̲, β̄, ν) o ficha propia `baron-myerson`. Va con la duda 2 del tema: Baron-Myerson en el cuerpo (2′ con Loeb-Magat y gráfico, aplicado) o solo una viñeta de Laffont-Tirole y el anexo.
- **[decidido 23/10/2026: A20-04, price cap con la advertencia] El DORA como *price cap*** (duda 5): se presenta así en el tema y en la ficha `price-cap`, con la advertencia de que su X (+0,33 %) se suma y cuadra ingresos y costes; la alternativa es llamarlo «regulación de ingreso máximo». Solo cambia el rótulo, no la cifra.
- **[decidir] W en Laffont-Tirole** (`notacion.md` § 1, fila W): el tema escribe el bienestar del regulador W = S − (1+λ)[β − e + ψ(e)] − λU, y el canon dice «bienestar del regulador → ET». Propuesta: aceptarlo como local (no es el ET, porque resta el coste de los fondos públicos y suma la renta); alternativa, quitar la letra, como el tema hace con Baron-Myerson. Menor.
- **Canon sin decisión (consecuencias de la P21-02 y de reglas ya aprobadas):** referencia en el 3.A.20 de `averch-johnson` (nombre «tasa de rentabilidad», no «de beneficio»), `laffont-tirole` (con la escala de la potencia y los gráficos `menu-contratos`, `baron-myerson` y `escala-potencia`), `price-cap` (X del DORA comprobada en el BOE), `yardstick` (alias `loeb-magat`) y `captura-regulador` (con Peltzman y su gráfico); en el 3.A.20, β solo es la eficiencia intrínseca (punta y valle de palabra), s_i y s conviven con nota, b = 1 es el precio fijo y 𝓛 es Lerner (ningún problema con lagrangiana); letras locales nuevas S(q), α, 𝒜, A, c_a, c_I, c_E, d, τ, ℓ, ℓ^c.

**Del 3.A.20 (no tocan el canon):**

- **[decidido 23/10/2026: A20-01, se mantienen]** Refranes: enganche «Tener la sartén por el mango», que retoma la idea final; pegatinas «Más sabe el loco en su casa…» (información asimétrica), «El que algo quiere, algo le cuesta» (incentivos frente a rentas), «Las comparaciones son odiosas» (*yardstick*) y «Poner al zorro a cuidar de las gallinas» (captura; el 3.A.23 liga la captura a «Hecha la ley, hecha la trampa»). A la lista de `CRITERIOS.md` § 8 cuando Víctor los apruebe (lo hace el coordinador).
- [decidido 23/10/2026: A20-02, opción c] Reparto 8′ / 11′ / 7′30″ (aplicado el 23/10/2026: el medio minuto sale de II.5 y va a I.3), en lugar del 7′30″ / 11′30″ / 7′30″ propuesto.
- Lo quitado por no estar comprobado (Google Adtech, AWS y Azure en la DMA, el recurso contra la Circular 9/2025, «más de la mitad, a los 3,5 años» de Guasch *et al.*, la cifra de Forbes del enganche, el «desde 2029» del TOTEX, las *killer acquisitions*) y las referencias por verificar al publicar (`fuentes/3A20/revision.md`, «Dudas abiertas», 6 y 7).

**Para los temas que se revisen después** (`mapa.yaml`, contradicciones de 3.A.20; resumen en `pendientes-coherencia.md`): **4.A.12** (regla p_{t+1} ≤ p_t(1 + IPC_t − X), no ṗ ≤ IPC − X; X del DORA; servicio universal e interconexión); **4.B.15** (t(C) = a − b(C − C^a) con el signo menos; Averch-Johnson con w_K y s; remisión al 3.A.20, no al «3.A.15» antiguo; resumir Laffont-Tirole, captura, *price cap*, *yardstick*, acceso y concesiones); **4.A.15** y **3.B.39** (mercado relevante con la Comunicación de 2024 y los mismos umbrales); **3.A.6, 3.A.36, 3.A.41** (la remisión duplicada de la consistencia dinámica); **4.B.2** (Peltzman en una línea con `\vertema{3.A.20}`).

**Ideas para la organización** (§ 11): con el 3.A.20 queda revisado entero el bloque de información y poder de mercado (3.A.13-3.A.20) y la parte teórica del bloque del bienestar. El 3.A.20 es la bisagra entre los 2: aplica la información asimétrica del 3.A.13, el diseño de mecanismos del 3.A.14 y el monopolio del 3.A.17 a un problema de política económica, y abre el bienestar levantando los supuestos 3 y 5 del 1TFEB del 3.A.22. En el PowerPoint conviene que el 3.A.17 (monopolio y su regulación con información completa) y el 3.A.20 (regulación con información asimétrica) vayan seguidos, y que la escala de la potencia (`escala-potencia`) sirva de lámina de repaso común del 3.A.17, el 3.A.20 y el 4.B.15. El 4.B.15, el 4.A.12 y el 4.A.15 deberían revisarse justo después de los temas del 3.º de los que dependen, reutilizando los gráficos y el ejemplo de *Redes del Valle*.

## 21. Decisiones abiertas tras la revisión de la 1D01 (24/10/2026)

La guía del dictamen es la primera revisión de la macro aplicada: fija en el canon $Y^p$ (D-05, decidido), OG, $\gamma^N$, $b^{pe}$ y el impulso fiscal, los precios y costes de la contabilidad nacional (CLU, PAT, $W/\mathrm{IPC}$, $W/P$, margen), la PIIN y su dinámica y el ROA bancario, y crea 9 fichas (`cambios.md`, 24/10/2026). Ningún tema revisado cambia (`pendientes-coherencia.md`, «Pendiente de la 1D01»). Quedan para Víctor:

- **[decidido 24/10/2026] Tasa de paro**: regla con nota en todo el temario (`notacion.md` § 6).
- **[decidir] Ley de Okun**: símbolo ϑ o sin letra; tema de referencia 3.A.28 (recomendado) o 4.B.4 (ficha `okun`).
- **[decidido 24/10/2026] Volatilidad del empleo**: «similar o algo menor» en todo el temario; el 3.A.42 se corrige al revisarlo (ficha `hechos-estilizados-ciclo`).
- **[decidir] «Norma salarial»** para la regla de Watt; «regla de oro» solo la fiscal (D040) (`notacion.md` § 14).
- **[comprobar]** la regla de 2 y 10 puntos de la brecha crédito-PIB, la métrica ARA y el nombre de la subyacente del BCE (fichas `brecha-credito-pib`, `adecuacion-reservas`, `ipc`).

## 22. Decisiones abiertas tras la revisión del 3.B.31 (31/10/2026)

El 3.B.31 se ha escrito desde cero (no había original de Víctor), con la estructura de Tebar reordenada y las fichas del canon; cierra el bloque del bienestar (3.A.20-3.A.24 y 3.B.31). Víctor está fuera hasta el 9/11: el coordinador aplicó la opción recomendada de cada duda (B31-01 a B31-12, `fuentes/3B31/revision.md`), y el canon la recoge como provisional. Lo que cambia en los temas ya revisados (3.A.22 y 3.A.23) no depende de estas dudas (`pendientes-coherencia.md`, «Pendiente del 3.B.31»).

**Que tocan el canon:**

- **[decidir] Fichas nuevas `dice` y `clubes-climaticos`** (B31-02; creadas): las 2 con el 3.B.31 de referencia (recomendada: los clubes ya los usa el 3.A.23 y los usarán el 3.B.19, el 3.B.33 y el 3.B.41). Alternativas: solo `dice`, con los clubes como apartado de `cbam`; o ninguna, todo local del tema.
- **[decidir] Letras de Nordhaus como locales avisadas** (D7 del tema; `notacion.md` § 1 y § 5, «Cambio climático»): $T_t$ temperatura, $\sigma_t$ intensidad de emisiones, $\mu_t$ tasa de control, $\Omega(T_t)$ daños, $\Lambda(\mu_t)$ coste de reducir con $\vartheta_1$, $\vartheta_2$ (no $\theta_1$, $\theta_2$, que chocan con la CRRA, ni $\psi$, que es el *second best*), y en el anexo $M^{AT}_t$, $F_t$ y compañía. Recomendada y aplicada: se reconocen en la literatura y no conviven en el tema con sus otros usos. Alternativa: letras sin choque (τ para la temperatura…). Relacionada: si se adopta ϑ para Okun (§ 21), sin subíndice, y no convive con el DICE.
- **[decidir] Producción neta del DICE multiplicativa**, $Q_t=[1-\Lambda(\mu_t)][1-\Omega(T_t)]Y_t$ (ecuación 2 de Barrage y Nordhaus, 2024, comprobada en el texto), en lugar de la aditiva $[1-\Omega-\Lambda]Y$ que proponía la fase de coherencia (K8); el anexo del tema dice que el código del modelo resta el coste de la producción neta de daños y que la diferencia es de segundo orden. Recomendada: la del artículo, como está.
- **[decidir] Cifras del DICE-2023** (B31-05 y B31-06): CSC del escenario de 2 °C, 76 $ (texto del artículo, recomendada) o 75 $ (su tabla 2); ρ y θ de DICE-2023 sin cifra (están en el apéndice, sin leer; recomendada) o leer el apéndice y darlas (el documento de trabajo da ρ = 1 % y θ = 1,5). Afectan a la ficha `dice`.
- **Canon sin decisión (consecuencias de D072 y de reglas ya aprobadas):** `cbam` con el 3.B.31 de referencia en desarrollo y su gráfico (`fuentes/3B31/graficos/mafc.tex`), 3.B.37 y 3.B.41 en resumen (P10, como D072); `cap-and-trade` en resumen en el 3.B.31 (P23); `impuestos-especiales` sin el 3.B.31; la ficha `dilema-prisionero` corregida (su matriz de referencia es la guerra de precios del 3.A.14, no Callar/Confesar); «fórmula de Ramsey del descuento» frente a «regla de Ramsey»; el 37 % del MRR remite al 3.B.45 (D9); una sola clave para el Reglamento (UE) 2023/956 (`UE2023Reglamento956`).

**Del 3.B.31 (no tocan el canon):**

- **[decidir]** Enganche y refranes (B31-01): «Quien siembra vientos recoge tempestades» con el dato de 2024 por encima de 1,5 °C, y las pegatinas «Pan para hoy, hambre para mañana» (descuento), «Más vale prevenir que curar» (mitigación y adaptación) y «Allá donde fueres, haz lo que vieres» (MAFC). A la lista de `CRITERIOS.md` § 8 cuando Víctor los apruebe (lo hace el coordinador).
- **[decidir]** Reparto 7′30″ / 9′ / 9′30″ (B31-03), MAFC en desarrollo con a)-e) y gráfico (B31-04), Bilal y Känzig con la cifra publicada (B31-07), Kotz *et al.* solo como retirado (B31-08), sin la frase de Joan Robinson (B31-09), datos de noviembre de 2026 (COP31 y Global Carbon Budget) antes de publicar (B31-11) y el importe del Fondo Social para el Clima (B31-12).

**Para los temas que se revisen después** (`mapa.yaml`, contradicciones de 3.B.31; resumen en `pendientes-coherencia.md`): **3.A.43** (la remisión del Solow con recurso natural al 3.B.31 sobra; la viñeta vacía del DICE, mención con la ficha `dice`); **3.A.29** (la remisión de los recursos naturales como inputs sobra; el 3.A.29 actual es la modelización dinámica, y el 3.B.31 no tiene remisión a él: la regla de Hotelling de los recursos agotables se cuenta en una línea); **3.B.37** (MAFC en resumen con el calendario correcto; RCDE como *cap and trade*, no «sistema de Coase»; NGEU al 3.B.45); **4.B.18** (RCDE y MAFC al día); **3.B.20** (Banco Mundial → 3.B.30); **3.B.41, 3.B.19, 3.B.33, 4.B.6, 4.A.6** (MAFC en resumen y frente al club; Club del Clima del G-7; nación más favorecida; descuento de Stern y Nordhaus con las cifras del 3.B.31, sin depender del 3.º; datos de octubre de 2026).

**Ideas para la organización** (§ 11): con el 3.B.31 queda revisado todo el bloque del bienestar. El 3.B.31 es su aplicación: usa el 1TFEB del 3.A.22, las externalidades, Coase, Samuelson y el *cap and trade* del 3.A.23, las generaciones futuras del 3.A.20, la ética del descuento del 3.A.24 y el dilema del 3.A.14, y enlaza con el crecimiento (RCK del 3.A.43, cambio técnico dirigido del 3.A.44), la política comercial y las finanzas de la UE (3.B.33, 3.B.37, 3.B.41) y la política española de energía y clima (4.A.6). En el PowerPoint conviene que vaya al final del bloque del bienestar, justo tras el 3.A.23, con una flecha al 4.A.6 (como proponía § 11, punto 7).

## 23. Decisiones abiertas tras la revisión del 3.A.25 (31/10/2026)

El 3.A.25 es el primer tema revisado del bloque de demanda y oferta agregadas (3.A.25-3.A.28, 3.A.33, 3.A.34) y fija la notación del mercado de trabajo que heredan los demás. Víctor está fuera hasta el 9/11: el coordinador aplicó la opción recomendada de cada duda (A25-01 a A25-12, `fuentes/3A25/revision.md`, «Dudas abiertas»; DK1-DK9 y D-P8 a D-P64 de `_trabajo/propuestas-coherencia.md`, § 9).

**Que tocan el canon:**

- **[decidir] Fichas nuevas `becker-capital-humano`, `demanda-trabajo`, `mincer` y `oaxaca-blinder`** (creadas, las 4 con el 3.A.25 de referencia): Becker y Mincer los usan el 3.A.13 (hecho), el 3.A.27, el 3.A.29, el 3.A.43, el 3.A.44, el 3.B.2 y los 4.A.2, 4.A.3 y 4.A.16; la demanda de trabajo, el 3.A.12 y el 3.A.17 (hechos), el 3.A.26 (variante dinámica), el 3.A.27, el 3.A.28 y el 4.A.16; Oaxaca-Blinder es técnica del 4.º (4.A.16, 4.A.3), con referencia en el 3.º por `CRITERIOS.md` § 6. Alternativa: dejar `oaxaca-blinder` dentro de `mincer`.
- **[decidir] $L^S$ con 2 significados** (A25-10): oferta de trabajo $L^S(w)$ (canon, § 6) y empleo del sindicato monopolista (anexo D del 3.A.25 y gráfico `monopolio-bilateral.tex` del 3.A.17). Aplicado: (a) mantenerlo, aclarado en el texto; alternativa (b): otra letra para el sindicato en los 2 temas y sus gráficos (entrada condicionada en `pendientes-coherencia.md`).
- **[decidir] $h_O(w,\overline U)$ para la hicksiana del ocio** (DK9), con nota de que la $h$ sola es el capital humano; alternativa $O^c$, que choca con la regla «nunca $x^c$» (§ 0).
- **[decidir] Empresa con $p$, $w_L$, $w_K$, $B$ y $w\equiv w_L/p$** (D-P64), como el 3.A.12 y el 3.A.17; $W$ nominal queda para la macro (WS-PS). Y **$w^c$, $L^c$ en todo el tema** (DK3), no $w^*$, $L^*$ en I.3.
- **[decidir] Tabla de supuestos `tab:supuestos-trabajo`** (DK5): las 5 filas del 3.A.16 con las mismas palabras y 3 propias del trabajo (6 salarios flexibles, 7 movilidad sin costes de ajuste, 8 sin externalidades), con la columna «Se levanta en»: se propone como **hilo del bloque** (los 3.A.26-3.A.28 la copian en una línea y marcan el supuesto que levantan), como la regla de las estructuras de mercado (`CRITERIOS.md` § 6). Si Víctor la aprueba, conviene escribirla en `CRITERIOS.md` § 6 como regla del bloque de mercado de trabajo.
- **[decidir] Lucas-Rapping en 2 periodos con el horizonte infinito en anexo** (A25-02, D-P40): es la presentación de referencia de la ficha (D068), con la Frisch $1/\varphi$ de la utilidad $\ln C-\chi L^{1+\varphi}/(1+\varphi)$.
- **Canon sin decisión (consecuencias de reglas ya aprobadas):** $\overline W$ en lugar de M (D002), $w^R$ (superíndice R = reserva), φ y χ (D004), $b_t$ (§ 7), grupos A y B en redonda (como el 3.A.13), $\varepsilon_{L,w}$ con 2 subíndices (§ 0); locales avisados: $F(\overline W)$, $\overline W^R(w)$, $\rho(S)$, $c$, $a$, ω, $k(X)$, $E(X)$, δ del anexo E (`notacion.md` § 1, § 6 y § 7). `areas.json`: `lucas-rapping` pasa de pensamiento a macro cerrada, como su ficha y el mapa.

**Del 3.A.25 (no tocan el canon):**

- **[decidir]** Estructura del original con la evidencia repartida (A25-01), monopsonio resumido en I.4 y anexo D (A25-03), gráfico de la EES de 2022 (A25-04; actualizar con la EES de 2026, previsiblemente en 2028), enganche «El tiempo es oro» con las pegatinas «hacer el agosto» y «el saber no ocupa lugar» (A25-05; ningún otro tema revisado los usa), reparto 2'30" / 10' / 6'30" / 10' / 1' (A25-06), títulos de II.4, II.5 y III.3 (A25-07), «Tema ICEX-CECO» en la bibliografía (A25-08), edición de McConnell y Brue (A25-09), González-Páramo (A25-11) y la materia «Economía laboral» en `seo.json` (A25-12).

**Para los temas que se revisen después** (`mapa.yaml`, contradicciones de 3.A.25; resumen en `pendientes-coherencia.md`): **3.A.29** (la separación de Fisher, no «de Acemoğlu y Autor»; remitir al 3.A.25 para Becker); **3.A.26 y 3.A.27** ($w^R$; el sindicato del 3.A.27 con $U_S$, $v(L)$, $w^D(L)$, $\mathrm{IMg}_S$ y $w^S$, no $c(L)$ ni $W(L)$; el 3.A.27 se está integrando en paralelo y no se ha tocado); **3.A.26-3.A.28** (sin repetir la contextualización; ni «único y estable» ni «de pleno empleo»; la tabla de supuestos en una línea); **3.A.6 y 3.A.42** (Lucas-Rapping en resumen y mención con $\varepsilon_{L,w}$ y φ); **4.B.10** ($\overline W$, remisión al 3.A.25 y el mismo gráfico); **3.B.2** (remitir al 3.A.25 la formación general pagada por la empresa). En el `mapa.yaml`, la entrada del 3.A.27 no se ha tocado: al cerrar su revisión hay que añadirle `demanda-trabajo` y `becker-capital-humano` (los demás temas ya llevan los ids nuevos).

**Ideas para la organización** (§ 11): el 3.A.25 abre el bloque y su tabla de supuestos ordena los 3 siguientes (el 3.A.26 levanta la información y la movilidad; el 3.A.27, la flexibilidad salarial y la precio-aceptación; el 3.A.28, la flexibilidad, con la tasa natural). En el PowerPoint conviene una flecha del 3.A.25 al 3.A.33 (la misma restricción intertemporal de Fisher en Lucas-Rapping y en la decisión de educarse) y otra al 3.A.43-3.A.44 (capital humano y rendimientos de Mincer), y marcar el 3.A.25 como referencia de la oferta de trabajo que aplica el 4.B.10.

## 24. Decisiones abiertas tras la revisión del 3.A.27 (31/10/2026)

El 3.A.27 es el 2.º tema revisado del bloque de demanda y oferta agregadas: hereda la notación del 3.A.25 ($w^R$, $L^D(w)$, $B$, γ, la tabla de supuestos) y fija la de la determinación de salarios, que usarán el 3.A.26, el 3.A.28, el 3.A.7 y el 4.A.16. Víctor está fuera hasta el 9/11: el coordinador aplicó la opción recomendada de cada duda (A27-01 a A27-16, `fuentes/3A27/revision.md`, «Dudas abiertas»; DK1-DK8 de `_trabajo/propuestas-coherencia.md`).

**Que tocan el canon:**

- **[decidir] Fichas nuevas, las 3 con el 3.A.27 de referencia**: `sindicato-monopolista` (el id ya estaba en el mapa sin ficha: los 3 modelos de negociación colectiva en un solo plano con `negociacion-colectiva.tex`), `insiders-outsiders` ($w_I=w_O+c_D+c_C$; usuarios 3.A.28, 4.A.16, 3.A.25 y 1D01) y `calmfors-driffill` (anexo D con `joroba.tex`; usuarios 3.B.16, 4.A.16 y 1D01). Las 2 últimas pasan de economía española a macro cerrada en `_inventario/areas.json`: la referencia teórica va en el 3.er ejercicio (`CRITERIOS.md` § 6) y el 4.A.16 las resume completo para su examen.
- **[decidir] Objetivo del sindicato: $U_S(w,L)$ de Booth** (A27-02): utilidad esperada de $\overline L$ afiliados aversos, con $z$ el valor del desempleo y $w^R=z$; con neutralidad equivale, salvo transformación afín, al $U_S=wL-v(L)$ del 3.A.17 con $v(L)=w^RL$, así que el 3.A.17 y el 3.A.25 no cambian. Alternativas: (b) solo la renta (se pierde la curva de contratos creciente); (c) $V(w,L)$ del original (choca con las vacantes y con $V_{\mathrm E}$).
- **[decidir] Sigla CNE** (A27-07) para la condición de no escaqueo, en castellano, con *no-shirking condition* la primera vez; la ficha `salarios-eficiencia` deja NSC. El 3.A.13 la nombra sin sigla y no cambia. Alternativas: NSC; sin sigla.
- **[decidir] $L^S$ con 2 significados también dentro del 3.A.27** (A25-10 ampliada): empleo del sindicato en $M$ (I.2 y `sindicato-monopolista.tex`) y oferta en `shapiro-stiglitz.tex`. Si Víctor elige (b) para el 3.A.17 y el 3.A.25, cambia también aquí (`pendientes-coherencia.md`).
- **Canon sin decisión (consecuencias de reglas ya aprobadas)**: $B$ para el beneficio (D003), $w^R=z$ (superíndice R = reserva), $s$ separación (D008), $f$ tasa de encontrar empleo sin argumento (como $f(\theta)$, D020), $J$ empresas (no $N$, población), $U$ tasa de paro en la CNE (regla del 24/10/2026), π_j probabilidades (D017), $U^R$ (como el 3.A.13), β_S, β_B y nunca δ en Rubinstein (3.A.14), $\varepsilon_{e,w}$ y $\varepsilon_{L^D,w}$ (§ 0); locales avisados: η, $b$, $x$, $w_a$ de Summers, $a$, $L_1$, $L_2$ del anexo E (`notacion.md` § 1 y § 6). En `mapa.yaml`, el 3.A.7 pasa de **desarrollo a resumen** en `salarios-eficiencia` y `contratos-implicitos` (lo que ya decían las fichas), y el 3.A.28 entra como mención de `salarios-eficiencia`.

**Del 3.A.27 (no tocan el canon):**

- **[decidir]** Orden del título y del original, I negociación / II eficiencia / III contratos implícitos, con 2'30" / 11' / 9'30" / 6' / 1' (A27-01; la guía oficial nueva ordena eficiencia → negociación → contratos); contratos fuertemente eficientes en viñeta y anexo B (A27-03); *insiders* en III.3 como extensión de los contratos implícitos (A27-04); anexo D corto sin gráfico de datos (A27-05; la serie de cobertura y afiliación por países queda en `fuentes/3A27/_trabajo/datos/` para el 4.A.16); cobertura del 92,1 % de la OCDE con las 3 cifras en una caja (A27-06); enganche del día de 5 dólares de Ford con «Lo barato sale caro» (A27-08; ningún otro tema revisado lo usa); sin la imagen de Nash (A27-09); Martínez Matute y Sahuquillo como lecturas (A27-10); lista de políticas atribuida a FEDEA (2009), **conviene cotejarla con el documento original** (A27-11); evidencia de la OCDE en paráfrasis (A27-12); tabla resumen en la conclusión sin cantar (A27-13); variantes de Shapiro y Stiglitz en gráfico aparte (A27-14); refranes «Hablando se entiende la gente», «Lo barato sale caro» y «A las duras y a las maduras» (A27-15); páginas de Cahuc et al. y de Romer sin comprobar (A27-16).

**Para los temas que se revisen después** (`mapa.yaml`, contradicciones de 3.A.27; resumen en `pendientes-coherencia.md`): **3.A.26** (se integra en paralelo: DMP con la notación del canon, la curva salarial con la misma γ y $z$ que el 3.A.27, y la nota 32 de los axiomas de Nash remitida al 3.A.14); **3.A.7** (resumir, no desarrollar, los salarios de eficiencia y los contratos implícitos, sin el error del paro involuntario, con remisión al 3.A.27); **3.A.28** (WS y PS, no SRN y SRP; $U^n$; *insiders* con la ficha nueva); **3.B.16 y 4.A.16** (resumir la centralización con `calmfors-driffill` y `joroba.tex`, no copiar el anexo antiguo); **3.A.4** (Hicks → 3.A.27, no 3.A.26). Ningún tema revisado tiene que cambiar (la precisión del 3.A.17 es opcional).

**Ideas para la organización** (§ 11): el 3.A.27 es el puente del bloque hacia la macro: sus 3 bloques son los microfundamentos de la curva WS que el 3.A.28 cruza con la PS, y la misma negociación de Nash (γ, $z$) cierra el DMP del 3.A.26. En el PowerPoint conviene una flecha del 3.A.27 al 3.A.28 (WS y *insiders*), otra al 3.A.26 (curva salarial), otra al 3.A.7 (rigideces reales de la NEK) y otra al 3.B.16 (centralización en una unión monetaria), además de las que llegan del 3.A.13 (IC), del 3.A.14 (Nash) y del 3.A.17 (monopolio bilateral). Conviene revisar ahora el 3.A.26 y el 3.A.28 seguidos, y el 3.A.7 antes de que se olviden los errores que copia del 3.A.27 antiguo.
