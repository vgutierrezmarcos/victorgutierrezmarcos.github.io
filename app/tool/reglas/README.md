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
curl -LO https://storage.googleapis.com/firebase-preview-drop/emulator/cloud-firestore-emulator-v1.19.8.jar
java -jar cloud-firestore-emulator-v1.19.8.jar --host 127.0.0.1 --port 8080 &
node prueba.mjs ../../../firestore.rules
```

Tiene que acabar con `0 fallidas`. Hay que repetirla cada vez que cambien las reglas, antes de publicarlas en la consola de Firebase.

## Últimos cambios

- **21 oct. 2026 (1.17.9, publicadas el mismo día)**: `match /sesiones/{id}/notas/{p}` dentro de los datos de cada usuario: las notas del preparador de una clase (su segunda pizarra). El alumno lee solo las páginas con `alumno == su uid` y `visible == true`; el preparador, dueño de su subárbol, escribe. La 1.17.11 añade `allow update` para el alumno en las páginas `editable` (sin tocar `alumno`, `visible` ni `editable`). La prueba con el emulador quedó sin ejecutar al publicarlas (sin Java en la máquina).

## Índices

La pizarra compartida guarda los trazos de cada página en una lista (`cantes/{id}/pizarra/{p}` → `trazos`). Firestore indexa por defecto cada elemento de una lista, y una página puede llegar a miles de trazos: conviene crear en la consola (Firestore → Índices → Campo único → Añadir exención) una **exención de índice** para el campo `trazos` del grupo de colecciones `pizarra`, desactivando los índices ascendente, descendente y de contenido de matriz. No afecta a ninguna consulta de la app (las páginas se leen enteras, ordenadas por `n`).
