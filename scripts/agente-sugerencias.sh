#!/bin/bash
# Lanza el agente diario de sugerencias (scripts/agente-sugerencias.py) desde la tarea programada
# de Windows «AgenteSugerenciasTCEE»:
#   C:\Users\vgutierrez\bin\agente-sugerencias.cmd  (que hace: wsl.exe -e bash <este fichero>)
# Para crearla o cambiarla (desde WSL; PowerShell está bloqueado):
#   cmd.exe /c 'schtasks /create /f /tn AgenteSugerenciasTCEE /xml C:\Users\vgutierrez\bin\agente-sugerencias.xml'
#   (el XML: cada día a las 08:30 y, si a esa hora el ordenador estaba apagado, en cuanto se enciende y se inicia sesión)
# Para quitarla:  cmd.exe /c 'schtasks /delete /f /tn AgenteSugerenciasTCEE'
export HOME="${HOME:-/home/vgutierrez}"
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/bin:/bin"
# La cuenta de Claude Code que paga los tokens: la personal de Víctor (~/.claude), fijada el 12 nov. 2026.
# Para usar la del trabajo: AGENTE_CLAUDE=trabajo en el entorno de la tarea.
if [ "$AGENTE_CLAUDE" = "trabajo" ]; then export CLAUDE_CONFIG_DIR="$HOME/.claude-trabajo"; else unset CLAUDE_CONFIG_DIR; fi
# Detrás del proxy del trabajo, que intercepta TLS.
[ -f "$HOME/.local/share/tcee-herramientas/certificados/cas.pem" ] && export NODE_EXTRA_CA_CERTS="$HOME/.local/share/tcee-herramientas/certificados/cas.pem"
[ -f "$HOME/.config/oposicion-red/cas.pem" ] && export SSL_CERT_FILE="$HOME/.config/oposicion-red/cas.pem"
cd "$(dirname "$0")/.." || exit 1
mkdir -p "$HOME/.local/share/oposicion-web/sugerencias/agente"
exec python3 scripts/agente-sugerencias.py "$@" >> "$HOME/.local/share/oposicion-web/sugerencias/agente/salida.log" 2>&1
