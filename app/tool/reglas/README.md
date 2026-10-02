# Prueba de las reglas de Firestore

`prueba.mjs` comprueba `firestore.rules` contra el emulador oficial de Firestore con varias cuentas simuladas: alumno, preparadores verificados y retirados, administrador y otro opositor. Cubre la privacidad de los datos de cada usuario, la verificación, los códigos, las sustituciones con sus contactos, los huecos y las reservas.

Hace falta Java 11 o posterior y Node 18 o posterior:

```bash
cd app/tool/reglas
npm install
curl -LO https://storage.googleapis.com/firebase-preview-drop/emulator/cloud-firestore-emulator-v1.19.8.jar
java -jar cloud-firestore-emulator-v1.19.8.jar --host 127.0.0.1 --port 8080 &
node prueba.mjs ../../../firestore.rules
```

Tiene que acabar con `0 fallidas`. Hay que repetirla cada vez que cambien las reglas, antes de publicarlas en la consola de Firebase.
