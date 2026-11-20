# Propuesta de cambios a la organización del temario (3.er ejercicio)

Fase `--organizacion` de `/revisartema`, 21/11/2026. Para que decida Víctor Gutiérrez Marcos: **no se ha tocado** el PowerPoint (`oposicion/organizacion/oculto/estructura_temario.pptx`), ni `estructura_temario.json` ni la app. El grafo de remisiones está en `canon/grafo-remisiones.json`.

## Resumen

1. Los 90 temas revisados tienen **5.852 remisiones `\vertema` entre temas del 3.º** (más 592 al 4.º), repartidas en 1.127 pares. Con el filtro pedido (en los dos sentidos o con 3 o más) salen 704 pares fuertes, demasiados para dibujarlos todos. Las propuestas usan los **74 «muy fuertes» (15 o más)**.
2. El esquema «tercero» dibuja 45 conexiones tema-tema del 3.º, y 40 de ellas son fuertes: lo que está dibujado casi siempre se sostiene. El fallo está en lo que **falta**: **28 temas (31 %) no tienen ninguna conexión** y 56 de los 74 pares muy fuertes no están dibujados. El más fuerte de todo el temario es 3.A.14–3.A.19 (41).
3. ORG-01 añade una conexión a cada uno de esos 28 temas (32 líneas) y ORG-02 añade 12 conexiones entre bloques. ORG-03 quita 3 que no se sostienen (3.A.38–3.B.24, 3.A.13–3.B.1 y 3.A.10–3.A.15: ninguna remisión, o una, y casi ningún modelo en común).
4. Bloques: mover **3.A.10 a «Modelo neoclásico básico»** (su título de 2024 es «Teoría de la demanda del consumidor (III)») y **3.B.13 a «Economía abierta»** (62 remisiones con ese bloque y 32 con el suyo). Partir «Organismos internacionales», el bloque menos cohesionado (12 % de remisiones internas), es opcional.
5. No conviene partir los bloques grandes (Corporativa y financiera, Economía abierta, UE, Pensamiento): la modularidad baja en todos los casos.
6. Orden de estudio: con el orden actual, **el 53 % de las dependencias fuertes entre bloques van hacia atrás** (un tema que usa un modelo antes de estudiar el tema que lo desarrolla). La causa principal es que Pensamiento va al final, cuando es el bloque que más modelos presta (IS-LM, monetarismo, NEK, expectativas racionales). Con el orden propuesto (ORG-13) baja al **30 %**, y el óptimo, empezando por el neoclásico, es el 29 %.
7. El planificador de la app manda «Información y poder de mercado» al puesto 43 y «Bienestar» al 71 de 90, y deja el 48 % de las dependencias hacia atrás. Con el orden propuesto queda en el 33 % (ORG-22).
8. Ideas clave: 22 rótulos o títulos del PowerPoint siguen con textos anteriores a 2024. Por ejemplo, 3.B.8 aún lleva la promoción exterior, 3.A.4 la «formalización», 3.A.39 solo la financiación y a 3.A.1 le falta la economía conductual. 3.A.20 y 3.B.31 no salen en la diapositiva de su bloque.
9. Hay 322 modelos que salen en dos o más temas, y 288 de ellos en más de un bloque. Conviene indicar dónde se explica cada uno (ORG-18). En `mapa.yaml` hay 10 modelos con dos temas que dicen «desarrollo» y 3 con un dato viejo (3.B.45 «previsto»).
10. App, por orden de valor: publicar las relaciones fuertes en `conexiones`, ponderarlas por número de remisiones, ordenar el cronograma por dependencias, y mostrar «dónde se explica este modelo» y «conviene ver antes» (ORG-20 a ORG-27).

## Datos y método

- **Remisiones**: `\vertema{X}` y `\vertemacorto{X}` en `oposicion/temario/fuentes/<T>/<T>.tex` (90 ficheros, sin líneas comentadas ni autorremisiones; el rango «3.A.16-3.A.19» cuenta una vez para cada tema). En «a→b / b→a», el primer número son las remisiones escritas en el primer tema hacia el segundo.
- **Fuerte**: en los dos sentidos o con 3 o más remisiones (704 pares). **Muy fuerte**: 15 o más (74). Se usa también el número de **modelos comunes** de `mapa.yaml` (los que usan los dos temas).
- **Bloques** (abreviaturas): NEO Modelo neoclásico básico · INF Información y poder de mercado · BIE Bienestar e intervención · COM Comercio internacional · CF Corporativa y financiera · CN Contabilidad nacional · CRE Crecimiento · CIC Ciclo y políticas de demanda · EAB Economía abierta · DAOA Demanda y oferta agregada · HE Historia económica · OI Organismos internacionales · UE Unión Europea · HPE Pensamiento económico.
- **Cohesión de bloques**: modularidad Q del reparto, con las remisiones como peso. El reparto actual tiene Q = 0,314; un ΔQ positivo indica que el cambio agrupa mejor los temas que se remiten entre sí.
- **Dependencias para el orden**: si un modelo tiene su tema de referencia en R y el tema T lo resume (peso 2) o lo menciona o usa (peso 1), R va antes que T. Hay 866 pares con dependencia. Como «mención» incluye mencionar algo que se ve más adelante, las cifras del orden usan solo las **dependencias fuertes (peso ≥ 3: 181 pares)**. El orden óptimo de bloques se ha calculado de forma exacta (programación dinámica sobre los 14 bloques).

## A. Conexiones del esquema «tercero» (diap. 5)

### ORG-01. Una conexión para cada tema que hoy no tiene ninguna. Recomendación: **sí**

Hay 28 temas sin ninguna conexión en el esquema (33 sin conexión con otro tema). Se propone su conexión más fuerte, y dos cuando la segunda cruza de bloque y es muy fuerte. Las que están dentro de un mismo bloque pueden ir en la diapositiva del bloque (ORG-06) si no caben en la general.

| Conexión | Bloques | a→b / b→a | Total | Modelos comunes |
|---|---|---|---|---|
| 3.A.14 – 3.A.19 | INF / INF | 22 / 19 | **41** | 10 |
| 3.A.14 – 3.A.23 | INF / BIE | 5 / 12 | 17 | 10 |
| 3.A.21 – 3.A.22 | NEO / BIE | 7 / 12 | 19 | 9 |
| 3.A.2 – 3.B.5 | HPE / COM | 9 / 7 | 16 | 2 |
| 3.A.6 – 3.A.42 | HPE / CIC | 3 / 11 | 14 | 22 |
| 3.A.26 – 3.A.28 | DAOA / DAOA | 10 / 7 | 17 | 10 |
| 3.A.27 – 3.A.25 | DAOA / DAOA | 5 / 12 | 17 | 7 |
| 3.A.33 – 3.A.29 | DAOA / CRE | 8 / 14 | 22 | 18 |
| 3.A.35 – 3.A.41 | CIC / CIC | 7 / 7 | 14 | 10 |
| 3.A.37 – 3.A.36 | CIC / CIC | 16 / 8 | 24 | 18 |
| 3.A.37 – 3.A.7 | CIC / HPE | 9 / 6 | 15 | 23 |
| 3.A.40 – 3.A.37 | CIC / CIC | 8 / 11 | 19 | 11 |
| 3.A.32 – 3.B.16 | EAB / EAB | 5 / 9 | 14 | 8 |
| 3.A.44 – 3.B.9 | CRE / COM | 5 / 15 | 20 | 5 |
| 3.A.44 – 3.A.43 | CRE / CRE | 13 / 11 | 24 | 19 |
| 3.A.45 – 3.A.43 | CRE / CRE | 18 / 8 | 26 | 18 |
| 3.B.23 – 3.A.10 | CF / INF | 5 / 9 | 14 | 7 |
| 3.B.25 – 3.B.13 | CF / CF | 8 / 10 | 18 | 2 |
| 3.B.26 – 3.B.27 | CF / CF | 14 / 8 | 22 | 9 |
| 3.B.26 – 3.B.17 | CF / EAB | 5 / 10 | 15 | 5 |
| 3.B.17 – 3.B.22 | EAB / OI | 10 / 9 | 19 | 10 |
| 3.B.18 – 3.B.11 | EAB / CN | 7 / 4 | 11 | 3 |
| 3.B.19 – 3.A.32 | EAB / EAB | 5 / 7 | 12 | 12 |
| 3.B.20 – 3.B.22 | HE / OI | 5 / 5 | 10 | 2 |
| 3.B.21 – 3.B.22 | HE / OI | 7 / 3 | 10 | 4 |
| 3.B.32 – 3.B.21 | HE / HE | 6 / 1 | 7 | 0 |
| 3.B.36 – 3.B.37 | UE / UE | 10 / 4 | 14 | 1 |
| 3.B.37 – 3.B.40 | UE / UE | 7 / 9 | 16 | 0 |
| 3.B.38 – 3.B.33 | UE / OI | 7 / 2 | 9 | 0 |
| 3.B.39 – 3.B.10 | UE / COM | 9 / 3 | 12 | 1 |
| 3.B.45 – 3.B.43 | UE / UE | 6 / 10 | 16 | 0 |
| 3.B.45 – 3.A.39 | UE / CIC | 6 / 6 | 12 | 0 |

Nota: en Pensamiento (3.A.1-3.A.7), el esquema solo une 3.A.1, 3.A.3, 3.A.4, 3.A.5 y 3.A.7 con bloques enteros, y 3.A.2 y 3.A.6 no tienen nada. 3.B.32 solo tiene remisiones débiles (como mucho 7 con un tema, casi todas en un solo sentido): basta la línea de tiempo de Historia económica.

### ORG-02. Conexiones muy fuertes entre bloques que no están dibujadas. Recomendación: **sí** para las 8 primeras, **opcional** el resto

| Conexión | Bloques | a→b / b→a | Total | Modelos comunes | Comentario |
|---|---|---|---|---|---|
| 3.A.12 – 3.A.17 | NEO / INF | 13 / 11 | 24 | 11 | Costes y monopolio natural |
| 3.B.11 – 3.B.12 | CN / EAB | 8 / 14 | 22 | 12 | Hoy solo hay 3.B.11 → bloque EAB: mejor tema a tema |
| 3.B.7 – 3.B.33 | COM / OI | 12 / 7 | 19 | 0 | Está en la diap. 23, pero no en el esquema general |
| 3.B.13 – 3.B.14 | CF / EAB | 8 / 10 | 18 | 9 | Desaparece si se acepta ORG-08 (mismo bloque) |
| 3.B.13 – 3.B.15 | CF / EAB | 7 / 9 | 16 | 11 | Igual |
| 3.A.16 – 3.A.17 | NEO / INF | 10 / 6 | 16 | 8 | Competencia frente a monopolio |
| 3.A.5 – 3.A.36 | HPE / CIC | 6 / 10 | 16 | 16 | Monetarismo, IS-LM y Taylor |
| 3.A.7 – 3.A.41 | HPE / CIC | 3 / 13 | 16 | 17 | NEK e inflación |
| 3.A.12 – 3.A.15 | NEO / INF | 6 / 9 | 15 | 6 | |
| 3.A.33 – 3.A.37 | DAOA / CIC | 7 / 8 | 15 | 8 | |
| 3.A.3 – 3.A.21 | HPE / NEO | 12 / 1 | 13 | 7 | Sustituye a 3.A.3 → bloque NEO (ORG-05) |
| 3.A.13 – 3.B.3 | INF / CF | 1 / 9 | 10 | 3 | Sustituye a 3.A.13–3.B.1 (ORG-03) |

### ORG-03. Quitar conexiones que el temario revisado no sostiene. Recomendación: **sí**

| Conexión dibujada | Remisiones | Modelos comunes | Propuesta |
|---|---|---|---|
| 3.A.38 – 3.B.24 | 0 | 0 | Quitar |
| 3.A.13 – 3.B.1 | 0 / 1 | 0 | Cambiar por 3.A.13 – 3.B.3 (1 / 9; información asimétrica y estructura de capital) |
| 3.A.10 – 3.A.15 | 0 | 1 | Quitar: 3.A.10 ya va unido a 3.A.13 (11) y a 3.A.8 (20) |

### ORG-04. Conexiones débiles que conviene revisar. Recomendación: **opcional**

| Conexión dibujada | Remisiones | Modelos comunes | Propuesta |
|---|---|---|---|
| 3.A.28 – 3.A.29 | 0 | 5 | Cambiar por 3.A.29 – 3.A.33 (22 remisiones, 18 modelos) |
| 3.A.16 – 3.A.25 | 0 / 2 | 3 | Quitar: la oferta de trabajo ya va unida a 3.A.8 (8 remisiones) |
| 3.B.13 – 3.B.27 | 4 / 0 | 2 | Mantener (prestamista de última instancia, controles de capital) |
| 3.A.22 – 3.B.10 | 1 / 3 | 2 | Mantener (second best y Viner) |
| 3.B.28 – 3.B.42 | 2 / 2 | 5 | Mantener |
| 3.A.36 – 3.A.38 | 0 / 4 | 6 | Mantener |

Dirección: 3.A.38 → 3.A.39 tiene 18 / 0 (3.A.38 remite 18 veces a 3.A.39 y 3.A.39 nunca a 3.A.38). Conviene que la flecha diga «antes 3.A.39» (ORG-14).

### ORG-05. Conexiones de un tema con un bloque entero. Recomendación: **sí**

Las remisiones de un tema con todos los temas de un bloque permiten comprobar las líneas que van de un tema a un bloque:

| Línea actual | Remisiones con ese bloque | Mejor destino | Propuesta |
|---|---|---|---|
| 3.A.7 → INF | 15 | CIC: 79 | Cambiar por 3.A.7 → CIC (o 3.A.7 – 3.A.37, ORG-01) |
| 3.A.5 → DAOA | 22 | CIC: 60 | Cambiar por 3.A.5 → CIC (o 3.A.5 – 3.A.36, ORG-02) |
| 3.A.4 → DAOA | 21 | HPE: 66; fuera, CIC: 32 | Cambiar por 3.A.4 → CIC |
| 3.A.3 → NEO | 52 | Bien | Mantener (o concretar con 3.A.3 – 3.A.21) |
| 3.B.11 → EAB, 3.B.13 → EAB | 73 y 62 | Bien | Mantener (o sustituir por ORG-02) |
| 3.B.31 → CRE y → OI | 22 y 14 | Su mayor vínculo es 3.A.23 (17, ya dibujado) | Mantener |

### ORG-06. Conexiones internas muy fuertes en las diapositivas de bloque (16-39). Recomendación: **opcional**

Para no cargar el esquema general, las conexiones dentro de un bloque pueden ir en la diapositiva del bloque. Estas tienen 20 o más remisiones y no están dibujadas: 3.A.14–3.A.19 (41), 3.A.43–3.A.45 (26), 3.A.20–3.A.23 (25), 3.A.36–3.A.37 (24), 3.A.43–3.A.44 (24), 3.A.14–3.A.15 (23), 3.B.3–3.B.4 (23), 3.A.1–3.A.6 (22), 3.A.22–3.A.24 (22), 3.B.26–3.B.27 (22), 3.A.12–3.A.16 (21), 3.A.18–3.A.19 (20) y 3.A.36–3.A.41 (20).

## B. Bloques

Cohesión actual, de más a menos remisiones internas:

| Bloque | Temas | Remisiones internas | Externas | % interno |
|---|---|---|---|---|
| CF | 10 | 276 | 427 | 39 % |
| UE | 10 | 207 | 437 | 32 % |
| COM | 6 | 152 | 384 | 28 % |
| NEO | 6 | 195 | 590 | 25 % |
| EAB | 9 | 249 | 754 | 25 % |
| INF | 7 | 232 | 743 | 24 % |
| CIC | 8 | 265 | 823 | 24 % |
| HPE | 7 | 207 | 791 | 21 % |
| BIE | 5 | 126 | 480 | 21 % |
| DAOA | 6 | 131 | 520 | 20 % |
| CRE | 5 | 118 | 492 | 19 % |
| CN | 3 | 28 | 174 | 14 % |
| OI | 5 | 47 | 352 | **12 %** |
| HE | 3 | 21 | 229 | **8 %** |

Los pares de bloques más unidos entre sí son CIC–HPE (271), NEO–INF (191), INF–BIE (167) y CIC–DAOA (134).

### ORG-07. 3.A.10 pasa a «Modelo neoclásico básico». Recomendación: **sí**

- Título de 2024: «Teoría de la demanda del consumidor (III). Elección del consumidor en situaciones de riesgo e incertidumbre». Es la tercera parte de 3.A.8 y 3.A.9, no un tema de información.
- Remisiones por tema del bloque: 5,0 con NEO y 3,7 con INF. Su mayor vínculo es 3.A.8 (10 / 10). ΔQ = +0,0016.
- Cambiar también su idea clave (ORG-15) y conservar la línea con 3.A.13, que es el puente con la información asimétrica.

### ORG-08. 3.B.13 pasa a «Economía abierta». Recomendación: **sí**

- Título de 2024: «Mercados de divisas: operaciones e instrumentos». Sus vínculos más fuertes, después de 3.B.25 (18), son 3.B.14 (18), 3.B.15 (16) y 3.B.17 (11).
- Remisiones: 62 con EAB (6,9 por tema) y 32 con CF (3,6 por tema). ΔQ = +0,0045. El PowerPoint ya lo une al bloque EAB (diap. 31).

### ORG-09. Repartir «Organismos internacionales». Recomendación: **opcional**

- Es el segundo bloque menos cohesionado: 47 remisiones internas y 352 hacia fuera. Cada organismo se apoya en la teoría que aplica: la OMC (3.B.33 y 3.B.34) en la política comercial (3.B.7–3.B.33: 19; 3.B.33–3.B.41: 19); el FMI (3.B.22) en las crisis y la balanza de pagos (3.B.17: 19; 3.B.29: 13; 3.B.12: 12) y en la historia (3.B.20 y 3.B.21: 10 cada uno); el BM (3.B.30) en 3.B.29 (17).
- Opción a: OMC y 3.B.35 a «Comercio internacional», y FMI y BM a «Historia económica», que pasaría a llamarse «Sistema económico internacional». ΔQ = +0,0100, el mayor de los cambios probados. Las remisiones internas de HE + FMI + BM pasan de 21 a 60.
- Opción b: solo la OMC y 3.B.35 a Comercio. ΔQ = +0,0060.
- En contra: «Organismos» es un bloque cómodo para memorizar (estructura, cuotas, préstamos). Si se mantiene, bastan las conexiones de ORG-01 y ORG-02.

### ORG-10. 3.A.29 pasa a «Demanda y oferta agregada» (o se marca como «herramienta» de toda la macro). Recomendación: **opcional**

- Remisiones: 51 con DAOA (8,5 por tema) y 21 con su bloque CRE (5,2). Su mayor vínculo es 3.A.33 (22). ΔQ = +0,0045.
- Es la caja de herramientas dinámica (horizonte infinito y generaciones solapadas) de consumo, inversión, crecimiento y política fiscal. Sea cual sea su bloque, conviene estudiarlo antes que ellos (ORG-13).

### ORG-11. Otros movimientos probados. Recomendación: **no**, salvo 3.B.11, que es opcional

| Movimiento | ΔQ | Comentario |
|---|---|---|
| 3.B.11 → EAB | +0,0077 | Opcional. Mejora la cohesión, pero CN se quedaría con 2 temas y pierde su sentido de «medición». Con ORG-02 (3.B.11–3.B.12) basta |
| 3.B.22 → EAB | +0,0066 | Mejor como en ORG-09 |
| 3.A.7 → CIC | +0,0034 | No: rompe la secuencia de escuelas. Se resuelve con el orden (ORG-13) |
| 3.A.42 → HPE | +0,0025 | No |
| 3.A.20 → INF | +0,0018 | No: su mayor vínculo es 3.A.23 (25). Se queda en BIE, pero hay que ponerlo en su diapositiva (ORG-17) |
| 3.B.31 → CRE | −0,0011 | No: cambio climático se queda en BIE (externalidades, 3.A.23) |
| 3.B.28 + 3.B.29 + 3.B.30 en un bloque «Desarrollo» | −0,0041 | No (las líneas entre ellos ya están dibujadas) |

Con ORG-07, ORG-08 y ORG-09a, Q sube de 0,314 a 0,330, y a 0,335 si se añade ORG-10.

### ORG-12. No partir los bloques grandes. Recomendación: **sí** (mantenerlos)

| Partición probada | ΔQ |
|---|---|
| CF en corporativa (3.B.1-3.B.4) y financiera (3.B.13, 3.B.23-3.B.27) | −0,0089 (71 remisiones cruzadas) |
| EAB en balanza de pagos y tipo de cambio | −0,0105 (95 cruzadas, frente a 50 y 104 dentro) |
| UE en tres (instituciones y finanzas, mercado y exterior, euro) | −0,0125 |
| HPE en clásicos y neoclásicos (3.A.1-3.A.3) y escuelas macro (3.A.4-3.A.7) | −0,0119 |

Los subgrupos ya están en las diapositivas 24, 31 y 38, y basta con eso.

### ORG-13. Orden de estudio de los bloques. Recomendación: **sí**

Contando las 419 dependencias fuertes entre bloques (dependencias de modelos con peso ≥ 3):

| Orden | Dependencias hacia atrás |
|---|---|
| Actual del PowerPoint: NEO, INF, BIE, COM, CF, CN, CRE, CIC, EAB, DAOA, HE, OI, UE, HPE | 221 (53 %) |
| **Propuesto: NEO, INF, BIE, HPE, CN, DAOA, CRE, CIC, CF, COM, EAB, HE, OI, UE** | **125 (30 %)** |
| Óptimo empezando por NEO: NEO, INF, BIE, HPE, DAOA, CRE, UE, CIC, CF, EAB, OI, HE, CN, COM | 120 (29 %) |

- **Pensamiento pasa del final al 4.º puesto**, entre la micro y la macro. Es el bloque que más presta: sus temas son la referencia de IS-LM y del monetarismo (3.A.5), de la *Teoría general* (3.A.4), de las expectativas racionales y la crítica de Lucas (3.A.6) y del modelo de 3 ecuaciones de la NEK (3.A.7). Las mayores dependencias hacia atrás del orden actual son HPE→CIC (91), HPE→DAOA (43) y HPE→CRE (30). Los temas que más dependencias aportan son 3.A.4 (61), 3.A.6 (56) y 3.A.5 (53).
- **DAOA va antes que CRE y CIC**: DAOA→CIC tiene 31 y DAOA→CRE, 19 (Phillips, renta permanente, restricciones de liquidez).
- CF va después de CIC y antes de EAB (CF→EAB: 26). Comercio va justo antes de Economía abierta, y la UE al final (es el bloque que más recibe y menos presta: recibe 54 y presta 8).
- El óptimo puro pondría la UE antes de CIC y la Contabilidad nacional al final. No se propone porque la ganancia es mínima (5 dependencias) y la UE se apoya en todo lo demás.

### ORG-14. Orden dentro de los bloques. Recomendación: **sí** para 3.A.39, **opcional** para 3.A.1

Dentro de los bloques, el orden por número funciona bien. Solo hay dos casos en que las dos señales (modelos y remisiones) piden otro orden y además tiene sentido:

| Cambio | Modelos | Remisiones |
|---|---|---|
| **3.A.39 antes que 3.A.38** | 5 frente a 0 (equivalencia ricardiana, restricción del sector público) | 3.A.38 remite 18 veces a 3.A.39 y 3.A.39 ninguna a 3.A.38 |
| 3.A.1 al final de Pensamiento | 3.A.5→3.A.1: 3 frente a 1; 3.A.6→3.A.1: 4 frente a 2 | 3.A.1 remite a 3.A.6 17 veces y a 3.A.5 11 (repasa la metodología de todas las escuelas) |

Se descartan 3.A.9 antes que 3.A.8 y 3.A.4 antes que 3.A.3: los datos los apuntan, pero son menciones anticipadas, y el orden por número o por cronología es mejor.

## C. Ideas clave y títulos

### ORG-15. Ideas clave (diap. 16-39) desactualizadas. Recomendación: **sí**

| Tema | Texto actual (diap.) | Qué cambia en el título de 2024 | Propuesta |
|---|---|---|---|
| 3.A.1 | «Objeto y método de la ciencia económica» (39) | Añade cuestiones actuales y **economía conductual** (3.A.1 es la referencia de la economía conductual, que sale en 16 temas) | «Objeto y métodos. Debates actuales y economía conductual» |
| 3.A.4 | «…Formalización y comparación con el modelo neoclásico…» (39) | Ya no pide formalizar ni comparar | «El pensamiento de Keynes. Economía postkeynesiana y desequilibrio» |
| 3.A.10 | «Información incompleta. Riesgo e incertidumbre» (17-20) | Es la parte (III) de la teoría del consumidor | «Consumidor (III): elección con riesgo e incertidumbre» (y ORG-07) |
| 3.A.15 | «Teoría de la Organización Industrial» (17-20) | Empieza por la empresa: tamaño eficiente, límites, costes de transacción; barreras y mercados impugnables | «La empresa y sus límites. Organización industrial: barreras y mercados impugnables» |
| 3.A.25 | «Modelización de la oferta de trabajo» (32) | Mercado de trabajo neoclásico, oferta intertemporal, capital humano y función de ingresos | «Mercado de trabajo neoclásico: oferta intertemporal y capital humano» |
| 3.A.27 | «Determinación de la curva salarial. Rigideces reales y cómo afectan a la curva WS» (32) | Modelos de negociación, salarios de eficiencia y contratos implícitos | «Salarios: negociación, eficiencia y contratos implícitos (curva WS)» |
| 3.A.28 | «Tasa Natural de Paro y NAIRU» (32) | Añade la persistencia del desempleo | «Tasa natural, NAIRU y persistencia del paro» |
| 3.A.34 | «Teorías de la demanda de inversión» (32) | Inversión en bienes de equipo, incertidumbre e irreversibilidad | «Inversión en bienes de equipo: incertidumbre e irreversibilidad» |
| 3.A.37 | «La política monetaria (II): los mecanismos de transmisión» (30) | Transmisión convencional (rigideces, fricciones financieras) y no convencional | «Transmisión de la política monetaria convencional y no convencional» |
| 3.A.38 | «Política fiscal. Especial referencia a los efectos…» (30) | «La política fiscal: efectos sobre el crecimiento económico y el ahorro» | El texto de 2024 |
| 3.A.39 | «La financiación del déficit público. Sostenibilidad» (30) | Conceptos, financiación, dominación monetaria y fiscal, dinámica de la deuda | «Déficit: financiación, dominación monetaria o fiscal y sostenibilidad de la deuda» |
| 3.A.41 | «La inflación: causas y efectos…» (30) | Añade hiperinflación y deflación | Añadirlo |
| 3.A.42 | «…El ciclo financiero y sus interrelaciones…» (30) | El ciclo financiero pasa a ser solo una «referencia» | «Ciclos nominales y reales; referencia al ciclo financiero» |
| 3.B.5 | «Teoría ricardiana… HOS y sus extensiones» (23) | Añade la relación real de intercambio | Añadirlo |
| 3.B.8 | «…La política de promoción exterior: justificación, instrumentos y objetivos» (23) | **Ya no tiene la promoción exterior** (está en el bloque del 5.º, diap. 12) | «Política comercial (II): la política comercial estratégica» |
| 3.B.13 | «Mercado de divisas» (24, 31) | «Mercados de divisas: operaciones e instrumentos» | El texto de 2024 |
| 3.B.20 | «El sistema económico internacional hasta la ruptura de BW» (36) | «desde el siglo XIX hasta…» | Añadirlo |
| 3.B.22 | «Fondo Monetario Internacional (FMI)» (37) | Estructura y políticas; prevención y solución de crisis | «FMI: estructura, políticas y solución de crisis» |
| 3.B.27 | «Fundamentos económicos y evidencia empírica» (24) | «Fundamentos teóricos» | Cambiarlo |
| 3.B.30 | «Grupo del BM y Bancos Regionales de Desarrollo» (37) | Añade otras instituciones financieras multilaterales de desarrollo | Añadirlo |
| 3.B.37 | «…y el presupuesto comunitario y el presupuesto comunitario…» (38) | Errata (repetido) | Quitar la repetición |
| 3.B.43 | «Funcionamiento y evolución del SME…» (38) | Empieza por «El origen del euro» | Añadirlo |

Errata en las diap. 21-22: «Gibbard-Satterthewaite» → «Gibbard-Satterthwaite».

### ORG-16. Títulos de las diapositivas de tema (41-130). Recomendación: **sí**

11 títulos no coinciden con los de 2024 (`scripts/temario/dudas/titulos.json`): 3.A.4 (diap. 44), 3.A.27 (67), 3.A.38 (78), 3.A.41 (81, con «Causas Efectos» pegado al final), 3.A.42 (82), 3.B.8 (93), 3.B.18 (103), 3.B.20 (105), 3.B.37 (122), 3.B.41 (126, «de la UE» en vez de «de la Unión Europea») y 3.B.43 (128). Los otros 79 coinciden. La app no se ve afectada, porque saca los títulos de `temario.json`.

### ORG-17. 3.A.20 y 3.B.31 en la diapositiva de su bloque (diap. 19-20). Recomendación: **sí**

Son los únicos dos temas del 3.º que no salen en ninguna diapositiva de bloque. Ideas propuestas:
- 3.A.20: «Poder de mercado y regulación óptima: mercado relevante e información asimétrica». Va unido a 3.A.23 (25) y a 3.A.17 (20, ya dibujado), y es el tema de referencia de 8 modelos compartidos (Laffont-Tirole, price cap, mercado relevante…).
- 3.B.31: «Cambio climático: evidencia, modelos integrados de evaluación y acuerdos». Va unido a 3.A.23 (17, externalidades).

Además, a 51 de los 90 temas la app no les muestra idea clave: la extracción descarta la que repite el título, y otros no tienen texto propio. Ver ORG-24.

## D. Tema de referencia de los modelos compartidos

### ORG-18. Indicar en la organización dónde se explica cada modelo. Recomendación: **sí** (en el PowerPoint, solo los principales; la lista completa, en la app, ORG-23)

`mapa.yaml` tiene 381 modelos. 322 salen en dos o más temas del 3.º y 288 en más de un bloque. Los que tienen su tema de referencia en cada bloque: INF 39, CIC 39, HPE 36, DAOA 34, EAB 29, BIE 27, CRE 27, NEO 27, 4.º ejercicio 22, CF 21, COM 16, CN 5, UE 4, OI 1 y HE 1. Propuesta: en cada diapositiva de bloque, un recuadro «Modelos que se explican aquí» con los de esta tabla (los que salen en 10 o más temas o en 6 o más bloques):

| Modelo | Tema de referencia | Temas del 3.º | Bloques |
|---|---|---|---|
| Economía conductual | 3.A.1 (HPE) | 16 | 8 |
| Equilibrio de Nash y refinamientos | 3.A.14 (INF) | 16 | 7 |
| Teoremas fundamentales del bienestar | 3.A.22 (BIE) | 16 | 5 |
| Crítica de Lucas | 3.A.6 (HPE) | 15 | 5 |
| Ciclo financiero | 3.A.42 (CIC) | 14 | 5 |
| Escuela austriaca | 3.A.3 (HPE) | 13 | 6 |
| Expectativas racionales | 3.A.6 (HPE) | 13 | 6 |
| Monopolio (Lerner, coste social) | 3.A.17 (INF) | 12 | 6 |
| Modelo de 3 ecuaciones de la NEK | 3.A.7 (HPE) | 12 | 6 |
| Prestamista de última instancia | 3.B.26 (CF) | 12 | 6 |
| Second best | 3.A.22 (BIE) | 12 | 5 |
| IS-LM-BP (Mundell-Fleming) | 3.A.32 (EAB) | 12 | 5 |
| Cournot | 3.A.19 (INF) | 12 | 5 |
| IS-LM | 3.A.5 (HPE) | 12 | 4 |
| Adam Smith (mano invisible, división del trabajo) | 3.A.2 (HPE) | 12 | 4 |
| Keynes, *Teoría general* | 3.A.4 (HPE) | 12 | 4 |
| Negociación (Nash, Rubinstein) | 3.A.14 (INF) | 11 | 5 |
| Inconsistencia temporal (Kydland-Prescott, Barro-Gordon) | 3.A.36 (CIC) | 11 | 5 |
| Crisis de primera generación | 3.B.17 (EAB) | 11 | 5 |
| Monetarismo | 3.A.5 (HPE) | 11 | 2 |
| Dixit-Stiglitz | 3.A.18 (INF) | 10 | 8 |
| Economía postkeynesiana | 3.A.4 (HPE) | 10 | 5 |
| Equivalencia ricardiana | 3.A.39 (CIC) | 10 | 5 |
| Ramsey-Cass-Koopmans | 3.A.43 (CRE) | 10 | 5 |
| Cuentas del SEC 2010 e identidades | 3.A.30 (CN) | 10 | 5 |
| Curva de Phillips | 3.A.28 (DAOA) | 10 | 4 |
| Regla de Taylor | 3.A.36 (CIC) | 10 | 3 |
| G-20 y OCDE | 3.B.19 (EAB) | 9 | 7 |
| Utilidad esperada (vNM) | 3.A.10 (INF; NEO con ORG-07) | 9 | 6 |
| Renta diferencial de Ricardo | 3.A.2 (HPE) | 9 | 6 |
| Marco input-output | 3.A.31 (CN) | 9 | 6 |
| Aversión al riesgo (Arrow-Pratt) | 3.A.10 (INF; NEO con ORG-07) | 8 | 6 |
| Racionamiento del crédito | 3.A.13 (INF) | 8 | 6 |
| Crisis de segunda y tercera generación | 3.B.17 (EAB) | 8 | 6 |
| Costes de transacción | 3.A.15 (INF) | 8 | 6 |
| Mercado de «limones» | 3.A.13 (INF) | 7 | 6 |

Cosas que arreglar en `mapa.yaml` antes de publicar nada (para `--canon`, no para el PowerPoint):
- **10 modelos con dos temas que dicen «desarrollo»**, así que no queda claro dónde se explica: equilibrio de Nash (3.A.14 y 3.A.19), Walras (3.A.21 y 3.A.22), Baumol-Tobin (3.A.35 y 3.B.2), Mundell-Fleming (3.A.32 y 3.B.19), centro-periferia (3.B.6, 3.B.9 y 3.B.40), Gordon-Shapiro (3.B.3 y 3.B.4), Tobin y la cartera (3.A.35 y 3.B.23), demanda de trabajo (3.A.25 y 3.A.26), ciclo financiero (3.A.42 y 3.B.15) y OA-DA (3.A.32 y 3.A.5). Hay que dejar «desarrollo» solo en el de referencia.
- MEDE, PEC y Semestre Europeo tienen 3.B.45 como referencia con el papel «previsto (tema sin fuente)», aunque 3.B.45 ya está escrito (tiene 38 remisiones). Hay que actualizar el dato.
- `escuela-schumpeter` no tiene tema de referencia (es la pieza común de los 7 temas de Pensamiento): ponerle 3.A.1 o sacarla de los modelos.
- Otros 24 modelos tienen como referencia un tema que solo los resume o los menciona (p. ej. Lancaster en 3.A.8, Leontief en 3.A.11, el dilema del prisionero en 3.A.14; varios son del 4.º). Hay que confirmarlo o cambiar el papel a «desarrollo».

### ORG-19. Esquema combinado 3.º–4.º (diap. 9-10). Recomendación: **opcional**

Hay 592 remisiones del 3.º al 4.º. Solo se pueden contar en ese sentido, porque los temas del 4.º no están revisados. Las 5 mayores no están dibujadas: 3.A.14 → 4.A.15 (7), 3.A.23 → 4.B.2 (7), 3.A.27 → 4.A.16 (6), 3.A.38 → 4.B.11 (6) y 3.B.29 → 4.A.24 (6). De las 3 líneas 3.º–4.º del esquema «tercero», 3.A.24–4.B.2 (7) y 3.B.11–4.A.21 (4) se sostienen, y 3.A.38–4.B.4 (2) es débil. Mejor decidirlo cuando se revise el 4.º.

## E. Herramienta de organización de la app

Por orden de valor para el opositor. Todo depende de datos de la rama de revisión, así que sigue la regla del lanzamiento conjunto: se prepara, pero no se publica hasta que se publique el temario revisado. El grafo tendría que copiarse a `oposicion/organizacion/` al fusionar la rama, o generarse allí.

### ORG-20. Publicar las relaciones fuertes no dibujadas en `conexiones`. Recomendación: **sí**

- **Dato**: `scripts/extraer-estructura-temario.py` lee `grafo-remisiones.json` y escribe en la raíz de `estructura_temario.json` una lista `conexiones` con `{de, a, peso, modelos}`. Entran las 4 más fuertes de cada tema (en los dos sentidos y con 8 o más) y todas las de 15 o más: 201 conexiones, 170 de ellas sin dibujar, con una mediana de 4 por tema. Los 4 temas con menos de 2 (3.A.31, 3.B.31, 3.B.32 y 3.B.40) se completan con sus 2 mayores.
- **App**: `EstructuraTemario` ya mezcla `conexiones` (`sinDibujar`) en «Conecta con» (`agenda_tema_page.dart`, `esquema_vista.dart`), en `sugeridos` y en `ordenSugerido` sin dibujarlas. El único cambio sería ordenar «Conecta con» por peso y limitarlo a 6 en `agenda_tema_page.dart`.
- **Por qué**: hoy 28 temas no tienen ningún «Conecta con» ni entran en «Por dónde seguir» (entre ellos 3.A.14, 3.A.37, 3.B.17 y 3.A.6).

### ORG-21. Ponderar las conexiones por número de remisiones. Recomendación: **sí**

- **Dato**: campo `peso` (total de remisiones; 1 si no viene) en cada conexión. Las dibujadas también lo llevan, sacado del grafo.
- **App**: en `app/lib/data/models/estructura.dart`, campo `peso` en `Conexion` (`fromJson`, valor por defecto 1); en `sugeridos`, sumar `peso` en vez de +1; en `planificador.dart`, `conexionesCon` suma `peso`.
- **Por qué**: hoy 3.A.11–3.A.12 (33 remisiones) cuenta igual que 3.A.13–3.B.1 (1). «Por dónde seguir» recomendaría primero lo que de verdad se apoya en lo ya estudiado.

### ORG-22. Orden del cronograma por dependencias. Recomendación: **sí**

- **Dato**: en `estructura_temario.json`, `orden` (los ids de bloque en el orden de ORG-13) y `requisitos` (`{tema: [[tema previo, peso], …]}`, de los modelos de `mapa.yaml` con peso ≥ 3: 181 pares, que afectan a 67 temas).
- **App**: en `planificador.dart`, `ordenSugerido` recorre los bloques en el orden de `orden` (hoy coge el primero de la lista y después el que más conexiones tiene con lo ya puesto). Dentro de cada bloque usa un orden topológico con `requisitos`, con el número del tema como desempate. El reparto en semanas no cambia.
- **Por qué**: con los 90 temas, el orden actual del planificador deja el 48 % de las dependencias fuertes hacia atrás. Pone INF a partir del puesto 43 y BIE a partir del 71, después de la UE. El orden por número deja el 36 % y el propuesto, el 33 %.

### ORG-23. «Dónde se explica este modelo». Recomendación: **sí**

- **Dato**: `oposicion/organizacion/modelos.json`, generado desde `mapa.yaml`, con los 322 modelos compartidos: `{id, nombre, tema_referencia, temas: {tema: papel}}`.
- **App**: proveedor nuevo junto a `estructuraProvider`. En la ficha del tema (`agenda_tema_page.dart`) van dos listas: «Se explican aquí» (los que tienen aquí su referencia) y «Se usan aquí y se explican en…», con un toque para abrir el tema de referencia. También vale para el buscador del temario.
- **Por qué**: es la duda más repetida al estudiar («¿dónde viene IS-LM entero?»). Hay 288 modelos que cruzan de bloque. Antes hay que arreglar los 10 modelos con dos temas de «desarrollo» (ORG-18).

### ORG-24. «Conviene ver antes». Recomendación: **sí**

- **Dato**: los mismos `requisitos` de ORG-22.
- **App**: en `agenda_tema_page.dart`, una línea «Conviene ver antes: 3.A.39 · 3.A.5» con los requisitos que aún no ha estudiado (`ajustes.temasEstudiados`). En `hoy_te_toca.dart` y en `sugeridos`, no se propone un tema con requisitos fuertes sin estudiar, o se baja en la lista.
- **Por qué**: evita, por ejemplo, empezar 3.A.38 sin 3.A.39 (18 remisiones de 3.A.38 a 3.A.39) o la macro sin Pensamiento (HPE→CIC: 91).

### ORG-25. Idea clave en los 90 temas. Recomendación: **opcional**

- **Dato**: hoy `ideas` tiene 39 temas. Se puede añadir `oposicion/organizacion/ideas-2024.json`, con los textos de ORG-15 y ORG-17 que Víctor apruebe, y que `extraer-estructura-temario.py` lo mezcle (el fichero manda sobre el PowerPoint).
- **App**: sin cambios. `bloque_page.dart`, `esquema_vista.dart` y `agenda_tema_page.dart` ya muestran `ideas[t]` cuando existe.
- **Por qué**: 51 temas no tienen idea clave, y algunas de las que hay están desfasadas (3.B.8, 3.A.4, 3.A.39).

### ORG-26. Ver las relaciones del temario revisado en el esquema. Recomendación: **opcional**

- **App**: en `esquema_vista.dart`, al tocar un tema, dibujar en trazo fino punteado sus 4-6 relaciones de `conexiones` que no están en el esquema, con un interruptor «Relaciones del temario revisado».
- **Por qué**: deja el esquema del PowerPoint intacto (es el de Víctor) y enseña lo que falta sin recargarlo.

### ORG-27. «Se apoya en / sirve para» en cada bloque. Recomendación: **opcional**

- **Dato**: matriz de dependencias entre bloques (la de ORG-13) en `estructura_temario.json` (`dependenciasBloques`).
- **App**: en `bloque_page.dart`, dos filas de bloques: «Se apoya en» (p. ej. CIC: HPE 91, DAOA 31) y «Sirve para». Hoy `conexionesDeBloque` solo cuenta las líneas dibujadas.
- **Por qué**: ayuda a decidir qué bloque toca después sin abrir el esquema.

## Cuadro de decisiones

| Id | Qué | Recomendación |
|---|---|---|
| ORG-01 | Una conexión para cada uno de los 28 temas sin ninguna (32 líneas) | Sí |
| ORG-02 | 12 conexiones muy fuertes entre bloques | Sí (las 8 primeras); opcional el resto |
| ORG-03 | Quitar 3.A.38–3.B.24 y 3.A.10–3.A.15; cambiar 3.A.13–3.B.1 por 3.A.13–3.B.3 | Sí |
| ORG-04 | Revisar 3.A.28–3.A.29 y 3.A.16–3.A.25 | Opcional |
| ORG-05 | Líneas tema→bloque: 3.A.7, 3.A.5 y 3.A.4 → CIC | Sí |
| ORG-06 | Conexiones internas de 20 o más en las diapositivas de bloque | Opcional |
| ORG-07 | 3.A.10 a Modelo neoclásico básico | Sí |
| ORG-08 | 3.B.13 a Economía abierta | Sí |
| ORG-09 | Repartir Organismos internacionales | Opcional |
| ORG-10 | 3.A.29 a DAOA | Opcional |
| ORG-11 | Otros movimientos (3.B.11 → EAB opcional) | No |
| ORG-12 | No partir CF, EAB, UE ni HPE | Sí (mantener) |
| ORG-13 | Orden de bloques: NEO, INF, BIE, HPE, CN, DAOA, CRE, CIC, CF, COM, EAB, HE, OI, UE | Sí |
| ORG-14 | 3.A.39 antes que 3.A.38; 3.A.1 al final de HPE | Sí / opcional |
| ORG-15 | 22 ideas clave y rótulos desfasados | Sí |
| ORG-16 | 11 títulos de diapositiva de tema | Sí |
| ORG-17 | 3.A.20 y 3.B.31 en la diapositiva de Bienestar | Sí |
| ORG-18 | Modelos de referencia en cada bloque y arreglos en `mapa.yaml` | Sí |
| ORG-19 | Conexiones 3.º–4.º del esquema combinado | Opcional |
| ORG-20 | App: `conexiones` con las relaciones fuertes | Sí |
| ORG-21 | App: peso por remisiones | Sí |
| ORG-22 | App: cronograma por dependencias | Sí |
| ORG-23 | App: dónde se explica cada modelo | Sí |
| ORG-24 | App: conviene ver antes | Sí |
| ORG-25 | App: idea clave en los 90 temas | Opcional |
| ORG-26 | App: relaciones revisadas en el esquema | Opcional |
| ORG-27 | App: «se apoya en / sirve para» por bloque | Opcional |
