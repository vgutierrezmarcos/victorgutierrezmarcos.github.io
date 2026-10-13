#!/usr/bin/env python3
"""Tercera versión del vídeo de demostración de Google Calendar (13 oct. 2026),
para la segunda respuesta de Google: el consentimiento con los permisos
desplegados («See access details», «See the 3 services») y por qué hace falta
`calendar.events` y no un permiso más estrecho (la clase tiene que estar en el
calendario principal para que el preparador salga ocupado).

Reutiliza el dibujo de scripts/montar-video-calendar.py. Fuentes (en CARPETA):
    nuevo.mp4    grabación del móvil con la cuenta de revisión (en inglés)
    viejo.mp4    el vídeo anterior (google-calendar-demo.mp4): de él se recorta
                 el móvil de los pasos que no cambian (cancelar, desconectar…)
    acceso.jpg   aviso de Google «Se ha concedido el acceso…» a esa cuenta

Uso:
    python3 scripts/montar-video-calendar-v3.py CARPETA SALIDA.mp4 --ffmpeg RUTA
"""
import argparse
import importlib.util
import os
import shutil
import subprocess
import tempfile

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
_spec = importlib.util.spec_from_file_location('base', os.path.join(RAIZ, 'scripts', 'montar-video-calendar.py'))
m = importlib.util.module_from_spec(_spec)
_spec.loader.exec_module(m)

TOTAL = 10
# Dónde estaba el móvil en el vídeo anterior (x, y, ancho, alto).
RECORTE_VIEJO = (1240, 40, 462, 1000)

# (fuente, desde, hasta, paso, título, texto, velocidad)
TRAMOS = [
    ('viejo.mp4', 6, 21, 1, 'Tutors schedule classes with their students',
     'The app is a free study companion for candidates to the Spanish civil-service exams TCEE and DCE. '
     'Tutors (“preparadores”) plan their classes in the Classes tab: date, time, duration, online or in person.', 1),
    ('nuevo.mp4', 0, 8, 2, 'Signing in uses only the basic profile',
     'The tutor (test account tcee.revision@gmail.com) signs in with Google. At this point the app only receives the name, '
     'e-mail address and profile picture. No calendar access is requested.', 1),
    ('nuevo.mp4', 22, 29, 2, 'The feature is optional and off by default',
     'Más (More) → Preparador (Tutor) → Ajustes de preparador (Tutor settings) → Google Calendar: the switch '
     '“Mis clases en Google Calendar” (My classes in Google Calendar).', 1),
    ('nuevo.mp4', 33.5, 38, 2, 'The feature is optional and off by default',
     'It stays off until the tutor turns it on. Turning it on starts Google’s consent flow.', 1),
    ('nuevo.mp4', 38, 50, 2, 'Google’s consent flow',
     'Google first shows the “unverified app” warning (this verification will remove it): '
     'Advanced → Go to Oposición TCEE · DCE.', 1),
    ('nuevo.mp4', 50, 66, 2, 'The consent screen, with the scope expanded',
     'One sensitive permission is requested: “View and edit events on all your calendars” (calendar.events). '
     '“See access details” shows its full description.', 1),
    ('nuevo.mp4', 66, 84, 2, 'Everything the app will have access to',
     '“See the 3 services” lists all the access granted: basic profile and e-mail (from sign-in) and Google Calendar events. '
     'Nothing else. The tutor reviews it and taps Continue.', 1),
    ('nuevo.mp4', 84, 90, 2, 'Access granted',
     'Back in the app the switch is on: “Conectado. Las clases que programes irán a tu Google Calendar” '
     '(Connected: the classes you schedule will go to your Google Calendar).', 1),
    ('acceso.jpg', 0, 5, 2, 'Google confirms the access',
     'Google’s security notice to the test account: “Oposición TCEE · DCE — Has access to Google Calendar.”', 1),
    ('nuevo.mp4', 90, 116, 3, 'Saving a class creates one event',
     'The tutor schedules an online class with a student, with no meeting link, and saves it. '
     'The app creates one event in the tutor’s primary calendar and asks Google Calendar to add a Google Meet conference.', 1.4),
    ('nuevo.mp4', 116, 123.5, 4, 'The event in the tutor’s primary calendar',
     '“Clase de TCEE: Prueba Revisión y Alumno De Prueba”, tomorrow 5–7 PM, with its Google Meet link, '
     'the student as guest and the note “Programada con la app”. Calendar: My calendar (primary).', 1),
    ('nuevo.mp4', 123.5, 132, 5, 'The student receives the invitation',
     'The student (another Google account) gets Google Calendar’s standard invitation e-mail, with “Join with Google Meet”. '
     'This is why the app needs to add attendees.', 1),
    ('nuevo.mp4', 132, 134, 6, 'Why the primary calendar: availability',
     'The class also shows in the student’s calendar.', 1),
    ('nuevo.mp4', 194, 198, 6, 'Why the primary calendar: availability',
     'Someone else (here, the student’s account) creates an event and invites the tutor…', 1),
    ('nuevo.mp4', 208, 220, 6, 'Why the primary calendar: availability',
     '…and “View schedules” shows the tutor busy from 5 to 7 PM, because the class is in the tutor’s primary calendar. '
     'Events in a secondary calendar created by the app (calendar.app.created) do not count as busy, '
     'so others would book over the tutor’s classes.', 1),
    ('nuevo.mp4', 236, 258.8, 7, 'Moving the class updates the same event',
     'Back in the app, the tutor moves the class from 17:00 to 16:00. The app updates the event it created '
     '(it keeps the event id with the class) instead of creating a new one; Google notifies the student.', 1),
    ('viejo.mp4', 119.4, 135.3, 8, 'Cancelling the class deletes the event',
     'The tutor cancels the class in the app and the app deletes that event. '
     'The app never reads, lists or changes any other event, and never touches the student’s calendar.', 1),
    ('viejo.mp4', 135.4, 145.2, 9, 'The tutor can disconnect at any time',
     'The same switch in Settings turns the feature off. From then on the app does not touch the calendar; '
     'access can also be removed at myaccount.google.com/permissions.', 1),
    ('viejo.mp4', 145.3, 165.2, 10, 'Privacy policy',
     'The policy has a section “Datos de usuario de Google” (Google user data): what is accessed, how it is used, '
     'shared and protected, and how it is retained and deleted.\n\n'
     'https://www.victorgutierrezmarcos.es/politica-cookies.html#datos-google', 1),
]

POR_QUE = [
    ('Why calendar.events and not a narrower scope', 66, m.CREMA, 'Bold'),
    ('calendar.app.created only allows events in a secondary calendar created by the app. Those events do not make the tutor '
     'busy for others, and tutors asked to see their classes in their own calendar, next to the rest of their schedule.', 38, m.CREMA, 'Regular'),
    ('calendar.events lets the app create, update and delete, in the primary calendar, only the events of the classes it schedules, '
     'with the student as attendee and a Google Meet link. The app stores each event id and never reads, lists or changes other events.', 38, m.CREMA, 'Regular'),
    ('Test account for the review: tcee.revision@gmail.com (credentials in the reply).', 34, m.DORADO, 'Semibold'),
]


def fondo_paso(num, titulo, texto, ancho_movil):
    img, d = m.lienzo()
    d.rounded_rectangle((m.X_MOVIL - 14, m.Y_MOVIL - 14, m.X_MOVIL + ancho_movil + 14, m.Y_MOVIL + m.ALTO_MOVIL + 14), 36, fill=(40, 30, 50))
    x, ancho = 90, m.X_MOVIL - 90 - 80
    d.text((x, 160), f'STEP {num} OF {TOTAL}', font=m.fuente(30, 'Semibold'), fill=m.DORADO)
    y = m.parrafo(d, titulo, x, 205, ancho, 64, m.CREMA, 'Bold', 1.15)
    m.parrafo(d, texto, x, y + 30, ancho, 36, m.GRIS, 'Regular', 1.35)
    return img


def main():
    p = argparse.ArgumentParser()
    p.add_argument('carpeta')
    p.add_argument('salida')
    p.add_argument('--ffmpeg', required=True)
    a = p.parse_args()
    ff = a.ffmpeg
    tmp = tempfile.mkdtemp(prefix='calendar3-')
    comunes = ['-r', str(m.FPS), '-c:v', 'libx264', '-preset', 'faster', '-crf', '20', '-pix_fmt', 'yuv420p', '-threads', '2', '-an']
    partes = []

    def tarjeta(lineas, nombre, seg):
        png = os.path.join(tmp, nombre + '.png')
        m.tarjeta(lineas).save(png)
        out = os.path.join(tmp, nombre + '.mp4')
        subprocess.run([ff, '-y', '-loglevel', 'error', '-loop', '1', '-framerate', str(m.FPS), '-t', str(seg), '-i', png, *comunes, out], check=True)
        partes.append(out)

    tarjeta(m.PORTADA, 'portada', 6)
    for i, (fuente, desde, hasta, num, titulo, texto, vel) in enumerate(TRAMOS):
        ruta = os.path.join(a.carpeta, fuente)
        if fuente == 'viejo.mp4':
            x, y, w, h = RECORTE_VIEJO
            filtro_src = f'crop={w}:{h}:{x}:{y},'
        else:
            w, h = m.tamano_video(ff, ruta) if fuente.endswith('.mp4') else m.Image.open(ruta).size
            filtro_src = ''
        ancho = round(w * m.ALTO_MOVIL / h / 2) * 2
        fondo = os.path.join(tmp, f'f{i}.png')
        fondo_paso(num, titulo, texto, ancho).save(fondo)
        out = os.path.join(tmp, f't{i}.mp4')
        if fuente.endswith('.jpg'):
            entrada = ['-loop', '1', '-framerate', str(m.FPS), '-t', str(hasta - desde), '-i', ruta]
        else:
            entrada = ['-ss', str(desde), '-t', str(hasta - desde), '-i', ruta]
        subprocess.run([ff, '-y', '-loglevel', 'error', '-loop', '1', '-framerate', str(m.FPS), '-i', fondo, *entrada,
                        '-filter_complex', f'[1:v]{filtro_src}setpts=(PTS-STARTPTS)/{vel},scale={ancho}:{m.ALTO_MOVIL}:flags=lanczos,fps={m.FPS}[v1];[0:v][v1]overlay={m.X_MOVIL}:{m.Y_MOVIL}:shortest=1[v]',
                        '-map', '[v]', *comunes, out], check=True)
        partes.append(out)
        print('tramo', i, fuente, desde, hasta, flush=True)
    tarjeta(POR_QUE, 'porque', 14)
    tarjeta(m.CIERRE, 'cierre', 8)
    lista = os.path.join(tmp, 'l.txt')
    with open(lista, 'w') as f:
        f.writelines(f"file '{x}'\n" for x in partes)
    subprocess.run([ff, '-y', '-loglevel', 'error', '-f', 'concat', '-safe', '0', '-i', lista, '-c', 'copy', '-movflags', '+faststart', a.salida], check=True)
    shutil.rmtree(tmp, ignore_errors=True)
    print(a.salida, round(os.path.getsize(a.salida) / 1e6, 1), 'MB')


if __name__ == '__main__':
    main()
