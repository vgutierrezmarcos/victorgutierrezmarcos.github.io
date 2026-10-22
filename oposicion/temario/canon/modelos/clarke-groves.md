# Mecanismo de Clarke-Groves

- **Área:** equilibrio general y bienestar · **Tema de referencia:** **3.A.23** (Bienestar II: bienes públicos; revisado el 21/10/2026, II.2.3 «Mecanismo de Clarke-Groves», con a)-c), la tabla `tab:clarke-groves` y el anexo `anexo:clarke-groves` con los mecanismos de Groves y el pivote de Clarke).
- **Temas que lo usan:** 3.A.23 (desarrollo; hecho, 21/10/2026), 3.A.24 (mención; hecho, 22/10/2026: salida a Gibbard-Satterthwaite con utilidad cuasilineal y pagos, III.3, con `\vertema{3.A.23}` y `\vertema{3.A.14}`), 4.B.7 (mención: principio del beneficio). Es una aplicación del diseño de mecanismos (ficha `diseno-mecanismos`). 3.A.14 (mención; hecho, 19/10/2026: los mecanismos VCG en el diseño de mecanismos, III.2; la subasta de segundo precio como su caso más sencillo; remite a 3.A.23). 3.A.22 (mención; hecho, 21/10/2026: VCG en estrategias dominantes en la tabla `tab:mecanismos` de III.3, con el presupuesto no equilibrado de Green y Laffont); 3.A.20 (mención; hecho, 22/10/2026: Loeb-Magat como mecanismo de Groves, con `\vertema{3.A.14}` `\vertema{3.A.23}`).
- **Manuales de referencia:** Vickrey (1961); Clarke (1971); Groves (1973); Groves y Ledyard (1977); Green y Laffont (1977), *Econometrica*; Mas-Colell, Whinston y Green, cap. 23.C.

## Presentación de referencia
**Pregunta:** ¿hay una regla con la que a cada uno le convenga decir la verdad sobre lo que valora un bien público? Idea: cada uno paga solo si su declaración cambia la decisión, y entonces paga el daño que su voto causa a los demás: un impuesto pigouviano sobre la externalidad que es su voto.

**Supuestos:** $I$ vecinos deciden si construyen o no un bien público indivisible de coste $C$ (la mota del río, hilo del 3.A.23); cuotas fijadas de antemano $c_i$ con $\sum_ic_i=C$, que no dependen de lo declarado; valoración privada $v_i$, valor neto $v_i-c_i$; utilidad cuasilineal.

**Regla:** cada uno declara $\tilde v_i$ (tilde = declarado); se construye si $\sum_i(\tilde v_i-c_i)\geq0$. **Impuesto de Clarke** (`eq:clarke`): el individuo **pivotal** (agente bisagra), cuya declaración cambia la decisión respecto a la que tomarían los demás solos, paga
$$H_i=\Big|\sum_{j\neq i}(\tilde v_j-c_j)\Big|\ \text{si es pivotal};\qquad H_i=0\ \text{si no lo es}.$$
**Ejemplo de referencia (3 vecinos y la mota, miles de euros; no la farola de Varian):** coste 300, cuotas 100; valoraciones 40, 150 y 170; netos −60, 50, 70 (suma 60: se construye); sin el 3 los demás suman −10: el 3 es pivotal y paga $H_3=10$; si el 1 mintiera (−200), no se construiría, pero pagaría 120 por ser pivotal, más que los 60 que se ahorra.

**Resultado:** decir la verdad, $\tilde v_i=v_i$, es estrategia (débilmente) dominante y se construye si y solo si es eficiente. Es la idea de los VCG (Vickrey-Clarke-Groves); la subasta de segundo precio es su caso más sencillo (3.A.14). Anexo: mecanismos de Groves con transferencia $\tau_i=d\sum_{j\neq i}(\tilde v_j-c_j)+h_i(\tilde v_{-i})$ ($d\in\{0,1\}$ la decisión) y el pivote de Clarke con $h_i=-\max\{S_{-i},0\}$, $S_{-i}=\sum_{j\neq i}(\tilde v_j-c_j)$, $H_i=-\tau_i$.

**Valoración:** no exige que el Estado conozca las valoraciones y la verdad es dominante; pero **el presupuesto no se equilibra** (los impuestos no pueden devolverse sin destruir los incentivos: la decisión es eficiente, la asignación no es Pareto óptima; Green y Laffont, 1977), necesita cuasilinealidad (sin ella, Gibbard-Satterthwaite), es vulnerable a coaliciones y puede parecer injusto.

**Gráfico de referencia:** ninguno; la tabla del ejemplo (`tab:clarke-groves`, con la fila del pivotal en salmón) va a la pizarra.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.23 | Revelación de preferencias | desarrollo (hecho, 21/10/2026) | Regla, `eq:clarke`, ejemplo de la mota con su tabla, propiedades y límites; Groves y Clarke en el anexo | — |
| 3.A.22 | *Second best* con información | mención (hecho, 21/10/2026) | VCG en la tabla `tab:mecanismos`: eficiente y veraz, sin presupuesto equilibrado (Green y Laffont, 1977) | El ejemplo |
| 3.A.24 | Elección colectiva | mención (hecho, 22/10/2026) | Mecanismo no manipulable frente a Gibbard-Satterthwaite (dominio restringido a cuasilineales); `\vertema{3.A.23}` | El ejemplo |
| 4.B.7 | Principio del beneficio | mención | Dificultad de revelar la disposición a pagar | — |
| 3.A.14 | Diseño de mecanismos | mención (hecho, 19/10/2026) | VCG: cada uno paga el daño que su presencia causa a los demás; decir la verdad es dominante; segundo precio como caso más sencillo; necesitan pagos monetarios (Gibbard-Satterthwaite) | El ejemplo numérico |
| 3.A.20 | Regulación sin conocer los costes | mención (hecho, 22/10/2026) | Loeb-Magat: pagar a la empresa todo el EC la hace reclamante residual, como un mecanismo de Groves | El mecanismo pivote |

## Divergencias encontradas en el temario actual
- Notación: $c_i$, $v_i$ (como las valoraciones de las subastas del 3.A.14), $\tilde v_i$ declaradas, $H_i$ impuesto de Clarke, $\tau_i$ transferencia de Groves (no $t_i$, que en el 3.A.14 son los tipos).
- 3.A.14 (revisado): dice «decir la verdad es una estrategia dominante y la decisión es eficiente» (l. 943) sin añadir que el presupuesto no se equilibra: matiz opcional en `pendientes-coherencia.md`.
- Resuelto en el 3.A.23 (21/10/2026): texto copiado sin ejemplo propio; Clarke-Groves sin terminar.
- 3.A.24: resuelto en su revisión (22/10/2026): el título «Ejemplo: Clarke y Groves» sin contenido desaparece; mención en III.3 con `\vertema{3.A.23}`.
