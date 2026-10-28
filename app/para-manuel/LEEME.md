# Ficheros para la web de DCE (manuelcabadogarcia.es)

La app «Oposición TCEE · DCE» descarga el temario de DCE de tu web. Esta carpeta tiene lo que necesita, ya generado:

```
oposicion/
├── temario/temario.json   los 99 temas del programa oficial (1.º, 3.º y 4.º ejercicio);
│                          los que ya tienes publicados, con el enlace a su página
├── organizacion/estructura_temario.json
│                          la organización del temario de tu presentación
│                          (organizacion_temario_DCE.pptx): bloques con sus colores,
│                          esquemas y conexiones del 1.er y del 3.er ejercicio
├── app-config.json        tu correo de contacto, tu LinkedIn y, si quieres, avisos
└── enlaces.json           enlaces útiles (vacío de momento)
```

La presentación está en `fuentes/` (no se publica). Si la cambias, Víctor vuelve a generar el JSON con `python3 scripts/extraer-estructura-dce.py`. Para que el script la siga entendiendo, mantén la estructura: las diapositivas «Bloques» con un rótulo por sección y una caja por bloque (nombre y «A1 · A2…»), el «Esquema por temas» con una casilla por tema, y en cada ficha «BLOQUE» y «CONECTADO CON».

## Qué tienes que hacer

1. **Copiar la carpeta `oposicion/` a la raíz de tu web**, de modo que se abra https://manuelcabadogarcia.es/oposicion/temario/temario.json.
2. **Decirle a Quarto que la publique.** Quarto solo copia a `_site` lo que renderiza, así que en `_quarto.yml` añade:
   ```yaml
   project:
     resources:
       - oposicion/
   ```
3. **Volver a generar `temario.json` cuando publiques temas nuevos**, para que la app los vea. Lo hace `scripts/generar-temario-dce.py` del repositorio de Víctor, que lee tu «Índice de temas». También puedes añadir lo mismo a tu `construir_web.py`: el formato está en el propio script.

No hace falta nada más: tu web está en GitHub Pages, que deja que la app descargue estos ficheros desde otro dominio, y la cortina de la portada no les afecta.

## Opcional

- **`fasesEscrito` en `app-config.json`**: cambia, sin publicar la app, los números del cronograma por fases del 1.er ejercicio. Por ejemplo, `"fasesEscrito": {"1": {"diasSinEscribir": 42, "proporcionDescarte": 0.67, "minSalidasDescarte": 3, "maxFlojosSemana": 3, "simulacrosPorSemana": 2, "reparto": {"vuelta": 0.55, "simulacros": 0.30, "revision": 0.15}}}`.
- **`oposicion/organizacion/como_cantar_un_tema.pdf`**: la ayuda del botón «?» de la pantalla de cantar.
- **Avisos** en `app-config.json` → `"avisos": ["…"]`: salen en la pantalla Hoy de quien prepare DCE.

## Administrador de la red de preparadores de DCE

Para verificar a los preparadores de DCE, Víctor crea en Firebase el documento `oposiciones/dce/admins/{tu correo de Google}`. Necesita tu correo de Google.
