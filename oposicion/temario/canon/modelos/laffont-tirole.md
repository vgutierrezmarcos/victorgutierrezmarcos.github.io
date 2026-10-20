# Menú de contratos de Laffont y Tirole (1986)

- **Área:** mercados-información-juegos · **Tema de referencia:** 3.A.17 (anexo A, «Regulación y control del monopolio»; revisado el 17/10/2026, A.3), reescrito desde Laffont y Tirole (1993). **[decidir]** Propuesta del 3.A.17 (D1, decisión provisional del orquestador pendiente de Víctor): cuando se redacte el 3.A.20 («desarrollos en presencia de información asimétrica» en el título), pasarle la referencia de este modelo, de Averch-Johnson, del *price cap* y del *yardstick*, y dejar el 3.A.17 en «mención» con remisión; Ramsey-Boiteux, la tarifa en dos partes y el monopolio natural se quedan en el 3.A.17.
- **Temas que lo usan:** 3.A.17 (desarrollo en el anexo A, no se canta; hecho, 17/10/2026), 4.B.15 (resumen; hoy mención con ecuaciones), 3.A.13 (mención; hecho, 19/10/2026: aplicación de la teoría de la regulación en I.1 y en la definición del riesgo moral, remitiendo al 3.A.17), 3.A.20 (previsto, sin fuente; posible referencia, D1). 3.A.14 (mención; hecho, 19/10/2026: la regulación con información asimétrica como problema de diseño de mecanismos, con `\vertema{3.A.17}`). 3.A.15 (mención; hecho, 20/10/2026: III.4, aportaciones de Tirole con el Nobel de 2014: menús de contratos, efecto trinquete, precios de acceso e interconexión, Laffont, Rey y Tirole, 1998, y Laffont y Tirole, 2000, con `\vertema{3.A.17}` y `\vertema{3.A.20}`).
- **Manuales de referencia:** Laffont y Tirole (1986), *JPE*; Laffont y Tirole (1993), *A Theory of Incentives in Procurement and Regulation*, cap. 1 y 3; Laffont y Tirole (1991), *QJE* (captura).

## Presentación de referencia (3.A.17, anexo A)
Pregunta: ¿cómo regular un monopolio cuando el regulador no observa su eficiencia ni su esfuerzo?
- **Supuestos**: coste observado C = β − e, con β la eficiencia intrínseca (información oculta: baja, β̲, con probabilidad ν, o alta, β̄; Δβ = β̄ − β̲) y e el esfuerzo (acción oculta), con desutilidad ψ(e) creciente y convexa (ψ y ν, como la fuente; locales: en información asimétrica la desutilidad es v(e) y la probabilidad π, `notacion.md` § 1 y § 4). El regulador observa C, reembolsa el coste y paga una transferencia t que cuesta a la sociedad **1 + λ** por euro (λ, coste sombra de los fondos públicos: **la misma λ de Ramsey-Boiteux**, con una nota en el tema; número de Ramsey λ/(1+λ)). La empresa obtiene U = t − ψ(e) ≥ 0.
- **Información completa**: ψ'(e*) = 1 y sin rentas.
- **Información asimétrica**: la eficiente puede imitar a la ineficiente esforzándose menos; hay que dejarle una **renta informativa** Φ(e) = ψ(e) − ψ(e − Δβ). En el óptimo:
$$\psi'(\underline e)=1,\qquad \psi'(\overline e)=1-\frac{\lambda}{1+\lambda}\cdot\frac{\nu}{1-\nu}\cdot\Phi'(\overline e)<1$$
«No hay distorsión arriba» y menos esfuerzo para la ineficiente: el mismo resultado que la discriminación de 2.º grado (ficha `discriminacion-precios`).
- **Puesta en práctica**: menú de contratos lineales t(C) = a − b(C − C^a), con C^a el coste anunciado y b ∈ [0,1] la **potencia** (parte del sobrecoste que paga la empresa): la eficiente elige el de **precio fijo** (b = 1) y la ineficiente uno de baja potencia, cercano al de **coste incrementado** (b → 0).
- **Implicación**: dilema **incentivos frente a extracción de rentas** (no «eficiencia frente a igualdad»): alta potencia (*price cap*) da incentivos y deja rentas; baja potencia (coste incrementado, tasa de rentabilidad), al revés.
- **Anotación** (anexo A): precio lineal en el coste p = bF + (1 − b)C (F cuantía fija, letra local): b = 0 coste incrementado (*cost plus*), b = 1 precio fijo, que es el *price cap* (ficha `price-cap`). Efecto trinquete (Weitzman, 1980; Freixas, Guesnerie y Tirole, 1985; Laffont y Tirole, 1988) y desfase regulatorio (tiempo **entre** revisiones: Baumol y Klevorick, 1970; Joskow, 1974).

Gráfico: no tiene; se cuenta con las ecuaciones.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.17 | Regulación con información asimétrica | desarrollo en el anexo A (hecho, 17/10/2026; no se canta) | Supuestos, óptimo con renta informativa, menú, dilema; enlace con el 2.º grado y con 3.A.13 | — |
| 3.A.20 | Regulación óptima con información asimétrica | previsto (sin fuente); referencia si se aprueba D1 | La presentación de arriba, con la misma notación | — |
| 3.A.13 | Selección adversa y agencia | mención (hecho, 19/10/2026) | Una viñeta en las aplicaciones de la selección adversa (el regulador no conoce los costes; menú que equilibra eficiencia y renta informativa; Laffont y Tirole, 1993) y una en las del riesgo moral (esfuerzo en reducir costes), con `\vertema{3.A.17}` (a 3.A.20 si se aprueba D1); la relación de agencia con selección adversa, en nota. Ficha `principal-agente` | El modelo |
| 3.A.14 | Diseño de mecanismos | mención (hecho, 19/10/2026) | La regulación con información asimétrica como aplicación del principio de revelación (renta informativa); remite a 3.A.17 (3.A.20 si se aprueba la D1 del 3.A.17) | El modelo |
| 3.A.15 | Nueva TOI: Tirole | mención (hecho, 20/10/2026) | Una viñeta entre las aportaciones del Nobel de Tirole (2014); remite a 3.A.17 y 3.A.20 | El modelo |
| 4.B.15 | Empresa pública y regulación | resumen (hoy mención; D139 (13/10/2026)) | Precio fijo frente a coste incrementado; p = bF + (1 − b)C | La formalización |

## Divergencias encontradas en el temario actual
- 3.A.17 original: «el principal no observa el coste», «sin conocer la distribución», «*trade-off* eficiencia e igualdad», contrato *fixed-cost*, cost plus «óptimo con información perfecta», efecto *ratchet* traducido de Wikipedia, *regulatory lag* «entre la revisión y su aplicación». **Resuelto** (17/10/2026), reescrito desde Laffont y Tirole (1993).
- λ en Ramsey-Boiteux y en Laffont-Tirole en el mismo tema: **resuelto**, λ en los 2 con una nota (la ficha proponía μ para el multiplicador; ya no).
- Signo de la transferencia: 4.B.15 escribe t = a + b(C − C^a); con b como potencia debe restarse (la empresa soporta el sobrecoste), como el 3.A.17.
- 3.A.13 original: la nota 13 remitía el modelo al 3.A.20 con «Laffont y Tirole (1991)». **Resuelto** (19/10/2026): Laffont y Tirole (1993) y `\vertema{3.A.17}`. Si se aprueba D1, cambiar esas 3 remisiones del 3.A.13 a 3.A.20 (`pendientes-coherencia.md`, condicional).

Autor: Víctor Gutiérrez Marcos
