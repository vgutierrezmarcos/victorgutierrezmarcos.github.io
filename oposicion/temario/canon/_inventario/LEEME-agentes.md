# Inventario del temario (repaso general, solo lectura)

Un fichero por tema: `<código sin puntos>.json` (p. ej. `3A08.json`), UTF-8, con esta forma:

```json
{
  "tema": "3.A.8",
  "titulo": "título oficial de temario.json",
  "fuente": "ruta del Word o PDF leído",
  "aviso_fuente": "si el Word no corresponde al título (pasa en varios del 4.º), qué se hizo",
  "estructura": ["I. …", "I.1. …", "II. …"],
  "referencias": [
    {"original": "[ver tema 3.A.9]", "apunta_a": "3.A.9", "contexto": "frase donde aparece (≤ 25 palabras)",
     "correcta": true, "deberia": "3.A.9", "motivo": "si no es correcta: por qué y a qué tema debería apuntar"}
  ],
  "faltan_referencias": [{"a": "3.A.10", "por_que": "usa el modelo X que se desarrolla allí y no lo cita"}],
  "modelos": [
    {"id": "slutsky", "nombre": "Ecuación de Slutsky", "papel": "desarrollo | resumen | mencion",
     "para_que": "a qué pregunta del tema responde aquí",
     "supuestos": "…", "ecuaciones": ["(p^1-p^0)(x^1-x^0)\\le 0", "…"],
     "graficos": ["descripción breve de cada gráfico del modelo"],
     "notacion": {"renta": "W", "precios": "p", "cantidades": "x"}}
  ],
  "notacion": [{"simbolo": "W", "significado": "renta monetaria"}],
  "conceptos": ["conceptos que también aparecen en otros temas, con el nombre que se les da aquí"],
  "incoherencias_internas": ["notación o definiciones que cambian dentro del tema"],
  "observaciones": "lo que convenga saber para coordinarlo con el resto"
}
```

`id` de modelo: corto, en minúsculas y con guiones (`is-lm`, `mundell-fleming`, `solow`,
`heckscher-ohlin`, `cobb-douglas`, `slutsky`, `ricardo`, `dornbusch`, `phillips`, `taylor`…).
Usa el mismo `id` para el mismo modelo aunque el tema lo llame distinto.
