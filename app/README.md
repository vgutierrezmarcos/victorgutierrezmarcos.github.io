# Oposición TCEE · DCE · app móvil

App Flutter (Android, iOS y navegador) complementaria de [victorgutierrezmarcos.es](https://www.victorgutierrezmarcos.es). La versión para el navegador es la misma app compilada para web y se sirve en [victorgutierrezmarcos.es/app/abrir/](https://www.victorgutierrezmarcos.es/app/abrir/) (ver «Versión web»). Todo el contenido (preguntas, temario, configuración) se descarga de la web, así que actualizar la web actualiza la app sin republicarla. Usa el mismo proyecto Firebase que la web (`web-vgm`): el historial de tests se comparte entre web y app, y el resto de datos del opositor (repaso, notas, cantes, planificación) se sincroniza entre sus dispositivos.

## Qué hace

Cinco bloques, iguales para opositores y preparadores, uno por cada cosa que se hace con la app (rutas en `lib/app.dart`; las de antes se redirigen con `rutaNueva`). La página pública que la explica, con capturas y vídeo, es [`app/index.html`](index.html) (victorgutierrezmarcos.es/app/).

| Bloque | Funciones |
|---|---|
| **Hoy** | Lo que toca. Al opositor: cuenta atrás al próximo ejercicio y al próximo cante, semana del cronograma, test diario (10 preguntas, iguales para todos cada día), repaso pendiente y probabilidad de aprobar. Al preparador, primero su panel (`PanelPreparadorHoy`): clases de hoy, reservas por confirmar, clases sueltas del tablón y verificaciones; después, test diario y repaso. Avisa cuando hay una versión nueva y de lo último que ha publicado el Ministerio en el proceso selectivo (`TarjetaNovedadProceso`). |
| **Estudiar** | Dos subpestañas. **Temas**: ejercicios → partes → temas, búsqueda, visor PDF con descarga para offline, marcar estudiado / en repaso y agenda de cada tema (apuntes para la próxima vuelta, vueltas dadas, cómo fue al cantarlo, test de sus preguntas y nota libre). **Test**: simulador con los mismos filtros y baremo que la web (1 / -0,33 / 0), resultados por bloque, revisión, estadísticas e historial unificado con la web. |
| **Cantes** | Al opositor, tres subpestañas. **Agenda**: calendario mensual, cuenta atrás, avisos la víspera y una hora antes, repetición semanal y exportación a Google Calendar o `.ics`. **Cantar**: sacar bola como en el examen o de una bolsa propia (estudiados, en repaso, lista o los temas de un cante), con prioridad opcional a los flojos; cronómetro de esquema y exposición (el esquema, con el tiempo del examen para uno o dos temas: `EjercicioDef.minutosEsquema`; «+5 min» y «Pasar a exponer»), con avisos en segundo plano, **compartido** con el preparador en las clases y **pantalla grande**, y grabación. **Diario**: cómo fue cada cante, estadísticas por tema y temas flojos. Al preparador: **Clases** (su semana) y **Cantar**. |
| **Organización** | Como la sección de la web: **cronograma** (generado, semana a semana o importado de texto, Excel, Word, PDF o CSV; se retoca a mano), **probabilidades** (como en el Excel de organización, por probabilidad o eficiencia, en 2D o 3D), **proceso selectivo** (lo que publica el Ministerio, con avisos de novedades), **convocatoria** (fechas que pone el usuario e hitos propios), **horario** de estudio, **mapa del temario** (bloques con el código de colores y esquema de conexiones), **mapa de calor** (qué temas se dominan) y documentos de organización. |
| **Más** | **Preparador** (si ese es su papel) o **Mi preparador** (si es opositor). Cuenta (Google), ajustes (oposición y papel, avisos, tema claro/oscuro, descargas), contenido, enlaces útiles y acerca de. |

### Papel en cada oposición

En cada oposición se es **opositor o preparador**, no las dos cosas (`Papel`, guardado en `PerfilPreparador.activo`, con `papelElegido`). Se elige al empezar (`ElegirOposicionApp`, segundo paso), se cambia en *Más → Ajustes → Tu papel* y a quien venía de una versión anterior se le pregunta una vez en Hoy (`TarjetaElegirPapel`). Pasar a preparador deja de compartir el progreso con los preparadores propios de esa oposición; los datos se conservan.

## Primeros pasos: bienvenida, guía y «Para empezar»

Lo que encuentra quien abre la app por primera vez, para que no abrume sin quitar nada:

- **Bienvenida** (`features/inicio/elegir_oposicion.dart`, solo en instalaciones nuevas con Firebase):
  - Entrada con Google (`entrarConGoogle` en `core/providers.dart`) o «Ahora no».
  - Después, «¿Qué oposición?» y «¿Cómo vas a usar la app?».
  - Se marca vista en la caja `app` (`bienvenida_vista`).
- **Guía de la app** (`features/guia/guia.dart`):
  - Globos sobre las pestañas (`AnclaGuia` en `_Shell`), con los pasos de `pasosGuia(papel)` y enlaces a los vídeos de ayuda.
  - Sale una vez por oposición y papel (`guia_vista_{oposicion}_{papel}`), después de la hoja de permisos, y se vuelve a abrir desde Más → Guía de la app.
- **«Para empezar» en Hoy** (`features/inicio/para_empezar.dart`):
  - Primeros pasos que se tachan solos según lo que ya se ha hecho (cuenta, fecha del examen, primer tema, primer test, preparador, avisos del proceso; al preparador: alta, código, huecos, primera clase).
  - Se oculta al completarlos o con «Ocultar».
- **Menos ruido**: Hoy no muestra la cuenta atrás sin fecha ni «Sin cantes programados», y en Organización lo menos usado va plegado en «Más herramientas».

Las capturas (`tool/demo_comun.dart`, `cajaAppSinPrimerosPasos`) dan todo esto por visto.

## Estructura

```
lib/
├── main.dart                  # Firebase + Hive + servicios; funciona sin credenciales Firebase (modo local)
├── app.dart                   # go_router: 5 bloques (/hoy, /temario, /cantes, /test, /mas); /examen y /resultados a pantalla completa
├── theme/app_theme.dart       # paleta, tipografías y componentes de styles.css (claro y oscuro)
├── core/                      # constants (URLs), cache_http (ETag + Hive), notificaciones, calendario (.ics), providers (Riverpod),
│                              # plataforma (ficheros y grabaciones: _io móvil / _web navegador), firebase_web (configuración web)
├── data/models/               # pregunta, resultado (esquema exam_results), temario, plan (cantes, horario, agenda), preparador (alumnos, enlace)
├── data/repos/                # contenido (web), usuario, plan y preparador (Hive + Firestore), descargas (PDF: _io guarda, _web en memoria)
├── features/test/             # motor_test (lógica pura), leitner (réplica de spaced-repetition.js), páginas
├── features/cantes/           # bloque Cantes: cabecera con las subpestañas Agenda, Cantar y Diario
├── features/cantar/           # sorteo (probabilidades del Excel y sorteos), reloj_cante, vista Cantar, probabilidades
├── features/plan/             # vistas Agenda y Diario, cante, convocatoria, horario
├── features/preparador/       # Preparador (alta, panel de Hoy, semana, alumnos, tablón) y Mi preparador
├── features/organizacion/     # bloques, detalle de bloque y esquema interactivo del temario
├── features/{inicio,temario,mas}/
└── widgets/comunes.dart       # piezas de la web: cabecera, títulos de sección, tarjetas, grupos desplegables
test/                          # lógica (motor, Leitner, sorteo, plan, preparadores) y pruebas de humo de la app completa
tool/capturas_test.dart        # capturas de la app con datos de demostración (para la página y el vídeo)
promo/                         # capturas ligeras (.webp), vídeo de presentación y su póster
index.html                     # página pública de la app (victorgutierrezmarcos.es/app/)
web/                           # plantilla de la versión web (index.html con pantalla de carga y pdf.js, manifiesto, iconos)
abrir/                         # versión web compilada (la genera scripts/publicar-app-web.py; se sube al repositorio)
android/, ios/                 # proyectos nativos (generados con flutter create y configurados)
```

Datos compartidos con la web (generados en el repo raíz):

- `oposicion/temario/primer-ejercicio/test/preguntas.json` y `bloques.json`
- `oposicion/temario/temario.json` y `oposicion/enlaces.json` (los crea `node build-app-data.js` en CI). Los temas del quinto ejercicio se mantienen a mano en `build-app-data.js` (`TEMAS_QUINTO`).
- `oposicion/organizacion/estructura_temario.json`: bloques, colores, esquemas y conexiones del temario. Se genera con `python3 scripts/extraer-estructura-temario.py` a partir de `estructura_temario.ppsx` (y del Excel para los bloques del cuarto ejercicio; las conexiones que no están en el PowerPoint se añaden en `CONEXIONES_EXTRA`); hay que repetirlo cuando cambie el PowerPoint.
- `oposicion/app-config.json`: versión publicada (`versionActual`), URL de descarga, reglas del sorteo (`sorteo`) y avisos. Editar a mano. La app no muestra el nombre de ninguna convocatoria ni trae fechas oficiales: las fechas las pone el usuario.

Firestore (`users/{uid}/…`, reglas en `firestore.rules` del repo raíz):

- `exam_results/{id}`: mismo esquema que la web; la app añade `respuestas`, `origen`, `tipo`.
- `progress/spaced_repetition`: mismo formato que `localStorage.vgm_spaced_repetition` de la web.
- `progress/settings`: temas estudiados/en repaso, recordatorio, tema.
- `progress/plan`: fechas de los ejercicios, hitos y horario.
- `cantes/{id}`: cantes programados y hechos (diario). El borrado es lógico (`borrado: true`). Los que programa o valora un preparador enlazado llevan `preparador` (su uid) y `preparadorNombre`.
- `progress/preparador`, `alumnos/{id}` y `sesiones/{id}`: perfil de preparador (código), sus alumnos y sus sesiones de cante.
- `preparadores/{uidPreparador}`: preparadores a los que el usuario da acceso.
- `notes/{tema}`: nota libre (`texto`) y agenda del tema (`pendientes`, `vueltas`).

## Varias oposiciones

La app sirve a dos oposiciones independientes, TCEE y DCE (Diplomado Comercial del Estado), cada una con su web (de la que sale el contenido), su examen, los datos de sus opositores y su red de preparadores con sus administradores. Una oposición con `lanzada: false` solo la ven, en *Más → Ajustes → Oposición*, sus administradores y el administrador general (`oposicionesVisiblesProvider`), para probarla antes de lanzarla. El opositor la elige al abrir la app por primera vez (`features/inicio/elegir_oposicion.dart`) y la cambia en *Más → Ajustes → Oposición* (`cambiarOposicionProvider`, que vuelve a crear los servicios en `RaizApp` de `main.dart`). Lo que necesita la web de DCE y los pasos del lanzamiento están en [`DCE.md`](DCE.md).

- **Descripción de cada oposición**: `data/models/oposicion.dart` (`Oposicion`, `EjercicioDef`, `Oposiciones.todas`). Lleva la web y las rutas del contenido, los ejercicios (cuáles se cantan, si es un dictamen sin temas, cuáles tienen sorteo, temas por parte, partes que hay que desarrollar, PDF por parte, qué se intercala en el cronograma) y, si su examen no tiene test, de qué oposición se practica el test de forma voluntaria (`testDe`). Las pantallas no llevan números de ejercicio fijos: los sacan de aquí.
- **La oposición elegida** se guarda en la caja Hive `app` (`oposicion`). Con ella `main()` crea los servicios y fija `Oposiciones.actual`; no cambia con la app abierta (`oposicionProvider` en los widgets). Las reglas del sorteo de `app-config.json` → `sorteo`, si las trae la web de esa oposición, mandan sobre las del examen (`Oposicion.bolasPorParte`).
- **Datos separados**: los de TCEE siguen donde estaban (`users/{uid}/…` y cajas Hive sin sufijo); los de otra oposición van en `users/{uid}/oposiciones/{id}/…` y en cajas con sufijo (`cantes_dce`); los PDF descargados, en su carpeta (`Oposicion.raizUsuario`, `Oposicion.caja`). La web hace lo mismo con `docUsuario` y `OPOSICION_WEB` de `firebase-config.js`.
- **Red de preparadores por oposición**: TCEE en las colecciones de la raíz y las demás en `oposiciones/{id}/…` (`Oposicion.red`), cada una con sus `admins`. Un preparador de las dos se verifica en cada una y tiene un código por oposición. `firestore.rules` se genera con `tool/reglas/generar.py` (ver su README).

## Cronograma

`data/models/cronograma.dart`, `features/cronograma/` (`planificador.dart` es la lógica pura, probada en `test/cronograma_test.dart`) y `core/cronograma_providers.dart`. Una vuelta al 3.º o al 4.º, con todos los temas o una selección, a N temas por semana o hasta una fecha (una sale de la otra), con semanas de descanso. Solo hay uno activo; al empezar otro, el anterior se archiva.

- **Orden sugerido** (`ordenSugerido`): los bloques del PowerPoint en su orden, eligiendo como siguiente el más conectado con lo ya puesto, y dentro de cada bloque un recorrido por las conexiones entre sus temas. El opositor lo reordena a mano (`ReordenarTemasPage`). No se reintroduce un reparto genérico: el anterior se retiró por ignorar bloques y conexiones.
- **Intercalado** (activado por defecto): en el 3.º, los temas de Mixto (historia, pensamiento, organismos internacionales y UE, más memorísticos) se reparten entre los demás en proporción a su peso (≈1 de cada 4) o «1 de cada N»; en el 4.º, se alternan las dos partes.
- **Hecho = estudiado + vuelta**: marcar un tema lo da por estudiado y anota una vuelta en su agenda; una vuelta anotada desde el tema también cuenta. Desmarcar no borra la vuelta (`desmarcados`).
- **Día de cante** (`Cronograma.diaCante`): el opositor elige qué día canta y la fecha del primer cante de la vuelta. Cada semana del cronograma va del día siguiente a un cante hasta el cante siguiente (`inicioSemana`), así que sus temas son los de ese cante, y los cálculos (ritmo, fin, retraso) cuentan cantes. Sin día fijo, semanas de lunes a domingo (como los cronogramas anteriores).
- **Retraso**: lo de semanas pasadas sin hacer. `replanificarCronograma` reparte lo pendiente desde esta semana manteniendo la fecha de fin (sube el ritmo) o el ritmo (se retrasa el fin). En Hoy, la tarjeta «Esta semana te toca».
- **Preparador**: el opositor puede compartirlo (desactivado por defecto). El preparador enlazado lo ve en la ficha del alumno y puede proponer otro ritmo, fecha u orden con una nota (`propuesta`), que el alumno acepta o rechaza. Firestore: `users/{uid}/cronogramas/{id}`; el preparador solo lee si `compartir == true` y solo escribe `propuesta` firmada por él.

## Proceso selectivo

El Ministerio publica cada proceso en `portal.mineco.gob.es/…/empleo/Paginas/OEP{año}TECOS.aspx` (TCEE) y `OEP{año}DIPLOS.aspx` (DCE): convocatoria, inscripción, admitidos, cronograma, convocatorias y aprobados de cada ejercicio. `scripts/leer-proceso.py` prueba el año siguiente, el actual y los anteriores, se queda con las dos convocatorias más recientes y deja sus documentos (apartado, título, enlace y día en que aparecieron) en `oposicion/proceso.json`; lo ejecuta la acción `.github/workflows/leer-proceso.yml` cada 2 horas (de 7 a 23 h). El servidor del Ministerio no envía su certificado intermedio, así que el script añade el de `scripts/certs/`; por eso (y por CORS en el navegador) la app no lee el portal directamente.

En la app (`data/models/proceso.dart`, `features/plan/proceso_page.dart`, `core/avisos_proceso.dart`): Organización → Proceso selectivo, con lo último arriba y todo por apartados; tarjeta en Hoy durante una semana; y, para quien lo activa (apagado por defecto), un aviso por documento nuevo que abre la página oficial. La primera vez se da por visto lo que ya había (`novedadesProceso`). En Android lo comprueba también la tarea en segundo plano, que ya no exige cuenta. No se envía nada del usuario: solo se descarga el JSON público.

## Mapa de calor

`features/organizacion/dominio_tema.dart` (lógica pura, `test/mapa_calor_test.dart`) y `mapa_calor_page.dart`. Cada tema del ejercicio, más intenso cuanto mejor se lleva, con cuatro vistas: **dominio** (estudiado 30 %, cantes 40 %, test 15 % y frescura del último repaso o cante 15 %; lo que falta cuenta como regular si el tema está estudiado, así que solo marcarlo lo deja a medias; sin nada, gris), **cantes** (valoración media), **test** (acierto en las preguntas del tema, con al menos 3) y **repaso** (frescura: la mitad a los 30 días). Al tocar un tema, el desglose y «Abrir el tema» o «Cantarlo». El preparador ve el de cada alumno con lo que este comparte.

## Widget de Android

`home_widget`: `core/widget_inicio*.dart` (no hace nada en el navegador), `core/widget_providers.dart` y, en Android, `WidgetTcee.kt`, `res/layout/widget_tcee.xml` y `res/xml/widget_tcee_info.xml`. Muestra la cuenta atrás al próximo ejercicio, el próximo cante (o clase, al preparador), la semana del cronograma y si el test diario está hecho. La app guarda las fechas en bruto cuando cambian (`datosWidgetProvider`) y el widget calcula los días y el «hoy»/«mañana» (se redibuja cada 30 min). Cada zona abre su pantalla (`tcee://widget/…`, en `_desdeWidget` de `app.dart`).

## Directorio de preparadores

Los preparadores pueden poner su perfil de LinkedIn (ajustes de preparador y solicitud de verificación; `enlaceLinkedin` lo deja en la forma `https://www.linkedin.com/in/…`, y las reglas solo aceptan esa forma). También cómo dan clase (online, presencial o las dos) y su ciudad (`modalidad`, `ciudad`; en el alta y en los ajustes, que además dejan cambiar los ejercicios; las reglas los validan con `fichaValida`). Sale en el directorio de preparadores verificados (`features/preparador/directorio_page.dart`; el alumno llega desde *Más → Mi preparador → Preparadores verificados* y el preparador desde *Más → Preparador → La red de preparadores*), filtrable por ejercicio, modalidad y ciudad, en la lista al pedir una clase suelta y en las solicitudes de verificación. **Orden** (`directorioOrdenadoProvider`): primero los preparadores del usuario, luego aquellos con los que ya ha tenido clase (fueron su preparador o le cogieron una clase suelta), luego los autoverificados (quienes administran la red, sin llamarlos así: son los únicos con `avaladoPor == uid`) y el resto al azar, con el mismo orden mientras dura la sesión.

## Red de preparadores

`data/models/red.dart`, `data/repos/red_repo.dart`, `core/red_providers.dart` y `features/preparador/` (semana, sustituciones, reservas, verificación, ajustes). Colecciones fuera de `users/{uid}` y sus reglas, en `firestore.rules`:

- **Verificación** (`admins/{uid}`, `preparadoresVerificados/{uid}`, `solicitudesPreparador/{uid}`). Para tener código de alumnos, ver el tablón de sustituciones, publicar huecos y verificar a otros hay que estar verificado. Verifica el administrador o un preparador ya verificado, nunca uno mismo; queda registrado quién avaló a quién, y el administrador puede retirar a alguien (`activo: false`), también en cadena. Si se retira a alguien, sus alumnos enlazados dejan de compartir con él (`esPreparadorDe` exige la verificación). Los administradores se crean a mano en la consola: un documento `admins/{uid}` (o con el correo como ID) en TCEE y `oposiciones/{id}/admins/{…}` en las demás. Con el campo `general: true` en `admins/` de la raíz, es **administrador general**: lo es de todas las oposiciones y ve las que aún no se han lanzado. El administrador se verifica a sí mismo desde la app (*Preparadores → Administración → Verificarme*).
- **Sustituciones** (`sustituciones/{id}` y `privado/{alumno|preparador}`). El alumno pide que le cojan un cante (desde un cante cancelado por su preparador o desde cero), a todos los verificados o a los que elija. Da un día y una franja de horas (`fecha`–`hasta`) o una hora fija, y elige los temas que lleva; no se pide duración. Quien la coge elige la hora (`hora`) dentro de la franja, y las reglas comprueban que cae dentro. Hay cantes del 1.er ejercicio (dictamen de coyuntura, sin temas), del 3.º y del 4.º; el 5.º no se canta. Las solicitudes de verificación pueden ir a un preparador concreto (`destinatario`): solo la ven él y el administrador. Los preparadores ven día, horas, ejercicio, temas y nota; el nombre y el teléfono del alumno, solo quien la coge, que deja los suyos. Coger es una transacción (gana el primero). El cante pasa a la semana del sustituto (alumno «suelto»: con el uid del alumno pero sin enlace, `Alumno.suelto`, y con su teléfono) y a la agenda del alumno (`sust_{id}`, firmado por el sustituto). Desde la 1.15.0 el sustituto puede cambiar esa clase (hora, enlace, cancelación) y le llega al alumno: las reglas (`esSustitutoDe`) le dejan escribir `users/{alumno}/cantes/sust_{id}` y usar su cronómetro y su pizarra. WhatsApp con `wa.me`.
- **Buscar preparador** (`busquedas/{id}`, `busquedas/{id}/interesados/{uid}`, `plazas/{preparador}`; `features/preparador/buscar_preparador_page.dart`, `busquedas_page.dart`, `disponibilidad_widget.dart`). Dos caminos: el preparador dice en Ajustes si **admite alumnos nuevos** (desde cuándo, su disponibilidad por tramos de la semana —`claveTramo`, «2-t» = martes por la tarde—, un mensaje y si deja su teléfono), y eso solo lo pueden leer los opositores (`!esVerificado`): los demás preparadores no ven si alguien tiene hueco. Y el opositor **cuenta lo que busca** (ejercicio, online/presencial y ciudad, disponibilidad, clases por semana, cuántos temas lleva, desde cuándo —puede ser dentro de unos meses— y una nota), sin nombre ni teléfono (`busquedaValida` lo exige), que ven los preparadores verificados en su tablón; si a uno le interesa, deja su contacto en `interesados/{uid}` (solo lo lee el opositor) y el opositor recibe aviso. **Siempre escribe el opositor** (WhatsApp o LinkedIn); el preparador no puede contactarle. Nada crea relación en la app: el enlace se hace después con el código. `compatibilidad()` (0-100, interno: en pantalla solo sale «Encaja mucho / Encaja / Encaja poco / No encaja», nunca un número, para que nadie lo tome por una nota) ordena: 0 si no prepara el ejercicio o no encajan online/presencial-ciudad; suma por modalidad, por tramos en común y resta si el preparador empieza mucho después. Sin precios ni nada mercantil. Avisos `busq:` (al preparador, si encaja) e `int:` (al opositor).
- **Huecos y reservas** (`huecos/{preparador}`, `reservas/{id}`), desactivado por defecto. El preparador publica sus huecos semanales y las horas ocupadas (sin nombres); sus alumnos enlazados piden un hueco y él la acepta (se crea la sesión) o la rechaza.
- **Clases fijas** (`Alumno.clasesFijas`): generan las sesiones de las seis semanas siguientes, con un id por día, así que no se duplican ni vuelven si se borran.
- **Avisos**: `core/avisos_red.dart` comprueba lo nuevo al sincronizar (cada 3 min con la app abierta) y lo notifica una vez (`core/vistos.dart`). En Android, además, una tarea de WorkManager lo comprueba cada ~15 min con la app cerrada (`core/avisos_fondo_io.dart`), y avisa también de las versiones nuevas (`core/avisos_version.dart`). En el navegador, notificaciones del navegador con la pestaña abierta. Cada aviso lleva su destino (`AvisoRed.ruta`): al tocarlo (o con «Ver») se abre la clase, el tablón, la semana, Mi preparador…; el alumno recibe avisos distintos cuando el preparador le programa, **mueve** (`mov:`) o cancela una clase y cuando le comparte material (`mat:`).
- **Tiempo real para el alumno** (`PlanRepo.escucharCantesDePreparadores`, `CantesNotifier.escucharNube`): con la app en primer plano escucha `users/{uid}/cantes` con `preparador`, así que un cambio de hora o una cancelación se ve al momento. Las clases canceladas que vienen se enseñan como tales en Hoy y en la agenda (`canceladasProximasProvider`), con la opción de pedir una clase suelta; el alumno no edita las clases del preparador (así su copia nunca pisa la de él).
- **Copias que no llegan**: `PreparadorRepo._copiarAlAlumno` anota las que fallan (`copiasPendientes`, con el motivo) y las reintenta al sincronizar; `_traerCambiosDeAlumnos` concilia además en los dos sentidos (vuelve a copiar lo mío si falta o es más antiguo en la agenda del alumno). La ficha de la clase muestra el estado real («En la agenda del alumno», «Pendiente de llegar…») con «Reintentar».
- **Temas antes de la clase** (`features/preparador/tema_anticipado.dart`): el preparador manda a su alumno uno o dos temas (`Cante.numTemas`, por defecto `PerfilPreparador.temasPorClase`, que si no se ha fijado es `Oposicion.temasPorClase`: 1 en TCEE, 2 en DCE), elegidos por él o sacados a suerte entre los que lleva el alumno (que ni él ve hasta la hora; con «uno de cada parte», `unoPorParte`, como en el examen; `Sorteo.sortearClase`), con antelación (la del examen para esos temas: 45 min para dos en TCEE, 30 en DCE; `PerfilPreparador.antelacionTema`) o a una hora concreta. La copia de la clase solo lleva `temaA` (la hora); los temas van en `temasAnticipados/{id}` (`temas`, `titulos`; `tema` y `titulo` para las versiones anteriores), fuera de los datos del alumno, y las reglas no dejan al alumno leerlos antes de `visibleDesde` ni listarlos. A su hora llegan como un mensaje del preparador (`Notificaciones.avisoTema`, con la cuenta atrás del esquema desde esa hora, `usesChronometer`) con «Empezar el esquema», que abre Cantar con esos temas y **arranca** el cronómetro (`arrancarEsquemaProvider`); el preparador recibe a esa misma hora un aviso programado con la misma cuenta atrás (`_programarEntregasDeTemas`). También se mandan en una clase suelta (`esSustitutoDe` en `temasAnticipados`). Si el alumno estaba apuntado a mano y luego enlaza su app, las dos fichas se unen solas por correo o nombre (`unirAlumnos`) o a mano desde la ficha («Unir»). El alumno no sortea en una clase del preparador: en la clase ve «Cantar los temas» (o «Cronometrar») y en Cantar se ocultan las bolas; el preparador, en la ficha de la clase, tiene como acción principal mandar los temas (sin sorteo desde la ficha) y, llegados, «Cantar los temas mandados». Si se mueve la clase, el envío (relativo a ella) se mueve con ella. En Android, una tarea puntual de WorkManager a esa hora (`programarTemasAnticipados`) y la periódica de respaldo; en el navegador, al sincronizar con la app abierta (`core/temas_anticipados.dart`).
- **Cronómetro compartido** (`features/cantar/reloj_compartido.dart`): en una clase, el alumno y su preparador comparten el reloj (`cantes/{id}/reloj/estado` en los datos del alumno), juntos o a distancia; el estado es «tiempo acumulado en tal instante del servidor» y cada dispositivo corrige su desfase al unirse. Lo maneja cualquiera. La pantalla grande (`reloj_grande_page.dart`) lo muestra a pantalla completa.
- **Pizarra compartida** (`features/cantar/pizarra_trazos.dart`, `pizarra_compartida.dart`, `pizarra_page.dart`): en una clase, un lienzo en blanco (virtual, 1600×1000, apaisado) en el que dibujan el alumno y el preparador, cada uno con su color, y lo que pinta uno le llega al otro al instante; solo se comparte lo que se dibuja, nada más del móvil, y sirve en el móvil, la tableta y el navegador (con Meet o Teams a la vez). Vive en `cantes/{id}/pizarra/{p1…p10}` en los datos del alumno, una página por documento con los trazos en una lista (`{i, u, g, p}`; los puntos, simplificados con Ramer–Douglas–Peucker y codificados como diferencias, 4-6 bytes por punto); los trazos terminados se suben en ráfagas de 300 ms (una escritura por ráfaga, nunca por punto), deshacer es `arrayRemove` del elemento exacto y «borrar todo» vacía la página. A 700 KB la página se bloquea («abre otra»). Las mismas reglas que el reloj (`match /{compartido}/{doc}`). Se abre desde la ficha de la clase (los dos) y desde Cantar. En la consola conviene una exención de índice de campo único para `pizarra` → `trazos` (ver `tool/reglas/README.md`).
- **Materiales** (`materiales/{id}` en la red; `MaterialCompartido` en `data/models/red.dart`, `RedRepo.guardarMaterial/materialesDe/materialesParaMi`, `features/preparador/materiales_page.dart`): el preparador verificado comparte enlaces (Drive, PDF en la web, vídeos…) con título, nota y, si va de un tema, el tema, para todos sus alumnos enlazados o para algunos (`paraTodos`, `alumnos`). Sin Storage: solo enlaces. El alumno los ve en *Mi preparador* y dentro del tema (`tema_page.dart`), y recibe un aviso. Las reglas (`materialValido`) exigen enlace http(s) y solo dejan al alumno listar con las dos consultas (`preparador == X` y `paraTodos`, o `alumnos` contiene su uid). Se borran con la cuenta (`romperTodosLosEnlaces`).
- **Recordatorios de clases** del preparador (víspera, 1 h, 30 o 15 min antes; `PerfilPreparador.avisosClase`, `Notificaciones.programarClases`).
- **Colores**: cada alumno y cada preparador tienen su color (`colorDePersona`); en la agenda del alumno se puede filtrar por preparador.

Las reglas se generan y se prueban con el emulador: `tool/reglas/` (ver su README).

## Cantes presenciales u online

Cada cante (y cada clase de un preparador) puede ser presencial, con el lugar, u online, con el enlace de la videollamada (`Cante.modalidad`, `lugar`, `enlace`; `features/plan/modalidad.dart`). El preparador elige la videollamada que propone, **Google Meet o Microsoft Teams** (`PerfilPreparador.plataforma`, y por clase `Cante.plataforma`; si no se dice, se deduce del enlace, `plataformaDeEnlace`); el alumno solo ve «Entrar a la clase (Meet/Teams)». «Crear reunión en Meet» abre `meet.google.com/new` y «…en Teams», `teams.live.com/meet` (Teams personal; con cuenta del trabajo se crea en Teams y se pega); al volver a la app con el enlace copiado se pega solo (`SelectorModalidad` mira el portapapeles al reanudar), y también hay botón de pegar (`enlaceReunion` acepta cualquier enlace). La ficha de la clase (`sesion_page.dart`) cambia todo esto al momento, sin pasar por el formulario: día y hora, duración, presencial u online, temas que se cantan, exposición por tema. Sin permisos extra de Google ni servidor. El enlace va en la copia del cante que llega al alumno, en el aviso de una hora antes, en Google Calendar y en el `.ics` (`LOCATION`), y la ficha del cante tiene «Entrar a la clase», «Copiar enlace» y, en la sesión del preparador, «Enviar por WhatsApp» al alumno. Las peticiones de sustitución dicen si son presenciales, online o «me da igual», y el cante del sustituto lo hereda.

## Google Calendar y Meet (preparadores, en pruebas)

En *Preparador → Ajustes → Google Calendar*, el preparador conecta su calendario (permiso `calendar.events`, solo en Android). Desde entonces cada clase que guarda va a su Google Calendar por la API, desde el móvil y sin servidor (`lib/data/repos/calendario_google.dart`): si es online y sin enlace se crea la reunión de Meet (su enlace vuelve a la clase y llega al alumno), y el alumno va como invitado con su correo (el de su cuenta al enlazar, `Alumno.email`, o el que apunte el preparador en la ficha). Cambiar la clase cambia el evento; cancelarla o borrarla lo borra (Google avisa al alumno). Va en segundo plano y por orden por clase (`PreparadorRepo.llevarAlCalendario`), con una huella para no volver a mandar lo que no cambia.

Mientras Google no verifique el permiso, la opción solo funciona para las cuentas apuntadas en Firestore en `pruebasCalendario/{correo o uid}` (raíz; la crea el administrador en la consola); a los demás preparadores verificados la tarjeta les dice por qué no pueden todavía (`PermisoCalendario`: no en la lista, sin permiso de lectura —reglas sin publicar—, sin red). El último error de Google se guarda (`CalendarioGoogle.ultimoError`, en la caja `app`) y se enseña entero en Ajustes y en la fila «Google Calendar» de la ficha de la clase, que permite reintentar; las clases que llegan por sincronización de otro dispositivo también se llevan al calendario (`PreparadorRepo.sincronizarTodo`). Con Teams no se pide reunión de Meet: el enlace de Teams va en el evento. Hace falta además, en Google Cloud (proyecto `web-vgm`): la **Google Calendar API** activada y el permiso `.../auth/calendar.events` añadido a la pantalla de consentimiento OAuth.

## Sincronización y privacidad

Sin cuenta, todo vive en Hive (en el navegador, IndexedDB). Con cuenta, cada repositorio sube lo que cambia en cuanto se guarda y `sincronizarTodo` fusiona nube y local (por elemento y por `updatedAt`); «Sincronizar ahora» (Cuenta) lee del servidor (`Source.server`) y dice si no ha podido. Se sincroniza al arrancar, al iniciar sesión, al volver a la app (`AppLifecycleListener` en `app.dart`) y, con la app abierta, cada 3 minutos (`SesionNotifier.sincronizarSiToca`, como mucho una vez por minuto). Así lo que se hace en el móvil aparece en el ordenador, lo que programa el preparador llega al alumno y lo que el alumno cambia en una sesión (hora, notas, valoración) vuelve al preparador (`_traerCambiosDeAlumnos`, que conserva el alumno, el título y el borrado del lado del preparador).

Privacidad, tal como se explica en la app (`TarjetaPrivacidad` en Cuenta), en `index.html` y en la política: los datos de cada cuenta solo los puede leer esa cuenta (`firestore.rules`), salvo lo que el alumno comparte con el preparador que elige; ni otros opositores ni otros alumnos del mismo preparador ven nada. Las grabaciones no salen del dispositivo. «Borrar todos mis datos» (Cuenta) rompe los enlaces, libera el código de preparador y borra `users/{uid}/…` entero (`PreparadorRepo.romperTodosLosEnlaces` + `UsuarioRepo.borrarTodoEnLaNube`).

## Duración de las clases y exposición

`Cante.minutos` es lo que dura la clase o el cante (lo que ocupa en la agenda, la semana y el calendario): 30 min en un cante por cuenta propia y, en las clases del preparador (nuevas, fijas, huecos para reservas y clases sueltas), `PerfilPreparador.minutosClase` (2 h por defecto; Ajustes → «Duración habitual»). Aparte, `Cante.exposicion` son los minutos de exposición por tema que cuenta el cronómetro (30 por defecto). `textoDuracion` escribe «2 h», «1 h 30 min»; las listas de opciones están en `cantes_util.dart` (`duracionesClase`, `duracionesCante`, `duracionesExposicion`).

## Avisos y permisos del sistema

La primera vez que se abre la app (y la primera con la 1.15.0) una hoja (`features/inicio/permisos_sheet.dart`) explica para qué son los avisos y pide el permiso de notificaciones y, en Android 12+, el de alarmas exactas. Cada interruptor de avisos pasa por `asegurarAvisos(context)`, que pide el permiso y, si el sistema lo tiene denegado, lo dice con un botón a los ajustes de la app (`core/permisos.dart` → canal `es.victorgutierrezmarcos.tcee_app/sistema` en `MainActivity.kt`, que abre los ajustes de notificaciones o los de batería y dice si la app está exenta de la optimización). En Hoy sale una tarjeta si el sistema tiene las notificaciones desactivadas, y en Más → Ajustes, el estado y la batería. El recordatorio diario no se repite solo: se programa el siguiente en cada arranque, al sincronizar y al terminar el test diario, así que no llega si el test ya está hecho.

## Actualizaciones

`core/actualizaciones.dart`: con la app instalada desde Google Play, al detectar una versión nueva (`actualizacionProvider`, por `app-config.json`) se ofrece la actualización dentro de la app (`in_app_update`, flexible: se descarga mientras se usa y se instala al aceptar; el botón «Actualizar» de la tarjeta de Hoy la hace inmediata). Instalada desde el APK, Play no la conoce (`ERROR_APP_NOT_OWNED`) y queda la tarjeta con la descarga; además la tarea en segundo plano avisa una vez por versión nueva (`core/avisos_version.dart`, al tocar se abre Play o el APK).

## Preparadores

`data/repos/preparador_repo.dart` y `features/preparador/`. Cada papel tiene su pantalla:

- **Preparador** (`preparador_page.dart`, *Más → Preparador*): sin alta, presenta la sección y lleva a `AltaPreparadorPage`, que fija el papel y pide la verificación en un solo paso. Ya dado de alta, por grupos: estado y código, tus clases (semana; cada clase es un `Cante` con `alumno`, una por alumno aunque se programen en grupo), tus alumnos (enlazados o a mano; ficha con temas, cantados y flojos, historial, notas privadas, clases fijas, sacar bola con `CantarPage(sesion: …)`, valoración e informe), clases sueltas (tablón), la red (directorio, verificar, gestionar) y ajustes. Funciona sin cuenta, en local.
- **Mi preparador** (`mi_preparador_page.dart`): el opositor escribe el código de seis caracteres de su preparador (`codigos/{codigo}` → uid). Al conectar crea `users/{alumno}/preparadores/{preparador}` (el permiso) y `preparadores/{preparador}/alumnos/{alumno}` (para que el preparador lo vea en su lista). Desde entonces el preparador lee `users/{alumno}/progress/settings` (temas estudiados y en repaso) y `users/{alumno}/cantes`, y cada clase que guarda se copia a `users/{alumno}/cantes/{id}`: aparece en la agenda del alumno y, una vez valorada, en su diario. No se comparten tests, notas ni grabaciones. Cualquiera de los dos puede romper el enlace. Desde aquí también se pide una clase suelta, se reserva clase, se ve el directorio y los materiales que comparten los preparadores. En *Cantes → Agenda*, el botón «Añadir» (`features/cantes/nuevo_cante_sheet.dart`) ofrece lo mismo explicado: un cante por mi cuenta, reservar clase con mi preparador o pedir una clase suelta; cada subpestaña de Cantes lleva una tarjeta de ayuda que se cierra (`ayudaVistaProvider`) y vuelve con el icono de ayuda de la barra.

En la interfaz se dice «clase» (nunca «sesión») y «clase suelta» (nunca «sustitución»); los identificadores internos (`Sesion…`, `sustitucion`) no cambian.

El enlace exige que ambos hayan iniciado sesión con Google y que las reglas de `firestore.rules` estén aplicadas en la consola de Firebase. `test/preparador_test.dart` comprueba el flujo completo con Firestore simulado; las reglas no se pueden probar ahí (el simulador no admite funciones), así que hay que verificarlas con dos cuentas reales.

## Versión web

La misma app compilada con `flutter build web`. Diferencias, todas resueltas con `kIsWeb` o con importaciones condicionales (`core/plataforma.dart`, `data/repos/descargas_repo.dart`):

- Firebase se inicia con `opcionesFirebaseWeb` (la app web de `web-vgm`, la misma de `firebase-config.js`) y el inicio de sesión es `signInWithPopup`. Como comparte origen con la web, si ya se ha entrado en victorgutierrezmarcos.es suele estar dentro sin volver a iniciar sesión.
- El contenido se pide al mismo origen (`Urls.base` = `Uri.base.origin`), sin cabeceras propias: así no hay peticiones entre dominios. En pruebas locales se lee el repositorio servido en localhost.
- **Avisos del navegador** con la web abierta (aunque esté en otra pestaña): los mismos que en el móvil (recordatorio diario, cantes, clases, temas mandados, cronómetro, red, proceso). `Notificaciones` los manda a `core/avisos_navegador_web.dart` → `window.avisosApp` (`web/index.html`), que los muestra con el service worker `web/avisos-sw.js` (sin caché; al tocar un aviso enfoca la pestaña o abre la app en `?aviso=…` y va a su pantalla); los programados van con temporizadores. Con la web cerrada no llegan (haría falta push con servidor). `index.html` quita además cualquier service worker antiguo y sus cachés, y la app compara su huella con la de `version.json` (la pone `publicar-app-web.py`, se pide sin caché) para ofrecer «Recargar» en Hoy cuando hay otra versión publicada. Los PDF se leen en memoria con pdf.js (cargado en `web/index.html`; su versión debe coincidir con la de `pdfx`), sin descargas para leer sin conexión. La grabación usa el primer formato que admita el navegador y vive en memoria. El `.ics` y la exportación JSON se descargan; los textos para compartir se copian al portapapeles.
- En pantallas de 720 px o más el menú pasa a un raíl lateral (con la foto de la cuenta arriba) y la app ocupa toda la pantalla: `ListaAdaptable` (widgets/comunes.dart) reparte las secciones de cada página en dos columnas a partir de 900 px, o centra la página si tiene una sola sección.

Publicar una versión nueva (cada vez que cambie `lib/` o `web/`):

```bash
python3 scripts/publicar-app-web.py   # desde la raíz: compila y copia a app/abrir/ (~9 MB)
```

y subir `app/abrir/`. El motor gráfico (canvaskit) no se copia: lo sirve www.gstatic.com. El script renombra `main.dart.js` con una huella de su contenido (`main.<huella>.dart.js`) y la añade a `flutter_bootstrap.js?v=` en `index.html`: GitHub Pages deja guardar los ficheros 10 minutos y, con el nombre fijo, el navegador podía seguir con la versión anterior.

## Diseño

Modo claro por defecto; el botón de sol y luna de la cabecera (`BotonTema`, en todas las pantallas) y *Más → Ajustes → Modo* cambian entre claro y oscuro. En oscuro, el lila (`dPrimario`) es para texto e iconos, y los rellenos con texto blanco (cabecera, botones, menú, selectores) usan `dRelleno`, con contraste de 7:1. La foto de la cuenta de Google sale en Hoy, Más, Cuenta y el raíl (`AvatarUsuario`).


La app reproduce la estética de la web (`styles.css` y los estilos de `simulador.html`):

- Tipografías incluidas en `assets/fonts` (no se descargan en tiempo de ejecución): TeX Gyre Pagella, equivalente libre de Palatino, para títulos y texto, y Source Sans 3 para la interfaz.
- `BarraWeb`: cabecera con degradado morado, título en blanco y línea dorada (`.site-header`). `TituloSeccion`: título morado con subrayado y rombo (`.section-title`). `Tarjeta`, `GrupoDesplegable` (`.tema-group-header`), `Contador` y `Estadistica` replican las cajas de la web y del simulador.
- El menú inferior sigue el de la web: etiquetas en mayúsculas y la sección activa en blanco sobre morado.

Sin blog: la app no enlaza ni muestra artículos. Sin cronograma: el reparto automático de temas se retiró; cuando se rehaga deberá apoyarse en los bloques y conexiones de la organización del temario.

## Organización del temario

`data/models/estructura.dart` lee `estructura_temario.json`. El código de colores es el del PowerPoint: catorce bloques en el tercer ejercicio (Microeconomía, Macroeconomía y Mixto), y rosa y morado para las dos partes del cuarto. `CasillaTema` pinta el código de un tema sobre el color de su bloque en el temario, la agenda de cada tema, el sorteo y los esquemas. `EsquemaVista` dibuja las casillas en la posición que tienen en la diapositiva, con sus marcos y flechas; al tocar un tema o un bloque se resaltan sus conexiones. «Por dónde seguir» propone los temas aún no estudiados que conectan con alguno ya estudiado.

## Probabilidades (réplica del Excel de organización)

`features/cantar/sorteo.dart` reproduce las hojas «Ej. 3», «Ej. 4», «Ej. 5» y «Probabilidad de aprobar» de `oposicion/organizacion/preparacion_oposicion_tcee.xlsm`, y `test/sorteo_test.dart` lo comprueba contra la fórmula literal de la hoja:

- Tercer y cuarto ejercicio: salen 2 temas de cada parte; probabilidad de una parte `x/N + (N−x)/N · x/(N−1)` y del ejercicio `P(A) · P(B)`. Rendimiento por tema, nivel de eficiencia y consejo de cambiar un tema de parte.
- Quinto ejercicio: un tema por parte y se desarrollan dos de los tres, así que cuenta el mejor par de partes.
- Las bolas por parte se pueden cambiar sin republicar en `app-config.json` → `sorteo`.

## Puesta en marcha

1. Instalar [Flutter](https://docs.flutter.dev/get-started/install) (stable) y Android Studio. Comprobar con `flutter doctor`.
2. `cd app && flutter pub get`. Las carpetas nativas ya están en el repositorio.
3. Firebase (consola del proyecto **web-vgm**). Sin este paso la app funciona, pero sin inicio de sesión:
   - Añadir app Android con id `es.victorgutierrezmarcos.tcee_app` y las huellas SHA-1 y SHA-256 de la clave de firma (`keytool -list -v -keystore android/tcee-upload.jks`). Descargar `google-services.json` a `android/app/`.
   - Añadir app iOS con bundle id `es.victorgutierrezmarcos.tceeApp`. Descargar `GoogleService-Info.plist` a `ios/Runner/` y añadir a `ios/Runner/Info.plist` el `CFBundleURLTypes` con su `REVERSED_CLIENT_ID` (Google Sign-In).
   - En Authentication → Google debe estar habilitado (ya lo está para la web).
   - Aplicar `firestore.rules` (Firestore → Reglas) si aún no están.
   Estos ficheros están en `.gitignore`; no se suben al repositorio.
4. Firma de Android: `android/key.properties` y el almacén `android/tcee-upload.jks` (ambos fuera del repositorio; **guardar copia**, porque es también la clave de subida a Google Play). Con ellos se firman las compilaciones de depuración y de publicación, de modo que la huella registrada en Firebase no cambia. Sin ellos se usa la clave de depuración de cada máquina y el inicio de sesión con Google no funcionará.
   ```
   storeFile=tcee-upload.jks
   storePassword=…
   keyAlias=tcee
   keyPassword=…
   ```
5. Ejecutar: `flutter run` (emulador Android o dispositivo), o `flutter build apk --release` para obtener `build/app/outputs/flutter-apk/app-release.apk`.

Para regenerar el icono: `dart run flutter_launcher_icons`.

## Comprobaciones

```bash
flutter analyze
flutter test
```

`test/app_test.dart` arranca la app completa sin Firebase ni red, con el `temario.json` y el `app-config.json` reales del repositorio, comprueba el diseño de ordenador (raíl y 1000 px) y recorre los cinco bloques y los flujos principales (programar un cante, sortear, cronometrar, guardar en el diario, hacer un test completo, agenda por tema, alta de un alumno y sesión de preparador).

Pruebas manuales en el móvil: programar un cante semanal y recibir el aviso; sortear y cantar con el cronómetro con la pantalla apagada; grabar y escucharse; apuntar algo en un tema y verlo al volver a abrirlo; hacer un test sin sesión, iniciar sesión y comprobar que aparece en el historial de la web y en `users/{uid}/exam_results`; modo avión con un PDF descargado; claro y oscuro.

## Capturas, vídeo y página de la app

```bash
flutter test tool/capturas_test.dart --update-goldens   # capturas en promo/capturas/ (no se suben)
python3 ../scripts/montar-video-app.py --ffmpeg RUTA     # promo/*.webp, promo/oposicion-tcee.mp4 y promo/poster.jpg
```

`tool/capturas_test.dart` arranca la app con datos de demostración ficticios y guarda cada pantalla a 1080 × 2340. `scripts/montar-video-app.py` (Pillow + ffmpeg) exporta las capturas ligeras que usa `index.html` y monta el vídeo de un minuto. Hay que repetir los dos pasos cuando cambie el aspecto de la app. Los datos de demostración y la navegación comunes están en `tool/demo_comun.dart`.

### Vídeos de ayuda

Once vídeos verticales de menos de un minuto (cómo se reserva una clase, la clase suelta, el cronograma, la clase con el preparador…), sin voz, con un rótulo por paso y un dedo que toca lo que se nombra. Están en `index.html#ayuda` («Cómo se usa») y la app los abre desde *Más → Ayuda en vídeo* y desde el botón ▶ de la cabecera de cada pantalla (`lib/features/mas/ayuda_videos.dart`, enlace `Urls.videoAyuda(id)` → `/app/#ayuda-<id>`).

```bash
flutter test tool/capturas_ayuda_test.dart --update-goldens          # promo/ayuda/capturas/<id>/ (no se suben)
python3 ../scripts/montar-videos-ayuda.py --ffmpeg RUTA [--solo ID]  # promo/ayuda/<id>.mp4 y <id>.jpg
```

Los cuatro de instalación (`instalar-android`, `-iphone`, `-windows`, `-mac`, con DCE elegida) no salen de un test sino de maquetas: `python3 ../scripts/maquetas-instalar.py` (usa las capturas de la app y `promo/ayuda/fuentes/instalar-movil.png`, una captura de `instalar.html` en el móvil); están en `#ayuda` y en `instalar.html`.

`tool/capturas_ayuda_test.dart` recorre cada vídeo tocando los botones de verdad y guarda, con cada pantalla, dónde se toca (`pasos.json`). Los guiones están en `promo/ayuda/GUIONES.md` y, como datos, en `VIDEOS` del script. Si se añade o cambia un vídeo, hay que tocar los tres sitios a la vez: el script, `videosAyuda` en `ayuda_videos.dart` y la sección `#ayuda` de `index.html`. Con poca memoria, mejor montar los vídeos de uno en uno (`--solo`).

## Frecuencia de temas en el test y probabilidad de aprobar

`oposicion/temario/primer-ejercicio/test/frecuencia_temas.json` dice cuántas preguntas tuvo cada tema en cada examen oficial del test. Se genera con `python3 ../scripts/frecuencia-test.py` a partir de `preguntas.json` y de `examenes_sin_texto.json` (exámenes clasificados de los que no está el texto); hay que repetirlo al añadir exámenes o cambiar temas. Lo usan la calculadora (`lib/features/organizacion/probabilidad_test*.dart`, igual que `oposicion/probabilidad-test.html` + `.js`), la ficha del tema, el mapa de calor («Lo que cae»), el simulador («N más preguntados») y el cronograma («Primero lo que más cae en el test»). Solo en TCEE.

## Compilación en GitHub Actions

`.github/workflows/build-app.yml` analiza, pasa los tests y compila el APK en cada tag `app-v*` (lo adjunta a una release) y en ejecución manual (lo deja como artefacto). Secretos opcionales:

- `GOOGLE_SERVICES_JSON`: `google-services.json` en base64.
- `KEYSTORE_BASE64` y `KEYSTORE_PASSWORD`: almacén `tcee-upload.jks` en base64 y su contraseña (alias `tcee`).

## Distribución del APK

El APK se publica como release `app-latest` del repositorio, y la web lo enlaza desde `urlApk`. Para publicar una versión nueva:

1. Subir `version` en `pubspec.yaml` (nombre y número de compilación), para que Android la acepte como actualización.
2. Compilar y sustituir el fichero de la release:
   ```bash
   flutter build apk --release
   cp build/app/outputs/flutter-apk/app-release.apk /tmp/oposicion-tcee.apk
   gh release upload app-latest /tmp/oposicion-tcee.apk --clobber
   ```
3. Poner esa versión en `app.versionActual` de `oposicion/app-config.json` y subir el cambio. Las apps instaladas con una versión anterior muestran entonces en Inicio el aviso «Hay una versión nueva», con un botón que abre la descarga (o la ficha de Google Play cuando exista `urlPlayStore`).

Las actualizaciones automáticas solo existen a través de las tiendas: al publicar en Google Play, es Play quien actualiza la app.

## Publicación

- **Android**: `flutter build appbundle --release` y subir a Play Console (25 $ una vez). Las cuentas personales nuevas deben pasar una prueba cerrada con 12 testers durante 14 días antes de producción. Al publicar, registrar también en Firebase la huella SHA-1 de la clave de firma de Google Play (Play Console → Integridad de la app).
- **iOS**: Apple Developer Program (99 $/año). Sin Mac se puede compilar y firmar con [Codemagic](https://codemagic.io) o con un runner macOS de GitHub Actions. Subir a TestFlight y enviar a revisión.
- Ficha: icono 1024 px, capturas (iPhone 6,7" y 6,5"; teléfono Android), descripción, URL de privacidad `https://www.victorgutierrezmarcos.es/politica-cookies.html`.
- La web muestra el aviso de descarga en la portada, en `oposicion/index.html` y en `app/index.html` (`app-banner.js`), y la guía paso a paso está en `app/instalar.html` (Android, iPhone y iPad desde Safari, ordenador). Sin `urlPlayStore` en `oposicion/app-config.json` se ve «Próximamente en Google Play» y el APK de `urlApk`. **El día que la app esté en Google Play basta con poner `urlPlayStore`** (`https://play.google.com/store/apps/details?id=es.victorgutierrezmarcos.tcee_app`): aparece el distintivo oficial (`app/promo/google-play-es.png`, que no se puede modificar ni usar antes de estar publicada), desaparece el APK y la guía avisa a quien tenía la versión descargada. Pasado un tiempo, poner `urlApk` a `null`.
