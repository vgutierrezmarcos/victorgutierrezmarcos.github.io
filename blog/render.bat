@echo off
REM ============================================================
REM RENDER QUARTO - Genera HTML y PDF de un articulo
REM Uso: render.bat mi-articulo.qmd
REM ============================================================
cd /d "%~dp0"

if "%~1"=="" (
    echo Uso: render.bat articulo.qmd
    echo.
    echo Ejemplo: render.bat ejemplo-comercio-exterior.qmd
    exit /b 1
)

echo.
echo === RENDER QUARTO ===
echo Procesando: %1
echo.

echo Generando HTML...
"%LOCALAPPDATA%\Programs\Quarto\bin\quarto.exe" render %1 --to html
if errorlevel 1 (
    echo ERROR: Fallo al generar HTML
    exit /b 1
) else (
    echo HTML generado correctamente
)

echo.
echo Generando PDF...
"%LOCALAPPDATA%\Programs\Quarto\bin\quarto.exe" render %1 --to pdf
if errorlevel 1 (
    echo ERROR: Fallo al generar PDF
) else (
    echo PDF generado correctamente
)

echo.
echo Actualizando indice del blog...
cscript //nologo "%~dp0templates\update-index.js" "%1"

echo.
echo === Proceso completado ===
echo.
echo Archivos generados:
echo   - %~n1.html
echo   - %~n1.pdf
echo.
