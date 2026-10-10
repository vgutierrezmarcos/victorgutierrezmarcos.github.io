--[[
extraer-docx.lua — Filtro de pandoc para extraer-docx.py (docx+styles → Markdown).

Deja el Markdown legible para los agentes:
  - quita los estilos de carácter (Hyperlink, footnote reference…);
  - quita los índices de Word (toc N);
  - mantiene como bloques ::: {custom-style="…"} solo los estilos con
    significado para la revisión (notas, cajas, figuras, comentarios…);
  - en los demás párrafos (Nivel 1, Nivel 2 SM…) pone el nivel delante: «[N2]»,
    que indica la sangría de la viñeta en el Word.

Autor: Víctor Gutiérrez Marcos
]]
local conservar = {
  ['Nota al opositor'] = true, ['Caja de anotaciones'] = true, ['Advertencia'] = true,
  ['No cantar'] = true, ['Comentario'] = true, ['Título imagen'] = true,
  ['Pie de Imagen'] = true, ['Imagen'] = true, ['Bibliografía'] = true,
  ['Introducción y conclusión'] = true, ['Cita'] = true, ['Quote'] = true,
}

function Span(s)
  if s.attributes['custom-style'] then return s.content end
end

function Div(d)
  local estilo = d.attributes['custom-style']
  if not estilo then return nil end
  if estilo:match('^toc %d') or estilo:match('^TDC') then return {} end
  if conservar[estilo] then return nil end
  local nivel = estilo:match('^Nivel (%d)')
  local etiqueta = nil
  if nivel then
    etiqueta = '[N' .. nivel .. (estilo:match('SM') and 's' or '') .. '] '
  elseif estilo ~= 'List Paragraph' and estilo ~= 'Normal' and estilo ~= 'Body Text' then
    etiqueta = '[' .. estilo .. '] '
  end
  if etiqueta and d.content[1] and (d.content[1].t == 'Para' or d.content[1].t == 'Plain') then
    d.content[1].content:insert(1, pandoc.Str(etiqueta))
  end
  return d.content
end
