--[[
tcee.lua — Filtro de pandoc para pasar los temas (LaTeX exportado de LyX) a
HTML y Word con la misma estructura que el PDF.

Lo usa scripts/temario/construir-tema.py, que pasa estas variables con -M:
  graficos-html  ruta relativa de los SVG desde la página HTML
  graficos-docx  ruta (Windows) de los PNG para Word

Qué hace:
  - Numera los apartados como el PDF (I, I.1, I.1.1) y pone los minutos del
    cante (\minutos{n}) junto al título.
  - Pone «Gráfico n.–» y «Tabla n.–» en los títulos y separa la «Fuente:».
  - Cambia la ruta y la extensión de los gráficos (SVG en HTML, PNG en Word).
  - Convierte las cajas (notaopositor, anotaciones, ideaclave, esquema) en
    estilos de Word y \vertema en una clase CSS.
  - Pasa los \clearpage del PDF (construir-tema.py los deja como un entorno
    «saltopagina») a saltos de página en Word, y pone otro antes de la
    bibliografía. En HTML se quitan.
  - En Word reparte el título en líneas de longitud parecida, como el PDF.

Autor: Víctor Gutiérrez Marcos
]]

local es_docx = FORMAT:match('docx') ~= nil
local graficos_html = 'graficos'
local graficos_docx = 'graficos'

local estilos_docx = {
  notaopositor = 'Nota al opositor',
  anotaciones = 'Caja de anotaciones',
  ideaclave = 'Idea clave',
  esquema = 'Esquema',
}

local function romano(n)
  local valores = { {10, 'X'}, {9, 'IX'}, {5, 'V'}, {4, 'IV'}, {1, 'I'} }
  local s = ''
  for _, v in ipairs(valores) do
    while n >= v[1] do s = s .. v[2]; n = n - v[1] end
  end
  return s
end

local SALTO = pandoc.RawBlock('openxml', '<w:p><w:r><w:br w:type="page"/></w:r></w:p>')

-- Reparte las palabras en n líneas de longitud parecida (n según la longitud)
local function titulo_equilibrado(texto, por_linea)
  local palabras = {}
  for p in texto:gmatch('%S+') do palabras[#palabras + 1] = p end
  local total = utf8.len(texto) or #texto
  local n = math.max(1, math.ceil(total / por_linea))
  local objetivo = total / n
  local salida, actual, lineas = pandoc.List(), 0, 1
  for i, p in ipairs(palabras) do
    local largo = utf8.len(p) or #p
    if actual > 0 and lineas < n and actual + largo / 2 > objetivo * lineas then
      salida:insert(pandoc.LineBreak())
      lineas = lineas + 1
    elseif i > 1 then
      salida:insert(pandoc.Space())
    end
    salida:insert(pandoc.Str(p))
    actual = actual + largo + 1
  end
  return salida
end

function Meta(m)
  if m['graficos-html'] then graficos_html = pandoc.utils.stringify(m['graficos-html']) end
  if m['graficos-docx'] then graficos_docx = pandoc.utils.stringify(m['graficos-docx']) end
  if es_docx and m.title then
    m.title = pandoc.MetaInlines(titulo_equilibrado(pandoc.utils.stringify(m.title), 62))
  end
  return m
end

-- Gráficos -----------------------------------------------------------------
local function ruta_grafico(src)
  if src:match('^https?:') then return src end
  local nombre = src:gsub('^.*[/\\]', ''):gsub('%.%w+$', '')
  local ext = src:match('%.(%w+)$')
  -- Las imágenes que no son gráficos TikZ (fotos, logotipos) conservan su formato
  if ext and ext ~= 'pdf' and ext ~= 'tex' then
    nombre = nombre .. '.' .. ext
  elseif es_docx then
    nombre = nombre .. '.png'
  else
    nombre = nombre .. '.svg'
  end
  if es_docx then return graficos_docx .. '/' .. nombre end
  return graficos_html .. '/' .. nombre
end

local function Image(img)
  img.src = ruta_grafico(img.src)
  if #img.caption == 1 and pandoc.utils.stringify(img.caption) == 'image' then
    img.caption = {}
  end
  if not es_docx then img.attributes['loading'] = 'lazy' end
  return img
end

-- Spans ----------------------------------------------------------------------
local function Span(s)
  local estilo = s.attributes['style'] or ''
  if estilo:match('tceegris') then
    s.attributes['style'] = nil
    s.classes:insert('vertema')
    if es_docx then s.attributes['custom-style'] = 'Referencia a tema' end
  end
  return s
end

-- Párrafos «Fuente: …» --------------------------------------------------------
local function es_fuente(bloque)
  if bloque.t ~= 'Para' and bloque.t ~= 'Plain' then return false end
  local primero = bloque.content[1]
  return primero and primero.t == 'Emph' and pandoc.utils.stringify(primero):match('^Fuente:') ~= nil
end

local function separar_fuente(bloques)
  -- Dentro de una figura, el Para lleva la imagen y luego «Fuente: …»
  local salida = pandoc.List()
  for _, b in ipairs(bloques) do
    if (b.t == 'Para' or b.t == 'Plain') then
      local antes, fuente = pandoc.List(), nil
      for i, el in ipairs(b.content) do
        if el.t == 'Emph' and pandoc.utils.stringify(el):match('^Fuente:') then
          fuente = pandoc.List({ table.unpack(b.content, i) })
          break
        end
        antes:insert(el)
      end
      if fuente then
        while #antes > 0 and (antes[#antes].t == 'SoftBreak' or antes[#antes].t == 'Space' or antes[#antes].t == 'LineBreak') do
          antes:remove()
        end
        if #antes > 0 then salida:insert(pandoc.Plain(antes)) end
        local attr = es_docx and { ['custom-style'] = 'Pie de imagen' } or {}
        salida:insert(pandoc.Div({ pandoc.Para(fuente[1].content) }, pandoc.Attr('', { 'fuente' }, attr)))
      else
        salida:insert(b)
      end
    else
      salida:insert(b)
    end
  end
  return salida
end

-- Recorrido del documento ------------------------------------------------------
function Pandoc(doc)
  local s, ss, sss = 0, 0, 0
  local nfig, ntab = 0, 0

  local function minutos_de(bloques, i)
    -- \minutos{n} va en el párrafo justo después del título: lo saca de ahí
    local sig = bloques[i + 1]
    if sig and (sig.t == 'Para' or sig.t == 'Plain') and #sig.content >= 1 then
      local el = sig.content[1]
      if el.t == 'Span' and (el.attributes['style'] or ''):match('tceeminutos') then
        table.remove(sig.content, 1)
        if #sig.content == 0 then table.remove(bloques, i + 1) end
        return pandoc.utils.stringify(el)
      end
    end
    return nil
  end

  local function procesar(bloques)
    local i = 1
    while i <= #bloques do
      local b = bloques[i]
      if b.t == 'Header' then
        local numero = nil
        if not b.classes:includes('unnumbered') then
          if b.level == 1 then s = s + 1; ss = 0; sss = 0; numero = romano(s) .. '.'
          elseif b.level == 2 then ss = ss + 1; sss = 0; numero = romano(s) .. '.' .. ss .. '.'
          elseif b.level == 3 then sss = sss + 1; numero = romano(s) .. '.' .. ss .. '.' .. sss .. '.'
          end
        end
        if numero then
          b.content:insert(1, pandoc.Space())
          b.content:insert(1, pandoc.Span({ pandoc.Str(numero) }, pandoc.Attr('', { 'numero' })))
        end
        local min = minutos_de(bloques, i)
        if min then
          b.attributes['minutos'] = min
          if not es_docx then
            b.content:insert(pandoc.Span({ pandoc.Str(min .. ' min') }, pandoc.Attr('', { 'minutos' })))
          end
        end
      elseif b.t == 'Figure' then
        local es_tabla = false
        b.content:walk({ Table = function() es_tabla = true end })
        local etiqueta
        if es_tabla then ntab = ntab + 1; etiqueta = 'Tabla ' .. ntab .. '.–'
        else nfig = nfig + 1; etiqueta = 'Gráfico ' .. nfig .. '.–' end
        local cap = b.caption.long[1]
        if cap then
          cap.content:insert(1, pandoc.Space())
          cap.content:insert(1, pandoc.Span({ pandoc.Str(etiqueta) }, pandoc.Attr('', { 'etiqueta' })))
        end
        b.content = separar_fuente(b.content)
        if es_docx then
          -- Word no conserva bloques extra dentro de la figura: la fuente va justo después
          local dentro = pandoc.List()
          for _, c in ipairs(b.content) do
            if c.t == 'Div' and c.classes:includes('fuente') then
              table.insert(bloques, i + 1, c)
            else
              dentro:insert(c)
            end
          end
          b.content = dentro
        end
      elseif b.t == 'Div' and b.classes:includes('saltopagina') then
        if es_docx then bloques[i] = SALTO else table.remove(bloques, i); i = i - 1 end
      elseif b.t == 'Div' and b.identifier == 'refs' then
        -- La bibliografía (citeproc) empieza en página nueva, como en el PDF
        local previo = bloques[i - 1]
        if es_docx then
          local pos = (previo and previo.t == 'Header') and i - 1 or i
          table.insert(bloques, pos, SALTO)
          i = i + 1
        end
      elseif b.t == 'Div' then
        for clase, estilo in pairs(estilos_docx) do
          if b.classes:includes(clase) and es_docx then
            b.attributes['custom-style'] = estilo
          end
        end
        -- En Word las cajas no tienen título propio (en HTML lo pone el CSS)
        local titulos = { notaopositor = 'Nota al opositor. ', esquema = 'Esquema del tema. ' }
        for clase, titulo in pairs(titulos) do
          local primero = b.content[1]
          if es_docx and b.classes:includes(clase) and primero and (primero.t == 'Para' or primero.t == 'Plain') then
            primero.content:insert(1, pandoc.Strong({ pandoc.Str(titulo) }))
          end
        end
        procesar(b.content)
      elseif b.t == 'BulletList' or b.t == 'OrderedList' then
        for _, item in ipairs(b.content) do procesar(item) end
      end
      i = i + 1
    end
  end

  procesar(doc.blocks)
  return doc:walk({ Image = Image, Span = Span })
end

return { { Meta = Meta }, { Pandoc = Pandoc } }
