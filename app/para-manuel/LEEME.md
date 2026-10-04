# Ficheros para la web de DCE (manuelcabadogarcia.es)

La app «Oposición TCEE · DCE» descarga el temario de DCE de tu web. Esta carpeta tiene lo que necesita, ya generado:

```
oposicion/
├── temario/temario.json   los 99 temas del programa oficial (1.º, 3.º y 4.º ejercicio);
│                          los que ya tienes publicados, con el enlace a su página
├── app-config.json        tu correo de contacto, tu LinkedIn y, si quieres, avisos
└── enlaces.json           enlaces útiles (vacío de momento)
```

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

- **`oposicion/organizacion/estructura_temario.json`**: bloques de temas con colores, esquemas y conexiones, como en la organización del temario de TCEE. Sin él, la app funciona sin esa pantalla.
- **`oposicion/organizacion/como_cantar_un_tema.pdf`**: la ayuda del botón «?» de la pantalla de cantar.
- **Avisos** en `app-config.json` → `"avisos": ["…"]`: salen en la pantalla Hoy de quien prepare DCE.

## Administrador de la red de preparadores de DCE

Para verificar a los preparadores de DCE, Víctor crea en Firebase el documento `oposiciones/dce/admins/{tu correo de Google}`. Necesita tu correo de Google.
