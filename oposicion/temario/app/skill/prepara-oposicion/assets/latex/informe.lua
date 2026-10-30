-- Filtro de pandoc para los documentos de «Prepara con Claude» (lo usa
-- scripts/informe-pdf.py con la plantilla informe.tex e informe.sty).
-- El aviso final («Este informe lo ha redactado una IA…»), venga como párrafo
-- en cursiva o como cita «>», va a la caja pálida informeaviso; si el informe
-- no lo trae, se añade con el texto del metadato «aviso».
-- Las tablas sin anchos (las «|---|---|» de siempre) reciben anchos
-- proporcionales al contenido de cada columna cuando no cabrían con sus
-- anchos naturales, para que nunca se salgan del margen.
-- Las marcas del informe del cante (assets/plantilla-informe-cante.md) pasan a
-- su forma gráfica: la tabla de cabecera con «Nota» es la ficha con la nota
-- grande; «### Apartado · 7,0/10» lleva la nota a la derecha; las listas
-- de ✓ ✕ ▲ ★ ✔ ✘ llevan la marca en color como viñeta; «**E1 · grave**»,
-- «**leve**», «**alta**», «**media**» son insignias; «**Aciertos**» y las
-- demás etiquetas de lista van en versalitas de color; «[07:12]» en gris y
-- «[E1]» (anexo de la transcripción) enlaza con su error.
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


-- ---------------------------------------------------------------------------
-- Informe del cante
-- ---------------------------------------------------------------------------

local function raw(t) return pandoc.RawInline('latex', t) end

local MARCAS = {
  ['✓'] = '\\informeok', ['✔'] = '\\informeok', ['✕'] = '\\informemal', ['✘'] = '\\informemal',
  ['✗'] = '\\informemal', ['▲'] = '\\informefalta', ['★'] = '\\informeextra',
}
local ETIQUETAS = {
  ['Aciertos'] = 'informeverde', ['Errores'] = 'informerojo', ['Falta'] = 'informeambar',
  ['Extras'] = 'informeprimario', ['Sobra'] = 'informegris',
  ['Lo primero que arreglar'] = 'informeprimario', ['Lo que cantaste'] = 'informesecundario',
  ['Lista de comprobación'] = 'informesecundario', ['Sobre lo cantado'] = 'informesecundario',
  ['Más allá'] = 'informesecundario',
  ['Enunciado'] = 'informesecundario', ['Tu respuesta'] = 'informesecundario', ['Cálculos'] = 'informesecundario',
  ['Respuesta modelo'] = 'informeprimario', ['Tu diagnóstico'] = 'informesecundario',
  ['El diagnóstico que dan los datos'] = 'informeprimario',
}
local GRADOS = {
  grave = 'informerojo', leve = 'informeambar', alta = 'informerojo', media = 'informeambar', baja = 'informegris',
}

-- «**Aciertos**» solo en su párrafo → etiqueta
function Para(p)
  if #p.content == 1 and p.content[1].t == 'Strong' then
    local texto = pandoc.utils.stringify(p.content[1]):gsub(':$', '')
    local color = ETIQUETAS[texto]
    if color then
      return pandoc.RawBlock('latex', '\\informeetiqueta{' .. color .. '}{' .. texto .. '}')
    end
  end
  return nil
end

-- «**E1 · grave**», «**leve**», «**alta**» → insignias (E1 con su ancla para el anexo)
function Strong(el)
  local texto = pandoc.utils.stringify(el)
  local id, grado = texto:match('^(E%d+) · (%a+)$')
  if id and GRADOS[grado] then
    return raw('\\hypertarget{' .. id .. '}{}\\informeinsignia{' .. GRADOS[grado] .. '}{' .. id .. ' · ' .. grado .. '}')
  end
  if GRADOS[texto] then
    return raw('\\informeinsignia{' .. GRADOS[texto] .. '}{' .. texto .. '}')
  end
  return nil
end

-- «[07:12]» en gris; «[E1]» como llamada enlazada
function Str(el)
  local id, resto = el.text:match('^%[(E%d+)%](.*)$')
  if id then
    return {raw('\\informellamada{' .. id .. '}'), pandoc.Str(resto)}
  end
  local minuto, resto2 = el.text:match('^%[(%d%d?%d?:%d%d)%](.*)$')
  if minuto then
    return {raw('\\informeminuto{' .. minuto .. '}'), pandoc.Str(resto2)}
  end
  return nil
end

-- Listas cuyos elementos empiezan por una marca: la marca, en color, es la viñeta
local function marca_de(item)
  local primero = item[1]
  if not primero or (primero.t ~= 'Plain' and primero.t ~= 'Para') then return nil end
  local c = primero.content
  if #c == 0 or c[1].t ~= 'Str' then return nil end
  for simbolo, orden in pairs(MARCAS) do
    if c[1].text == simbolo or c[1].text:sub(1, #simbolo) == simbolo then
      return orden, simbolo
    end
  end
  return nil
end

function BulletList(lista)
  local marcas, alguna = {}, false
  for i, item in ipairs(lista.content) do
    local orden, simbolo = marca_de(item)
    marcas[i] = orden and {orden, simbolo} or false
    alguna = alguna or orden ~= nil
  end
  if not alguna then return nil end
  local bloques = pandoc.List({pandoc.RawBlock('latex', '\\begin{itemize}[leftmargin=1.7em,labelsep=0.55em]')})
  for i, item in ipairs(lista.content) do
    if not marcas[i] then
      -- un elemento sin marca en una lista con marcas: la viñeta de siempre
      if item[1] and (item[1].t == 'Plain' or item[1].t == 'Para') then
        item[1].content:insert(1, raw('\\item '))
      else
        bloques:insert(pandoc.RawBlock('latex', '\\item'))
      end
    else
      local orden, simbolo = marcas[i][1], marcas[i][2]
      local c = item[1].content
      local resto = c[1].text:sub(#simbolo + 1)
      if resto == '' then
        c:remove(1)
        if c[1] and c[1].t == 'Space' then c:remove(1) end
      else
        c[1] = pandoc.Str(resto)
      end
      c:insert(1, raw('\\item[' .. orden .. '] '))
    end
    bloques:extend(item)
  end
  bloques:insert(pandoc.RawBlock('latex', '\\end{itemize}'))
  return bloques
end

-- «### II. Estática comparativa · 5,0/10» → la nota a la derecha del título
function Header(h)
  local c = h.content
  local n = #c
  if n >= 3 and c[n].t == 'Str' and c[n - 1].t == 'Space' and c[n - 2].t == 'Str' and c[n - 2].text:match('·$') then
    local nota = c[n].text:match('^(%d+,%d)/10$')
    if nota then
      local quitar = 3
      if c[n - 2].text == '·' then
        if c[n - 3] and c[n - 3].t == 'Space' then quitar = 4 end
      else
        c[n - 2] = pandoc.Str(c[n - 2].text:gsub('%s*·$', ''))
        quitar = 2
      end
      for _ = 1, quitar do c:remove(#c) end
      c:insert(raw('\\hfill\\informenotaapartado{' .. nota .. '}'))
      return h
    end
  end
  return nil
end

-- La tabla de cabecera (última columna «Nota», como mucho cuatro filas) → ficha con la nota grande
local function celdas(fila)
  local r = {}
  for _, celda in ipairs(fila.cells) do
    r[#r + 1] = pandoc.utils.blocks_to_inlines(celda.contents)
  end
  return r
end

local function ficha(t)
  if #t.head.rows ~= 1 or #t.bodies ~= 1 then return nil end
  local cabeza = celdas(t.head.rows[1])
  local n = #cabeza
  if n < 2 or pandoc.utils.stringify(cabeza[n]) ~= 'Nota' then return nil end
  local filas = t.bodies[1].body
  if #filas < 1 or #filas > 4 then return nil end
  local anchos = {}
  if n == 4 then anchos = {0.36, 0.16, 0.28, 0.20} else
    for i = 1, n - 1 do anchos[i] = 0.80 / (n - 1) end
    anchos[n] = 0.20
  end
  local columnas = ''
  for i = 1, n do
    local alineado = i == n and '\\raggedleft' or '\\raggedright'
    columnas = columnas .. '>{' .. alineado .. '\\arraybackslash}p{\\dimexpr' .. anchos[i] .. '\\linewidth-2\\tabcolsep\\relax}'
  end
  local ins = pandoc.List({raw('\\begin{informeficha}\\begin{tabular}{@{}' .. columnas .. '@{}}')})
  for i, celda in ipairs(cabeza) do
    ins:insert(raw((i > 1 and ' & ' or '') .. '\\informerotulo{' .. pandoc.utils.stringify(celda) .. '}'))
  end
  ins:insert(raw('\\\\[1pt]'))
  for k, fila in ipairs(filas) do
    local cs = celdas(fila)
    for i = 1, n do
      ins:insert(raw(i > 1 and ' & ' or ''))
      if i == n then
        local nota, resto = pandoc.utils.stringify(cs[i] or {}):match('^%s*(%d+,%d)%s*/%s*10(.-)%s*$')
        if nota then
          resto = resto:gsub('^[%s·]+', '')
          ins:insert(raw('\\informenota{' .. nota .. '}'))
          if resto ~= '' then ins:insert(raw('\\par{\\footnotesize\\bfseries\\color{' ..
            (resto:lower():find('suspen') and 'informerojo' or 'informeverde') .. '}' .. resto .. '}')) end
        else
          ins:extend(cs[i] or {})
        end
      else
        ins:extend(cs[i] or {})
      end
    end
    ins:insert(raw(k < #filas and '\\\\[3pt]' or ''))
  end
  ins:insert(raw('\\end{tabular}\\end{informeficha}'))
  return pandoc.Plain(ins)
end

-- Si la versión de pandoc representa las tablas de otro modo, se deja la tabla como está
function Table(t)
  local ok, f = pcall(ficha, t)
  if ok and f then return f end
  local ok2, resultado = pcall(anchos_tabla, t)
  if ok2 then return resultado end
  return nil
end

-- La línea en cursiva bajo un título («*[00:00–02:45] · 2′45″ de 2′30″ · peso 8 %*») va pegada al
-- título y a lo que sigue: nunca se queda sola al pie de la página
local function pegar_lineas(bloques)
  local salida = pandoc.List()
  for i, b in ipairs(bloques) do
    salida:insert(b)
    local previo = bloques[i - 1]
    if previo and previo.t == 'Header' and b.t == 'Para' and #b.content == 1 and b.content[1].t == 'Emph' then
      salida:insert(pandoc.RawBlock('latex', '\\informeseguido'))
    end
  end
  return salida
end

function Pandoc(doc)
  doc.blocks = pegar_lineas(doc.blocks)
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
