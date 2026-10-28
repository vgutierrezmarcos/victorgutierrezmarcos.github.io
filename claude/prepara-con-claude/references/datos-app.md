# Los datos de la app: qué recibes y qué devuelves

La app «Oposición TCEE · DCE» no habla con Claude por su cuenta: es el opositor quien exporta sus datos, sube un fichero a la conversación y copia a la app lo que tú le devuelves. Tres ficheros entran y dos bloques salen.

## 1. `cante_<tema>_<fecha>.txt`: la transcripción de un cante

Lo genera la app al terminar un cante con «Transcribir» activado (reconocimiento de voz del móvil o del navegador, sin conexión cuando el dispositivo lo permite). Formato:

```
# Cante · Oposición TCEE · 3.er ejercicio · Tema 3.A.8 · Teoría de la demanda del consumidor (I)
Fecha: 2026-11-03 18:02 · Exposición: 29:41 (prevista 30:00) · Esquema: 44:10 (previsto 45:00)
Sorteados: 3.A.8, 3.A.11, 3.B.4, 3.B.9 · Cantado: 3.A.8
Transcripción automática del móvil: puede tener errores de reconocimiento (nombres propios, fórmulas, números).

[00:00] ¿Puede una teoría explicar lo que elegimos sin ver lo que queremos? Marshall definía la economía como …
[01:00] … y en lo macroeconómico es la base del consumo …
[02:00] …
```

- Cada marca `[mm:ss]` abre un segmento de un minuto de exposición (no cuenta el tiempo de esquema). Un segmento vacío o muy corto es un silencio o un fallo del reconocedor: no lo tomes por un hueco del cante sin más, pero señálalo si coincide con un cambio de apartado.
- Los errores de reconocimiento son frecuentes en nombres propios (Slutsky, Hicks, Debreu), en fórmulas dichas en voz alta y en números: antes de dar algo por error de contenido, piensa si es un error del reconocedor y, si no está claro, dilo así («puede ser un error de transcripción»).
- Si la cabecera dice DCE, el cante es de 20 minutos (`oposiciones/dce.md`).
- Si el opositor pega una transcripción sin este formato (de la grabadora del móvil, de un vídeo), trabaja igual: pide la duración total si no se ve y reparte los tiempos por el número de palabras si no hay marcas.

## 2. `oposicion_<id>_para_claude.json`: el resumen de su preparación

Lo genera la app en Más → Prepara con Claude → «Exportar mis datos para Claude». Es un recorte pensado para ti:

```json
{
  "oposicion": "tcee", "generado": "2026-11-01T10:12:00", "app": "1.21.0",
  "examen": {"fechas": {"1": "2027-03-06", "3": "2027-06-15"}, "hitos": [{"titulo": "Simulacro de test", "fecha": "2027-02-20"}]},
  "temas": {
    "estudiados": ["3.A.1", "3.A.2", "…"], "enRepaso": ["3.A.8"],
    "agenda": {"3.A.8": {"vueltas": ["2026-09-12", "2026-10-20"], "pendientes": ["repasar Slutsky cruzado"]}}
  },
  "cronograma": {"ejercicio": 3, "inicio": "2026-10-05", "temasPorSemana": 3, "diaCante": 6, "fin": "2027-05-29",
    "semanas": [{"lunes": "2026-10-05", "temas": ["3.A.8", "3.A.9", "3.B.1"]}, {"lunes": "2026-10-12", "descanso": true}],
    "hechos": {"3.A.8": "2026-10-10"}, "fases": [{"tipo": "vuelta", "inicio": "…", "fin": "…"}]},
  "cantes": [{"fecha": "2026-10-10", "ejercicio": 3, "temas": ["3.A.8", "3.B.1"], "exposicion": 30,
    "resultado": {"temaCantado": "3.A.8", "segundos": 1781, "valoracion": 3, "valoraciones": {"3.A.8": 3}, "comentarios": "Bien la intro; me perdí en Slutsky cruzado", "descartados": ["3.A.11"]}}],
  "tests": [{"fecha": "2026-10-28", "tipo": "test", "notaSobre10": 6.4, "correctas": 48, "incorrectas": 19, "sinResponder": 8, "totalPreguntas": 75, "tiempoSeconds": 6900,
    "porTema": {"3.A.8": {"correctas": 3, "incorrectas": 2}, "3.B.4": {"correctas": 1, "incorrectas": 3}}}],
  "leitner": {"porCaja": {"1": 40, "2": 85, "3": 120, "4": 60, "5": 30}, "vencidas": 23, "temasConMasFallos": ["3.B.4", "3.A.19"]},
  "horario": {"lunes": "estudio 9-14, cante 17-18", "…": "…"}
}
```

Claves: `examen.fechas` va por número de ejercicio; `cronograma.diaCante` es 1 (lunes) a 7 (domingo); `cantes[].resultado.valoracion` y `valoraciones` van de 1 a 5 (5 = lo cantaría así en el examen; 3 = regular; 1 = mal); `tests[].tipo` es `test` (simulacro completo), `diario` (reto del día) o `repaso` (Leitner); `leitner.porCaja` cuenta preguntas por caja de repetición espaciada (la 1 son las que más falla). Todo lo que falte, pregúntalo solo si lo necesitas de verdad.

Si el opositor sube en su lugar **`oposicion_<id>_datos.json`** (la exportación completa de Más → Cuenta, pensada para la portabilidad de datos), el contenido equivalente está en `resultados[]` (cada test, con `respuestas` por pregunta y `temas`), `leitner.questions` (por pregunta: `box`, `timesCorrect`, `timesFailed`), `ajustes` (`fechaConvocatoria`, `temasEstudiados`, `temasEnRepaso`), `notas` (por tema), `cantes[]` (cada uno con `resultado`), `plan` (`fechas`, `hitos`, `horario`), `agendaTemas` y `cronogramas[]` (el activo es el no `archivado` más reciente). Ignora `preparador`, `alumnos` y `sesiones`: son datos de la red de preparadores y no te hacen falta.

## 3. Fotos, PDF y textos del opositor

Dictámenes y temas escritos llegan en foto o PDF, muchas veces a mano. Transcribe primero lo que entiendes, marca `[ilegible]` donde no, y corrige sobre tu transcripción. Los apuntes propios llegan en Word, PDF o texto.

## 4. Lo que devuelves: el bloque «Para la app»

Al final de cada informe de cante o de dictamen, un bloque que el opositor copia en la app al guardar el cante en el diario («¿Cómo ha ido el cante?»):

```
**Para la app**
Valoración: 3/5 (3.A.8: 3/5 · 3.B.1: 4/5)
Comentarios: Intro completa y buen ritmo. Error de signo en el efecto sustitución (II.2) y conclusión sin opinión. Repasar Slutsky cruzado y los axiomas 5-7.
Antes del próximo cante: 1) reescribir II.2 con la ecuación de Slutsky en la pizarra; 2) cronometrar la intro a 2′30″; 3) tres preguntas de tribunal sobre preferencia revelada.
```

- **Valoración** de 1 a 5, con este criterio: **5** lo cantaría así en el examen; **4** cantable con uno o dos retoques; **3** estructura bien y dos o tres errores o huecos que hay que arreglar; **2** errores de fondo o reparto del tiempo muy desviado; **1** sin estructura, sin tiempo o con errores graves de contenido. Si cantó dos temas, una por tema y la general.
- **Comentarios**: hasta 300 caracteres, los que el opositor pegará en la app. Lo más importante primero.
- **Tres tareas** concretas para antes del próximo cante.

## 5. Lo que devuelves: el cronograma para «Traer el tuyo»

La app importa un cronograma pegado o en un fichero `.txt` o `.csv` (Cronograma → Traer el tuyo; también desde Más → Prepara con Claude → «Traer cronograma de Claude»). Entiende una línea por semana de cante con la fecha del cante y los códigos de los temas. Devuélvelo exactamente así, en un bloque de código para que se copie limpio:

```
# Cronograma · TCEE · 3.er ejercicio · cante los sábados · hecho con Claude el 2026-11-01
2026-11-07: 3.A.8, 3.A.9, 3.B.1
2026-11-14: 3.A.10, 3.B.2
2026-11-28: 3.A.11, 3.A.12, 3.B.3
```

- Fecha en formato `AAAA-MM-DD`, la del cante de esa semana, siempre el mismo día de la semana que tiene el opositor en la app (pregúntalo si no está en el JSON: `cronograma.diaCante`).
- Códigos con puntos (`3.A.8`), separados por comas. No pongas títulos en esas líneas.
- Una semana sin cante (vacaciones, examen de idiomas) es simplemente una fecha que falta: la app la deja como descanso.
- La primera línea con `#` es la cabecera: la app la ignora. No pongas nada más en el bloque (ni «Semana 1», ni comentarios).
- Para DCE 1.º por fases, el mismo formato: en las semanas de simulacro pon los temas que se escriben; la app no distingue fases al importar, así que indica las fases en la tabla explicativa que acompaña al bloque, no dentro de él.

Al importarlo, el opositor revisa cada semana en la app antes de crearlo; dile que compruebe que el día del cante coincide.
