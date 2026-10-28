# Tu carpeta de la oposición (y cómo usar Claude desde ella)

Una carpeta ordenada en el ordenador, con todo lo de la oposición, hace que Claude trabaje mejor: encuentra el tema que toca, guarda cada informe junto al cante que corrige y no hay que subir los mismos ficheros cada vez. Esta es la estructura que recomendamos; adáptala, pero mantén los códigos de tema en los nombres (`3A08`, `3.A.8`), que es lo que la skill y la app usan para encontrar las cosas.

```
Oposición TCEE/                      (o «Oposición DCE»)
  prepara-con-claude.zip             la skill (descargada de la app o de la web)
  00 Organización/
     programa-oficial.pdf            el anexo de la convocatoria
     convocatoria-2026.pdf
     oposicion_tcee_para_claude.json la exportación de la app (actualízala cada semana)
     cronograma.txt                  el último cronograma acordado con Claude
  01 Temario/
     3º/3A/3A08/                     una carpeta por tema
        3A08.pdf                     el tema del temario (o tus apuntes)
        3A08-repaso.pdf              la ficha de repaso, si existe
        mis-apuntes-3A08.docx
     3º/3B/…  4º/…  5º/…
  02 Cantes/
     2026-11-03_3A08.txt             la transcripción que manda la app
     2026-11-03_3A08-informe.pdf     el informe de Claude
  03 Dictámenes/
     2026-11-15_meridia.pdf          las hojas escaneadas y el cuadernillo
     2026-11-15_meridia-informe.pdf
  04 Test/
     resultados y preguntas que fallas (de la app)
  05 Idiomas/
```

## Cómo usar Claude desde la carpeta

- **Claude.ai en el navegador o en el móvil**: sube a cada chat lo que haga falta (la transcripción, el JSON, las fotos). Un **Proyecto** de Claude.ai con la skill activada y los ficheros de `00 Organización` como conocimiento evita subirlos cada vez: crea el proyecto «Oposición» y usa siempre ese.
- **Claude Desktop (Windows y Mac)**: la app de escritorio puede trabajar sobre una carpeta de tu ordenador (modo de trabajo con ficheros): dale acceso a `Oposición TCEE` y pídele «corrige el cante de hoy» o «guarda el informe junto a la transcripción»; leerá y escribirá ahí. Instala la skill igual que en Claude.ai (misma cuenta).
- **Claude Code (terminal)**: abre una terminal en la carpeta y escribe `claude`. Para que use la skill, descomprime el ZIP en `Oposición TCEE/.claude/skills/prepara-con-claude/` (o en `~/.claude/skills/`); después, en la terminal, pide lo mismo que en el chat. Es la forma más cómoda de que los informes queden guardados solos en `02 Cantes`.

## Qué le pides a Claude cuando trabaja en la carpeta

- «Corrige `02 Cantes/2026-11-03_3A08.txt` y guarda el informe en PDF al lado.»
- «Con `00 Organización/oposicion_tcee_para_claude.json`, replanifica desde esta semana y actualiza `cronograma.txt`.»
- «Compara `01 Temario/3º/3A/3A08/mis-apuntes-3A08.docx` con la ficha del tema y dime qué me falta.»
- «Lee los tres últimos informes de `02 Cantes` y dime qué error se repite.»

Cuando Claude trabaja con ficheros, sigue aplicando `LICENCIA.md`: los documentos de la skill no se copian a la carpeta ni se convierten; lo que se guarda son tus informes, tus cronogramas y tus fichas.
