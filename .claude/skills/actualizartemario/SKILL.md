---
name: actualizartemario
description: Actualiza los datos numéricos que caducan en los temas revisados del temario TCEE (series del INE, Eurostat, BCE, FMI…, encuesta trienal del BIS, presupuestos de la UE, PGE, MFP, aranceles de la OMC…) a partir del inventario fuentes/<T>/datos-actualizables.yaml de cada tema. Uso /actualizartemario [tema|--todos] [--solo-comprobar].
argument-hint: "[3B25 | --todos] [--solo-comprobar] [--fuente bis|pge|ue|ine|…]"
---

# /actualizartemario

Pone al día las cifras que caducan de los temas ya revisados, sin tocar la
teoría. Se trabaja en la rama de revisión (worktree `R`, nunca `main`); al
acabar, los temas cambiados se reconstruyen y se publican en la rama como en
`/revisartema` (fase construir, calidad y publicar), y si un tema o ficha ya
estaba aprobado, se regenera el manifiesto de la app.

## El inventario: `oposicion/temario/fuentes/<T>/datos-actualizables.yaml`

Lo escribe quien revisa el tema (CRITERIOS §4, «Datos que caducan») y lo
mantiene al día cada cambio de un dato. Formato:

```yaml
tema: 3B25
fecha_inventario: 2026-11-09
datos:
  - id: trienal-volumen                 # único en el tema
    texto: "9,5 billones de dólares"    # literal tal como está en la fuente, para localizarlo con grep
    donde: [3B25.tex, repaso/3B25-repaso.tex]   # ficheros (relativos a la carpeta del tema) donde aparece
    valor: 9.5
    unidad: billones de USD diarios
    periodo: abril 2025                 # a qué fecha o periodo se refiere el dato
    fuente: BIS2025Triennial            # clave del .bib que lo cita
    organismo: BIS
    serie: "Triennial Central Bank Survey, OTC FX turnover, total"   # tabla, indicador o código de serie
    url: https://www.bis.org/statistics/rpfx25.htm
    periodicidad: trienal               # mensual | trimestral | anual | trienal | por presupuesto | irregular
    proxima: 2028-09                    # cuándo se espera el dato siguiente (AAAA-MM), si se sabe
    familia: bis-trienal                # agrupa datos que se actualizan juntos en varios temas (ver abajo)
    depende: [datos/fx-volumen.csv, graficos/fx-volumen.tex]   # gráficos o CSV que hay que rehacer
    frase: "cambia también «unas 3 veces el PIB mundial anual»"  # texto derivado que hay que revisar, si lo hay
```

**Familias** (mismo dato en varios temas; se actualizan de una vez y con la
misma cifra): `bis-trienal`, `mff-ue` (marco financiero plurianual),
`presupuesto-ue` (anual), `pge` (Presupuestos Generales del Estado),
`ngeu`, `omc-aranceles`, `fmi-weo`, `ine-epa`, `ine-pib`, `bce-tipos`,
`eurostat-deuda`, etc. Lista viva en `oposicion/temario/fuentes/_datos-familias.yaml`.

## Pasos

1. Lee CRITERIOS §4 (fuentes por orden de preferencia, doble comprobación,
   cómo citar) y el inventario de los temas pedidos (`--todos`: todos los
   `datos-actualizables.yaml`). Agrupa por `familia` y por `organismo`.
2. **Comprobar** (agentes `tema-verificador-datos` en paralelo, uno por
   familia u organismo, hasta 6 a la vez): para cada dato, ¿hay uno más
   reciente que `periodo`? Si lo hay, lo baja de la fuente primaria, lo
   comprueba dos veces y escribe una propuesta en
   `oposicion/temario/_actualizacion/<fecha>/<familia>.md` (dato viejo,
   nuevo, fuente, urldate, temas y ficheros afectados, frases derivadas).
   Con `--solo-comprobar` se para aquí y se entrega a Víctor la lista.
3. **Aplicar** (agente `tema-editor-lyx` por tema): cambia el texto literal,
   la entrada del `.bib` (año, `urldate`), los CSV de `depende`, las frases
   derivadas y la ficha; actualiza la entrada del inventario (`texto`,
   `valor`, `periodo`, `proxima`, `fecha_inventario`). No cambia nada que no
   esté en la propuesta.
4. **Construir y publicar en la rama** los temas cambiados
   (`reconstruir-todos.py` o `construir-tema.py` + `verificar-tema.py` +
   `publicar-tema.py`), commit `Datos actualizados: <familias>` y push.
5. Resumen para Víctor: qué cifras cambiaron (tabla viejo → nuevo), qué no
   tenía dato nuevo y qué no se pudo comprobar.

## Reglas

- Nunca se cambia un dato sin fuente primaria comprobada dos veces; si no
  cuadra, se deja el anterior y se anota.
- Si el dato nuevo cambia el mensaje del texto (por ejemplo, una tendencia
  que se invierte), no se reescribe la idea: se anota como duda para Víctor.
- Un dato que aparece en el tema y no está en el inventario se añade al
  inventario en la misma pasada.
