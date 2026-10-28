# Reglas de Firestore: generación y prueba

`firestore.rules` (en la raíz del repositorio) **no se edita a mano**: lo genera `generar.py`, porque cada oposición repite las mismas reglas (TCEE en la raíz y las demás en `oposiciones/{op}/…` y `users/{uid}/oposiciones/{op}/…`). Para cambiarlas, editar el script y ejecutar desde la raíz:

```bash
python3 app/tool/reglas/generar.py
```

Para añadir una oposición con datos, ponerla en `OPOSICIONES` del script.

## Prueba

`prueba.mjs` comprueba `firestore.rules` contra el emulador oficial de Firestore con varias cuentas simuladas: alumno, preparadores verificados y retirados, administrador y otro opositor. Cubre la privacidad de los datos de cada usuario, la verificación, los códigos, las sustituciones con sus contactos, los huecos y las reservas, y que cada oposición tenga su propia red (un administrador o un verificado de TCEE no lo es de DCE, y al revés).

Hace falta Java 11 o posterior y Node 18 o posterior:

```bash
cd app/tool/reglas
npm install
java -jar ~/.local/share/tcee-herramientas/emulador-firestore/cloud-firestore-emulator-v1.19.8.jar --host 127.0.0.1 --port 8080 &
node prueba.mjs ../../../firestore.rules
```

Ese jar no es el que distribuye Google: desde 2026 la URL de siempre
(`https://storage.googleapis.com/firebase-preview-drop/emulator/cloud-firestore-emulator-vX.Y.Z.jar`)
baja un lanzador nativo interno de Google (ELF de 63 MB) que aborta fuera de su entorno
(`Group nobody not found`). El jar de verdad va embebido al final de ese fichero, con los
desplazamientos del zip relativos al principio del ELF, así que Java no lo abre tal cual; hay que
reempaquetarlo una vez con Python (`zipfile` sí lo lee):

```python
import zipfile
src = zipfile.ZipFile('cloud-firestore-emulator-v1.19.8.jar')   # el ELF descargado
with zipfile.ZipFile('emulador.jar', 'w') as dst:
    for info in src.infolist():
        dst.writestr(info, src.read(info))
```

El resultado (52 MB, `Main-Class: com.google.cloud.datastore.emulator.firestore.CloudFirestore`)
está guardado en `~/.local/share/tcee-herramientas/emulador-firestore/` en el ordenador de Víctor,
y se lanza con el JDK 17 de `~/.local/share/tcee-herramientas/jdk`.

Tiene que acabar con `0 fallidas`. Hay que repetirla cada vez que cambien las reglas, antes de publicarlas en la consola de Firebase.

## Últimos cambios

- **28 oct. 2026 (1.21.1, pendientes de publicar)**: `retoDiario/{dia}` y `retoDiario/{dia}/participantes/{uid}` (raíz y `oposiciones/{op}`): el agregado anónimo del test diario. Funciones `participaAhora` y `notaReto` en la cabecera (`existsAfter` y `getAfter` sobre la marca del propio usuario en la misma transacción). 14 casos nuevos en `prueba.mjs`; probadas con el emulador el 28 oct. (335 correctas, 0 fallidas).

- **21 oct. 2026 (1.17.9, publicadas el mismo día)**: `match /sesiones/{id}/notas/{p}` dentro de los datos de cada usuario: las notas del preparador de una clase (su segunda pizarra). El alumno lee solo las páginas con `alumno == su uid` y `visible == true`; el preparador, dueño de su subárbol, escribe. La 1.17.11 añade `allow update` para el alumno en las páginas `editable` (sin tocar `alumno`, `visible` ni `editable`); publicadas el 21 oct. La prueba con el emulador quedó sin ejecutar al publicarlas (sin Java en la máquina).

## Índices

La pizarra compartida guarda los trazos de cada página en una lista (`cantes/{id}/pizarra/{p}` → `trazos`). Firestore indexa por defecto cada elemento de una lista, y una página puede llegar a miles de trazos: conviene crear en la consola (Firestore → Índices → Campo único → Añadir exención) una **exención de índice** para el campo `trazos` del grupo de colecciones `pizarra`, desactivando los índices ascendente, descendente y de contenido de matriz. No afecta a ninguna consulta de la app (las páginas se leen enteras, ordenadas por `n`).
