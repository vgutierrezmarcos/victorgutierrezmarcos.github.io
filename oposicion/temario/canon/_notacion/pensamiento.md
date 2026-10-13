# Notación del área pensamiento económico (3.A.1-3.A.7)

Paso 2 del canon (13 oct. 2026). Fuentes: `_inventario/3A01…3A07.json`, `resumen-por-area.md` (comprobado contra los Word originales). Los temas de pensamiento usan pocas ecuaciones; cuando presentan un modelo (IS-LM, Phillips, Lucas, Barro-Gordon, RBC, NEK), la notación es la de su tema de referencia, casi siempre en macro cerrada: véase `_notacion/macro-cerrada.md`, que manda. Decisiones aprobadas por Víctor el 13/10/2026 (`decisiones.json`): la columna «Canon» es la notación definitiva; `notacion.md` manda si difiere por un choque entre áreas.

## Símbolos propios del área o con conflicto en ella

| Símbolo | Significado | Alternativas en el temario (temas) | Canon | Motivo |
|---|---|---|---|---|
| i, r | Tipo de interés nominal y real | i y r sin distinguir en 3.A.4 (r en la inversión, i en la demanda de dinero); v en 3.A.4 como sensibilidad | **i** nominal, **r** real; en IS-LM con precios fijos y π^e = 0, i = r y se dice | Incoherencia interna de 3.A.4 |
| c | Propensión marginal a consumir | c (3.A.4, 3.A.5) | **c** | Unánime |
| b | Sensibilidad de la inversión al tipo de interés, I = Ī − b·i | v (3.A.4, 3.A.37, 3.A.38, 4.B.4) | **b** | v es la relación capital-producto (acelerador, Harrod-Domar: 3.A.34, 3.A.43). Dornbusch-Fischer-Startz usan b. Coordinar con macro abierta (Mundell-Fleming) |
| k, h | Sensibilidades de la demanda de dinero a la renta y al tipo, M/P = kY − h·i | k, h (3.A.4, 3.A.37, 3.A.38, 4.B.4) | **k, h** | Unánime; por eso la pendiente de Phillips no puede ser h (3.A.41) |
| t | Tipo impositivo sobre la renta en IS-LM | t (3.A.37, 3.A.38, 4.B.4) | **t** en IS-LM (τ en modelos con optimización) | Uso consolidado en los manuales intermedios |
| π_t, π^e_t | Inflación y expectativa formada en t−1 | π, π_t | **π_t, π^e_t ≡ E_{t−1}[π_t]** | — |
| y^n | Producción natural (logs) | y_TNP (3.A.6); Y (3.A.6); x_t es la brecha (3.A.7) | **y^n_t**; brecha **x_t ≡ y_t − y^n_t** | Coherente con la NEK |
| ω | Coeficiente de extracción de señal de Lucas, ω = σ²_z/(σ²_z + σ²_p) | θ (3.A.6, 3.A.37) | **ω** | θ es la CRRA (3.A.6 la usa también en el RBC y 3.A.37 en la IS dinámica: choque dentro del mismo tema) |
| ε_S, ψ | Elasticidad de la oferta de cada isla al precio relativo percibido (ε_S) y respuesta de la producción a la sorpresa de precios, ψ ≡ ω·ε_S, en y_t = y^n_t + ψ(p_t − p^e_t) | θ·β (3.A.6, 3.A.37, 3.A.41) | **ε_S y ψ** | β es el factor de descuento (RBC en 3.A.6) y b la sensibilidad de la inversión en IS-LM, que convive con Lucas en 3.A.37 |
| β | Factor de descuento β ≡ 1/(1+ρ) | β (3.A.1 cuasihiperbólico, 3.A.6 RBC); R_t como «tipo de descuento» de la empresa (3.A.6) | **β**; R_t solo rendimiento bruto del capital | 3.A.6 da a β tres sentidos (Lucas, descuento, coeficiente de regresión) |
| β, δ (Laibson) | Modelo cuasihiperbólico: U_t = u(C_t) + β Σ_{k≥1} δ^k u(C_{t+k}); β sesgo hacia el presente, δ factor exponencial | β (3.A.1) | **β, δ como en Laibson (1997)**, avisando de que es una excepción | Es el nombre del modelo («β-δ»); no convive con la depreciación |
| θ | CRRA | θ (3.A.6 RBC, 3.A.7) | **θ** | Véase macro cerrada |
| η | Probabilidad de Calvo de no revisar el precio | η (3.A.7) | **η** | — |
| κ | Pendiente de la NKPC | δ (3.A.7) | **κ** | δ es depreciación |
| A_t, ln A_t | PTF en el RBC | A_t = A_0 + e^{gt+Ã_t} y ln A_t = ln A_0 + gt + Ã_t a la vez (3.A.6); ln A_t = ρ_A A_{t−1} (3.A.6) | **ln A_t = ρ_A ln A_{t−1} + ε^A_t** (y tendencia gt si se quiere) | Errores de 3.A.6 (suma frente a producto; niveles frente a logaritmos) |
| U, U^n, U* | Paro, paro natural, paro objetivo | U, U_t, Ū (3.A.6, 3.A.36) | **U_t, U^n, U*** | — |

## Choques con otras áreas

- **θ**: en 3.A.6 significa extracción de señal (Lucas) y CRRA (RBC); en 3.A.37 también. Se resuelve con ω para Lucas.
- **β**: factor de descuento (macro) y coeficientes de regresión (β-convergencia en 3.A.45, regresiones de Lucas 1973 en 3.A.6). En regresiones se admite β_0, β_1 con subíndice.
- **σ**: varianzas σ²_z, σ²_p en Lucas (desviación típica: uso general); no se usa para la CRRA.
- **v**: ver b arriba.

Autor: Víctor Gutiérrez Marcos
