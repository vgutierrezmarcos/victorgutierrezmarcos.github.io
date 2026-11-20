# Renovación de equipos: modelo MAPI (Terborgh, 1949), retiro simple y cadena de renovaciones

- **Área:** finanzas-empresa · **Tema de referencia:** **3.B.2** (La empresa y las decisiones de inversión; revisado el 8/11/2026) — único tema que lo desarrolla; `mapa.yaml` lo listaba sin ficha. Ficha creada en la pasada final (noviembre de 2026).
- **Temas que lo usan:** 3.B.2 (desarrollo; hecho, 8/11/2026). Ningún otro uso conocido.
- **Manuales de referencia:** Terborgh (1949), *Dynamic Equipment Policy* (Machinery and Allied Products Institute, MAPI); Suárez Suárez, *Decisiones óptimas de inversión y financiación en la empresa* (retiro y renovación).

## Presentación de referencia (3.B.2)
**Pregunta:** ¿cuándo se renueva un equipo cuando aparecen otros mejores?

**Idea:** el coste del equipo por año tiene 2 partes: los **costes de capital**, decrecientes con la vida útil (se reparte la inversión entre más años), y la **inferioridad de servicio**, creciente (deterioro propio y obsolescencia frente a los equipos nuevos). Su suma es un **coste total en U**; la vida óptima está en el mínimo.

**Junto a él:** el **modelo simple de retiro** (se retira el equipo cuando el valor del flujo de un año más no compensa el valor residual que se pierde) y la **cadena de renovaciones** (equipos iguales que se sustituyen indefinidamente: se elige la vida $n$ que maximiza $\mathrm{VAN}_\infty(n)=\mathrm{VAN}(n)\,\dfrac{(1+k)^n}{(1+k)^n-1}$, con $\mathrm{VAN}(n)$ el de un solo ciclo).

**Gráfico de referencia:** `oposicion/temario/fuentes/3B02/graficos/mapi.tex` (costes de capital decrecientes, inferioridad de servicio creciente y coste total en U con su mínimo).

**Notación:** $\mathrm{VAN}(n)$, $\mathrm{VAN}_\infty(n)$; $k$ tasa de descuento genérica (ficha `van-tir`); $I_0$ desembolso (D085).

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.B.2 | Decisiones de inversión: renovación de equipos | desarrollo (hecho, 8/11/2026) | MAPI con el gráfico, retiro simple y cadena de renovaciones con $\mathrm{VAN}_\infty(n)$ | — |

## Divergencias encontradas en el temario actual
- `mapa.yaml` listaba el id `mapi` en el 3.B.2 sin ficha: resuelto en la pasada final.

Autor: Víctor Gutiérrez Marcos
