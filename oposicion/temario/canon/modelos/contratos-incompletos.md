# Contratos incompletos y derechos de propiedad (Grossman y Hart, 1986; Hart y Moore, 1990; Hart, 1995)

- **Área:** mercados-información-juegos (teoría de la empresa) · **Tema de referencia:** **3.A.15** (La empresa: el tamaño eficiente y sus límites…; revisado el 20/10/2026, II.3 `sec:contratos-incompletos`, con el anexo `anexo:ghm`) — único tema que lo desarrolla con un modelo (a)-e)). Ficha creada a raíz de esa revisión (C4 de coherencia).
- **Temas que lo usan:** 3.A.15 (desarrollo; hecho, 20/10/2026), 3.A.13 (mención; hecho, 19/10/2026: la valoración del principal-agente remite al 3.A.15 los contratos incompletos, l. 792), 3.A.17 (mención; hecho, 17/10/2026: «los costes de transacción de los contratos incompletos», anexo A.2), 4.B.15 (mención para la privatización: Hart, Shleifer y Vishny, 1997), 3.B.3 (mención posible: deuda y acciones como reparto de los derechos de control; Aghion y Bolton, 1992; Hart y Moore, 1994), 3.B.4 (mención: hoy atribuye la teoría a Williamson).
- **Manuales de referencia:** Grossman y Hart (1986), *JPE* 94(4); Hart y Moore (1990), *JPE*; Hart (1995), *Firms, Contracts, and Financial Structure*, caps. 2-4; Hart, Shleifer y Vishny (1997), *QJE*; Baker y Hubbard (2003); Hart (2017), *AER* (conferencia Nobel); Nash (1950) para el reparto.

## Presentación de referencia (3.A.15, II.3)

Pregunta: ¿qué cambia al integrar, si el proveedor que pasa a ser una división puede seguir siendo oportunista? Conclusión: cambia **quién es dueño de los activos**, y la propiedad decide quién manda en lo que el contrato no prevé; integrar da incentivos a uno y se los quita a otro, y eso es un límite al tamaño.

- **a) Idea**: la empresa como conjunto de activos de propiedad común; la propiedad es poder porque los contratos son incompletos.
- **b) Modelo. i) Supuestos**: variables observables pero **no verificables** por un juez; **derechos específicos** (los del contrato) y **derechos residuales de control** sobre los **activos** (Hart, 1995; la propiedad es su titularidad; no hay propiedad sobre las personas); un comprador hace una **inversión específica** $e$, con coste $e$, no contractible; si comercian, valor $y(e)$, $y'>0$, $y''<0$; si no, el comprador obtiene su opción exterior $y_0(e)$, $0\le y_0'<y'$, y el vendedor 0; renegociación *ex post* con reparto de Nash simétrico, $\gamma=\tfrac12$ (ficha `nash-negociacion`, 3.A.14). **ii) Desarrollo**: el comprador maximiza $\tfrac12y(e)+\tfrac12y_0(e)-e$ e invierte hasta
$$\tfrac12\,y'(e^{*})+\tfrac12\,y_0'(e^{*})=1,\qquad\text{frente a}\qquad y'(e^{o})=1\ \Rightarrow\ e^{*}<e^{o}:$$
  **infrainversión** (el *hold-up* formalizado); la propiedad mueve la opción exterior: integrar sube $y_0'$ del comprador y baja la del vendedor. **iii) Implicaciones**: la propiedad va a quien más aporta su inversión; activos muy complementarios, mismo dueño; independientes, dueños distintos; la parte imprescindible, propietaria; la empresa **no** crece hasta tener todos los derechos residuales: integración hacia atrás, hacia delante o ninguna, según quién invierte.
- **c) Extensiones**: propiedad pública o privada (prisiones; Hart, Shleifer y Vishny, 1997; 4.B.15 para ampliar); finanzas (deuda y acciones como reparto de los derechos de control, 3.B.3).
- **d) Evidencia**: ordenadores a bordo y propiedad de los camiones (Baker y Hubbard, 2003).
- **e) Valoración**: Nobel de Hart (2016, con Holmström); supone renegociación *ex post* eficiente (Hart, 2017) y se centra en activos físicos, cuando a menudo el activo clave es el capital humano.

**Gráfico de referencia:** ninguno en TikZ; en la pizarra, el esquema a mano de la secuencia (propiedad → inversión $e$ → negociación ½ → comercio) y la condición ½y′ + ½y₀′ = 1 frente a y′ = 1.

**Notación** (`notacion.md` § 4): $e$ (como el esfuerzo del 3.A.13), $y(e)$, $y_0(e)$ (opción exterior; $y_0^{\mathrm I}$ con integración, en el anexo), $e^*$, $e^o$ (eficiente, superíndice o en cursiva), γ = ½ (canon). La propuesta de coherencia era $e_1$, $e_2$, $V(e_1,e_2)$; el tema usa la versión con un solo inversor de Hart (1995, cap. 2), más sencilla de cantar.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.15 | Límites de la empresa | desarrollo (hecho, 20/10/2026) | Todo lo anterior | La solución de Nash (3.A.14) |
| 3.A.13 | Principal-agente | mención (hecho, 19/10/2026) | Valoración: los contratos reales son incompletos; remite al 3.A.15 | El modelo |
| 3.A.17 | Política de competencia | mención (hecho, 17/10/2026) | Las concentraciones pueden reducir los costes de los contratos incompletos | — |
| 4.B.15 | Empresa pública y privatización | mención | Hart, Shleifer y Vishny (1997): mantener la propiedad pública si el ahorro de costes deteriora la calidad no contratable; remitir al 3.A.15 | El modelo de infrainversión |
| 3.B.3 | Estructura financiera | mención (posible) | Deuda y acciones como reparto de los derechos de control (Aghion y Bolton, 1992; Hart y Moore, 1994) | — |
| 3.B.4 | Fusiones e integración | mención | Integrar cambia la propiedad y los incentivos; remitir al 3.A.15 | — |

## Divergencias encontradas en el temario actual
- 3.A.15 original: Grossman y Hart «1985» (es 1986); derechos específicos «con información completa (material de oficina)» y residuales «(trabajo cualificado)»; «la empresa crecerá hasta hacerse con todos los derechos residuales»; Holmström (1979) en el bloque de derechos de propiedad como *benchmark* sin información asimétrica. **Resuelto** (20/10/2026).
- 3.B.4 (sin revisar): «Enfoque de los contratos incompletos de Williamson» (la teoría es de Grossman, Hart y Moore; Williamson es la economía de los costes de transacción, ficha `costes-transaccion`).

Autor: Víctor Gutiérrez Marcos
