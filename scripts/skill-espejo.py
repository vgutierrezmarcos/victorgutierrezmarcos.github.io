#!/usr/bin/env python3
"""
Espejo público de la skill «Prepara con Claude» para `npx skills add`.

Copia la carpeta desplegada de la skill (oposicion/temario/app/skill/prepara-oposicion/,
la misma que lee claude.ai de la web) a un repositorio público de GitHub con un
README, y hace un commit por versión. Con ese repositorio, en Claude Code, Cursor,
Codex y similares la skill se instala con:

    npx skills add victorgutierrezmarcos/prepara-oposicion

(la CLI de Vercel lee SKILL.md de la raíz de un repositorio público). Para claude.ai
en el navegador o el móvil no cambia nada: sigue el ZIP o el botón «Empezar en Claude».
La copia desplegada ya es pública en GitHub Pages, así que el espejo no expone nada nuevo.

    python3 scripts/skill-espejo.py                       # empuja a victorgutierrezmarcos/prepara-oposicion
    python3 scripts/skill-espejo.py --repo usuario/nombre # otro repositorio destino
    python3 scripts/skill-espejo.py --probar              # prepara el clon y enseña el diff, sin commit ni push

El repositorio se crea UNA sola vez, a mano (Víctor decide cuándo):

    gh auth switch -u vgutierrezmarcos
    gh repo create victorgutierrezmarcos/prepara-oposicion --public \\
        --description "Skill de Claude para preparar la oposición a TCEE y DCE (victorgutierrezmarcos.es)"

Después, cada vez que scripts/skill-opositor.py publique una versión nueva (version.json),
este script la lleva al espejo: clona el repo en una carpeta temporal, vacía el árbol,
copia la skill desplegada, escribe README.md (y .gitignore), y hace el commit
«Skill prepara-oposicion <versión>» y el push. Si la versión del espejo (VERSION.txt)
ya es la desplegada, no hace nada. Necesita `gh` con sesión en la cuenta
vgutierrezmarcos (o `git` con acceso por SSH/HTTPS al repositorio).

Autor: Víctor Gutiérrez Marcos
"""
import argparse
import json
import os
import shutil
import subprocess
import sys
import tempfile

RAIZ = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DESPLEGADA = os.path.join(RAIZ, 'oposicion', 'temario', 'app', 'skill')
NOMBRE = 'prepara-oposicion'
REPO = 'victorgutierrezmarcos/prepara-oposicion'
PAGINA = 'https://www.victorgutierrezmarcos.es/oposicion/economia.html'
CONDICIONES = 'https://www.victorgutierrezmarcos.es/condiciones-materiales.html'

README = '''# Prepara con Claude · skill «prepara-oposicion»

Equipo de preparación con IA para las oposiciones a **Técnico Comercial y Economista del Estado (TCEE)** y
**Diplomado Comercial del Estado (DCE)**: corrige cantes transcritos y dictámenes de coyuntura, resuelve dudas
con el temario de [victorgutierrezmarcos.es](https://www.victorgutierrezmarcos.es/), organiza el cronograma,
hace tests a medida con las preguntas oficiales, simula al tribunal y lee los datos que exporta la app
«Oposición TCEE · DCE». Es una *skill* de Claude (Anthropic): un `SKILL.md` que enruta la petición a los
agentes de `references/agentes/` y el material del temario revisado.

Este repositorio es un **espejo** de la copia desplegada en la web; se actualiza con cada versión
({version}, generada el {generado}). La skill instalada comprueba sola si hay una versión nueva en la web.

## Cómo instalarla

- **En claude.ai (navegador o móvil)**: sube el ZIP de la skill desde la app (Más → Prepara con Claude) o
  desde la [página de la skill]({pagina}) (Customize → Skills → Subir), o usa el botón **«Empezar en Claude»**
  de esa página, que abre un chat que la lee de la web sin instalar nada. Hace falta una cuenta de pago
  (Pro, Max o Team); la skill y el material son gratuitos.
- **En Claude Code, Cursor, Codex y similares**:

  ```
  npx skills add {repo}
  ```

- A mano: copia esta carpeta a `~/.claude/skills/{nombre}/`.

Cómo usarla, el vídeo y las preguntas frecuentes: {pagina}

## Licencia

Material exclusivo de victorgutierrezmarcos.es y la app Oposición TCEE · DCE, © Víctor Gutiérrez Marcos; las
referencias de DCE se publican con permiso de Manuel Cabado García. **Licencia de uso personal**: puedes usar la
skill y sus materiales (en especial `references/temas`, `references/dictamen` y `references/canon`) para tu
propia preparación de la oposición, en tu cuenta de Claude. No se autoriza subirlos a otras plataformas o
asistentes, redistribuirlos, modificarlos para difundirlos ni usarlos para entrenar o alimentar otros sistemas
de IA (se reserva el derecho de minería de textos y datos). Condiciones completas en `LICENCIA.md` y en
{condiciones}. El programa oficial y los exámenes oficiales son documentos del Ministerio de Economía,
Comercio y Empresa y no son exclusivos.

*Claude no sustituye a un preparador para la oposición: lo complementa.*
'''


def correr(args, cwd=None, capturar=False):
    r = subprocess.run(args, cwd=cwd, text=True, capture_output=capturar)
    if r.returncode:
        sys.exit(f'Falló: {" ".join(args)}' + (f'\n{r.stderr}' if capturar else ''))
    return r.stdout if capturar else ''


def version_desplegada():
    ruta = os.path.join(DESPLEGADA, 'version.json')
    if not os.path.exists(ruta):
        sys.exit(f'No hay skill desplegada en {DESPLEGADA} (ejecuta antes scripts/skill-opositor.py)')
    with open(ruta, encoding='utf-8') as f:
        return json.load(f)


def version_espejo(clon):
    ruta = os.path.join(clon, 'VERSION.txt')
    if not os.path.exists(ruta):
        return ''
    with open(ruta, encoding='utf-8') as f:
        for linea in f:
            if linea.startswith('version:'):
                return linea.split(':', 1)[1].strip()
    return ''


def main():
    p = argparse.ArgumentParser(description='Empuja la skill desplegada a su espejo público para `npx skills add`.')
    p.add_argument('--repo', default=REPO, help=f'repositorio destino usuario/nombre (por defecto {REPO})')
    p.add_argument('--probar', action='store_true', help='prepara el clon y enseña el diff; sin commit ni push')
    args = p.parse_args()

    version = version_desplegada()
    origen = os.path.join(DESPLEGADA, NOMBRE)
    if not os.path.isdir(origen):
        sys.exit(f'Falta la carpeta desplegada {origen}')
    if not shutil.which('gh') and not shutil.which('git'):
        sys.exit('Hacen falta gh o git')

    temporal = tempfile.mkdtemp(prefix='skill-espejo-')
    clon = os.path.join(temporal, 'repo')
    try:
        if shutil.which('gh'):
            correr(['gh', 'repo', 'clone', args.repo, clon, '--', '--depth', '1'])
        else:
            correr(['git', 'clone', '--depth', '1', f'https://github.com/{args.repo}.git', clon])
        if version_espejo(clon) == version['version'] and not args.probar:
            print(f'El espejo ya tiene la versión {version["version"]}; nada que hacer.')
            return
        # Vaciar el árbol (salvo .git) y copiar la skill desplegada
        for nombre in os.listdir(clon):
            if nombre == '.git':
                continue
            ruta = os.path.join(clon, nombre)
            shutil.rmtree(ruta) if os.path.isdir(ruta) else os.remove(ruta)
        shutil.copytree(origen, clon, dirs_exist_ok=True)
        with open(os.path.join(clon, 'README.md'), 'w', encoding='utf-8', newline='\n') as f:
            f.write(README.format(version=version['version'], generado=version['generado'], pagina=PAGINA,
                                  repo=args.repo, nombre=NOMBRE, condiciones=CONDICIONES))
        with open(os.path.join(clon, '.gitignore'), 'w', encoding='utf-8', newline='\n') as f:
            f.write('__pycache__/\n*.pyc\n')
        correr(['git', 'add', '-A'], cwd=clon)
        estado = correr(['git', 'status', '--porcelain'], cwd=clon, capturar=True)
        if not estado.strip():
            print('El espejo ya está al día con la copia desplegada; nada que hacer.')
            return
        n = len(estado.strip().splitlines())
        if args.probar:
            print(correr(['git', 'diff', '--cached', '--stat'], cwd=clon, capturar=True))
            print(f'--probar: {n} ficheros cambiarían; el clon queda en {clon} (no se ha hecho commit ni push).')
            temporal = ''  # no borrar: que se pueda mirar
            return
        correr(['git', 'commit', '-q', '-m', f'Skill {NOMBRE} {version["version"]}',
                '-m', f'Copia de {version["base"]} generada el {version["generado"]} ({len(version.get("temas", []))} temas revisados).'],
               cwd=clon)
        correr(['git', 'push', '-q'], cwd=clon)
        print(f'Espejo actualizado: {args.repo} → versión {version["version"]} ({n} ficheros). '
              f'Instalación: npx skills add {args.repo}')
    finally:
        if temporal and os.path.isdir(temporal):
            shutil.rmtree(temporal, ignore_errors=True)


if __name__ == '__main__':
    main()
