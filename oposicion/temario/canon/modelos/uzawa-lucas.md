# Crecimiento con capital humano (Uzawa 1965; Lucas 1988)

- **Área:** macro cerrada · **Tema de referencia:** **3.A.44** (crecimiento endógeno: capital humano) — lo tiene en el título y lo desarrolla con a)-e) en I.2.5 (`sec:uzawa-lucas`, 3′30″ en el cante) y paso a paso en el anexo B (`anexo:uzawa-lucas`); revisado el 1/11/2026.
- **Temas que lo usan:** 3.A.44 (desarrollo; hecho, 1/11/2026), 3.B.9 (mención: la externalidad de Lucas y la apertura; su «modelo de Lucas» es en realidad `arrow-romer-spillovers`), 4.A.29 (mención), 4.A.2 (previsto), 3.A.25 (mención; hecho, 31/10/2026: la acumulación de Ben-Porath del anexo E es la ecuación del sector educativo, y el rendimiento social del capital humano en III.3 e) y la conclusión), 3.A.43 (mención; hecho, 31/10/2026: las críticas a MRW llevan a Uzawa-Lucas, `\vertema{3.A.44}`; el modelo de 2 sectores de Uzawa, 1961 y 1963, es otro, en II.2)
- **Manuales de referencia:** Uzawa (1965), *IER*; Lucas (1988), *JME*; Barro y Sala-i-Martin (2004), cap. 5; Sala-i-Martín (2000), cap. 5; Acemoglu (2009), cap. 10.
- **Decisión D131 (13/10/2026):** ¿Cómo se distinguen en Uzawa-Lucas la externalidad del capital humano y la participación del capital en Ḣ? η para la externalidad y α_H para la participación del capital físico en la producción de capital humano
- **Decisión D020 (13/10/2026):** λ con subíndice si hay varios multiplicadores: aquí $\lambda_{K,t}$ y $\lambda_{H,t}$.

## Presentación de referencia (3.A.44, I.2.5 y anexo B)

**a) Idea.** Pregunta: ¿puede la acumulación de capital humano sostener el crecimiento? El $AK$ trata el capital humano como físico y MRW lo acumula igual, con rendimientos decrecientes (solo niveles, `\vertema{3.A.43}`); pero el capital humano se forma dedicando **tiempo** (que es capital humano) a aprender (`\vertema{3.A.25}`). Uzawa (1965): un sector que produce conocimiento con trabajo; Lucas (1988): lo reinterpreta como capital humano y añade la externalidad del capital humano medio. Clave: si la educación no tiene rendimientos decrecientes en $h$, el sector educativo es un $AK$ en $h$ que arrastra a la economía.

**b) i) Supuestos.** 2 sectores: bienes (capital físico y la fracción $u$ del capital humano) y **sector educativo** (la fracción $1-u$, solo capital humano; versión general $\dot H=B\,(K^H)^{\alpha_H}(H^H)^{1-\alpha_H}$ en nota, con $\alpha_H<\alpha$; Lucas: $\alpha_H=0$). Por trabajador (con $k\equiv K/L$, $h\equiv H/L$, sin progreso técnico exógeno):
$$\dot k_t=A\,k_t^{\alpha}(u_th_t)^{1-\alpha}h_{a,t}^{\eta}-c_t-(\delta_K+n)\,k_t\qquad(\texttt{eq:ul-k})$$
$$\dot h_t=B\,(1-u_t)\,h_t-(\delta_H+n)\,h_t\qquad(\texttt{eq:ul-h})$$
$A,B>0$ productividades; $\delta_K$, $\delta_H$ depreciaciones (la del capital humano, el olvido); $h_a$ capital humano medio; **η ≥ 0 externalidad de Lucas**. El capital humano es **rival** ($H=H^Y+H^H$). Hogares de Ramsey con CRRA con el −1, $u(c)=(c^{1-\theta}-1)/(1-\theta)$, descuento ρ y población a n; eligen $c_t$ y $u_t\in[0,1]$; el ahorro deja de ser exógeno ($K$ se acumula con $Y-C$).

**b) ii) Desarrollo.** Sin externalidad, el planificador coincide con el equilibrio. **Hamiltoniano en valor corriente** con un coestado por capital, **$\lambda_{K,t}$ y $\lambda_{H,t}$** (no λ y μ: μ es el margen):
$$\mathcal H_t=\frac{c_t^{1-\theta}-1}{1-\theta}+\lambda_{K,t}\left[A\,k_t^{\alpha}(u_th_t)^{1-\alpha}-c_t-(\delta_K+n)k_t\right]+\lambda_{H,t}\left[B(1-u_t)h_t-(\delta_H+n)h_t\right]$$
con descuento efectivo ρ − n. CPO: $c_t^{-\theta}=\lambda_{K,t}$; $\lambda_{K,t}(1-\alpha)y_t/u_t=\lambda_{H,t}Bh_t$ (una hora en la fábrica vale lo mismo que en el aula); $\dot\lambda_{K,t}/\lambda_{K,t}=\rho+\delta_K-\alpha y_t/k_t$, $\dot\lambda_{H,t}/\lambda_{H,t}=\rho+\delta_H-B$; 2 transversalidades. En el cuerpo, una caja gris con las condiciones genéricas en valor corriente (estado $x_t$, control $z_t$, locales de la caja porque $u$ es la fracción del modelo; A44-02) y `\vertema{3.A.34}`; no se copia el anexo común.

Senda equilibrada ($u$ constante; $c$, $k$, $h$, $y$ a la misma tasa):
$$\gamma=\gamma_c=\gamma_k=\gamma_h=\gamma_y=\frac{B-\delta_H-\rho}{\theta}\qquad(\texttt{eq:ul-gamma})$$
Es la Euler `eq:euler-endogeno`, $\gamma_c=(r-\rho)/\theta$, con **$r=B-\delta_H$** (pizarra: «U-L: $r=B-\delta_H$»); en la senda, $\alpha y/k-\delta_K=B-\delta_H$. $u^*=1-(\gamma+n+\delta_H)/B$, entre 0 y 1 si $B>\delta_H+\rho$ y ρ − n > (1 − θ)γ.

**Dinámica de transición** en $k/h$ (no en el nivel de la renta; Barro y Sala-i-Martin, 2004, cap. 5): **si una guerra destruye capital físico**, $k/h$ queda por debajo de su valor de equilibrio, el capital físico es escaso y rinde mucho, y la economía crece un tiempo **más deprisa** que γ (Alemania y Japón tras la Segunda Guerra Mundial: perdieron máquinas, no conocimientos); **si una epidemia o una fuga de cerebros destruyen capital humano**, $k/h$ queda por encima y la recuperación es **más lenta** (hay que sacar tiempo de la producción). Es decir: se corrige antes el desequilibrio cuando **sobra capital humano** (falta el físico), no cuando sobra el físico.

**Con la externalidad** (η > 0; sin depreciación ni n, Lucas, 1988):
$$\gamma_h^{\mathrm E}=\frac{(1-\alpha)(B-\rho)}{\theta(1-\alpha+\eta)-\eta}\quad<\quad\gamma_h^{\mathrm P}=\frac{1}{\theta}\left[B-\frac{1-\alpha}{1-\alpha+\eta}\,\rho\right],\qquad \gamma_y=\frac{1-\alpha+\eta}{1-\alpha}\,\gamma_h.$$

**b) iii) Implicaciones.** Crecimiento endógeno si $B>\delta_H+\rho$; sube con $B$ y la paciencia, baja con θ y $\delta_H$; **no depende de $A$** ni de la propensión a ahorrar en capital físico; sin convergencia en niveles (la composición de la dotación inicial importa); política: eficiencia del sistema educativo, subvenciones con la externalidad, crédito para estudiar (`\vertema{3.A.25}`).

**c) Extensiones.** Capital humano en tasa (Lucas) o en nivel (Nelson y Phelps, 1966: adopción de tecnologías); MRW, rendimientos decrecientes y solo niveles (`\vertema{3.A.43}`); la ecuación del sector educativo es la de Ben-Porath (`\vertema{3.A.25}`, con $a$ en lugar de $B$); economía abierta (`\vertema{3.B.9}`).

**d) Evidencia.** Benhabib y Spiegel (1994): cuenta el nivel, no el aumento; Hanushek y Woessmann (2008): competencias cognitivas, no años; externalidades pequeñas o moderadas (Acemoglu y Angrist, 2000, ninguna significativa en la secundaria; Moretti, 2004, sí para universitarios).

**e) Valoración.** A favor: papel propio del capital humano, transición contrastable, justificación de la política educativa. En contra: linealidad de $\dot h$ en $h$ (otro filo de la navaja); el capital humano de cada persona está limitado por su vida (Acemoglu, 2009); lo que se acumula es rival → nexo con las ideas (II del 3.A.44).

**Gráfico de referencia:** no tiene; en la pizarra, las 2 ecuaciones de acumulación bajo la Euler.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.44 | Crecimiento con capital humano | desarrollo (hecho, 1/11/2026) | Lo de arriba: 2 sectores, 𝓗 en valor corriente, γ, $u^*$, transición en $k/h$, externalidad con las 2 tasas, MRW frente a Lucas | — |
| 3.B.9 | Comercio y crecimiento | mención | La externalidad de Lucas y la movilidad del capital humano; su «modelo de Lucas» con $Y=AK^{\alpha}L^{1-\alpha}E^{\eta}$ es el de externalidades del capital físico (ficha `arrow-romer-spillovers`) | La versión de dos sectores `\vertema{3.A.44}` |
| 3.A.25 | Capital humano y función de ingresos | mención (hecho, 31/10/2026) | Anexo E: $\dot h(t)=a[1-u(t)]h(t)$ (Ben-Porath), «la misma ecuación que el sector educativo de Uzawa-Lucas», con $u$ la fracción del tiempo en producción como aquí y **$a$ local** en lugar de $B$ (en el 3.A.25, $B$ es el beneficio de la empresa) y sin depreciación ni $n$ (con depreciación, δ local); III.3 e): el rendimiento social puede superar al privado de Mincer | El modelo de crecimiento |
| 4.A.29, 4.A.2 | Política macro y crecimiento en España | mención / previsto | Relevancia del crecimiento a largo plazo; capital humano y productividad | — |
| 3.A.43 | MRW | mención (hecho, 31/10/2026) | Salida a las críticas de MRW: el capital humano genera crecimiento endógeno | El modelo `\vertema{3.A.44}` |

## Divergencias encontradas en el temario actual
- 3.A.44 (Word): η con 2 significados, δ^K y δ^H, δ sin subíndice en γ, $\mathcal H^0$ con λ y μ, «no hay fallos de mercado» sin la salvedad de la externalidad, nota 25 al revés y «no predice convergencia» sin la transición en $k/h$. **Resuelto** (1/11/2026).
- **Esta ficha** decía hasta el 1/11/2026 que «los desequilibrios entre k y h se corrigen más rápido si sobra capital físico (reconstrucción tras guerras)»: era al revés (tras una guerra **falta** capital físico y sobra el humano, y la recuperación es rápida). Corregido.
- 3.B.9 llama «Lucas» a una variante con externalidad de la apertura (β) que no es el modelo de 1988 (es Arrow-Romer, `arrow-romer-spillovers`); β ahí choca con el factor de descuento: decirlo. Su Word usa también en la relevancia la cita de Lucas (1988, p. 5) que ya usa el 3.A.43: no repetirla.

Autor: Víctor Gutiérrez Marcos
