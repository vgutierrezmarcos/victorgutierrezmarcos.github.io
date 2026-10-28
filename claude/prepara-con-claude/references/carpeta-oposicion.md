# Tu carpeta de la oposición (y cómo usar Claude desde ella)

Una carpeta ordenada en el ordenador, con todo lo de la oposición, hace que Claude trabaje mejor: encuentra el tema que toca, guarda cada informe junto al cante que corrige y no hay que subir los mismos ficheros cada vez. Esta es la estructura que recomendamos; adáptala, pero mantén los códigos de tema en los nombres (`3A08`, `3.A.8`), que es lo que la skill y la app usan para encontrar las cosas.

```
Oposición TCEE/                          (o «Oposición DCE»)
  LEEME.md                               qué hay en cada carpeta
  prepara-con-claude.zip                 la skill (descargada de la app o de la web)
  0_organizacion/
     OEP2025TECOS_Convocatoria_BOE.pdf   convocatoria y programa oficial
     preparacion_oposicion_tcee.xlsm     Excel de estrategia (probabilidades, sorteos)
     estructura_temario.pdf · como_cantar_un_tema.pdf
     oposicion_tcee_para_claude.json     la exportación de la app (actualízala cada semana)
     cronograma.txt                      el último cronograma acordado con Claude
  1_primer_ejercicio/
     1_test/                             examenes_oficiales_test.pdf, plantillas; tus simulacros
     2_dictamen/                         esquema_dictamen_economico.pdf, examenes_oficiales_dictamen.pdf
        simulacros/                      2026-11-15_meridia.pdf · 2026-11-15_meridia-informe.pdf
  2_segundo_ejercicio/                   idiomas
  3_tercer_ejercicio/
     A/3A08/                             una carpeta por tema
        3A08.pdf · 3A08.docx             el tema de la web
        mis-apuntes-3A08.docx
        cantes/                          2026-11-03.txt (la app) · 2026-11-03-informe.pdf (Claude)
     A/3A09/ … B/3B01/ …
  4_cuarto_ejercicio/A/… B/…
  5_quinto_ejercicio/A/… B/… C/…
```

## Crearla con un solo prompt

La skill lleva `scripts/carpeta-oposicion.py`, que crea esta estructura y baja a cada carpeta los materiales públicos de la web (los 177 temas en PDF y Word, la organización, los exámenes oficiales, el esquema del dictamen). Desde Claude Code o Claude Desktop con acceso a ficheros basta con pedir:

> «Crea mi carpeta de la oposición en Documentos/Oposición TCEE con todos los materiales de la web.»

Claude ejecuta `python3 scripts/carpeta-oposicion.py "<ruta>" --oposicion tcee` (opciones: `--sin-word` para no bajar los .docx, `--solo-carpetas` para solo la estructura; `--oposicion dce` usa la web de Manuel). Tarda unos minutos (unos 450 MB con los PDF) y se puede repetir: lo que ya está no se vuelve a bajar. Los materiales exclusivos (temas revisados, fichas, guía 1D01) no se descargan: se leen en la app y están dentro de la skill. En Claude.ai sin acceso a ficheros, Claude puede entregar el script para ejecutarlo en el ordenador.

## Cómo usar Claude desde la carpeta

- **Claude.ai en el navegador o en el móvil**: sube a cada chat lo que haga falta (la transcripción, el JSON, las fotos). Un **Proyecto** de Claude.ai con la skill activada y los ficheros de `0_organizacion` como conocimiento evita subirlos cada vez: crea el proyecto «Oposición» y usa siempre ese.
- **Claude Desktop (Windows y Mac)**: la app de escritorio puede trabajar sobre una carpeta de tu ordenador (modo de trabajo con ficheros): dale acceso a `Oposición TCEE` y pídele «corrige el cante de hoy» o «guarda el informe junto a la transcripción»; leerá y escribirá ahí. Instala la skill igual que en Claude.ai (misma cuenta).
- **Claude Code (terminal)**: abre una terminal en la carpeta y escribe `claude`. Para que use la skill, descomprime el ZIP en `Oposición TCEE/.claude/skills/prepara-oposicion/` (o en `~/.claude/skills/`); después, en la terminal, pide lo mismo que en el chat. Es la forma más cómoda de que los informes queden guardados solos en la carpeta `cantes/` de cada tema.

## Qué le pides a Claude cuando trabaja en la carpeta

- «Corrige `3_tercer_ejercicio/A/3A08/cantes/2026-11-03.txt` y guarda el informe en PDF al lado.»
- «Con `0_organizacion/oposicion_tcee_para_claude.json`, replanifica desde esta semana y actualiza `cronograma.txt`.»
- «Compara `3_tercer_ejercicio/A/3A08/mis-apuntes-3A08.docx` con la ficha del tema y dime qué me falta.»
- «Lee los tres últimos informes de `cantes/` de los temas que he cantado este mes y dime qué error se repite.»

Cuando Claude trabaja con ficheros, sigue aplicando `LICENCIA.md`: los documentos de la skill no se copian a la carpeta ni se convierten; lo que se guarda son tus informes, tus cronogramas y tus fichas.
