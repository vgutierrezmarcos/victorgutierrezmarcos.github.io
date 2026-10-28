-- Filtro de pandoc para los documentos de «Prepara con Claude» (lo usa
-- scripts/informe-pdf.py con la plantilla informe.tex e informe.sty).
-- El aviso final («Este informe lo ha redactado una IA…»), venga como párrafo
-- en cursiva o como cita «>», va a la caja pálida informeaviso; si el informe
-- no lo trae, se añade con el texto del metadato «aviso».
-- Las tablas sin anchos (las «|---|---|» de siempre) reciben anchos
-- proporcionales al contenido de cada columna cuando no cabrían con sus
-- anchos naturales, para que nunca se salgan del margen.
-- Autor: Víctor Gutiérrez Marcos

local INICIO = 'Este informe lo ha redactado una IA'

-- Quita la cursiva o negrita que envuelve el párrafo entero
local function sin_enfasis(inlines)
  if #inlines == 1 and (inlines[1].t == 'Emph' or inlines[1].t == 'Strong') then
    return sin_enfasis(inlines[1].content)
  end
  return inlines
end

-- Los inlines del párrafo que contiene el aviso (dentro de una cita o suelto), o nil
local function parrafo_aviso(bloque)
  if bloque.t == 'BlockQuote' then
    for _, b in ipairs(bloque.content) do
      local p = parrafo_aviso(b)
      if p then return p end
    end
  elseif bloque.t == 'Para' or bloque.t == 'Plain' then
    if pandoc.utils.stringify(bloque):find(INICIO, 1, true) then
      return sin_enfasis(bloque.content)
    end
  end
  return nil
end

local function caja(inlines)
  return {
    pandoc.RawBlock('latex', '\\begin{informeaviso}'),
    pandoc.Para(inlines),
    pandoc.RawBlock('latex', '\\end{informeaviso}'),
  }
end

-- Anchos de columna proporcionales al texto más largo de cada una (tope de
-- 40 caracteres por celda) si la tabla no cabe en unos 55 caracteres
local function anchos_tabla(t)
  local n = #t.colspecs
  for _, c in ipairs(t.colspecs) do
    if c[2] and c[2] > 0 then return nil end -- ya trae anchos
  end
  local largos = {}
  for i = 1, n do largos[i] = 2 end
  local function medir(filas)
    for _, fila in ipairs(filas) do
      for i, celda in ipairs(fila.cells) do
        local texto = pandoc.utils.stringify(celda)
        local l = utf8.len(texto) or #texto
        if l > 40 then l = 40 end
        if i <= n and l > largos[i] then largos[i] = l end
      end
    end
  end
  medir(t.head.rows)
  for _, cuerpo in ipairs(t.bodies) do medir(cuerpo.head); medir(cuerpo.body) end
  medir(t.foot.rows)
  local total = 0
  for i = 1, n do total = total + largos[i] end
  if total <= 55 then return nil end
  for i = 1, n do t.colspecs[i] = {t.colspecs[i][1], largos[i] / total} end
  return t
end

-- Si la versión de pandoc representa las tablas de otro modo, se deja la tabla como está
function Table(t)
  local ok, resultado = pcall(anchos_tabla, t)
  if ok then return resultado end
  return nil
end

function Pandoc(doc)
  local bloques = doc.blocks
  for i = #bloques, 1, -1 do
    local inlines = parrafo_aviso(bloques[i])
    if inlines then
      local nuevos = pandoc.List()
      for j = 1, i - 1 do nuevos:insert(bloques[j]) end
      nuevos:extend(caja(inlines))
      for j = i + 1, #bloques do nuevos:insert(bloques[j]) end
      doc.blocks = nuevos
      return doc
    end
  end
  if doc.meta.aviso then
    local aviso = doc.meta.aviso
    if aviso.t ~= 'Inlines' and aviso.t ~= 'MetaInlines' then
      aviso = pandoc.Inlines(pandoc.Str(pandoc.utils.stringify(aviso)))
    end
    doc.blocks:extend(caja(aviso))
  end
  return doc
end
