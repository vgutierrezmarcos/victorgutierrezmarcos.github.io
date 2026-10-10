#!/usr/bin/env python3
"""
Genera el vídeo del cante de un tema (unos 30 minutos, 1920 × 1080) a partir
de fuentes/<tema>/video/escenas.yaml.

    python3 scripts/temario/generar-video.py 3A08 [--solo-escena N] [--borrador]

El vídeo imita un cante ante el tribunal con pizarra: arriba, el apartado y
sus minutos; a la izquierda, lo que el opositor va escribiendo en la pizarra;
a la derecha, el gráfico, la fórmula o la imagen de ese momento. Los gráficos
TikZ se dibujan por capas: \\capa{n}{…} aparece cuando la narración llega al
paso que la pide, con un fundido.

Formato de escenas.yaml:

    tema: 3.A.8
    voz: es-ES-AlvaroNeural        # opcional (CRITERIOS.md fija la de por defecto)
    velocidad: "+0%"               # opcional
    escenas:
      - apartado: Introducción
        minutos: 3
        pasos:
          - di: "Texto que se narra."
            escribe: "Lo que se anota en la pizarra"    # opcional
          - di: "…"
            grafico: oferta-demanda                     # graficos/oferta-demanda.tex
            capa: 1                                     # opcional (por defecto 1)
          - di: "…"
            capa: 2                                     # mismo gráfico, capa 2
          - di: "…"
            formula: "\\\\max_x u(x) \\\\text{ s.a. } px \\\\le m"
          - di: "…"
            imagen: video/marshall.jpg                  # ruta desde fuentes/<tema>/
            pie: "Alfred Marshall (1842-1924). Wikimedia Commons, dominio público."

Salida (fuera de git, en la carpeta Vídeos de Windows):
  Vídeos/temario/<tema>.mp4          el vídeo
  Vídeos/temario/<tema>.srt          subtítulos (para subirlos a YouTube)
  Vídeos/temario/<tema>-youtube.txt  título, descripción y capítulos para YouTube

La voz es Edge TTS (neural, gratuita). Los audios y las imágenes se guardan en
fuentes/<tema>/_trabajo/video/ y solo se rehacen si cambia su texto.

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import asyncio
import glob
import hashlib
import json
import os
import re
import subprocess
import sys
import time

import fitz  # PyMuPDF
import yaml
from PIL import Image, ImageDraw, ImageFilter, ImageFont

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from comun import Tema, MIKTEX, entorno_tex, ejecutar, errores_log  # noqa: E402

ANCHO, ALTO = 1920, 1080
FPS = 25
FUNDIDO = 0.45          # segundos de fundido entre pasos
PAUSA = 0.55            # silencio tras cada paso
SALIDA = os.environ.get('TCEE_VIDEOS', '/mnt/c/Users/vgutierrez/Videos/temario')
FUENTES_WIN = '/mnt/c/Windows/Fonts'
VOZ_DEFECTO = 'es-ES-AlvaroNeural'

MORADO = (95, 41, 135)
MORADO_PALIDO = (243, 238, 247)
TINTA = (40, 38, 44)
GRIS = (118, 113, 113)
PIZARRA = (251, 251, 248)
SALVIA = (226, 239, 217)


def fuente(nombre, tam):
    return ImageFont.truetype(os.path.join(FUENTES_WIN, nombre), tam)


F_TEXTO = fuente('pala.ttf', 38)
F_TEXTO_N = fuente('palab.ttf', 38)
F_BARRA = fuente('segoeuisl.ttf', 30)
F_BARRA_N = fuente('segoeuib.ttf', 30)
F_PIE = fuente('palai.ttf', 26)
F_TITULO = fuente('palab.ttf', 64)
F_SUBTITULO = fuente('pala.ttf', 40)


def huella(*partes):
    return hashlib.sha1('\x00'.join(map(str, partes)).encode()).hexdigest()[:12]


# --- Voz -----------------------------------------------------------------------------
def version_edge():
    """Edge TTS exige una versión de Edge reciente: se toma la instalada en Windows."""
    versiones = [os.path.basename(p) for p in glob.glob('/mnt/c/Program Files (x86)/Microsoft/Edge/Application/*')
                 if re.fullmatch(r'\d+\.\d+\.\d+\.\d+', os.path.basename(p))]
    return max(versiones, key=lambda v: tuple(map(int, v.split('.')))) if versiones else None


def preparar_edge_tts():
    import edge_tts.communicate as cm
    v = version_edge()
    if v:
        mayor = v.split('.')[0]
        cm.SEC_MS_GEC_VERSION = '1-' + v
        cm.WSS_HEADERS['User-Agent'] = re.sub(r'(Chrome|Edg)/\d+', rf'\1/{mayor}', cm.WSS_HEADERS['User-Agent'])


async def _sintetizar(texto, voz, velocidad, mp3, marcas):
    import edge_tts
    com = edge_tts.Communicate(texto, voz, rate=velocidad, boundary='SentenceBoundary')
    frases = []
    with open(mp3, 'wb') as f:
        async for trozo in com.stream():
            if trozo['type'] == 'audio':
                f.write(trozo['data'])
            elif trozo['type'] in ('SentenceBoundary', 'WordBoundary'):
                frases.append({'inicio': trozo['offset'] / 1e7, 'duracion': trozo['duration'] / 1e7,
                               'texto': trozo['text']})
    with open(marcas, 'w', encoding='utf-8') as f:
        json.dump(frases, f, ensure_ascii=False)


def sintetizar(texto, voz, velocidad, carpeta):
    h = huella(texto, voz, velocidad)
    mp3, marcas = os.path.join(carpeta, f'voz-{h}.mp3'), os.path.join(carpeta, f'voz-{h}.json')
    if not (os.path.exists(mp3) and os.path.getsize(mp3) > 0 and os.path.exists(marcas)):
        # Edge TTS devuelve a veces 403 durante un rato: se reintenta esperando cada vez más
        for intento in range(8):
            try:
                asyncio.run(_sintetizar(texto, voz, velocidad, mp3, marcas))
                break
            except Exception as e:
                if intento == 7:
                    raise RuntimeError(f'Edge TTS falló: {e}')
                time.sleep(min(15 * 2 ** intento, 300))
    return mp3, json.load(open(marcas, encoding='utf-8'))


def duracion_audio(ffmpeg, mp3):
    r = subprocess.run([ffmpeg, '-i', mp3], capture_output=True, text=True)
    m = re.search(r'Duration: (\d+):(\d+):([\d.]+)', r.stderr)
    return int(m.group(1)) * 3600 + int(m.group(2)) * 60 + float(m.group(3))


# --- Visuales (gráficos por capas, fórmulas, imágenes) ---------------------------------
def grafico_png(tema, nombre, capa, carpeta):
    tex = os.path.join(tema.graficos, f'{nombre}.tex')
    if not os.path.exists(tex):
        raise RuntimeError(f'No existe el gráfico graficos/{nombre}.tex')
    contenido = open(tex, encoding='utf-8').read()
    h = huella(contenido, capa)
    png = os.path.join(carpeta, f'g-{nombre}-{capa}-{h}.png')
    if os.path.exists(png):
        return png
    trabajo = f'{nombre}-capa{capa}'
    orden = [os.path.join(MIKTEX, 'pdflatex.exe'), '-interaction=nonstopmode', '-halt-on-error',
             f'-jobname={trabajo}', f'-output-directory=../_trabajo/video',
             f'\\def\\tceepaso{{{capa}}}\\input{{{nombre}.tex}}']
    # Se compila desde graficos/ para que \input{../../../latex/tikz-tcee} funcione
    cod, _ = ejecutar(orden, cwd=tema.graficos, env=entorno_tex(), timeout=300, comprobar=False)
    pdf = os.path.join(carpeta, f'{trabajo}.pdf')
    if cod != 0 or not os.path.exists(pdf):
        raise RuntimeError(f'Error al compilar {nombre} (capa {capa}):\n'
                           + '\n'.join(errores_log(os.path.join(carpeta, f'{trabajo}.log'))))
    doc = fitz.open(pdf)
    doc[0].get_pixmap(dpi=400, alpha=True).save(png)
    return png


def formula_png(formula, carpeta):
    h = huella(formula)
    png = os.path.join(carpeta, f'f-{h}.png')
    if os.path.exists(png):
        return png
    tex = os.path.join(carpeta, f'f-{h}.tex')
    with open(tex, 'w', encoding='utf-8') as f:
        f.write('\\documentclass[border=6pt]{standalone}\n\\usepackage{amsmath}\\usepackage{newpxtext,newpxmath}\n'
                '\\usepackage{xcolor}\\definecolor{tceemorado}{HTML}{5F2987}\n'
                f'\\begin{{document}}$\\displaystyle {formula}$\\end{{document}}\n')
    cod, _ = ejecutar([os.path.join(MIKTEX, 'pdflatex.exe'), '-interaction=nonstopmode', '-halt-on-error',
                       os.path.basename(tex)], cwd=carpeta, env=entorno_tex(), timeout=300, comprobar=False)
    if cod != 0:
        raise RuntimeError(f'Error en la fórmula {formula!r}:\n' + '\n'.join(errores_log(tex[:-4] + '.log')))
    fitz.open(tex[:-4] + '.pdf')[0].get_pixmap(dpi=600, alpha=True).save(png)
    return png


# --- Composición de cada paso -------------------------------------------------------------
def partir(texto, fuente_, ancho, dibujo):
    palabras, lineas, actual = texto.split(), [], ''
    for p in palabras:
        prueba = (actual + ' ' + p).strip()
        if dibujo.textlength(prueba, font=fuente_) <= ancho:
            actual = prueba
        else:
            if actual:
                lineas.append(actual)
            actual = p
    if actual:
        lineas.append(actual)
    return lineas


def fondo():
    img = Image.new('RGB', (ANCHO, ALTO), PIZARRA)
    d = ImageDraw.Draw(img)
    # Marco de pizarra blanca
    d.rounded_rectangle([28, 96, ANCHO - 28, ALTO - 28], radius=18, outline=(214, 214, 208), width=6)
    return img


def componer(tema, estado, visual, pie):
    img = fondo()
    d = ImageDraw.Draw(img)
    # Barra superior
    d.rectangle([0, 0, ANCHO, 76], fill=MORADO)
    d.text((40, 20), f'Tema {tema.codigo}', font=F_BARRA_N, fill='white')
    d.text((40 + d.textlength(f'Tema {tema.codigo}', font=F_BARRA_N) + 26, 20),
           estado['apartado'], font=F_BARRA, fill=(235, 225, 245))
    if estado.get('minutos'):
        txt = f'{estado["minutos"]} min'
        d.text((ANCHO - 40 - d.textlength(txt, font=F_BARRA), 20), txt, font=F_BARRA, fill=(235, 225, 245))
    # Columna izquierda: lo escrito en la pizarra
    x0, y = 80, 140
    ancho_col = 660 if visual else ANCHO - 200
    for i, linea in enumerate(estado['pizarra']):
        ultimo = i == len(estado['pizarra']) - 1
        nivel = len(linea) - len(linea.lstrip('>'))
        texto = linea.lstrip('> ')
        xi = x0 + nivel * 40
        color = MORADO if ultimo else TINTA
        marca = '■' if nivel == 0 else '–'
        d.text((xi, y + 4), marca, font=fuente('segoeui.ttf', 26 if nivel == 0 else 34), fill=MORADO)
        for j, l in enumerate(partir(texto, F_TEXTO_N if ultimo else F_TEXTO, ancho_col - (xi - x0) - 40, d)):
            d.text((xi + 38, y), l, font=F_TEXTO_N if ultimo else F_TEXTO, fill=color)
            y += 50
        y += 12
        if y > ALTO - 120:
            break
    # Derecha: gráfico, fórmula o imagen
    if visual:
        caja = (ANCHO - 1060, 130, ANCHO - 70, ALTO - (120 if pie else 70))
        v = Image.open(visual).convert('RGBA')
        escala = min((caja[2] - caja[0]) / v.width, (caja[3] - caja[1]) / v.height)
        v = v.resize((max(1, int(v.width * escala)), max(1, int(v.height * escala))), Image.LANCZOS)
        px = caja[0] + ((caja[2] - caja[0]) - v.width) // 2
        py = caja[1] + ((caja[3] - caja[1]) - v.height) // 2
        img.paste(v, (px, py), v)
        if pie:
            for j, l in enumerate(partir(pie, F_PIE, caja[2] - caja[0], d)[:2]):
                w = d.textlength(l, font=F_PIE)
                d.text((caja[0] + ((caja[2] - caja[0]) - w) / 2, ALTO - 112 + j * 34), l, font=F_PIE, fill=GRIS)
    return img


def portada(tema, titulo):
    img = Image.new('RGB', (ANCHO, ALTO), MORADO)
    d = ImageDraw.Draw(img)
    d.text((ANCHO / 2, 330), f'Tema {tema.codigo}', font=F_TITULO, fill='white', anchor='mm')
    y = 450
    for l in partir(titulo, F_SUBTITULO, 1500, d):
        d.text((ANCHO / 2, y), l, font=F_SUBTITULO, fill=(235, 225, 245), anchor='mm')
        y += 58
    d.text((ANCHO / 2, ALTO - 140), 'Víctor Gutiérrez Marcos · victorgutierrezmarcos.es', font=F_BARRA,
           fill=SALVIA, anchor='mm')
    d.text((ANCHO / 2, ALTO - 95), 'Oposición a Técnico Comercial y Economista del Estado', font=F_PIE,
           fill=(220, 210, 230), anchor='mm')
    return img


# --- Montaje ------------------------------------------------------------------------------------
def segmento(ffmpeg, previa, actual, audio, duracion, destino):
    entradas = ['-loop', '1', '-t', f'{duracion:.3f}', '-i', actual]
    if previa:
        entradas = ['-loop', '1', '-t', f'{duracion:.3f}', '-i', previa] + entradas
        filtro = (f'[0:v][1:v]xfade=transition=fade:duration={FUNDIDO}:offset=0,'
                  f'fps={FPS},format=yuv420p[v]')
        n_audio = 2
    else:
        filtro = f'[0:v]fps={FPS},format=yuv420p[v]'
        n_audio = 1
    if audio:
        entradas += ['-i', audio]
        mapa = ['-map', '[v]', '-map', f'{n_audio}:a', '-af', f'apad=whole_dur={duracion:.3f}']
    else:
        entradas += ['-f', 'lavfi', '-t', f'{duracion:.3f}', '-i', 'anullsrc=r=24000:cl=mono']
        mapa = ['-map', '[v]', '-map', f'{n_audio}:a']
    orden = [ffmpeg, '-y', '-loglevel', 'error', *entradas, '-filter_complex', filtro, *mapa,
             '-t', f'{duracion:.3f}', '-c:v', 'libx264', '-preset', 'veryfast', '-tune', 'stillimage',
             '-crf', '20', '-c:a', 'aac', '-b:a', '128k', '-ar', '24000', '-ac', '1', destino]
    subprocess.run(orden, check=True)


def srt_tiempo(s):
    h, s = divmod(s, 3600)
    m, s = divmod(s, 60)
    return f'{int(h):02d}:{int(m):02d}:{s:06.3f}'.replace('.', ',')


def yt_tiempo(s):
    m, s = divmod(int(s), 60)
    h, m = divmod(m, 60)
    return f'{h}:{m:02d}:{s:02d}' if h else f'{m}:{s:02d}'


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument('tema')
    ap.add_argument('--solo-escena', type=int, help='monta solo esa escena (1, 2…) para probar')
    ap.add_argument('--borrador', action='store_true', help='sin voz: 3 s por paso (para revisar la imagen)')
    ap.add_argument('--ffmpeg', default=None)
    args = ap.parse_args()
    tema = Tema(args.tema)
    import imageio_ffmpeg
    ffmpeg = args.ffmpeg or imageio_ffmpeg.get_ffmpeg_exe()

    ruta_yaml = os.path.join(tema.dir, 'video', 'escenas.yaml')
    guion = yaml.safe_load(open(ruta_yaml, encoding='utf-8'))
    voz = guion.get('voz', VOZ_DEFECTO)
    velocidad = guion.get('velocidad', '+0%')
    titulo = guion.get('titulo') or tema.titulo()
    carpeta = os.path.join(tema.trabajo, 'video')
    os.makedirs(carpeta, exist_ok=True)
    if not args.borrador:
        preparar_edge_tts()

    escenas = guion['escenas']
    if args.solo_escena:
        escenas = [escenas[args.solo_escena - 1]]

    segmentos, subtitulos, capitulos = [], [], []
    t = 0.0
    previa = None
    # Portada (5 s, con el título leído)
    img = portada(tema, titulo)
    png = os.path.join(carpeta, 'portada.png')
    img.save(png)
    texto_portada = f'Tema {tema.codigo.replace(".", " ")}. {titulo}'
    if args.borrador:
        audio, dur = None, 3.0
    else:
        audio, _ = sintetizar(texto_portada, voz, velocidad, carpeta)
        dur = duracion_audio(ffmpeg, audio) + 1.2
    seg = os.path.join(carpeta, 'seg-0000.mp4')
    segmento(ffmpeg, None, png, audio, dur, seg)
    segmentos.append(seg)
    capitulos.append((0.0, 'Presentación'))
    t += dur
    previa = png

    n = 0
    for e_i, escena in enumerate(escenas, 1):
        estado = {'apartado': escena.get('apartado', ''), 'minutos': escena.get('minutos'), 'pizarra': []}
        capitulos.append((t, escena.get('apartado', f'Parte {e_i}')))
        visual, pie, grafico_actual = None, None, None
        for paso in escena.get('pasos', []):
            n += 1
            if paso.get('borrar'):
                estado['pizarra'] = []
            if paso.get('escribe'):
                estado['pizarra'].append(paso['escribe'])
            if paso.get('grafico'):
                grafico_actual = paso['grafico']
                visual = grafico_png(tema, grafico_actual, paso.get('capa', 1), carpeta)
                pie = paso.get('pie')
            elif paso.get('capa') and grafico_actual:
                visual = grafico_png(tema, grafico_actual, paso['capa'], carpeta)
            elif paso.get('formula'):
                visual, pie, grafico_actual = formula_png(paso['formula'], carpeta), paso.get('pie'), None
            elif paso.get('imagen'):
                visual, pie, grafico_actual = os.path.join(tema.dir, paso['imagen']), paso.get('pie'), None
            elif paso.get('quitar_visual'):
                visual, pie, grafico_actual = None, None, None
            img = componer(tema, estado, visual, pie)
            png = os.path.join(carpeta, f'paso-{n:04d}.png')
            img.save(png)
            texto = paso.get('di', '').strip()
            if args.borrador or not texto:
                audio, dur, marcas = None, (3.0 if args.borrador else 1.5), []
            else:
                audio, marcas = sintetizar(texto, voz, velocidad, carpeta)
                dur = duracion_audio(ffmpeg, audio) + PAUSA
            seg = os.path.join(carpeta, f'seg-{n:04d}.mp4')
            segmento(ffmpeg, previa, png, audio, dur, seg)
            segmentos.append(seg)
            for m in marcas:
                subtitulos.append((t + m['inicio'], t + m['inicio'] + m['duracion'], m['texto']))
            t += dur
            previa = png
        print(f'Escena {e_i}/{len(escenas)} «{estado["apartado"]}»: hasta {yt_tiempo(t)}', flush=True)

    os.makedirs(SALIDA, exist_ok=True)
    sufijo = f'-escena{args.solo_escena}' if args.solo_escena else ('-borrador' if args.borrador else '')
    lista = os.path.join(carpeta, 'segmentos.txt')
    with open(lista, 'w') as f:
        f.writelines(f"file '{s}'\n" for s in segmentos)
    mp4 = os.path.join(SALIDA, f'{tema.archivo}{sufijo}.mp4')
    subprocess.run([ffmpeg, '-y', '-loglevel', 'error', '-f', 'concat', '-safe', '0', '-i', lista,
                    '-c', 'copy', '-movflags', '+faststart', mp4], check=True)

    with open(os.path.join(SALIDA, f'{tema.archivo}{sufijo}.srt'), 'w', encoding='utf-8') as f:
        for i, (a, b, texto) in enumerate(subtitulos, 1):
            f.write(f'{i}\n{srt_tiempo(a)} --> {srt_tiempo(b)}\n{texto}\n\n')
    with open(os.path.join(SALIDA, f'{tema.archivo}{sufijo}-youtube.txt'), 'w', encoding='utf-8') as f:
        f.write(f'Tema {tema.codigo}: {titulo} | Cante (Oposición TCEE)\n\n')
        f.write(f'Exposición oral del tema {tema.codigo} de la oposición a Técnico Comercial y Economista '
                f'del Estado, con la pizarra y los gráficos del tema.\n\n'
                f'Tema completo (PDF, Word y web): https://www.victorgutierrezmarcos.es/oposicion/temario/'
                f'{tema.carpeta}/{tema.archivo}.html\n\nCapítulos:\n')
        for inicio, nombre in capitulos:
            f.write(f'{yt_tiempo(inicio)} {nombre}\n')
        f.write('\nVoz sintética (Microsoft Edge TTS). Material de preparación no oficial.\n'
                'Víctor Gutiérrez Marcos · victorgutierrezmarcos.es\n')
    print(f'Vídeo: {mp4} ({yt_tiempo(t)}, {len(segmentos)} pasos)')


if __name__ == '__main__':
    main()
