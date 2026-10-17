#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Limpia un .docx para publicarlo: elimina el texto oculto (w:vanish), acepta los
cambios controlados, borra comentarios, normaliza los metadatos de autoria,
recomprime las imagenes incrustadas y pone la licencia CC BY-NC-ND 4.0 en las
propiedades del documento (Comentarios y las personalizadas «Licencia» y «URL
de la licencia»), sin tocar el texto.

Uso:
    python3 scripts/limpiar-docx.py entrada.docx salida.docx
    python3 scripts/limpiar-docx.py --licencia a.docx b.docx ...   # solo la licencia, en el sitio
"""

import io
import os
import re
import sys
import zipfile

from lxml import etree

try:
    from PIL import Image
except ImportError:  # la optimizacion de imagenes es opcional
    Image = None

W = "http://schemas.openxmlformats.org/wordprocessingml/2006/main"
NS = {"w": W}

AUTOR = "Víctor Gutiérrez Marcos"

# Licencia (la misma que LICENSE.md, el pie de la web y los metadatos de los PDF)
LICENCIA = "CC BY-NC-ND 4.0"
LICENCIA_URL = "https://creativecommons.org/licenses/by-nc-nd/4.0/deed.es"
LICENCIA_URL_LEGAL = "https://creativecommons.org/licenses/by-nc-nd/4.0/"
PERMISOS = "puedes compartirlo citando al autor, sin fines comerciales y sin modificarlo"
CUSTOM = "http://schemas.openxmlformats.org/officeDocument/2006/custom-properties"
VT = "http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes"
REL_CUSTOM = "http://schemas.openxmlformats.org/officeDocument/2006/relationships/custom-properties"
TIPO_CUSTOM = "application/vnd.openxmlformats-officedocument.custom-properties+xml"
FMTID = "{D5CDD505-2E9C-101B-9397-08002B2CF9AE}"

# Partes del paquete que pueden contener texto oculto
PARTES_TEXTO = re.compile(
    r"^word/(document\.xml|header\d*\.xml|footer\d*\.xml|footnotes\.xml|"
    r"endnotes\.xml|glossary/document\.xml)$"
)

MAX_LADO = 1600
CALIDAD_JPEG = 82


def q(tag):
    return "{%s}%s" % (W, tag)


def _activo(el):
    """Un elemento booleano de OOXML esta activo salvo que lleve w:val 0/false/off."""
    if el is None:
        return False
    val = el.get(q("val"))
    return val not in ("0", "false", "off")


def estilos_ocultos(xml_estilos):
    """Devuelve el conjunto de styleId cuyo formato efectivo es 'oculto',
    resolviendo la herencia via w:basedOn."""
    if xml_estilos is None:
        return set()
    raiz = etree.fromstring(xml_estilos)
    propio = {}      # styleId -> True / False / None (no dice nada)
    padre = {}
    for st in raiz.findall(q("style")):
        sid = st.get(q("styleId"))
        if not sid:
            continue
        rpr = st.find(q("rPr"))
        vanish = rpr.find(q("vanish")) if rpr is not None else None
        propio[sid] = None if vanish is None else _activo(vanish)
        base = st.find(q("basedOn"))
        if base is not None:
            padre[sid] = base.get(q("val"))

    cache = {}

    def resolver(sid, visto=()):
        if sid in cache:
            return cache[sid]
        if sid not in propio or sid in visto:
            return False
        v = propio[sid]
        if v is None:
            v = resolver(padre.get(sid), visto + (sid,)) if padre.get(sid) else False
        cache[sid] = v
        return v

    return {sid for sid in propio if resolver(sid)}


def _rpr_oculto(rpr, ocultos):
    if rpr is None:
        return False
    vanish = rpr.find(q("vanish"))
    if vanish is not None:
        return _activo(vanish)
    rstyle = rpr.find(q("rStyle"))
    if rstyle is not None and rstyle.get(q("val")) in ocultos:
        return True
    return False


def _quitar(el):
    padre = el.getparent()
    if padre is not None:
        padre.remove(el)


def limpiar_parte(xml, ocultos, stats):
    raiz = etree.fromstring(xml)

    # --- cambios controlados: aceptar inserciones, descartar eliminaciones ---
    for ins in raiz.findall(".//" + q("ins")):
        padre = ins.getparent()
        idx = list(padre).index(ins)
        for hijo in reversed(list(ins)):
            padre.insert(idx, hijo)
        padre.remove(ins)
        stats["ins"] += 1
    for dele in raiz.findall(".//" + q("del")):
        _quitar(dele)
        stats["del"] += 1

    # --- comentarios ---
    for tag in ("commentRangeStart", "commentRangeEnd", "commentReference"):
        for el in raiz.findall(".//" + q(tag)):
            # commentReference vive dentro de un run que solo sirve de ancla
            padre = el.getparent()
            _quitar(el)
            if tag == "commentReference" and padre is not None and padre.tag == q("r"):
                _quitar(padre)
            stats["comentarios"] += 1

    # --- bloques sdt ocultos (indices/TDC marcados como ocultos) ---
    for sdt in raiz.findall(".//" + q("sdt")):
        sdtpr = sdt.find(q("sdtPr"))
        if sdtpr is not None and _rpr_oculto(sdtpr.find(q("rPr")), ocultos):
            _quitar(sdt)
            stats["sdt"] += 1

    # --- parrafos con estilo de parrafo oculto ---
    for p in raiz.findall(".//" + q("p")):
        ppr = p.find(q("pPr"))
        if ppr is None:
            continue
        pstyle = ppr.find(q("pStyle"))
        if pstyle is not None and pstyle.get(q("val")) in ocultos:
            _quitar(p)
            stats["parrafos"] += 1

    # --- runs ocultos ---
    for r in raiz.findall(".//" + q("r")):
        if _rpr_oculto(r.find(q("rPr")), ocultos):
            _quitar(r)
            stats["runs"] += 1

    # --- parrafos cuya marca de parrafo esta oculta y ya no tienen contenido ---
    for p in raiz.findall(".//" + q("p")):
        ppr = p.find(q("pPr"))
        if ppr is None:
            continue
        rpr = ppr.find(q("rPr"))
        if not _rpr_oculto(rpr, ocultos):
            continue
        if p.find(".//" + q("r")) is None:
            _quitar(p)
            stats["parrafos"] += 1

    return etree.tostring(raiz, xml_declaration=True, encoding="UTF-8", standalone=True)


def limpiar_core(xml):
    raiz = etree.fromstring(xml)
    ns = raiz.nsmap
    dc = ns.get("dc", "http://purl.org/dc/elements/1.1/")
    cp = ns.get("cp", "http://schemas.openxmlformats.org/package/2006/metadata/core-properties")
    for tag, valor in (("{%s}creator" % dc, AUTOR), ("{%s}lastModifiedBy" % cp, AUTOR)):
        el = raiz.find(tag)
        if el is None:
            el = etree.SubElement(raiz, tag)
        el.text = valor
    for tag in ("{%s}revision" % cp, "{%s}lastPrinted" % cp):
        el = raiz.find(tag)
        if el is not None:
            raiz.remove(el)
    return etree.tostring(raiz, xml_declaration=True, encoding="UTF-8", standalone=True)


def _anio_core(xml):
    m = re.search(rb"<dcterms:created[^>]*>(\d{4})", xml or b"")
    return m.group(1).decode() if m else ""


def licencia_corta(anio):
    return "© %s%s · %s" % (anio + " " if anio else "", AUTOR, LICENCIA)


def licencia_larga(anio):
    return "© %s%s · Licencia %s (%s): %s." % (anio + " " if anio else "", AUTOR, LICENCIA,
                                              LICENCIA_URL, PERMISOS)


def licencia_core(xml):
    """dc:description (Comentarios) = la licencia completa."""
    raiz = etree.fromstring(xml)
    dc = raiz.nsmap.get("dc", "http://purl.org/dc/elements/1.1/")
    el = raiz.find("{%s}description" % dc)
    if el is None:
        el = etree.SubElement(raiz, "{%s}description" % dc)
    el.text = licencia_larga(_anio_core(xml))
    return etree.tostring(raiz, xml_declaration=True, encoding="UTF-8", standalone=True)


def licencia_custom(xml, anio):
    """Propiedades personalizadas «Licencia» y «URL de la licencia»."""
    if xml:
        raiz = etree.fromstring(xml)
    else:
        raiz = etree.Element("{%s}Properties" % CUSTOM, nsmap={None: CUSTOM, "vt": VT})
    nombres = ("Licencia", "URL de la licencia")
    for p in raiz.findall("{%s}property" % CUSTOM):
        if p.get("name") in nombres:
            raiz.remove(p)
    pid = max([int(p.get("pid", "1")) for p in raiz.findall("{%s}property" % CUSTOM)] + [1])
    for nombre, valor in zip(nombres, (licencia_corta(anio), LICENCIA_URL_LEGAL)):
        pid += 1
        p = etree.SubElement(raiz, "{%s}property" % CUSTOM, fmtid=FMTID, pid=str(pid), name=nombre)
        etree.SubElement(p, "{%s}lpwstr" % VT).text = valor
    return etree.tostring(raiz, xml_declaration=True, encoding="UTF-8", standalone=True)


def poner_licencia(ruta):
    """Escribe la licencia en las propiedades de un .docx ya hecho (en el sitio).
    Las demas partes se copian tal cual. Devuelve False si ya la tenia."""
    with zipfile.ZipFile(ruta) as zin:
        nombres = zin.namelist()
        core = zin.read("docProps/core.xml") if "docProps/core.xml" in nombres else None
        custom = zin.read("docProps/custom.xml") if "docProps/custom.xml" in nombres else None
        anio = _anio_core(core)
        if core is not None and custom is not None and licencia_larga(anio).encode() in core \
                and LICENCIA_URL_LEGAL.encode() in custom:
            return False
        buf = io.BytesIO()
        with zipfile.ZipFile(buf, "w", zipfile.ZIP_DEFLATED) as zout:
            for info in zin.infolist():
                datos = zin.read(info.filename)
                if info.filename == "docProps/core.xml":
                    datos = licencia_core(datos)
                elif info.filename == "docProps/custom.xml":
                    datos = licencia_custom(datos, anio)
                elif info.filename == "[Content_Types].xml" and b"/docProps/custom.xml" not in datos:
                    datos = datos.replace(b"</Types>", ('<Override PartName="/docProps/custom.xml" '
                                                       'ContentType="%s"/></Types>' % TIPO_CUSTOM).encode())
                elif info.filename == "_rels/.rels" and REL_CUSTOM.encode() not in datos:
                    ids = [int(i) for i in re.findall(rb'Id="rId(\d+)"', datos)] + [0]
                    datos = datos.replace(b"</Relationships>", (
                        '<Relationship Id="rId%d" Type="%s" Target="docProps/custom.xml"/></Relationships>'
                        % (max(ids) + 1, REL_CUSTOM)).encode())
                zout.writestr(info, datos)
            if custom is None:
                zout.writestr("docProps/custom.xml", licencia_custom(None, anio))
    with open(ruta, "wb") as fh:
        fh.write(buf.getvalue())
    return True


def limpiar_app(xml):
    raiz = etree.fromstring(xml)
    for el in raiz:
        if etree.QName(el).localname in ("Company", "Manager"):
            el.text = ""
    return etree.tostring(raiz, xml_declaration=True, encoding="UTF-8", standalone=True)


def optimizar_imagen(nombre, datos, stats):
    """Devuelve los bytes optimizados, o los originales si no se puede mejorar.
    Mantiene el formato del fichero para no tener que tocar los rels."""
    if Image is None:
        return datos
    ext = os.path.splitext(nombre)[1].lower()
    if ext not in (".png", ".jpg", ".jpeg", ".gif"):
        return datos  # wmf/emf/wdp: Pillow no los maneja con garantias
    try:
        im = Image.open(io.BytesIO(datos))
        if getattr(im, "n_frames", 1) > 1:
            return datos  # animacion: se conserva tal cual
        im.load()
        alfa = im.mode in ("RGBA", "LA", "PA") or "transparency" in im.info
        if max(im.size) > MAX_LADO:
            factor = MAX_LADO / max(im.size)
            nuevo = (max(1, int(im.width * factor)), max(1, int(im.height * factor)))
            im = im.convert("RGBA" if alfa else "RGB").resize(nuevo, Image.LANCZOS)
        salida = io.BytesIO()
        if ext in (".jpg", ".jpeg"):
            im.convert("RGB").save(salida, "JPEG", quality=CALIDAD_JPEG, optimize=True)
        elif ext == ".gif":
            im.convert("P", palette=Image.ADAPTIVE).save(salida, "GIF", optimize=True)
        elif alfa:
            # conserva transparencia: PNG optimizado
            im.convert("RGBA").save(salida, "PNG", optimize=True)
        else:
            im.convert("RGB").save(salida, "PNG", optimize=True)
        nuevos = salida.getvalue()
    except Exception:
        return datos
    if len(nuevos) < len(datos):
        stats["imagenes"] += 1
        stats["bytes_img"] += len(datos) - len(nuevos)
        return nuevos
    return datos


def limpiar(entrada, salida):
    stats = dict(runs=0, parrafos=0, sdt=0, ins=0, **{"del": 0},
                 comentarios=0, imagenes=0, bytes_img=0)
    zin = zipfile.ZipFile(entrada)
    nombres = set(zin.namelist())
    ocultos = estilos_ocultos(zin.read("word/styles.xml") if "word/styles.xml" in nombres else None)

    comentarios = {n for n in nombres if re.match(r"^word/comments.*\.xml$", n)}

    buf = io.BytesIO()
    zout = zipfile.ZipFile(buf, "w", zipfile.ZIP_DEFLATED, compresslevel=9)
    for info in zin.infolist():
        nombre = info.filename
        if nombre in comentarios:
            continue
        datos = zin.read(nombre)
        if PARTES_TEXTO.match(nombre):
            datos = limpiar_parte(datos, ocultos, stats)
        elif nombre == "docProps/core.xml":
            datos = limpiar_core(datos)
        elif nombre == "docProps/app.xml":
            datos = limpiar_app(datos)
        elif nombre == "[Content_Types].xml" and comentarios:
            datos = re.sub(rb'<Override[^>]*comments[^>]*/>', b"", datos)
        elif nombre.endswith(".rels") and comentarios:
            datos = re.sub(rb'<Relationship[^>]*comments[^>]*/>', b"", datos)
        elif nombre.startswith("word/media/"):
            datos = optimizar_imagen(nombre, datos, stats)
        zout.writestr(nombre, datos)
    zout.close()
    zin.close()

    with open(salida, "wb") as fh:
        fh.write(buf.getvalue())
    poner_licencia(salida)
    return stats


def main():
    if len(sys.argv) > 2 and sys.argv[1] == "--licencia":
        for ruta in sys.argv[2:]:
            print(("✓ " if poner_licencia(ruta) else "= ") + ruta)
        return 0
    if len(sys.argv) != 3:
        print(__doc__)
        return 1
    entrada, salida = sys.argv[1], sys.argv[2]
    antes = os.path.getsize(entrada)
    stats = limpiar(entrada, salida)
    despues = os.path.getsize(salida)
    print(
        "%s: %.1f MB -> %.1f MB | runs=%d parrafos=%d sdt=%d comentarios=%d "
        "ins=%d del=%d imagenes=%d"
        % (os.path.basename(salida), antes / 1e6, despues / 1e6, stats["runs"],
           stats["parrafos"], stats["sdt"], stats["comentarios"], stats["ins"],
           stats["del"], stats["imagenes"])
    )
    return 0


if __name__ == "__main__":
    sys.exit(main())
