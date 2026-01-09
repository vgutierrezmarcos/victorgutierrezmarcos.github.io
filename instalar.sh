#!/bin/bash

# Script de instalación para el sistema de descarga ZIP automática
# Víctor Gutiérrez Marcos - victorgutierrezmarcos.es

echo "======================================"
echo "Instalación ZIP automático con GitHub Actions"
echo "======================================"
echo ""

# Colores para output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 1. Verificar que estamos en un repositorio git
if [ ! -d .git ]; then
    echo "❌ Error: No estás en un repositorio git"
    echo "   Ejecuta este script desde la raíz de tu repositorio"
    exit 1
fi

echo "✓ Repositorio git detectado"
echo ""

# 2. Crear estructura de carpetas
echo "📁 Creando estructura de carpetas..."
mkdir -p .github/workflows
echo "✓ Carpeta .github/workflows creada"
echo ""

# 3. Copiar archivos (asumiendo que están en el directorio actual)
echo "📋 Copiando archivos..."

if [ -f "create-materials-zip.yml" ]; then
    cp create-materials-zip.yml .github/workflows/
    echo "✓ Workflow copiado a .github/workflows/"
else
    echo "❌ Error: No se encuentra create-materials-zip.yml"
    echo "   Asegúrate de que el archivo está en el directorio actual"
    exit 1
fi

if [ -f "index.html" ]; then
    # Hacer backup del index.html actual
    if [ -f "index.html" ]; then
        cp index.html index.html.backup
        echo "✓ Backup creado: index.html.backup"
    fi
    cp index.html ./
    echo "✓ index.html actualizado"
else
    echo "⚠️  Aviso: No se encuentra index.html nuevo"
    echo "   Tendrás que actualizar el enlace manualmente"
fi

echo ""

# 4. Verificar estado de git
echo "📊 Verificando cambios..."
git status --short
echo ""

# 5. Preguntar si hacer commit
read -p "¿Quieres hacer commit y push de estos cambios? (s/n): " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Ss]$ ]]; then
    echo ""
    echo "📝 Haciendo commit..."
    git add .github/workflows/create-materials-zip.yml
    git add index.html 2>/dev/null || true
    git commit -m "Añadir generación automática de ZIP con materiales educativos"
    
    echo ""
    echo "🚀 Haciendo push..."
    git push origin main
    
    echo ""
    echo -e "${GREEN}✓ ¡Instalación completada!${NC}"
    echo ""
    echo "El workflow se está ejecutando en GitHub Actions"
    echo "En 1-2 minutos podrás descargar el ZIP desde:"
    echo -e "${YELLOW}https://github.com/$(git config --get remote.origin.url | sed 's/.*github.com[:/]\(.*\)\.git/\1/')/releases/download/materiales-latest/materiales-tcee.zip${NC}"
    echo ""
    echo "Verifica el progreso en:"
    echo "https://github.com/$(git config --get remote.origin.url | sed 's/.*github.com[:/]\(.*\)\.git/\1/')/actions"
else
    echo ""
    echo "⏸️  No se hizo commit"
    echo "   Puedes revisar los cambios y hacer commit manualmente cuando quieras"
    echo ""
    echo "   Para hacer commit más tarde:"
    echo "   git add .github/workflows/create-materials-zip.yml index.html"
    echo "   git commit -m \"Añadir generación automática de ZIP\""
    echo "   git push origin main"
fi

echo ""
echo "======================================"
echo "Para más información, lee INSTRUCCIONES_GITHUB_ACTIONS.md"
echo "======================================"
