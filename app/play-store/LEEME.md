# Publicar la app en Google Play

Todo lo necesario para publicar «Oposición TCEE · DCE» en Google Play, preparado para cuando se pague la cuenta de desarrollador. Los textos y respuestas de los formularios están más abajo, listos para copiar.

## Pasos

1. **Cuenta de desarrollador** (25 $, una sola vez): https://play.google.com/console/signup. Cuenta personal, verificación de identidad con DNI y dirección. Se puede dar acceso a Manuel después (*Usuarios y permisos*).
2. **Crear la app** en Play Console: nombre «Oposición TCEE · DCE», idioma predeterminado español (España), tipo *App*, *Gratis*.
3. **Paquete**: `cd app && flutter build appbundle --release` → `build/app/outputs/bundle/release/app-release.aab`. Se firma con la misma clave de subida que el APK (`android/tcee-upload.jks`, alias `tcee`), así que es la *clave de subida*; la de firma final la genera y guarda Google (*Firma de apps de Google Play*, aceptar la opción recomendada).
4. **Firebase**: en Play Console → *Integridad de la app* → *Firma de apps*, copiar la huella **SHA-1 y SHA-256 de la clave de firma de apps** y añadirlas en la consola de Firebase (proyecto `web-vgm` → configuración → app Android `es.victorgutierrezmarcos.tcee_app`). Sin esto, el inicio de sesión con Google no funciona en la app instalada desde Play.
5. **Ficha de Play Store** (*Presencia en Play Store → Ficha principal*): textos de abajo y gráficos de [`graficos/`](graficos/) (`icono-512.png`, `grafico-destacado.png` y las 8 capturas de `capturas/`). Se regeneran con `python3 scripts/generar-graficos-play.py`.
6. **Contenido de la app** (*Política → Contenido de la app*): respuestas de abajo.
7. **Prueba cerrada** (obligatoria en cuentas personales nuevas): *Pruebas → Prueba cerrada*, subir el `.aab`, crear una lista con los correos de Google de **al menos 12 personas** y compartirles el enlace de participación. Tienen que seguir dentro **14 días seguidos**. Después, *Solicitar acceso a producción* (preguntan cómo fue la prueba).
8. **Producción**: subir el `.aab` (con `version` de `pubspec.yaml` mayor que la anterior) y enviar a revisión (unos días la primera vez).
9. **Al publicarse**: en `oposicion/app-config.json`, poner `urlPlayStore` (`https://play.google.com/store/apps/details?id=es.victorgutierrezmarcos.tcee_app`) y `urlApk` a `null`. La web y la app pasan a enlazar a Play, y Play se encarga de las actualizaciones. Quien tenga el APK instalado debe desinstalarlo e instalar la de Play (la firma es distinta).

## Ficha de Play Store

**Nombre** (máx. 30): `Oposición TCEE · DCE`

**Descripción breve** (máx. 80): `Cantes, temario, test y preparadores para las oposiciones de TCEE y DCE`

**Descripción completa** (máx. 4000):

```
La app para preparar las oposiciones a Técnico Comercial y Economista del Estado (TCEE) y a Diplomado Comercial del Estado (DCE). Gratis, sin anuncios y también en el navegador.

Eliges tu oposición al abrirla y si la preparas o preparas a otros. Cada una tiene su temario, su examen, sus probabilidades y sus preparadores, y lo de cada una se guarda aparte.

HOY
• Cuenta atrás al próximo cante y al examen (la fecha la pones tú).
• Test diario y lo que te toca esta semana según tu cronograma.

ESTUDIAR
• Todos los temas, dentro de la app: los PDF de TCEE y los apuntes de DCE.
• Agenda de cada tema: apuntes para la próxima vuelta, vueltas dadas, cómo te fue al cantarlo y notas.
• El simulador de test de la web, con las mismas preguntas oficiales y el mismo historial.

CANTES
• Agenda con avisos la víspera y una hora antes, cantes presenciales u online (con enlace de Google Meet) y exportación al calendario.
• Sacar bola como en el examen o de tu propia bolsa, cronómetro de preparación y exposición, y grabación para escucharte.
• Diario: qué tema cantaste, cuánto duró y cómo fue.

ORGANIZACIÓN
• Cronograma de vueltas: genéralo, hazlo semana a semana o trae el tuyo desde un Excel, un Word o un PDF.
• Probabilidad de que salga un tema que llevas, con las reglas de cada examen.
• Convocatoria con tus hitos, horario de estudio y el mapa del temario.

TU PREPARADOR
• Conecta con tu preparador: ve tus temas y tus cantes, y te programa las clases.
• ¿Te cancelan la clase? Pide una clase suelta a preparadores verificados: el día, una franja de horas y los temas que llevas. Quien la coge elige la hora y os pasáis el WhatsApp.

SI PREPARAS A OPOSITORES
• Date de alta y te verifica otro preparador. Al abrir la app, tus clases de hoy.
• Tu semana con todas las clases, la ficha de cada alumno, clases fijas, reservas y el tablón de clases sueltas.

EN EL ORDENADOR
• La misma app en el navegador, con tu cuenta de Google y todo sincronizado.

Tus datos solo los ves tú: ni otros opositores ni nadie más. Solo compartes lo que decidas enseñar a tu preparador. La cuenta de Google es opcional.

Hecha por Víctor Gutiérrez Marcos (TCEE) y Manuel Cabado García (DCE). Temario de TCEE en victorgutierrezmarcos.es y de DCE en manuelcabadogarcia.es.
```

**Categoría**: Educación. **Etiquetas**: Estudio, Educación.
**Correo de contacto**: contacto@victorgutierrezmarcos.es · **Sitio web**: https://www.victorgutierrezmarcos.es/app/
**Política de privacidad**: https://www.victorgutierrezmarcos.es/politica-cookies.html

## Contenido de la app (formularios)

**Política de privacidad**: la URL de arriba.

**Acceso a la app**: *Toda la funcionalidad está disponible sin restricciones especiales.* La cuenta de Google es opcional; sin ella funciona todo salvo sincronizar y enlazar con preparadores. (Si pidieran credenciales para revisar la parte de preparadores: crear una cuenta de Google de prueba y verificarla como preparador desde *Gestionar la red*.)

**Anuncios**: No contiene anuncios.

**Clasificación del contenido** (cuestionario IARC): categoría *Referencia, noticias o educación*. Violencia, sexo, lenguaje, drogas, apuestas: no. Interacción entre usuarios: **sí, limitada** (los preparadores y alumnos que se enlazan, y las peticiones de sustitución, intercambian nombre y teléfono para hablar por WhatsApp). Comparte la ubicación: no. Compras: no. Resultado esperado: PEGI 3 / Para todos.

**Público objetivo**: mayores de 18 años (opositores y preparadores). No dirigida a menores.

**Aplicación de noticias**: no. **Apps de salud**: no. **Servicios financieros**: no. **Aplicación del Gobierno**: no (aunque prepara oposiciones del Estado, no es oficial).

**Seguridad de los datos**:

- ¿Recoge o comparte datos? **Sí recoge; no comparte con terceros** (Firebase es un proveedor de servicios, no cuenta como compartir).
- ¿Cifrado en tránsito? **Sí** (HTTPS).
- ¿Se pueden eliminar los datos? **Sí**: en la app (*Más → Cuenta → Eliminar mi cuenta*) y en https://www.victorgutierrezmarcos.es/app/eliminar-cuenta.html (es la **URL de eliminación de cuenta** que pide el formulario).
- Datos que recoge (todos **opcionales**, solo si se inicia sesión, para **funcionalidad de la app** y **gestión de la cuenta**; ninguno para publicidad ni analíticas):
  - *Información personal*: **nombre** y **dirección de correo** (de la cuenta de Google); **ID de usuario**; **número de teléfono** (solo si un preparador o un alumno lo escribe para que le contacten al coger una sustitución).
  - *Actividad en la app*: **otras acciones** (temas estudiados, resultados de test, cantes, notas, cronogramas).
  - *Fotos*: la foto de perfil de Google se muestra, no se guarda.
  - *Audio*: **no se recoge**: las grabaciones de los cantes se quedan en el dispositivo.
- ¿Se tratan de forma efímera? No. ¿Obligatorio? No (opcional).

**Declaración de permisos**: si Play pregunta por `SCHEDULE_EXACT_ALARM`: *El cronómetro de exposición oral avisa de los minutos que quedan con la pantalla apagada; un aviso que llega minutos tarde no sirve. Si el usuario no concede el permiso, la app usa avisos aproximados.*

**Funciones en segundo plano / tareas**: WorkManager comprueba cada ~15 minutos, con red y solo si el usuario lo activa, si hay clases sueltas nuevas en el tablón o reservas por confirmar.

## Notas de la versión (ejemplo)

```
Primera versión en Google Play: TCEE y DCE, cronograma con tu día de cante, cantes presenciales u online y la app también en el ordenador.
```
