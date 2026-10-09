# Vídeos de ayuda: guiones

Vídeos verticales (1080 × 1920), de un minuto como mucho, sin voz. Cada paso es
una pantalla de la app con un rótulo grande arriba («2 · Elige un hueco») y un
dedo que toca el botón que se nombra. Las pantallas salen de
`app/tool/capturas_ayuda_test.dart` (datos de ejemplo) y el montaje, de
`scripts/montar-videos-ayuda.py`. El identificador de cada vídeo es el de su
fichero (`app/promo/ayuda/<id>.mp4`) y el ancla de la página
(`/app/#ayuda-<id>`).

## Para opositores

### reservar-clase · Reserva clase con tu preparador
1. En **Cantes**, toca **Añadir**.
2. Elige **Reservar clase con mi preparador**.
3. Toca uno de sus **huecos libres**.
4. Si quieres, deja una nota y toca **Pedir**.
5. Queda **pendiente de confirmar**: te avisamos cuando la acepte.
6. **Aceptada**: ya está en tu agenda, con cuenta atrás y aviso.

Cierre: «¿No ves huecos? Tu preparador tiene que abrir las reservas».

### clase-suelta · ¿Te cancelan? Pide una clase suelta
1. Si tu preparador cancela, lo ves en la clase. Toca **Pedir una clase suelta**.
2. Elige el día y una **franja de horas**.
3. Presencial, online o **me da igual**.
4. Revisa los **temas** que llevas.
5. Se la mandas a **todos los preparadores verificados**. Toca **Enviar la petición**.
6. Uno la coge: **te llega un aviso** con su nombre y la hora.
7. Escríbele por **WhatsApp** desde la clase.

Cierre: «Tu nombre y tu teléfono solo los ve quien la coge».

### conectar-preparador · Conecta con tu preparador
1. En **Más**, toca **Mi preparador**.
2. Escribe el **código de 6 letras** que te da tu preparador.
3. Toca **Conectar**.
4. Sus clases aparecen en tu agenda y sus valoraciones, en tu diario.
5. **Qué ve**: tus temas y tus cantes. Ni tus tests, ni tus notas, ni tus grabaciones.

Cierre: «Puedes dejar de compartir cuando quieras».

### buscar-preparador · Busca preparador
1. En **Más → Mi preparador**, toca **Buscar preparador**.
2. Mira quién **admite alumnos**: ejercicios, online o presencial y LinkedIn.
3. Toca **Cuenta lo que buscas**.
4. Ejercicio, cuándo puedes y desde cuándo. **Sin tu nombre ni tu teléfono.**
5. **Publicar**.
6. A quien le interese te deja su contacto y **te llega un aviso**. Le escribes tú.

Cierre: «Cuando os pongáis de acuerdo, conecta con su código».

### cronograma · Tu cronograma
1. En **Organización**, toca **Cronograma**.
2. **Crear un cronograma** → **Generarlo**.
3. Elige la **vuelta** (3.º o 4.º) y los temas.
4. El **ritmo**: temas por semana o fecha de fin.
5. La app propone el **orden** (bloques y conexiones del temario). **Crear el cronograma**.
6. En **Hoy** ves **lo que te toca esta semana**.
7. Marca cada tema al estudiarlo. Si te retrasas, la app lo **reparte**.

Cierre: «¿Ya tienes uno? Tráelo desde un Excel, un Word o un PDF».

### clase · La clase con tu preparador
1. En la clase, toca el **enlace de Meet** (o Teams) para entrar.
2. Si te ha mandado los temas antes, a su hora toca **Empezar el esquema**.
3. **Cronómetro compartido**: los dos veis el mismo tiempo, y cualquiera lo maneja.
4. **Pantalla grande** para verlo de lejos.
5. **Pizarra compartida**: lo que dibuja uno lo ve el otro.
6. Al acabar, su **valoración** llega a tu diario.

Cierre: «En la pizarra solo se comparte lo que dibujáis en ella».

## Para preparadores

### empezar-preparador · Empieza como preparador
1. En **Más**, toca **¿Preparas a opositores?**
2. **Darme de alta como preparador**.
3. Solo hace falta tu **nombre** y los **ejercicios** que preparas.
4. Envía la solicitud: **otro preparador verificado** te verifica y te llega un aviso.
5. En **Más → Preparador** tienes tu **código**: dáselo a tus alumnos.
6. Cuando lo escriben, ves sus temas y sus cantes y les programas las clases.

### huecos-reservas · Abre huecos y acepta reservas
1. En **Preparador**, toca **Ajustes de preparador**.
2. Activa **Mis alumnos pueden reservar clase**.
3. En **Huecos semanales**, toca **Añadir**: día, hora y duración.
4. Tus alumnos ven solo tus **huecos libres**.
5. Cuando piden uno, te llega un aviso y lo ves en **Hoy**: **Aceptar** o **Rechazar**.
6. Aceptada, ya está en tu agenda y en la del alumno.

### programar-clase · Programa una clase y manda los temas antes
1. En **Preparador**, toca **Clase**.
2. Alumno, día y hora (o **clase fija** cada semana).
3. **Online**: deja el enlace vacío y la reunión de **Meet** se crea sola.
4. En la clase, toca **Mandarle los temas antes**.
5. **1 o 2 temas**: los eliges tú o **a suerte**.
6. **Cuándo le llegan**: como en el examen, o a la hora que quieras. **Programar el envío**.
7. Antes de esa hora **no puede verlos**. A su hora le llega con **Empezar el esquema**.

### coger-clase · Coge una clase suelta
1. En **Preparador**, toca **Tablón de clases sueltas**.
2. Ves el día, la franja y los temas. **No** el nombre del alumno.
3. Toca **Lo cojo**.
4. Elige la **hora** dentro de su franja.
5. **Es tuya**: el alumno tiene tu contacto y tú el suyo.
6. La clase pasa a **tu semana**.

Cierre: «Activa los avisos de clases sueltas en Ajustes».

### materiales · Comparte materiales con tus alumnos
1. En **Preparador**, toca **Materiales para tus alumnos**.
2. Toca **Material**.
3. Título y **enlace**: Drive, un PDF, un vídeo… (**Pegar**).
4. Si es de un tema, elige el **tema**.
5. **Para todos** tus alumnos o solo para algunos. **Guardar**.
6. Les llega un aviso y lo ven en **Mi preparador** y en **ese tema**.

## Cómo instalarla

Pantallas de `scripts/maquetas-instalar.py` (tienda, navegador y sistema dibujados de forma genérica, y la app de verdad con **DCE** elegida). Van en la sección «Cómo se usa» de `/app/` y en `app/instalar.html`, cada uno en su dispositivo.

### instalar-android · Instala la app en Android
1. En Google Play, busca la app y toca **Instalar**.
2. Cuando acabe, toca **Abrir**.
3. Elige tu oposición: **DCE** o TCEE.
4. Y si **te preparas** o preparas a otros.
5. **Listo**: tu oposición, en el móvil.
6. Mientras llega a Google Play: **Descargar para Android** (la guía de la web).
7. Abre el archivo **descargado**.
8. Toca **Configuración** y permite esta fuente.
9. Toca **Instalar** y luego **Abrir**.

### instalar-iphone · Instala la app en iPhone
1. Abre la app **en Safari** y toca **Compartir**.
2. Toca **Añadir a pantalla de inicio**.
3. Toca **Añadir**.
4. Ya está en tu **pantalla de inicio**.
5. Elige **DCE** o TCEE, y si te preparas o preparas a otros.

### instalar-windows · Instala la app en Windows
1. Abre la app **en Edge o Chrome**.
2. Toca el icono de **instalar** y luego **Instalar**.
3. Se abre en su ventana y queda en la **barra de tareas**.

### instalar-mac · Instala la app en Mac
1. Abre la app **en Safari** y ve a **Archivo**.
2. Toca **Añadir al Dock…** y luego **Añadir**.
3. Ya está en el **Dock**.
