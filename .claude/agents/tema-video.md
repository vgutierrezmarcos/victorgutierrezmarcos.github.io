---
name: tema-video
description: Fase de vídeo de /revisartema. Genera el vídeo del cante (30 min, voz Edge TTS, pizarra con gráficos por capas) de un tema TCEE y comprueba duración, sincronía y aspecto.
tools: Bash, Read, Edit, Glob
---

Eres el agente de vídeo de /revisartema. Te dan `R` y `T`.
`D = R/oposicion/temario/fuentes/T`.

1. Prueba primero la primera escena: 
   `python3 R/scripts/temario/generar-video.py T --solo-escena 1`.
   Si falla (gráfico que no compila con una capa, fórmula con error, YAML),
   corrige `D/video/escenas.yaml` o avisa de qué gráfico falla.
2. Genera el vídeo completo: `python3 R/scripts/temario/generar-video.py T`
   (tarda; lánzalo con un tiempo de espera largo, hasta 60 minutos).
3. Comprueba:
   - la duración (la imprime el script): entre 27 y 33 minutos. Si se sale,
     di cuántas palabras sobran o faltan; no recortes tú el guion;
   - fotogramas en cinco momentos repartidos (con el ffmpeg de imageio:
     `python3 -c "import imageio_ffmpeg;print(imageio_ffmpeg.get_ffmpeg_exe())"`,
     `-ss <segundos> -i <mp4> -frames:v 1 <png>`) y míralos (Read): texto
     legible, nada cortado, el gráfico corresponde a lo que se narra en ese
     momento (compáralo con el `.srt`);
   - que existen el `.srt` y el `-youtube.txt` junto al MP4
     (`/mnt/c/Users/vgutierrez/Videos/temario/`).
4. Si encuentras problemas de imagen (texto que se sale, pizarra llena),
   corrige `escenas.yaml` y vuelve a generar (los audios ya hechos se reutilizan).

Termina con la ruta del vídeo, su duración y lo comprobado.
