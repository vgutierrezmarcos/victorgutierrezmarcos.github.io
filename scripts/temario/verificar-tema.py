#!/usr/bin/env python3
"""
Comprueba que un tema revisado está listo para que lo lea Víctor
(último paso de /revisartema, lo usa el agente tema-control-calidad).

    python3 scripts/temario/verificar-tema.py 3A08 [--json]

Errores (el tema no está terminado):
  - quedan marcas ⟦…⟧ de la extracción, «Fuente: …» vacías o notas de trabajo
    (TODO, PENDIENTE, XXX) en la fuente;
  - alguna figura no tiene \\fuente{…};
  - faltan el PDF, el HTML o el Word, o son más antiguos que la fuente;
  - el PDF tiene referencias o citas sin definir;
  - el HTML tiene LaTeX sin convertir o imágenes que no existen;
  - el Word no se abre;
  - faltan revision.md, guion-cante.md o video/escenas.yaml.

Avisos (para que los mire el control de calidad):
  - párrafos con cifras (%, millones, años recientes) sin cita en ese párrafo;
  - palabras del guion y de la narración del vídeo lejos de ≈5.500;
  - números de tema dichos en voz alta.
Y comprueba los criterios del cante: sin saludo al tribunal, conclusión que
empieza por «En conclusión» y sin gracias al final.

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import re
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from comun import Tema  # noqa: E402

PALABRAS_POR_MINUTO = 185
SECCIONES_INFORME = ['Resumen', 'Errores corregidos', 'Marcas resueltas', 'Datos actualizados',
                     'Coherencia', 'Dudas abiertas']


def leer(ruta):
    return open(ruta, encoding='utf-8', errors='replace').read() if os.path.exists(ruta) else None


def parrafos_tex(tex):
    cuerpo = tex.split('\\begin{document}', 1)[-1]
    return [p for p in re.split(r'\n\s*\n|\\item\b', cuerpo) if p.strip()]


def verificar(tema):
    errores, avisos, datos = [], [], {}
    tex_ruta = os.path.join(tema.dir, f'{tema.archivo}.tex')
    tex = leer(tex_ruta)
    if tex is None:
        return [f'No existe la fuente {tema.archivo}.tex'], avisos, datos
    if not os.path.exists(tema.lyx):
        avisos.append(f'No existe {tema.archivo}.lyx (¿está instalado LyX?)')

    # --- Fuente ---------------------------------------------------------------
    for patron, texto in ((r'⟦[^⟧]*⟧', 'marca de la extracción'), (r'\b(TODO|PENDIENTE|XXX|FIXME)\b', 'nota de trabajo'),
                          (r'\\fuente\{\s*(…|\.\.\.)?\s*\}', '«Fuente» vacía')):
        for m in re.finditer(patron, tex):
            linea = tex.count('\n', 0, m.start()) + 1
            errores.append(f'{texto} en {tema.archivo}.tex:{linea}: {m.group(0)[:60]}')
    figuras = re.findall(r'\\begin\{figure\}(.*?)\\end\{figure\}', tex, re.S)
    for i, fig in enumerate(figuras, 1):
        if '\\fuente{' not in fig:
            cap = re.search(r'\\caption\{([^}]*)', fig)
            errores.append(f'Figura {i} sin \\fuente: {cap.group(1)[:60] if cap else ""}')
    datos['figuras'] = len(figuras)
    datos['citas'] = len(re.findall(r'\\(?:foot|auto|text|paren)?cite\b', tex))
    datos['notas_al_pie'] = len(re.findall(r'\\footnote\b', tex)) + len(re.findall(r'\\footcite\b', tex))
    graficos_usados = set(re.findall(r'\\(?:grafico|includegraphics)(?:\[[^\]]*\])?\{([^}]+)\}', tex))
    for g in graficos_usados:
        base = os.path.join(tema.graficos, os.path.splitext(g)[0])
        if not any(os.path.exists(base + ext) for ext in ('.tex', '.png', '.jpg', '.jpeg', '.pdf', '.svg')):
            errores.append(f'Gráfico inexistente: {g}')
    datos['graficos_tikz'] = len([f for f in os.listdir(tema.graficos) if f.endswith('.tex')]) \
        if os.path.isdir(tema.graficos) else 0

    # Cifras sin cita en el mismo párrafo
    sin_cita = 0
    for p in parrafos_tex(tex):
        texto = re.sub(r'\$[^$]*\$|\\\[.*?\\\]', '', p, flags=re.S)
        if re.search(r'\d+(?:[.,]\d+)?\s*(?:\\?%|por ciento|millones|mill\.|billones|€|puntos)|\b20[12]\d\b', texto) \
                and not re.search(r'\\(?:foot|auto|text|paren)?cite|\\footnote|\\fuente', p):
            sin_cita += 1
            if sin_cita <= 15:
                avisos.append('Cifra sin cita: ' + re.sub(r'\s+', ' ', texto.strip())[:140])
    datos['parrafos_con_cifras_sin_cita'] = sin_cita

    # --- Resultados ---------------------------------------------------------------
    mtime_fuente = max(os.path.getmtime(tex_ruta), os.path.getmtime(tema.lyx) if os.path.exists(tema.lyx) else 0)
    for ext in ('pdf', 'html', 'docx'):
        ruta = os.path.join(tema.dir_publico, f'{tema.archivo}.{ext}')
        if not os.path.exists(ruta):
            errores.append(f'Falta {tema.carpeta}/{tema.archivo}.{ext} (ejecutar construir-tema.py)')
        elif os.path.getmtime(ruta) + 1 < mtime_fuente:
            errores.append(f'{tema.archivo}.{ext} es anterior a la fuente: volver a construir')
    log = leer(os.path.join(tema.trabajo, f'{tema.archivo}.log')) if os.path.exists(
        os.path.join(tema.trabajo, f'{tema.archivo}.log')) else None
    if log is None and os.path.exists(os.path.join(tema.trabajo, f'{tema.archivo}.log')):
        log = open(os.path.join(tema.trabajo, f'{tema.archivo}.log'), encoding='latin-1').read()
    if log:
        for m in set(re.findall(r'(?:Reference|Citation) [`\']([^\']+)\' on page \d+ undefined', log)):
            errores.append(f'Referencia o cita sin definir en el PDF: {m}')
        datos['avisos_overfull'] = len(re.findall(r'Overfull \\hbox \((\d{2,})', log))
    html = leer(os.path.join(tema.dir_publico, f'{tema.archivo}.html'))
    if html:
        sin_math = re.sub(r'\\\(.*?\\\)|\\\[.*?\\\]', '', html, flags=re.S)
        for m in set(re.findall(r'\\(?:textbf|emph|textit|begin|end|cite|footcite|ref|label|capa|fuente)\b', sin_math)):
            errores.append(f'LaTeX sin convertir en el HTML: {m}')
        for src in re.findall(r'<img[^>]+src="([^"]+)"', html):
            if not src.startswith('http') and not os.path.exists(os.path.normpath(os.path.join(tema.dir_publico, src))):
                errores.append(f'Imagen inexistente en el HTML: {src}')
    docx = os.path.join(tema.dir_publico, f'{tema.archivo}.docx')
    if os.path.exists(docx):
        try:
            from docx import Document
            d = Document(docx)
            datos['docx_imagenes'] = len(d.inline_shapes)
            for p in d.paragraphs:
                if re.search(r'\\[a-zA-Z]{2,}\{|\$\$', p.text):
                    errores.append(f'LaTeX sin convertir en el Word: {p.text[:80]}')
        except Exception as e:
            errores.append(f'El Word no se abre: {e}')

    # --- Informe, guion y vídeo -------------------------------------------------------
    informe = leer(os.path.join(tema.dir, 'revision.md'))
    if informe is None:
        errores.append('Falta revision.md (informe de revisión)')
    else:
        for s in SECCIONES_INFORME:
            if not re.search(rf'^#+\s*{re.escape(s)}', informe, re.M | re.I):
                errores.append(f'revision.md sin la sección «{s}»')
    guion = leer(os.path.join(tema.dir, 'guion-cante.md'))
    if guion is None:
        errores.append('Falta guion-cante.md')
    else:
        # Solo lo que se dice: fuera títulos, el esquema de pizarra y las notas [Pizarra: …]
        hablado = re.sub(r'^## Esquema de pizarra.*?(?=^## )', '', guion, flags=re.M | re.S)
        hablado = re.sub(r'^```.*?^```', '', hablado, flags=re.M | re.S)
        hablado = re.sub(r'\[[^\]\n]*\]|^#.*$|^>.*$|\|.*\|', '', hablado, flags=re.M)
        palabras = len(re.findall(r'\w+', hablado))
        datos['guion_palabras'] = palabras
        datos['guion_minutos_estimados'] = round(palabras / PALABRAS_POR_MINUTO, 1)
        if not 28 <= palabras / PALABRAS_POR_MINUTO <= 32:
            avisos.append(f'El guion da {palabras / PALABRAS_POR_MINUTO:.1f} min a {PALABRAS_POR_MINUTO} palabras/min')
    escenas = leer(os.path.join(tema.dir, 'video', 'escenas.yaml'))
    if escenas is None:
        errores.append('Falta video/escenas.yaml')
    else:
        import yaml
        try:
            g = yaml.safe_load(escenas)
            escs = g['escenas']
            dichos = [p.get('di', '') for e in escs for p in e.get('pasos', [])]
            palabras_video = len(re.findall(r'\w+', ' '.join(dichos)))
            datos['video_palabras'] = palabras_video
            # La voz del vídeo (+15 %) dice unas 185 palabras por minuto; el script
            # ajusta el ritmo para que dure 30:00 (generar-video.py --medir da la cifra exacta)
            datos['video_minutos_naturales_estimados'] = round(palabras_video / 185, 1)
            if not 5000 <= palabras_video <= 6000:
                avisos.append(f'La narración del vídeo tiene {palabras_video} palabras (objetivo ≈5.500)')
            if 'bloques' not in g:
                errores.append('escenas.yaml sin «bloques» (formato antiguo del vídeo)')
            nombres = {b['nombre'] for b in g.get('bloques', [])}
            for i, e in enumerate(escs, 1):
                if e.get('bloque') not in nombres:
                    errores.append(f'Escena {i}: el bloque «{e.get("bloque")}» no está en «bloques»')
                for p in e.get('pasos', []):
                    acciones = p.get('pizarra') or []
                    for a in (acciones if isinstance(acciones, list) else [acciones]):
                        if a.get('grafico') and not os.path.exists(os.path.join(tema.graficos, a['grafico'] + '.tex')):
                            errores.append(f'escenas.yaml usa un gráfico inexistente: {a["grafico"]}')
            # Criterios del cante (CRITERIOS.md, 8)
            texto = ' '.join(dichos)
            if re.search(r'miembros del tribunal', texto, re.I):
                errores.append('El cante saluda al tribunal («Señores miembros del tribunal»): se empieza por el título')
            if re.search(r'\b(muchas gracias|gracias por su atención|gracias)\b', ' '.join(dichos[-3:]), re.I):
                errores.append('El cante termina dando las gracias')
            concl = [e for e in escs if re.match(r'conclusi', str(e.get('bloque', '')), re.I)]
            if concl:
                primero = next((p.get('di', '') for p in concl[0].get('pasos', []) if p.get('di')), '')
                if not re.match(r'\s*(En conclusión|A modo de conclusión)', primero):
                    errores.append('La conclusión no empieza por «En conclusión» o «A modo de conclusión»')
            for m in set(re.findall(r'\btema\s+(?:\d|tres|cuatro)[\w .]*?(?=[,.;:]|$)', texto, re.I)):
                avisos.append(f'Se dice un número de tema en voz alta: «{m.strip()[:40]}»')
            if re.search(r'\btermino ya\b', texto, re.I):
                avisos.append('«termino ya»: la conclusión empieza por «En conclusión»')
        except Exception as e:
            errores.append(f'escenas.yaml no es válido: {e}')
    return errores, avisos, datos


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(2)
    tema = Tema(sys.argv[1])
    errores, avisos, datos = verificar(tema)
    if '--json' in sys.argv:
        print(json.dumps({'tema': tema.codigo, 'errores': errores, 'avisos': avisos, 'datos': datos},
                         ensure_ascii=False, indent=2))
    else:
        print(f'Tema {tema}: {len(errores)} errores, {len(avisos)} avisos')
        for e in errores:
            print('  ERROR', e)
        for a in avisos:
            print('  aviso', a)
        print('  ' + ', '.join(f'{k}: {v}' for k, v in datos.items()))
    sys.exit(1 if errores else 0)


if __name__ == '__main__':
    main()
