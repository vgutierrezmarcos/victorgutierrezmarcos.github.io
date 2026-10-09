#!/usr/bin/env python3
"""Monta el vídeo de demostración de Google Calendar para la verificación del
permiso OAuth (ver app/google-calendar-verificacion.md): un lienzo de
1920×1080 con la grabación del móvil a la derecha y, a la izquierda, el
rótulo en inglés de cada parte; portada y cierre.

Uso:
    python3 scripts/montar-video-calendar.py CARPETA SALIDA.mp4 [--ffmpeg RUTA]

CARPETA contiene las grabaciones del móvil (`bruto.mp4`, `clip4.mp4`…); los
cortes están en TRAMOS. Sin audio (las grabaciones solo tienen toques).
"""
import argparse
import os
import shutil
import subprocess
import sys
import tempfile
import textwrap

from PIL import Image, ImageDraw, ImageFont

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
FUENTES = os.path.join(RAIZ, 'app', 'assets', 'fonts')
ANCHO, ALTO, FPS = 1920, 1080, 30
FONDO = (22, 16, 28)
CREMA = (246, 240, 232)
DORADO = (232, 196, 110)
GRIS = (190, 182, 196)
MORADO = (95, 41, 135)

# Dónde va el móvil (altura fija; el ancho sale de la grabación).
ALTO_MOVIL = 1000
X_MOVIL, Y_MOVIL = 1240, 40

# (fichero, desde s, hasta s, número de paso, título, texto). Un paso puede
# tener varios tramos seguidos (mismo rótulo).
TRAMOS = [
    ('bruto.mp4', 8, 22, 1, 'Tutors schedule classes with their students',
     'The app is a free study companion for candidates to the Spanish civil-service exams TCEE and DCE. '
     'Tutors (“preparadores”) plan their classes in the Classes tab: date, time, duration, online or in person.'),
    ('clip4.mp4', 30, 52, 2, 'The feature is optional and off by default',
     'Settings → “My classes in Google Calendar”. Turning the switch on opens Google’s consent screen. '
     'The app requests a single scope: see and edit calendar events (calendar.events). '
     'The “unverified app” warning is what this verification will remove.'),
    ('bruto.mp4', 76, 108, 3, 'Saving a class creates one event',
     'A new online class with the student, with no meeting link. When the tutor saves it, the app creates one event '
     'in the tutor’s primary calendar and asks Google Calendar to add a Google Meet conference.'),
    ('bruto.mp4', 131, 147, 4, 'The event in Google Calendar',
     'Title “Clase de TCEE: tutor and student”, the time, the Meet link, the topics to prepare and the note '
     '“Scheduled with the app”. The student receives the invitation by e-mail.'),
    ('bruto.mp4', 140, 162, 5, 'Moving the class updates the same event',
     'Back in the app, the tutor changes the time to 20:30. The app updates the event it created '
     '(it keeps the event id with the class) instead of creating a new one.'),
    ('bruto.mp4', 178, 184, 5, 'Moving the class updates the same event',
     'Google Calendar now shows the class at 20:30–22:30, with the same Meet link.'),
    ('bruto.mp4', 184, 195, 6, 'Cancelling the class deletes the event',
     'The tutor cancels the class in the app. The app deletes that event from the calendar. '
     'The app never reads, lists or changes any other event, and never touches the student’s calendar.'),
    ('borrado.mp4', 2.6, 7.5, 6, 'Cancelling the class deletes the event',
     'A moment later, Google Calendar on Saturday 10: the event is gone. Nothing else in the calendar was touched.'),
    ('bruto.mp4', 266, 275, 7, 'The tutor can disconnect at any time',
     'The same switch in Settings turns the feature off. From then on the app does not touch the calendar; '
     'existing events stay as they are.'),
    ('bruto.mp4', 296, 316, 8, 'Privacy policy',
     'More → Privacy opens the policy, which explains what the app stores (only the event id and the Meet link of each class) '
     'and that calendar data is never shared with third parties.\n\nhttps://www.victorgutierrezmarcos.es/politica-cookies.html'),
]

PORTADA = [
    ('Oposición TCEE · DCE', 110, CREMA, 'Bold'),
    ('Google Calendar integration — demo for OAuth verification', 54, DORADO, 'Semibold'),
    ('Google Cloud project web-vgm (1092815793613) · Android app es.victorgutierrezmarcos.tcee_app', 36, GRIS, 'Regular'),
    ('Scope requested: https://www.googleapis.com/auth/calendar.events', 36, GRIS, 'Regular'),
]
CIERRE = [
    ('What the app does with the scope', 72, CREMA, 'Bold'),
    ('Creates one event per class the tutor schedules, updates it when the class moves, deletes it when the class is cancelled.', 40, CREMA, 'Regular'),
    ('It never reads or lists other events, never creates calendars and never accesses the student’s calendar.', 40, CREMA, 'Regular'),
    ('Only the event id and the Meet link are stored, with the class, in the tutor’s own data.', 40, CREMA, 'Regular'),
    ('Privacy policy: https://www.victorgutierrezmarcos.es/politica-cookies.html', 36, DORADO, 'Semibold'),
    ('Home page: https://www.victorgutierrezmarcos.es/app/', 36, DORADO, 'Semibold'),
]


def fuente(tam, peso='Regular'):
    return ImageFont.truetype(os.path.join(FUENTES, f'SourceSans3-{peso}.ttf'), tam)


def parrafo(d, texto, x, y, ancho, tam, color, peso='Regular', interlineado=1.3):
    f = fuente(tam, peso)
    # Ajuste de líneas por anchura real.
    for bloque in texto.split('\n'):
        if not bloque:
            y += tam * interlineado
            continue
        linea = ''
        for palabra in bloque.split(' '):
            prueba = (linea + ' ' + palabra).strip()
            if d.textlength(prueba, font=f) > ancho and linea:
                d.text((x, y), linea, font=f, fill=color)
                y += tam * interlineado
                linea = palabra
            else:
                linea = prueba
        if linea:
            d.text((x, y), linea, font=f, fill=color)
            y += tam * interlineado
    return y


def lienzo():
    img = Image.new('RGB', (ANCHO, ALTO), FONDO)
    d = ImageDraw.Draw(img)
    # Una línea dorada arriba y el nombre de la app, discretos.
    d.rectangle((0, 0, ANCHO, 6), fill=MORADO)
    d.text((60, 30), 'Oposición TCEE · DCE  ·  Google Calendar integration', font=fuente(28, 'Semibold'), fill=GRIS)
    return img, d


def fondo_paso(num, titulo, texto, ancho_movil):
    img, d = lienzo()
    # Marco detrás del móvil.
    d.rounded_rectangle((X_MOVIL - 14, Y_MOVIL - 14, X_MOVIL + ancho_movil + 14, Y_MOVIL + ALTO_MOVIL + 14), 36, fill=(40, 30, 50))
    x, ancho = 90, X_MOVIL - 90 - 80
    d.text((x, 160), f'STEP {num} OF 8', font=fuente(30, 'Semibold'), fill=DORADO)
    y = parrafo(d, titulo, x, 205, ancho, 64, CREMA, 'Bold', 1.15)
    parrafo(d, texto, x, y + 30, ancho, 36, GRIS, 'Regular', 1.35)
    return img


def tarjeta(lineas):
    img, d = lienzo()
    total = sum(tam * 1.5 + 14 for _, tam, _, _ in lineas)
    y = (ALTO - total) / 2
    for texto, tam, color, peso in lineas:
        y = parrafo(d, texto, 120, y, ANCHO - 240, tam, color, peso, 1.5) + 14
    return img


def tamano_video(ffmpeg, ruta):
    salida = subprocess.run([ffmpeg, '-i', ruta], capture_output=True, text=True).stderr
    for linea in salida.splitlines():
        if 'Video:' in linea:
            for trozo in linea.replace(',', ' ').split():
                if 'x' in trozo and trozo.replace('x', '').isdigit():
                    w, h = map(int, trozo.split('x'))
                    return w, h
    sys.exit(f'No se lee el tamaño de {ruta}')


def main():
    p = argparse.ArgumentParser()
    p.add_argument('carpeta')
    p.add_argument('salida')
    p.add_argument('--ffmpeg', default=os.environ.get('FFMPEG') or shutil.which('ffmpeg'))
    args = p.parse_args()
    if not args.ffmpeg:
        sys.exit('No se encuentra ffmpeg: --ffmpeg o la variable FFMPEG.')
    tmp = tempfile.mkdtemp(prefix='calendar-')
    partes = []
    comunes = ['-r', str(FPS), '-c:v', 'libx264', '-preset', 'faster', '-crf', '20', '-pix_fmt', 'yuv420p', '-threads', '2', '-an']

    def tarjeta_a_video(img, nombre, segundos):
        png = os.path.join(tmp, nombre + '.png')
        img.save(png)
        mp4 = os.path.join(tmp, nombre + '.mp4')
        subprocess.run([args.ffmpeg, '-y', '-loglevel', 'error', '-loop', '1', '-framerate', str(FPS), '-t', str(segundos), '-i', png, *comunes, mp4], check=True)
        partes.append(mp4)

    tarjeta_a_video(tarjeta(PORTADA), 'portada', 6)
    tamanos = {}
    for i, (fichero, desde, hasta, num, titulo, texto) in enumerate(TRAMOS):
        ruta = os.path.join(args.carpeta, fichero)
        if fichero not in tamanos:
            tamanos[fichero] = tamano_video(args.ffmpeg, ruta)
        w, h = tamanos[fichero]
        ancho_movil = round(w * ALTO_MOVIL / h / 2) * 2
        fondo = os.path.join(tmp, f'fondo{i}.png')
        fondo_paso(num, titulo, texto, ancho_movil).save(fondo)
        mp4 = os.path.join(tmp, f'tramo{i}.mp4')
        subprocess.run([
            args.ffmpeg, '-y', '-loglevel', 'error',
            '-loop', '1', '-framerate', str(FPS), '-i', fondo,
            '-ss', str(desde), '-t', str(hasta - desde), '-i', ruta,
            '-filter_complex', f'[1:v]scale={ancho_movil}:{ALTO_MOVIL}:flags=lanczos,fps={FPS}[m];[0:v][m]overlay={X_MOVIL}:{Y_MOVIL}:shortest=1[v]',
            '-map', '[v]', *comunes, mp4,
        ], check=True)
        partes.append(mp4)
        print(f'tramo {i}: {fichero} {desde}-{hasta} s', flush=True)
    tarjeta_a_video(tarjeta(CIERRE), 'cierre', 8)

    lista = os.path.join(tmp, 'lista.txt')
    with open(lista, 'w', encoding='utf-8') as f:
        for parte in partes:
            f.write(f"file '{parte}'\n")
    subprocess.run([args.ffmpeg, '-y', '-loglevel', 'error', '-f', 'concat', '-safe', '0', '-i', lista, '-c', 'copy', '-movflags', '+faststart', args.salida], check=True)
    shutil.rmtree(tmp, ignore_errors=True)
    print(f'{args.salida}: {os.path.getsize(args.salida) / 1e6:.1f} MB')


if __name__ == '__main__':
    main()
