# Optimización dinámica: tiempo discreto (sustitución, Lagrange, Euler, condición terminal y no-Ponzi) y tiempo continuo (control óptimo: principio del máximo, hamiltoniano en valor presente y corriente, transversalidad)

- **Área:** macro cerrada (método) · **Tema de referencia:** **3.A.29** (sin revisar; «Modelización dinámica de las tomas de decisiones» está en su título). Es una **pieza común en 2 partes** que copian los temas que la usan (nota de Víctor en el Word del 3.A.29: «Coordinar este anexo en los temas 3.A.29, 3.A.34, 3.A.43, 3.A.33… si se cambia algo en uno, se cambie en todos»). **Texto de referencia de cada parte:**
  - **tiempo discreto**: el anexo B del **3.A.33**, `anexo:optimizacion` (revisado el 31/10/2026; K34/A33-21);
  - **tiempo continuo**: el anexo A del **3.A.34**, `anexo:control-optimo` (revisado el 31/10/2026; DK9/A34-17 y C35/C36; lleva una `notaopositor` que dice que es común y remite al 3.A.33 para el discreto).
  Ficha creada en la fase canon del 3.A.33 (**[decidir]**: K34 del 3.A.33 y DK9 del 3.A.34, opción (a) aplicada).
- **Temas que lo usan:** 3.A.29 (desarrollo: copia las 2 partes y añade la programación dinámica), 3.A.33 (anexo B, discreto; hecho, 31/10/2026), 3.A.34 (anexo A, continuo; hecho, 31/10/2026; el cuerpo usa 𝓗 en valor corriente en Jorgenson, con λ_t, y en la q, con q_t), 3.A.43 (anexo: copia la parte continua para Ramsey-Cass-Koopmans), 3.A.26 (mención; hecho, 31/10/2026: hamiltoniano en valor corriente del anexo D, costes de ajuste del empleo), 3.A.25 (mención; hecho: horizonte infinito y no-Ponzi en el anexo C de Lucas-Rapping, en discreto), 3.B.31 (mención; hecho: Ramsey-DICE en discreto, Euler y fórmula de Ramsey), 3.A.42 (mención: RBC).
- **Manuales de referencia:** discreto: Romer (2019), caps. 2 y 8; Ljungqvist y Sargent (2018), *Recursive Macroeconomic Theory*; Heijdra (2017); continuo: Pontriaguin *et al.* (1962); Chiang (1992), *Elements of Dynamic Optimization*; Cerdá (2001), *Optimización dinámica*; Acemoglu (2009), cap. 7; Obstfeld y Rogoff (1996).

## Parte 1. Tiempo discreto (texto de referencia: 3.A.33, `anexo:optimizacion`)

Estructura del anexo: a) el problema; b) la solución por sustitución (y con Lagrange); c) implicaciones; d) los efectos de un cambio del tipo de interés (Slutsky con dotación). Lo que debe copiarse igual:

- **Problema** (`eq:problema-t-periodos`, con `\optim`): T+1 periodos, t = 0,…,T, certidumbre, U_0 ≡ Σ_{t=0}^{T} β^t u(C_t), u′ > 0, u″ < 0, β ≡ 1/(1+ρ);
$$\max_{\{C_t\}}\ \sum_{t=0}^{T}\beta^t u(C_t)\quad\text{s.a.}\quad b_{t+1}=(1+r)\,b_t+Y_t-C_t,\ \ t=0,\dots,T;\qquad b_0\ \text{dado};\qquad b_{T+1}\ge0$$
  con la lectura de la restricción de cada periodo (consumo + activos para t+1 = renta + activos con intereses; b_{t+1} − b_t = Y_t + rb_t − C_t, el ahorro como vehículo).
- **Condición terminal** b_{T+1} ≥ 0: impide morir endeudado; en el óptimo, b_{T+1} = 0 (no interesa morir con activos).
- **Restricción intertemporal** (`eq:restriccion-intertemporal`), sustituyendo hacia delante:
$$\sum_{t=0}^{T}\frac{C_t}{(1+r)^t}=(1+r)\,b_0+\sum_{t=0}^{T}\frac{Y_t}{(1+r)^t};$$
  nota: con certidumbre siempre se resume así; con incertidumbre hacen falta mercados completos; con activos redundantes la restricción se cumple y lo indeterminado es la cartera.
- **Solución por sustitución**: C_t = (1+r)b_t + Y_t − b_{t+1} en el objetivo; CPO en b_{t+1}: −β^t u′(C_t) + β^{t+1}(1+r)u′(C_{t+1}) = 0 ⇒ **u′(C_t) = β(1+r)u′(C_{t+1})** (la `eq:euler` de la ficha `fisher-intertemporal`). **Con Lagrange** sobre la intertemporal, multiplicador λ: β^t u′(C_t) = λ/(1+r)^t. Con incertidumbre o problemas más complejos, programación dinámica (Bellman) en el 3.A.29.
- **Caso de referencia** β(1+r) = 1: consumo constante, C = [(1+r)b_0 + Σ Y_t/(1+r)^t]/Σ(1+r)^{−t}; con r = ρ = 0, C = (b_0 + ΣY_t)/(T+1).
- **Horizonte infinito**: la condición terminal pasa a **no-Ponzi**, lim_{T→∞} b_{T+1}/(1+r)^T ≥ 0, con igualdad en el óptimo (**transversalidad**). Con incertidumbre, el problema de Hall (`eq:problema-hall`, ficha `hall`) con 𝔼_0 y la restricción en cada periodo y estado.
- **Slutsky con dotación** (`eq:slutsky-dotacion`, con `\vertema{3.A.9}`): p ≡ 1/(1+r), W̄ = Y_1 + pY_2; dC_1/dp = sustitución + (Y_2 − C_2)∂C_1/∂W̄; efectos sustitución, renta y riqueza (dotación); los 2 últimos con el signo del ahorro. Es la misma ecuación que el 3.A.25 escribe con la dotación de tiempo (anexo A, `anexo:slutsky-ecuacion`).

## Parte 2. Tiempo continuo (texto de referencia: 3.A.34, `anexo:control-optimo`, revisado el 31/10/2026)

Estructura del anexo (párrafos con `\paragraph`): Idea; El problema; El principio del máximo; Horizonte infinito; El hamiltoniano en valor corriente; `tab:hamiltonianos`; caja `anotaciones` «Para profundizar». Lo que debe copiarse igual:

- **Nota al opositor** al principio: anexo común a los temas que resuelven problemas en tiempo continuo (3.A.29, 3.A.43, 3.A.26); la versión discreta, en el 3.A.33.
- **Idea**: optimización estática frente a dinámica (trayectoria óptima completa); 3 métodos (cálculo de variaciones, control óptimo, programación dinámica); se usa el **control óptimo** porque es el de los modelos en tiempo continuo del temario (q, RCK, costes de ajuste del empleo), trata las restricciones sobre los controles y el multiplicador es el **precio sombra del stock**.
- **Problema tipo** (con `\optim`):
$$\max_{\{u_t\in U\}}\int_0^TF(t,y_t,u_t)\,dt\quad\text{s.a.}\quad\dot y_t=f(t,y_t,u_t),\ \ y_0=A\ \text{dado},\ \ y_T=Z\ (\text{o } y_T\ \text{libre})$$
  con tiempo $t$, **estado $y_t$** (el capital) y **control $u_t$** (la inversión); la ecuación de estado hace que baste buscar la senda del control.
- **Principio del máximo**: anunciado en 1956 por Boltianski, Gamkrelidze y Pontriaguin y publicado completo por **Pontryagin *et al.* (1962)** (nunca «Pontryagin, 1956»). **Hamiltoniano en valor presente** $\mathcal H^0\equiv F(t,y_t,u_t)+\lambda^0_tf(t,y_t,u_t)$, con **λ⁰_t** variable de coestado (multiplicador de Lagrange dinámico: valor en 0 de una unidad más del estado en $t$). 4 condiciones necesarias: (1) el control maximiza 𝓗⁰ ($\partial\mathcal H^0/\partial u=0$ si es interior); (2) $\dot y_t=\partial\mathcal H^0/\partial\lambda^0$; (3) $\dot\lambda^0_t=-\partial\mathcal H^0/\partial y$; (4) en el momento final: si $y_T=Z$, **condición terminal** (no es transversalidad); si $y_T$ libre, **transversalidad** $\lambda^0_T=0$ (con $y_T\ge0$: $\lambda^0_T\ge0$, $\lambda^0_Ty_T=0$). Nota: una ecuación de coestado por estado y una CPO por control.
- **Suficiencia**: **Mangasarian** (𝓗⁰ cóncavo en estado y control a la vez) o, más general, **Arrow** (hamiltoniano maximizado $\mathcal H^{0*}$ cóncavo en el estado).
- **Horizonte infinito**: la integral debe converger (descuento) y la transversalidad es un límite, $\lim_{t\to\infty}\lambda^0_ty_t=0$ (si no, convendría consumir el stock; en la q, vender capital); si el estado converge a un valor dado, no hace falta más.
- **Valor corriente** (el del cuerpo de los temas): con $F=e^{-\rho t}G(y_t,u_t)$,
$$\mathcal H_t\equiv e^{\rho t}\mathcal H^0_t=G(y_t,u_t)+\lambda_tf(t,y_t,u_t),\qquad\lambda_t\equiv e^{\rho t}\lambda^0_t;$$
  condiciones: $\partial\mathcal H/\partial u=0$; $\dot y_t=f$; **$\dot\lambda_t=\rho\lambda_t-\partial\mathcal H/\partial y$**; transversalidad **$\lim_{t\to\infty}e^{-\rho t}\lambda_ty_t=0$** (nota: $\lim e^{-\rho t}\mathcal H_t=0$ es la condición de un momento final libre y aquí no hace falta; error del original corregido).
- **Aplicaciones en el 3.A.34**: en Jorgenson $\rho=r$, $y=K$, $u=(L,I)$ y λ_t el precio sombra del capital ($\lambda_t=P^K_t$); en la q, el coestado en valor corriente es la propia **q_t**. En el 3.A.26, λ_t es el valor sombra de un trabajador.
- **`tab:hamiltonianos`** (sustituye a las 2 líneas de tiempo del original, A34-08): filas Construcción, Significado del coestado (descontado a 0 / medido en t), Control, Coestado, Transversalidad; columnas 𝓗⁰ y 𝓗.
- **Para profundizar** (`anotaciones`): Cerdá (2001); Acemoglu (2009); Heijdra (2009); Obstfeld y Rogoff (1996); Perman *et al.* (2011, 4.ª ed., apéndice 14.1); crecimiento óptimo `\vertema{3.A.43}`.

## Notación
- Discreto: C_t, b_t, Y_t, r, ρ, β (§ 7); λ multiplicador (§ 0, D020); U_0 la intertemporal (V es la indirecta).
- Continuo: **𝓗** caligráfica en valor corriente y **𝓗⁰** en valor presente (DK8/A34-16 del 3.A.34, **[decidir]**; H es el capital humano; el 3.A.26 escribe H en su anexo D: cambio cosmético pendiente de la decisión, `pendientes-coherencia.md`), **λ_t** coestado en valor corriente (q_t en la q de Tobin), **λ⁰_t** en valor presente, ρ la tasa de descuento genérica (r en los modelos de empresa). **Letras genéricas del anexo** (fijadas por el 3.A.34; **[decidir]**: se mantienen las de Chiang y Cerdá): $y_t$ estado, $u_t$ control, $U$ conjunto de controles admisibles, $F(t,y,u)$ integrando y $G(y,u)$ su parte sin descuento, $f(t,y,u)$ ecuación de estado, $A$ y $Z$ valores inicial y final. Son **locales del anexo**: en el cuerpo, $y$ es la producción por trabajador eficiente, $u$ la utilidad o la fracción de Uzawa-Lucas, $F$ la producción y $A$ la productividad, así que en los cuerpos se escribe siempre con las variables del modelo (K, I, L, C). Alternativa: $x_t$, $z_t$ y $\Pi$ para el integrando.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.29 | Modelización dinámica | desarrollo | Las 2 partes copiadas (discreto del 3.A.33, continuo del 3.A.34) y la programación dinámica (Bellman), que solo desarrolla él | — |
| 3.A.33 | Consumo | anexo B, discreto (hecho, 31/10/2026) | T periodos, sustitución y Lagrange, condición terminal, no-Ponzi, Slutsky con dotación | El continuo |
| 3.A.34 | Inversión | anexo A, continuo (hecho, 31/10/2026; texto de referencia) | Control óptimo con 𝓗⁰ y 𝓗, transversalidad, Mangasarian y Arrow, `tab:hamiltonianos`; remite al 3.A.33 para el discreto | El discreto |
| 3.A.43 | Crecimiento (Solow, RCK) | anexo | Copia la parte continua para Ramsey-Cass-Koopmans | — |
| 3.A.26 | Costes de ajuste del empleo | mención (hecho) | Hamiltoniano en valor corriente en el anexo D | El método |
| 3.A.25 | Oferta de trabajo intertemporal | mención (hecho) | No-Ponzi y horizonte infinito en el anexo C (discreto) | El método |
| 3.B.31 | Cambio climático | mención (hecho) | Euler en discreto y fórmula de Ramsey | El método |
| 3.A.42 | Ciclos | mención | RBC resuelto con la Euler | El método |

## Divergencias encontradas en el temario actual
- 3.A.33 original: notas 9 y 25 duplicadas (s_T, a_T); «tasa de ahorro negativa en T»; «con activos redundantes no se puede obtener la restricción intertemporal». **Resuelto** (31/10/2026).
- 3.A.29 (sin revisar): anexo de optimización propio; al revisarse copia las 2 partes.
- 3.A.34 original: «y_T = Z → transversalidad», «lim 𝓗^c e^{−ρt} = 0» como transversalidad, «Pontryagin (1956)», solo Arrow en la suficiencia y 2 líneas de tiempo como imágenes. **Resuelto** (31/10/2026).
- 3.A.33 (revisado): su anexo B no dice que es la parte discreta de una pieza común ni remite al 3.A.34 para la continua (el anexo A del 3.A.34 sí lo hace): nota opcional (`pendientes-coherencia.md`, «Pendiente del 3.A.34»).
- 3.A.26 (revisado): hamiltoniano en valor corriente con H, no 𝓗 (cosmético, si se adopta DK8).

Autor: Víctor Gutiérrez Marcos
