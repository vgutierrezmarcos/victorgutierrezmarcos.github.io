# Notación del área sector público (4.B)

Paso 2 del canon (13 oct. 2026). Fuentes: `_inventario/4B*.json`, `resumen-por-area.md`
(sección sector-publico, comprobada a mano: la detección automática mezcla «tipo» con
«tipo de interés» y «B» con «beneficio»), y la fuente revisada de 3.A.8 (que manda en lo
que comparte con el consumidor). Manuales base del área: Stiglitz y Rosengard, *Economics
of the Public Sector* (4.ª ed., 2015); Rosen y Gayer, *Public Finance*; Atkinson y Stiglitz,
*Lectures on Public Economics* (1980, 2.ª ed. 2015); Gruber, *Public Finance and Public
Policy*; Albi, Paredes y Rodríguez Ojeda, *Economía pública* I y II; Albi et al., *Sistema
fiscal español* (Ariel, anual); Mueller, *Public Choice III* (2003); Persson y Tabellini,
*Political Economics* (2000). Para el saldo estructural, la metodología de la Comisión
Europea (Mourre et al., 2013 y 2019).

Autor: Víctor Gutiérrez Marcos

## 1. Imposición: micro (4.B.7–4.B.13)

| Símbolo | Significado | Alternativas en el temario actual (temas) | **Propuesta** | Motivo |
|---|---|---|---|---|
| $t$ | tipo impositivo (unitario en € por unidad o *ad valorem* en tanto por uno; se dice cuál) | $\tau$ (4.B.1, 4.B.5, 4.B.6, 4.B.7, 4.B.8, 4.B.10); $t$ (4.B.4, 4.B.8, 4.B.9, 4.B.10, 4.B.11, 4.B.13); $\theta$ (4.B.11); $t_X$, $t_{KX}$ (4.B.8); $\tau_{X_i}$, $z_m$ (4.B.9) | **$t$**; con subíndice el objeto gravado: $t_i$ (bien $i$), $t_L$, $t_K$, $t_{KX}$ (capital en el sector $X$), $t_c$ (consumo), $t_w$ (salarios), $t_r$ (rendimientos del ahorro) **[decidir]** | Es la letra de Stiglitz, Rosen, Atkinson-Stiglitz y de 3.A.16 (impuesto unitario $t$). $\tau$ queda para los modelos macro dinámicos (ver §4), donde ya lo usan 3.A.38/3.A.39. Alternativa razonable: $\tau$ en todo el temario (Auerbach-Hines, Salanié). |
| $T$, $T(Y)$ | recaudación / cuota; función impositiva | $T$ (todos); $\mathrm{T}$ griega en 3.A.39 | **$T$** (latina siempre) | — |
| $Y$ | renta (base) del contribuyente en progresividad: $T(Y)$ | $Y$ (4.B.3, 4.B.4, 4.B.7); $BI$ (4.B.3, 4.B.12); $y$ (4.B.3) | **$Y$** para la renta antes de impuestos; **$BI$** para la base imponible cuando se distinga de la renta | Notación de Lambert y de todos los manuales de progresividad. Choque con $\overline{W}$ (renta del consumidor en 3.A.8): ver §6. |
| $t_{me}=T/Y$, $t_{mg}=T'(Y)$ | tipo medio y marginal | $t_{me}$, $t_{mg}$ (4.B.3, 4.B.4, 4.B.12); $t$ (4.B.7) | **$t_{me}$, $t_{mg}$** | Ya mayoritario. |
| $\varepsilon_{T,BI}$, $\varepsilon_{BI,Y}$, $\varepsilon_{T,Y}$ | elasticidades recaudación-base, base-renta y recaudación-renta | igual en 4.B.3, 4.B.4, 4.B.7, 4.B.12 | **igual** | Sin conflicto. |
| $p$ | precio del bien (del productor si hay impuesto) | $P$ (4.B.9, 4.B.11, 4.B.13); $P_i$ (4.B.15); $p$ (3.A.8, 3.A.16) | **$p$** (minúscula, como 3.A.8 y 3.A.16) | Evita el choque con $P$ = nivel de precios (macro) y con $P$ = gasto total (4.B.1). |
| $p_c$, $p_v$ | precio que paga el consumidor y que recibe el vendedor; $p_c=p_v+t$ (unitario) o $p_c=(1+t)p_v$ (*ad valorem*) | $P_C$, $P_V$ (4.B.8); $\hat p_m$, $\hat p_i$ (3.A.16); $q=p+t$ (Diamond-Mirrlees) | **$p_c$, $p_v$** en incidencia y exceso de gravamen; en 4.B.11 se admite $q_i=p_i+t_i$ diciendo que $q$ es el precio al consumidor **[decidir]** | Legible y coherente con $p$. |
| $x(p)$, $q(p)$ | demanda y oferta de mercado | $X$, $Y$, $Q$, $h$ (4.B.8, 4.B.9, 4.B.11) | **$x$ demanda marshalliana, $h$ demanda hicksiana (compensada), $q$ oferta** | Como 3.A.8 ($x$, $h$) y 3.A.16 ($q$). |
| $\varepsilon_D$, $\varepsilon_S$ | elasticidades precio de la demanda y de la oferta, **con su signo** ($\varepsilon_D<0$); en las fórmulas se escribe $\lvert\varepsilon_D\rvert$ | $\varepsilon$ con signo (4.B.9); $\varepsilon$ positiva (4.B.11); $\eta_s$, $\eta_d$ (4.B.7) | **$\varepsilon_D$ con signo y $\lvert\varepsilon_D\rvert$ en las fórmulas**; $\varepsilon^h$ si es compensada **[decidir]** | 3.A.8 ya define las elasticidades con su signo; así desaparece el error de signo de $EG$ en 4.B.11. |
| $EG$ | exceso de gravamen (siempre $\ge 0$) | $EG$ (todos); «carga excesiva», «pérdida irrecuperable» | **$EG$**, «exceso de gravamen» (sinónimos: carga excesiva, pérdida de eficiencia) | — |
| $EGMg_i$, $RMg_i$, $\lambda$ | exceso de gravamen y recaudación marginales; multiplicador de la restricción de recaudación | igual (4.B.11) | **igual** | — |
| $S_{ij}=\partial h_i/\partial p_j$ | efecto sustitución (término de Slutsky) | $S_{ij}$, $\partial Q^i/\partial P^j$ (4.B.7, 4.B.9, 4.B.11) | **$S_{ij}$**, definido sobre la demanda compensada | Como 3.A.9 (Slutsky). |
| $O$, $\bar O$ | ocio y dotación de tiempo | $O$, $O_0$ (4.B.9, 4.B.10, 4.B.11); $L$ (4.B.10) | **$O$ y $\bar O$**; $L=\bar O-O$ trabajo | Tradición del temario (4.B.9/4.B.10). Comprobar con la ficha de oferta de trabajo (3.A.25). |
| $w$, $r$ | precios del trabajo y del capital | $W$, $R$ (4.B.8, 4.B.9); $w_L$, $w_K$ (4.B.9, 4.B.11) | **$w$, $r$** | Como 3.A.11 y 3.A.21 (comprobar con la ficha de producción). |
| $\overline{W}$ | renta exógena del consumidor | $M$ (4.B.10); $\overline{W}=w\bar O+M$ (4.B.11) | **$\overline{W}$** (renta no laboral: $M$) | Canon de 3.A.8. |

## 2. Elección pública y burocracia (4.B.2, 4.B.5)

| Símbolo | Significado | Alternativas | **Propuesta** | Motivo |
|---|---|---|---|---|
| $W$ | función de bienestar social | $W$ (4.B.2, 3.A.22); $W(\cdot)$ (3.A.24); $W$ = salario (4.B.8) | **$W$** (y el salario pasa a $w$, §1) | Choque resuelto con $w$. |
| $U_i$ | utilidad del individuo $i$ | igual | **$U_i$**; ojo: en 3.A.8 $U_i$ es la utilidad marginal del bien $i$: usar $U^h$ (superíndice) para el individuo si se mezclan **[decidir]** | Choque real con 3.A.8. |
| $\succ_i$, $\succsim_i$ | preferencias individuales | $R_i$ (4.B.2); $R_i$, $\succ_i$ (3.A.24) | **$\succsim_i$**, $\succsim_G$ social | Como 3.A.8 (axiomas) y 3.A.24. |
| $CE(M)$, $CD(M)$, $M^*$ | costes externos y de decisión; mayoría óptima | igual (4.B.2) | **igual** | — |
| $G^*$, $G'$ | presupuesto eficiente y del burócrata (Niskanen) | igual (4.B.2, 4.B.5) | **igual** | — |
| $B(G)$, $C(G)$ | beneficio y coste totales del gasto | $BT$, $CT$; $BMg_S$, $CMg_S$ (4.B.1, 4.B.5) | **$B(G)$, $C(G)$; $BMg_S$, $CMg_S$** | — |

## 3. Presupuesto, saldo y deuda (4.B.1, 4.B.4, 4.B.21–4.B.26)

| Símbolo | Significado | Alternativas | **Propuesta** | Motivo |
|---|---|---|---|---|
| $G$ | gasto público | $G$, $g$, $P$ (4.B.1); $G$ (4.B.5) | **$G$**; en % del PIB, $g=G/Y$ | Se elimina $P$ (4.B.1) y $g$ como gasto per cápita. |
| $D_t$, $d_t$ | deuda pública en nivel y en % del PIB | $D_t$, $B_t$ (4.B.4); $D$, $d$ (4.B.26, 3.A.39); $B$ = bonos (4.B.4) | **$D_t$, $d_t$** | Como 3.A.39. |
| $b_t$ | saldo presupuestario en % del PIB (positivo = superávit) | $B_t$ (4.B.4); «saldo» (4.B.1) | **$b$; $b^{c}$ cíclico, $b^{ca}=b-b^{c}$ cíclicamente ajustado, $b^{e}=b^{ca}-$ medidas puntuales estructural, $b^{p}$ primario** **[decidir]** | Hoy $B$ choca con bonos y beneficio. Alternativa: siglas de la Comisión (CAB, SB, PB). |
| $OG_t$ | brecha de producción $(Y-Y^*)/Y^*$ | $OG$ (4.B.4); $x_t$ (4.B.4, NEK); $\tilde y$ (macro) | **$OG$** en 4.B; en los modelos NEK, la notación de 3.A.37 | Es la sigla de la Comisión y de la AIReF. |
| $\varepsilon$ | semielasticidad del saldo respecto a la brecha ($b^{c}=\varepsilon\,OG$) | $\eta$ (4.B.4, choca con Calvo); «elasticidad» y «semielasticidad» mezcladas | **$\varepsilon$ (semielasticidad, $\approx 0{,}6$ para España [comprobar dato vigente])** **[decidir]** | Notación de la Comisión (Mourre et al., 2013); libera $\eta$. |
| $i$, $r$, $\gamma$ | tipo de interés nominal y real; crecimiento del PIB nominal | $i$ (4.B.4, 4.B.26); $r$ (4.B.1, 4.B.26); $\gamma^Y$ (3.A.39, 4.B.26); $g$ (4.B.1, en «$r<g$») | **$i$, $r$; $\gamma$ crecimiento nominal y $\gamma_r$ real** (se dice siempre «$i-\gamma$» o «$r-\gamma_r$») | Como 3.A.39; $g$ queda para $G/Y$. |
| $s_t$ | señoreaje | $s$ (4.B.26) | **$s$** (en 4.B no hay tasa de ahorro que choque; en 4.B.3 la tasa de ahorro pasa a $\sigma$ solo si se mezclan) | — |

## 4. Política fiscal macro (4.B.4, 4.B.10, 4.B.11)

| Símbolo | Significado | Alternativas | **Propuesta** | Motivo |
|---|---|---|---|---|
| $\tau_t$ | tipo impositivo en modelos dinámicos (RBC, Barro, Chamley-Judd) | $\tau_t$ como **recaudación** en el anexo de Barro (4.B.9, 4.B.11) | **$\tau_t$ = tipo; la recaudación es $T_t$** | Hoy $\tau$ significa tres cosas en 4.B.11. |
| $\theta$ | aversión relativa al riesgo (CRRA) | $\theta$ (4.B.4, 3.A.38); $\beta$ (4.B.10); $\eta$ (3.A.8 anexo) | **la de la ficha `crra` (área consumidor)**; en 4.B, $\theta$ como 3.A.38 **[decidir con el área consumidor]** | 3.A.8 usa $\eta$: hay que unificar entre áreas. |
| $\beta$, $\rho$ | factor de descuento y tasa de preferencia temporal | $\beta$ (4.B.3, 4.B.4, 4.B.11); $\rho$ (4.B.4); $\delta$ (4.B.6) | **$\beta=1/(1+\rho)$**; $\delta$ solo depreciación | $\beta$ era también la movilidad del capital en la BP (4.B.4): ahí, la letra de la ficha Mundell-Fleming. |
| $c$, $m$, $t$, $v$, $k$, $h$ | propensión a consumir, a importar, tipo, sensibilidad de la inversión y de la demanda de dinero (IS-LM) | $v$ y $b$ (4.B.4) | **la de la ficha `is-lm` (macro cerrada)** | Ver esa ficha. |

## 5. Evaluación (4.B.6)

| Símbolo | Significado | Alternativas | **Propuesta** | Motivo |
|---|---|---|---|---|
| $r_s$ | tasa social de descuento | $\delta$ (4.B.6); $TPT$; $r$ (4.B.8) | **$r_s$** **[decidir]** | $\delta$ es depreciación en todo el temario. |
| $B_t$, $C_t$ | beneficios y costes del periodo $t$ | igual (4.B.6) | **igual** (en 4.B.6 no se usa $B$ para saldo) | — |
| $\alpha$ | proporción de inversión privada desplazada (precio sombra del capital) | $\alpha$ (4.B.6); $\alpha$ = elasticidad del capital (4.B.5, Barro) | **$\alpha$ solo para la elasticidad del capital; desplazamiento: $\phi$** **[decidir]** | Choque con la Cobb-Douglas. |

## 6. Choques con otras áreas que se mezclan

- **Renta**: $\overline{W}$ (3.A.8, canon) frente a $Y$ (base del IRPF y PIB). Propuesta: $\overline{W}$ en los modelos de consumidor (4.B.9, 4.B.10, 4.B.11); $Y$ solo en progresividad ($T(Y)$) y en macro. **[decidir]**
- **$\tau$**: tipo en macro dinámica (3.A.38, 3.A.39) y en 4.B.1/4.B.5/4.B.7; propuesta: $t$ en micro de la imposición y $\tau$ en macro dinámica (§1 y §4).
- **$P$**: nivel de precios en macro; en 4.B.9/4.B.11 precio del bien y en 4.B.1 gasto total. Propuesta: $p$ para el precio del bien y nada de $P$ para el gasto.
- **$g$**: crecimiento (macro, «$r<g$») frente a gasto. Propuesta: $\gamma$ para el crecimiento nominal en las ecuaciones de deuda (como 3.A.39) y $g=G/Y$.
- **$\eta$**: CRRA (3.A.8), rigidez de Calvo y sensibilidad del saldo (4.B.4). Propuesta: la sensibilidad del saldo pasa a $\varepsilon$.
- **$\alpha$** (4.B.6) y **$\beta$** (4.B.4, BP): ver §4 y §5.
- **$U_i$**: utilidad marginal del bien $i$ en 3.A.8 y utilidad del individuo $i$ en 4.B.2/3.A.24 (§2).
- **«Ramsey»**: en 4.B es siempre la **regla de Ramsey (1927) de imposición óptima**; el modelo de crecimiento es «Ramsey-Cass-Koopmans» y la tarificación del monopolio natural, «Ramsey-Boiteux». No usar «Ramsey» a secas. (Ojo: `_inventario/alias.json` lista «ramsey» como alias de `ramsey-cass-koopmans`; con la excepción de 3.A.6 basta, y el alias general debería quitarse.)
- **«Harberger»**: el **modelo bisectorial de Harberger (1962)** es incidencia (4.B.8); el **triángulo de Harberger (1964)** es la medida del exceso de gravamen (4.B.9). Nombrarlos siempre así.

## 7. Correspondencia de numeración (para corregir «[ver tema …]» y cabeceras)

En el temario anterior el bloque de impuestos y presupuesto tenía otra numeración. Los Word
y PDF públicos llevan aún la cabecera vieja. Correspondencia (viejo → nuevo):

| Viejo | Nuevo | Viejo | Nuevo |
|---|---|---|---|
| 4.B.1, 4.B.2 | 4.B.1, 4.B.2 | 4.B.17 | 4.B.15 |
| 4.B.3 | desaparece (presupuesto) | 4.B.18 | 4.B.18 (otro título: solo aprovecha parte) |
| 4.B.4 … 4.B.14 | 4.B.3 … 4.B.13 (n → n−1) | 4.B.19, 4.B.20, 4.B.21, 4.B.22 | 4.B.16, 4.B.17, 4.B.19, 4.B.20 (sin fuente) |
| 4.B.15 | 4.B.14 (sin fuente) | 4.B.23 | 4.B.22 (parcial) |
| 4.B.16 | desaparece (regulación de la empresa pública; su parte útil, a 3.A.17) | 4.B.24 | 4.B.21 |
| | | 4.B.25, 4.B.26 | 4.B.24, 4.B.25 (sin fuente) |
| | | 4.B.27 + 4.B.28 | 4.B.26 (fusión) |

Regla práctica para las referencias internas del bloque: «[ver tema 4.B.n]» del viejo,
con 4 ≤ n ≤ 14, pasa a 4.B.(n−1); las demás, por la tabla. `mapa.yaml` ya lo recoge
referencia a referencia.
