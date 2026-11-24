#!/usr/bin/env python3
"""Banco de países para los dictámenes de práctica del conector («preparar_dictamen»).

Baja de las API públicas del FMI (World Economic Outlook, SDMX 3.0 en
api.imf.org) y del Banco Mundial (World Development Indicators) las series
anuales de unos 75 países desde 1990, con las proyecciones del WEO, y escribe
oposicion/datos/paises-dictamen.json. El conector elige de ahí el país del
cuadernillo, lo anonimiza y se lo da a la IA del opositor; si el opositor pide
un país o una variable que no está, la IA lo busca en fuentes oficiales.

Lo ejecuta cada lunes .github/workflows/paises-dictamen.yml (recoge solo el
WEO de abril y de octubre y las revisiones del Banco Mundial). A mano:

    python3 scripts/paises-dictamen.py              # escribe el JSON y enseña un resumen
    python3 scripts/paises-dictamen.py --no-escribir

Si una fuente o un indicador falla, se conservan sus series del JSON anterior y
se avisa; el script solo falla si fallan las dos fuentes. Solo biblioteca estándar.

Autor: Víctor Gutiérrez Marcos
"""
import json
import os
import sys
import urllib.parse
import urllib.request
from datetime import datetime, timezone
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
SALIDA = RAIZ / 'oposicion/datos/paises-dictamen.json'
FMI = 'https://api.imf.org/external/sdmx/3.0/data/dataflow/IMF.RES/WEO/+/'
BM = 'https://api.worldbank.org/v2/country/'
DESDE = 1990
HASTA = 2031  # último año de proyección del WEO (se recorta a lo que haya)

# Detrás del proxy del trabajo (intercepta TLS), su raíz junto a las del sistema.
_CAS = Path.home() / '.config/oposicion-red/cas.pem'
if _CAS.exists() and 'SSL_CERT_FILE' not in os.environ:
    os.environ['SSL_CERT_FILE'] = str(_CAS)

# ------------------------------------------------------------------ Países
# iso3, nombre, tipo (avanzado | emergente | en_desarrollo), región, materias
# primas (lo que domina sus exportaciones, o ''), régimen cambiario aproximado
# (flotante | intermedio | fijo | union_monetaria | sin_moneda_propia; según el
# AREAER del FMI, a comprobar en el artículo IV) y moneda (para quitarla del cuadernillo).
# Regiones: europa, america_norte, america_latina, asia_oriental, asia_sur,
# asia_central, oriente_medio_norte_africa, africa_subsahariana, oceania.
PAISES = [
    # Avanzados
    ('USA', 'Estados Unidos', 'avanzado', 'america_norte', '', 'flotante', 'dólar estadounidense'),
    ('CAN', 'Canadá', 'avanzado', 'america_norte', 'petróleo', 'flotante', 'dólar canadiense'),
    ('JPN', 'Japón', 'avanzado', 'asia_oriental', '', 'flotante', 'yen'),
    ('KOR', 'Corea del Sur', 'avanzado', 'asia_oriental', '', 'flotante', 'won'),
    ('SGP', 'Singapur', 'avanzado', 'asia_oriental', '', 'intermedio', 'dólar de Singapur'),
    ('HKG', 'Hong Kong (RAE de China)', 'avanzado', 'asia_oriental', '', 'fijo', 'dólar de Hong Kong'),
    ('AUS', 'Australia', 'avanzado', 'oceania', 'minerales y carbón', 'flotante', 'dólar australiano'),
    ('NZL', 'Nueva Zelanda', 'avanzado', 'oceania', 'agroalimentarias', 'flotante', 'dólar neozelandés'),
    ('GBR', 'Reino Unido', 'avanzado', 'europa', '', 'flotante', 'libra esterlina'),
    ('CHE', 'Suiza', 'avanzado', 'europa', '', 'flotante', 'franco suizo'),
    ('NOR', 'Noruega', 'avanzado', 'europa', 'petróleo y gas', 'flotante', 'corona noruega'),
    ('SWE', 'Suecia', 'avanzado', 'europa', '', 'flotante', 'corona sueca'),
    ('DNK', 'Dinamarca', 'avanzado', 'europa', '', 'fijo', 'corona danesa'),
    ('ISL', 'Islandia', 'avanzado', 'europa', 'pesca y aluminio', 'flotante', 'corona islandesa'),
    ('ISR', 'Israel', 'avanzado', 'oriente_medio_norte_africa', '', 'flotante', 'nuevo séquel'),
    ('CZE', 'Chequia', 'avanzado', 'europa', '', 'flotante', 'corona checa'),
    ('DEU', 'Alemania', 'avanzado', 'europa', '', 'union_monetaria', 'euro'),
    ('FRA', 'Francia', 'avanzado', 'europa', '', 'union_monetaria', 'euro'),
    ('ITA', 'Italia', 'avanzado', 'europa', '', 'union_monetaria', 'euro'),
    ('ESP', 'España', 'avanzado', 'europa', '', 'union_monetaria', 'euro'),
    ('PRT', 'Portugal', 'avanzado', 'europa', '', 'union_monetaria', 'euro'),
    ('GRC', 'Grecia', 'avanzado', 'europa', '', 'union_monetaria', 'euro'),
    ('IRL', 'Irlanda', 'avanzado', 'europa', '', 'union_monetaria', 'euro'),
    ('NLD', 'Países Bajos', 'avanzado', 'europa', '', 'union_monetaria', 'euro'),
    ('BEL', 'Bélgica', 'avanzado', 'europa', '', 'union_monetaria', 'euro'),
    ('AUT', 'Austria', 'avanzado', 'europa', '', 'union_monetaria', 'euro'),
    ('FIN', 'Finlandia', 'avanzado', 'europa', '', 'union_monetaria', 'euro'),
    # Emergentes
    ('CHN', 'China', 'emergente', 'asia_oriental', '', 'intermedio', 'renminbi'),
    ('IND', 'India', 'emergente', 'asia_sur', '', 'intermedio', 'rupia india'),
    ('IDN', 'Indonesia', 'emergente', 'asia_oriental', 'carbón y aceite de palma', 'flotante', 'rupia indonesia'),
    ('THA', 'Tailandia', 'emergente', 'asia_oriental', '', 'flotante', 'bat'),
    ('MYS', 'Malasia', 'emergente', 'asia_oriental', '', 'flotante', 'ringit'),
    ('PHL', 'Filipinas', 'emergente', 'asia_oriental', '', 'flotante', 'peso filipino'),
    ('VNM', 'Vietnam', 'emergente', 'asia_oriental', '', 'intermedio', 'dong'),
    ('BRA', 'Brasil', 'emergente', 'america_latina', 'agroalimentarias y minerales', 'flotante', 'real'),
    ('MEX', 'México', 'emergente', 'america_latina', '', 'flotante', 'peso mexicano'),
    ('ARG', 'Argentina', 'emergente', 'america_latina', 'agroalimentarias', 'intermedio', 'peso argentino'),
    ('CHL', 'Chile', 'emergente', 'america_latina', 'cobre', 'flotante', 'peso chileno'),
    ('COL', 'Colombia', 'emergente', 'america_latina', 'petróleo y carbón', 'flotante', 'peso colombiano'),
    ('PER', 'Perú', 'emergente', 'america_latina', 'cobre y oro', 'flotante', 'sol'),
    ('URY', 'Uruguay', 'emergente', 'america_latina', 'agroalimentarias', 'flotante', 'peso uruguayo'),
    ('DOM', 'República Dominicana', 'emergente', 'america_latina', '', 'intermedio', 'peso dominicano'),
    ('CRI', 'Costa Rica', 'emergente', 'america_latina', '', 'flotante', 'colón'),
    ('ECU', 'Ecuador', 'emergente', 'america_latina', 'petróleo', 'sin_moneda_propia', 'dólar estadounidense'),
    ('TUR', 'Turquía', 'emergente', 'europa', '', 'flotante', 'lira turca'),
    ('POL', 'Polonia', 'emergente', 'europa', '', 'flotante', 'esloti'),
    ('HUN', 'Hungría', 'emergente', 'europa', '', 'flotante', 'forinto'),
    ('ROU', 'Rumanía', 'emergente', 'europa', '', 'intermedio', 'leu rumano'),
    ('BGR', 'Bulgaria', 'emergente', 'europa', '', 'fijo', 'leva'),
    ('SRB', 'Serbia', 'emergente', 'europa', '', 'intermedio', 'dinar serbio'),
    ('KAZ', 'Kazajistán', 'emergente', 'asia_central', 'petróleo', 'flotante', 'tenge'),
    ('ZAF', 'Sudáfrica', 'emergente', 'africa_subsahariana', 'minerales', 'flotante', 'rand'),
    ('EGY', 'Egipto', 'emergente', 'oriente_medio_norte_africa', '', 'intermedio', 'libra egipcia'),
    ('MAR', 'Marruecos', 'emergente', 'oriente_medio_norte_africa', 'fosfatos', 'intermedio', 'dírham marroquí'),
    ('TUN', 'Túnez', 'emergente', 'oriente_medio_norte_africa', '', 'intermedio', 'dinar tunecino'),
    ('DZA', 'Argelia', 'emergente', 'oriente_medio_norte_africa', 'petróleo y gas', 'intermedio', 'dinar argelino'),
    ('JOR', 'Jordania', 'emergente', 'oriente_medio_norte_africa', '', 'fijo', 'dinar jordano'),
    ('SAU', 'Arabia Saudí', 'emergente', 'oriente_medio_norte_africa', 'petróleo', 'fijo', 'riyal saudí'),
    ('ARE', 'Emiratos Árabes Unidos', 'emergente', 'oriente_medio_norte_africa', 'petróleo', 'fijo', 'dírham de los EAU'),
    ('QAT', 'Catar', 'emergente', 'oriente_medio_norte_africa', 'gas', 'fijo', 'riyal catarí'),
    ('PAK', 'Pakistán', 'emergente', 'asia_sur', '', 'intermedio', 'rupia pakistaní'),
    ('LKA', 'Sri Lanka', 'emergente', 'asia_sur', '', 'flotante', 'rupia de Sri Lanka'),
    # En desarrollo (países de renta baja según el FMI)
    ('BGD', 'Bangladés', 'en_desarrollo', 'asia_sur', '', 'intermedio', 'taka'),
    ('NPL', 'Nepal', 'en_desarrollo', 'asia_sur', '', 'fijo', 'rupia nepalí'),
    ('KHM', 'Camboya', 'en_desarrollo', 'asia_oriental', '', 'intermedio', 'riel'),
    ('LAO', 'Laos', 'en_desarrollo', 'asia_oriental', 'minerales y electricidad', 'intermedio', 'kip'),
    ('BOL', 'Bolivia', 'en_desarrollo', 'america_latina', 'gas y minerales', 'fijo', 'boliviano'),
    ('HND', 'Honduras', 'en_desarrollo', 'america_latina', 'agroalimentarias', 'intermedio', 'lempira'),
    ('NGA', 'Nigeria', 'en_desarrollo', 'africa_subsahariana', 'petróleo', 'flotante', 'naira'),
    ('KEN', 'Kenia', 'en_desarrollo', 'africa_subsahariana', 'agroalimentarias', 'flotante', 'chelín keniano'),
    ('ETH', 'Etiopía', 'en_desarrollo', 'africa_subsahariana', 'agroalimentarias', 'flotante', 'birr'),
    ('GHA', 'Ghana', 'en_desarrollo', 'africa_subsahariana', 'oro, cacao y petróleo', 'flotante', 'cedi'),
    ('CIV', 'Costa de Marfil', 'en_desarrollo', 'africa_subsahariana', 'cacao', 'union_monetaria', 'franco CFA de África Occidental'),
    ('SEN', 'Senegal', 'en_desarrollo', 'africa_subsahariana', '', 'union_monetaria', 'franco CFA de África Occidental'),
    ('TZA', 'Tanzania', 'en_desarrollo', 'africa_subsahariana', 'oro', 'intermedio', 'chelín tanzano'),
    ('UGA', 'Uganda', 'en_desarrollo', 'africa_subsahariana', '', 'flotante', 'chelín ugandés'),
    ('RWA', 'Ruanda', 'en_desarrollo', 'africa_subsahariana', '', 'intermedio', 'franco ruandés'),
    ('ZMB', 'Zambia', 'en_desarrollo', 'africa_subsahariana', 'cobre', 'flotante', 'kwacha zambiano'),
    ('MOZ', 'Mozambique', 'en_desarrollo', 'africa_subsahariana', 'carbón, gas y aluminio', 'intermedio', 'metical'),
]

# Episodios para «un episodio histórico»: país, año T (el último del cuadernillo:
# el examen se pone como si se escribiera al final de ese año) y lo que lo hace interesante.
EPISODIOS = [
    ('tailandia-1997', 'THA', 1997, 'Crisis asiática', 'déficit corriente financiado a corto plazo en dólares, tipo de cambio fijo y burbuja inmobiliaria; abandono del anclaje'),
    ('mexico-1994', 'MEX', 1995, 'Crisis del tequila', 'déficit corriente, deuda a corto plazo indexada al dólar (tesobonos), devaluación y programa del FMI'),
    ('argentina-2001', 'ARG', 2001, 'Fin de la convertibilidad', 'caja de conversión, apreciación real, deuda pública en moneda extranjera, recesión y default'),
    ('turquia-2001', 'TUR', 2001, 'Crisis bancaria turca', 'programa de desinflación con tipo de cambio, banca frágil y flotación forzosa'),
    ('islandia-2008', 'ISL', 2008, 'Crisis bancaria islandesa', 'sistema bancario sobredimensionado, carry trade y control de capitales'),
    ('irlanda-2010', 'IRL', 2010, 'Rescate de Irlanda', 'burbuja inmobiliaria, garantía bancaria y salto de la deuda pública dentro del euro'),
    ('grecia-2010', 'GRC', 2010, 'Crisis de deuda griega', 'déficit y deuda públicos, pérdida de competitividad y estadísticas revisadas dentro del euro'),
    ('portugal-2011', 'PRT', 2011, 'Rescate de Portugal', 'crecimiento débil, déficit gemelos y ajuste dentro del euro'),
    ('espana-2012', 'ESP', 2012, 'Crisis española', 'ajuste del sector inmobiliario, paro, saneamiento bancario y devaluación interna'),
    ('brasil-2015', 'BRA', 2015, 'Recesión brasileña', 'fin del ciclo de materias primas, deterioro fiscal y recesión con inflación'),
    ('kazajistan-2015', 'KAZ', 2015, 'Caída del petróleo en Kazajistán', 'choque de relación real de intercambio y paso a la flotación'),
    ('argentina-2018', 'ARG', 2018, 'Crisis cambiaria argentina', 'déficits gemelos, dependencia del financiamiento externo y acuerdo con el FMI'),
    ('turquia-2018', 'TUR', 2018, 'Crisis de la lira', 'crédito rápido, deuda privada en moneda extranjera e independencia del banco central'),
    ('egipto-2016', 'EGY', 2016, 'Devaluación egipcia', 'escasez de divisas, flotación de la libra y programa del FMI'),
    ('zambia-2020', 'ZMB', 2020, 'Default de Zambia', 'deuda externa, precio del cobre y reestructuración en el Marco Común del G20'),
    ('sri-lanka-2022', 'LKA', 2022, 'Crisis de Sri Lanka', 'agotamiento de reservas, default y recortes de impuestos sin financiación'),
    ('ghana-2022', 'GHA', 2022, 'Crisis de deuda de Ghana', 'inflación, depreciación y reestructuración de la deuda interna y externa'),
    ('reino-unido-2022', 'GBR', 2022, 'Inflación tras la pandemia', 'choque energético, mercado de trabajo tenso y reacción del banco central'),
]

# ------------------------------------------------------------------ Variables
# id, código, fuente, grupo, nombre y unidad. Los grupos van en el orden del
# cuadernillo del examen (los simulacros de la web): sector real, mercado de
# trabajo, sector exterior, ahorro e inversión, sector público, precios y
# dinero, sistema financiero y pro memoria. Fuentes: weo (FMI, con
# proyecciones), wdi (Banco Mundial) y wdi_pib (Banco Mundial en dólares
# corrientes, que el script pasa a % del PIB con el PIB en dólares del BM).
VARIABLES = [
    # Producción
    ('pib_real', 'NGDP_RPCH', 'weo', 'Producción', 'PIB real', 'variación % anual'),
    ('brecha_producto', 'NGAP_NPGDP', 'weo', 'Producción', 'Brecha de producción (output gap)', '% del PIB potencial'),
    ('pib_usd', 'NGDPD', 'weo', 'Producción', 'PIB nominal', 'miles de millones de USD'),
    ('pib_pc_usd', 'NGDPDPC', 'weo', 'Producción', 'PIB por habitante', 'USD'),
    ('pib_pc_ppa', 'PPPPC', 'weo', 'Producción', 'PIB por habitante en paridad de poder adquisitivo', 'dólares internacionales'),
    # Demanda
    ('consumo_priv_var', 'NE.CON.PRVT.KD.ZG', 'wdi', 'Demanda', 'Consumo privado', 'variación % anual'),
    ('consumo_pub_var', 'NE.CON.GOVT.KD.ZG', 'wdi', 'Demanda', 'Consumo público', 'variación % anual'),
    ('fbcf_var', 'NE.GDI.FTOT.KD.ZG', 'wdi', 'Demanda', 'Formación bruta de capital fijo', 'variación % anual'),
    ('export_var', 'NE.EXP.GNFS.KD.ZG', 'wdi', 'Demanda', 'Exportaciones de bienes y servicios', 'variación % anual'),
    ('import_var', 'NE.IMP.GNFS.KD.ZG', 'wdi', 'Demanda', 'Importaciones de bienes y servicios', 'variación % anual'),
    ('export_vol', 'TX_RPCH', 'weo', 'Demanda', 'Volumen de exportaciones de bienes y servicios (FMI, con previsión)', 'variación % anual'),
    ('import_vol', 'TM_RPCH', 'weo', 'Demanda', 'Volumen de importaciones de bienes y servicios (FMI, con previsión)', 'variación % anual'),
    ('consumo_priv', 'NE.CON.PRVT.ZS', 'wdi', 'Demanda', 'Consumo privado', '% del PIB'),
    ('consumo_pub', 'NE.CON.GOVT.ZS', 'wdi', 'Demanda', 'Consumo público', '% del PIB'),
    ('fbc', 'NE.GDI.TOTL.ZS', 'wdi', 'Demanda', 'Formación bruta de capital', '% del PIB'),
    # Oferta
    ('vab_agricultura', 'NV.AGR.TOTL.ZS', 'wdi', 'Oferta', 'Agricultura, silvicultura y pesca (VAB)', '% del PIB'),
    ('vab_industria', 'NV.IND.TOTL.ZS', 'wdi', 'Oferta', 'Industria con construcción (VAB)', '% del PIB'),
    ('vab_manufacturas', 'NV.IND.MANF.ZS', 'wdi', 'Oferta', 'Manufacturas (VAB)', '% del PIB'),
    ('vab_servicios', 'NV.SRV.TOTL.ZS', 'wdi', 'Oferta', 'Servicios (VAB)', '% del PIB'),
    ('vab_agricultura_var', 'NV.AGR.TOTL.KD.ZG', 'wdi', 'Oferta', 'Agricultura (VAB real)', 'variación % anual'),
    ('vab_industria_var', 'NV.IND.TOTL.KD.ZG', 'wdi', 'Oferta', 'Industria (VAB real)', 'variación % anual'),
    ('vab_manufacturas_var', 'NV.IND.MANF.KD.ZG', 'wdi', 'Oferta', 'Manufacturas (VAB real)', 'variación % anual'),
    ('vab_servicios_var', 'NV.SRV.TOTL.KD.ZG', 'wdi', 'Oferta', 'Servicios (VAB real)', 'variación % anual'),
    ('rentas_recursos', 'NY.GDP.TOTL.RT.ZS', 'wdi', 'Oferta', 'Rentas de los recursos naturales', '% del PIB'),
    # Mercado de trabajo
    ('paro', 'LUR', 'weo', 'Mercado de trabajo', 'Tasa de paro', '% de la población activa'),
    ('paro_mujeres', 'SL.UEM.TOTL.FE.ZS', 'wdi', 'Mercado de trabajo', 'Tasa de paro de las mujeres (OIT)', '% de la población activa'),
    ('paro_joven', 'SL.UEM.1524.ZS', 'wdi', 'Mercado de trabajo', 'Paro de 15 a 24 años (OIT)', '% de la población activa de esa edad'),
    ('actividad', 'SL.TLF.CACT.ZS', 'wdi', 'Mercado de trabajo', 'Tasa de actividad, 15 años o más (OIT)', '%'),
    ('actividad_mujeres', 'SL.TLF.CACT.FE.ZS', 'wdi', 'Mercado de trabajo', 'Tasa de actividad de las mujeres (OIT)', '%'),
    ('tasa_empleo', 'SL.EMP.TOTL.SP.ZS', 'wdi', 'Mercado de trabajo', 'Tasa de empleo, 15 años o más (OIT)', '%'),
    ('empleo_agricultura', 'SL.AGR.EMPL.ZS', 'wdi', 'Mercado de trabajo', 'Empleo en la agricultura', '% del empleo'),
    ('empleo_industria', 'SL.IND.EMPL.ZS', 'wdi', 'Mercado de trabajo', 'Empleo en la industria', '% del empleo'),
    ('empleo_servicios', 'SL.SRV.EMPL.ZS', 'wdi', 'Mercado de trabajo', 'Empleo en los servicios', '% del empleo'),
    ('empleo_vulnerable', 'SL.EMP.VULN.ZS', 'wdi', 'Mercado de trabajo', 'Empleo vulnerable (por cuenta propia y familiar)', '% del empleo'),
    ('empleo', 'LE', 'weo', 'Mercado de trabajo', 'Empleo', 'millones'),
    # Comercio exterior
    ('exportaciones', 'NE.EXP.GNFS.ZS', 'wdi', 'Comercio exterior', 'Exportaciones de bienes y servicios', '% del PIB'),
    ('importaciones', 'NE.IMP.GNFS.ZS', 'wdi', 'Comercio exterior', 'Importaciones de bienes y servicios', '% del PIB'),
    ('x_combustibles', 'TX.VAL.FUEL.ZS.UN', 'wdi', 'Comercio exterior', 'Combustibles en las exportaciones de mercancías', '% de las exportaciones'),
    ('x_minerales', 'TX.VAL.MMTL.ZS.UN', 'wdi', 'Comercio exterior', 'Minerales y metales en las exportaciones de mercancías', '% de las exportaciones'),
    ('x_alimentos', 'TX.VAL.FOOD.ZS.UN', 'wdi', 'Comercio exterior', 'Alimentos en las exportaciones de mercancías', '% de las exportaciones'),
    ('x_manufacturas', 'TX.VAL.MANF.ZS.UN', 'wdi', 'Comercio exterior', 'Manufacturas en las exportaciones de mercancías', '% de las exportaciones'),
    ('x_alta_tecnologia', 'TX.VAL.TECH.MF.ZS', 'wdi', 'Comercio exterior', 'Alta tecnología en las exportaciones de manufacturas', '% de las exportaciones de manufacturas'),
    ('m_combustibles', 'TM.VAL.FUEL.ZS.UN', 'wdi', 'Comercio exterior', 'Combustibles en las importaciones de mercancías', '% de las importaciones'),
    ('m_alimentos', 'TM.VAL.FOOD.ZS.UN', 'wdi', 'Comercio exterior', 'Alimentos en las importaciones de mercancías', '% de las importaciones'),
    ('m_manufacturas', 'TM.VAL.MANF.ZS.UN', 'wdi', 'Comercio exterior', 'Manufacturas en las importaciones de mercancías', '% de las importaciones'),
    # Protección comercial
    ('arancel_simple', 'TM.TAX.MRCH.SM.AR.ZS', 'wdi', 'Protección comercial', 'Arancel aplicado, media simple (todos los productos)', '%'),
    ('arancel_ponderado', 'TM.TAX.MRCH.WM.AR.ZS', 'wdi', 'Protección comercial', 'Arancel aplicado, media ponderada por el comercio', '%'),
    ('arancel_consolidado', 'TM.TAX.MRCH.BC.ZS', 'wdi', 'Protección comercial', 'Líneas arancelarias consolidadas en la OMC', '% de las líneas'),
    # Competitividad y tipo de cambio
    ('tcer', 'PX.REX.REER', 'wdi', 'Competitividad y tipo de cambio', 'Tipo de cambio efectivo real (subida = apreciación)', 'índice 2010 = 100'),
    ('rri', 'TT.PRI.MRCH.XD.WD', 'wdi', 'Competitividad y tipo de cambio', 'Relación real de intercambio de mercancías', 'índice 2015 = 100'),
    ('tipo_cambio', 'PA.NUS.FCRF', 'wdi', 'Competitividad y tipo de cambio', 'Tipo de cambio oficial', 'moneda nacional por USD, media anual'),
    ('factor_ppa', 'PA.NUS.PPP', 'wdi', 'Competitividad y tipo de cambio', 'Factor de conversión de la PPA', 'moneda nacional por dólar internacional'),
    # Balanza de pagos
    ('saldo_corriente', 'BCA_NGDPD', 'weo', 'Balanza de pagos', 'Saldo de la cuenta corriente', '% del PIB'),
    ('saldo_byss', 'BN.GSR.GNFS.CD', 'wdi_pib', 'Balanza de pagos', 'Saldo de bienes y servicios', '% del PIB'),
    ('saldo_bienes', 'BN.GSR.MRCH.CD', 'wdi_pib', 'Balanza de pagos', 'Saldo de bienes', '% del PIB'),
    ('saldo_rentas_primarias', 'BN.GSR.FCTY.CD', 'wdi_pib', 'Balanza de pagos', 'Saldo de rentas primarias', '% del PIB'),
    ('saldo_rentas_secundarias', 'BN.TRF.CURR.CD', 'wdi_pib', 'Balanza de pagos', 'Saldo de rentas secundarias (transferencias)', '% del PIB'),
    ('remesas', 'BX.TRF.PWKR.DT.GD.ZS', 'wdi', 'Balanza de pagos', 'Remesas recibidas', '% del PIB'),
    ('cuenta_financiera', 'BN.FIN.TOTL.CD', 'wdi_pib', 'Balanza de pagos', 'Saldo de la cuenta financiera (+ = salida neta de capital, MBP6)', '% del PIB'),
    ('ied_neta', 'BN.KLT.DINV.CD', 'wdi_pib', 'Balanza de pagos', 'Inversión directa neta (activos − pasivos)', '% del PIB'),
    ('cartera_neta', 'BN.KLT.PTXL.CD', 'wdi_pib', 'Balanza de pagos', 'Inversión de cartera neta (activos − pasivos)', '% del PIB'),
    ('variacion_reservas', 'BN.RES.INCL.CD', 'wdi_pib', 'Balanza de pagos', 'Variación de las reservas (− = aumento, presentación del BM)', '% del PIB'),
    ('errores_omisiones', 'BN.KAC.EOMS.CD', 'wdi_pib', 'Balanza de pagos', 'Errores y omisiones netos', '% del PIB'),
    ('ied_entrada', 'BX.KLT.DINV.WD.GD.ZS', 'wdi', 'Balanza de pagos', 'Inversión extranjera directa, entradas netas', '% del PIB'),
    # Posición exterior y deuda
    ('reservas_meses', 'FI.RES.TOTL.MO', 'wdi', 'Posición exterior y deuda externa', 'Reservas internacionales', 'meses de importaciones'),
    ('reservas_deuda', 'FI.RES.TOTL.DT.ZS', 'wdi', 'Posición exterior y deuda externa', 'Reservas sobre deuda externa total', '%'),
    ('deuda_externa', 'DT.DOD.DECT.GN.ZS', 'wdi', 'Posición exterior y deuda externa', 'Deuda externa total (solo países de renta baja y media)', '% de la RNB'),
    ('deuda_ext_cp', 'DT.DOD.DSTC.ZS', 'wdi', 'Posición exterior y deuda externa', 'Deuda externa a corto plazo', '% de la deuda externa'),
    ('servicio_deuda_ext', 'DT.TDS.DECT.EX.ZS', 'wdi', 'Posición exterior y deuda externa', 'Servicio de la deuda externa (solo países de renta baja y media)', '% de las exportaciones y rentas primarias'),
    # Ahorro e inversión
    ('ahorro', 'NGSD_NGDP', 'weo', 'Ahorro e inversión', 'Ahorro nacional bruto', '% del PIB'),
    ('inversion', 'NID_NGDP', 'weo', 'Ahorro e inversión', 'Inversión total', '% del PIB'),
    # Sector público
    ('ingresos_pub', 'GGR_NGDP', 'weo', 'Sector público: ingresos y gastos', 'Ingresos de las AA. PP.', '% del PIB'),
    ('presion_fiscal', 'GC.TAX.TOTL.GD.ZS', 'wdi', 'Sector público: ingresos y gastos', 'Ingresos tributarios del Gobierno central', '% del PIB'),
    ('imp_renta', 'GC.TAX.YPKG.RV.ZS', 'wdi', 'Sector público: ingresos y gastos', 'Impuestos sobre la renta, los beneficios y las ganancias de capital', '% de los ingresos'),
    ('imp_consumo', 'GC.TAX.GSRV.RV.ZS', 'wdi', 'Sector público: ingresos y gastos', 'Impuestos sobre bienes y servicios', '% de los ingresos'),
    ('gastos_pub', 'GGX_NGDP', 'weo', 'Sector público: ingresos y gastos', 'Gastos de las AA. PP.', '% del PIB'),
    ('intereses_ingresos', 'GC.XPN.INTP.RV.ZS', 'wdi', 'Sector público: ingresos y gastos', 'Pago de intereses del Gobierno central', '% de los ingresos'),
    ('gasto_militar', 'MS.MIL.XPND.GD.ZS', 'wdi', 'Sector público: ingresos y gastos', 'Gasto militar', '% del PIB'),
    ('gasto_educacion', 'SE.XPD.TOTL.GD.ZS', 'wdi', 'Sector público: ingresos y gastos', 'Gasto público en educación', '% del PIB'),
    ('gasto_salud', 'SH.XPD.CHEX.GD.ZS', 'wdi', 'Sector público: ingresos y gastos', 'Gasto corriente en salud (público y privado)', '% del PIB'),
    ('gasto_id', 'GB.XPD.RSDV.GD.ZS', 'wdi', 'Sector público: ingresos y gastos', 'Gasto en I+D (público y privado)', '% del PIB'),
    ('saldo_pub', 'GGXCNL_NGDP', 'weo', 'Sector público: saldos', 'Saldo de las AA. PP.', '% del PIB'),
    ('saldo_primario', 'GGXONLB_NGDP', 'weo', 'Sector público: saldos', 'Saldo primario de las AA. PP.', '% del PIB'),
    ('saldo_estructural', 'GGSB_NPGDP', 'weo', 'Sector público: saldos', 'Saldo estructural de las AA. PP.', '% del PIB potencial'),
    ('deuda_pub', 'GGXWDG_NGDP', 'weo', 'Sector público: deuda', 'Deuda bruta de las AA. PP.', '% del PIB'),
    ('deuda_pub_neta', 'GGXWDN_NGDP', 'weo', 'Sector público: deuda', 'Deuda neta de las AA. PP.', '% del PIB'),
    # Precios y dinero
    ('inflacion', 'PCPIPCH', 'weo', 'Precios y costes', 'Inflación (IPC), media anual', '%'),
    ('inflacion_fin', 'PCPIEPCH', 'weo', 'Precios y costes', 'Inflación (IPC), final del año', '%'),
    ('deflactor_var', 'NY.GDP.DEFL.KD.ZG', 'wdi', 'Precios y costes', 'Deflactor del PIB', 'variación % anual'),
    ('tipo_activo', 'FR.INR.LEND', 'wdi', 'Tipos de interés y dinero', 'Tipo de interés de los préstamos', '%'),
    ('tipo_pasivo', 'FR.INR.DPST', 'wdi', 'Tipos de interés y dinero', 'Tipo de interés de los depósitos', '%'),
    ('tipo_real', 'FR.INR.RINR', 'wdi', 'Tipos de interés y dinero', 'Tipo de interés real (préstamos)', '%'),
    ('m2_var', 'FM.LBL.BMNY.ZG', 'wdi', 'Tipos de interés y dinero', 'Dinero en sentido amplio (M2)', 'variación % anual'),
    # Sistema financiero
    ('credito_priv', 'FS.AST.PRVT.GD.ZS', 'wdi', 'Sistema financiero', 'Crédito interno al sector privado', '% del PIB'),
    ('morosidad', 'FB.AST.NPER.ZS', 'wdi', 'Sistema financiero', 'Préstamos dudosos', '% del crédito bruto'),
    ('capital_bancos', 'FB.BNK.CAPA.ZS', 'wdi', 'Sistema financiero', 'Capital y reservas de los bancos', '% de los activos'),
    # Pro memoria
    ('gini', 'SI.POV.GINI', 'wdi', 'Indicadores sociales', 'Índice de Gini', '0-100'),
    ('pobreza', 'SI.POV.DDAY', 'wdi', 'Indicadores sociales', 'Pobreza extrema (3 USD al día en PPA)', '% de la población'),
    ('matricula_terciaria', 'SE.TER.ENRR', 'wdi', 'Indicadores sociales', 'Matriculación en educación terciaria', '% bruto'),
    ('esperanza_vida', 'SP.DYN.LE00.IN', 'wdi', 'Demografía', 'Esperanza de vida al nacer', 'años'),
    ('fecundidad', 'SP.DYN.TFRT.IN', 'wdi', 'Demografía', 'Tasa de fecundidad', 'hijos por mujer'),
    ('poblacion_var', 'SP.POP.GROW', 'wdi', 'Demografía', 'Crecimiento de la población', 'variación % anual'),
    ('poblacion_urbana', 'SP.URB.TOTL.IN.ZS', 'wdi', 'Demografía', 'Población urbana', '% de la población'),
    ('dependencia', 'SP.POP.DPND', 'wdi', 'Demografía', 'Tasa de dependencia', '% de la población en edad de trabajar'),
    ('poblacion', 'LP', 'weo', 'Demografía', 'Población', 'millones'),
]
# Del Banco Mundial se baja también el PIB en dólares, para pasar a % del PIB las partidas en dólares.
PIB_USD_BM = 'NY.GDP.MKTP.CD'

# Rangos plausibles: un valor fuera se descarta (error de la fuente) y se avisa.
RANGOS = {
    '%': (-100, 100000), 'variación % anual': (-100, 100000), '% del PIB': (-400, 600), 'meses de importaciones': (0, 60),
}


def pedir(url, cabeceras=None):
    for intento in range(4):
        try:
            req = urllib.request.Request(url, headers={'Accept': 'application/json', 'User-Agent': 'victorgutierrezmarcos.es paises-dictamen', **(cabeceras or {})})
            with urllib.request.urlopen(req, timeout=120) as r:
                return json.load(r)
        except OSError:
            if intento == 3:
                raise


def anios():
    return list(range(DESDE, HASTA + 1))


def weo(isos, codigos):
    """Series anuales del WEO: {iso: {codigo: {año: valor}}} y la fecha de la edición."""
    clave = f"{'+'.join(isos)}.{'+'.join(codigos)}.A"
    d = pedir(FMI + clave)
    est = d['data']['structures'][0]
    dims = est['dimensions']['series']
    paises = [v['id'] for v in next(x for x in dims if x['id'] == 'COUNTRY')['values']]
    inds = [v['id'] for v in next(x for x in dims if x['id'] == 'INDICATOR')['values']]
    orden = [x['id'] for x in dims]
    tiempos = [v.get('value') or v.get('id') for v in est['dimensions']['observation'][0]['values']]
    atributos = [a['id'] for a in est['attributes'].get('series', [])]
    pos_fecha = atributos.index('COUNTRY_UPDATE_DATE') if 'COUNTRY_UPDATE_DATE' in atributos else None
    salida, fechas = {}, []
    for k, s in d['data']['dataSets'][0]['series'].items():
        idx = dict(zip(orden, map(int, k.split(':'))))
        iso, cod = paises[idx['COUNTRY']], inds[idx['INDICATOR']]
        serie = {}
        for i, v in s.get('observations', {}).items():
            try:
                anio, valor = int(tiempos[int(i)]), float(v[0])
            except (TypeError, ValueError, IndexError):
                continue
            if DESDE <= anio <= HASTA:
                serie[anio] = valor
        salida.setdefault(iso, {})[cod] = serie
        if pos_fecha is not None:
            try:
                f = s['attributes'][pos_fecha]
                fechas.append(datetime.strptime(f, '%m/%d/%Y').date())
            except (TypeError, ValueError, IndexError, KeyError):
                pass
    return salida, (max(fechas) if fechas else None)


def wdi(isos, codigo):
    """Una variable del Banco Mundial para todos los países: {iso: {año: valor}}."""
    url = f"{BM}{';'.join(isos)}/indicator/{codigo}?" + urllib.parse.urlencode({'format': 'json', 'date': f'{DESDE}:{HASTA}', 'per_page': 20000})
    d = pedir(url)
    if not isinstance(d, list) or len(d) < 2 or d[1] is None:
        raise ValueError(f'sin datos ({str(d)[:120]})')
    salida = {}
    for o in d[1]:
        if o.get('value') is None:
            continue
        salida.setdefault(o['countryiso3code'], {})[int(o['date'])] = float(o['value'])
    return salida


def edicion_weo(fecha):
    """«2026-10» para el WEO de octubre de 2026 (las fechas de actualización caen en septiembre-octubre o marzo-abril)."""
    if fecha is None:
        return None
    if fecha.month >= 9:
        return f'{fecha.year}-10'
    if fecha.month >= 3:
        return f'{fecha.year}-04'
    return f'{fecha.year - 1}-10'


# El WEO da en unidades lo que el cuadernillo quiere en miles de millones o millones.
ESCALA = {'NGDPD': 1e9, 'LP': 1e6, 'LE': 1e6}


def comprimir(serie, unidad):
    """{año: valor} → lista desde DESDE con null donde no hay dato; redondeo según la magnitud."""
    lo, hi = RANGOS.get(unidad, (None, None))
    fuera = []
    out = []
    for a in anios():
        v = serie.get(a)
        if v is not None and lo is not None and not (lo <= v <= hi):
            fuera.append((a, v))
            v = None
        out.append(None if v is None else (round(v, 2) if abs(v) < 1000 else round(v)))
    while out and out[-1] is None:
        out.pop()
    return out, fuera


def main():
    anterior = {}
    if SALIDA.exists():
        try:
            anterior = json.loads(SALIDA.read_text(encoding='utf-8'))
        except Exception:
            anterior = {}
    previas = {p['iso']: p.get('series', {}) for p in anterior.get('paises', [])}
    isos = [p[0] for p in PAISES]
    fallos, avisos = [], []

    # FMI: una sola petición con todos los países y variables del WEO.
    datos_weo, fecha_weo = {}, None
    codigos_weo = [v[1] for v in VARIABLES if v[2] == 'weo']
    try:
        datos_weo, fecha_weo = weo(isos, codigos_weo)
    except Exception as e:  # noqa: BLE001
        fallos.append(f'FMI (WEO): {e}')

    # Banco Mundial: una petición por variable.
    datos_wdi = {}
    for cod in [v[1] for v in VARIABLES if v[2] in ('wdi', 'wdi_pib')] + [PIB_USD_BM]:
        try:
            datos_wdi[cod] = wdi(isos, cod)
        except Exception as e:  # noqa: BLE001
            fallos.append(f'Banco Mundial {cod}: {e}')
    # Las partidas en dólares, en % del PIB (solo los años con PIB).
    pib_bm = datos_wdi.get(PIB_USD_BM, {})
    for v in VARIABLES:
        if v[2] == 'wdi_pib' and v[1] in datos_wdi:
            datos_wdi[v[1]] = {iso: {a: 100 * x / pib_bm[iso][a] for a, x in serie.items() if pib_bm.get(iso, {}).get(a)}
                               for iso, serie in datos_wdi[v[1]].items()}

    if not datos_weo and not datos_wdi:
        print('Han fallado las dos fuentes:', *fallos, sep='\n  ', file=sys.stderr)
        sys.exit(1)

    paises = []
    for iso, nombre, tipo, region, mp, regimen, moneda in PAISES:
        series = {}
        for vid, cod, fuente, _g, _n, unidad in VARIABLES:
            bruta = (datos_weo.get(iso, {}).get(cod) if fuente == 'weo' else datos_wdi.get(cod, {}).get(iso))
            if bruta is None and ((fuente == 'weo' and not datos_weo) or (fuente != 'weo' and cod not in datos_wdi)):
                if vid in previas.get(iso, {}):
                    series[vid] = previas[iso][vid]  # la fuente ha fallado: se queda la serie de antes
                continue
            if not bruta:
                continue
            if cod in ESCALA:
                bruta = {a: x / ESCALA[cod] for a, x in bruta.items()}
            s, fuera = comprimir(bruta, unidad)
            for a, val in fuera:
                avisos.append(f'{iso} {vid} {a}: {val} fuera de rango, descartado')
            if any(x is not None for x in s):
                series[vid] = s
        # Identidad ahorro − inversión ≈ saldo corriente (WEO): una diferencia grande delata un error.
        sc, ah, inv = series.get('saldo_corriente'), series.get('ahorro'), series.get('inversion')
        if sc and ah and inv:
            for i, a in enumerate(anios()):
                if i < min(len(sc), len(ah), len(inv)) and None not in (sc[i], ah[i], inv[i]) and a >= 2010 and abs(sc[i] - (ah[i] - inv[i])) > 8:
                    avisos.append(f'{iso} {a}: saldo corriente {sc[i]} frente a ahorro − inversión {round(ah[i] - inv[i], 1)}')
        paises.append({
            'iso': iso, 'nombre': nombre, 'tipo': tipo, 'region': region, 'materiasPrimas': mp or None,
            'regimenCambiario': regimen, 'moneda': moneda,
            'urlFmi': f'https://www.imf.org/en/Countries/{iso}',
            'series': series,
        })

    edicion = edicion_weo(fecha_weo) or anterior.get('fuentes', {}).get('weo', {}).get('edicion')
    datos = {
        'actualizado': datetime.now(timezone.utc).strftime('%Y-%m-%dT%H:%MZ'),
        'desde': DESDE,
        'fuentes': {
            'weo': {'nombre': 'FMI, World Economic Outlook', 'edicion': edicion,
                    # En el WEO de abril y en el de octubre del año A, A ya es proyección.
                    'primerAnioProyeccion': int(edicion[:4]) if edicion else None,
                    'url': 'https://www.imf.org/en/Publications/WEO'},
            'wdi': {'nombre': 'Banco Mundial, World Development Indicators', 'url': 'https://databank.worldbank.org/source/world-development-indicators'},
        },
        'variables': [{'id': v[0], 'codigo': v[1], 'fuente': 'weo' if v[2] == 'weo' else 'wdi', 'grupo': v[3], 'nombre': v[4], 'unidad': v[5]} for v in VARIABLES],
        'paises': paises,
        'episodios': [{'id': e[0], 'iso': e[1], 'anioT': e[2], 'titulo': e[3], 'foco': e[4]} for e in EPISODIOS],
    }
    sin_hora = {k: v for k, v in datos.items() if k != 'actualizado'}
    if anterior and sin_hora == {k: v for k, v in anterior.items() if k != 'actualizado'}:
        print('Sin datos nuevos.')
    elif '--no-escribir' not in sys.argv:
        SALIDA.parent.mkdir(parents=True, exist_ok=True)
        SALIDA.write_text(json.dumps(datos, ensure_ascii=False, separators=(',', ':')) + '\n', encoding='utf-8')
        print(f'Escrito {SALIDA.relative_to(RAIZ)} ({SALIDA.stat().st_size // 1024} KB)')

    print(f'WEO {edicion}; {len(paises)} países, {len(VARIABLES)} variables, {len(EPISODIOS)} episodios.')
    vacias = [(p['iso'], v[0]) for p in paises for v in VARIABLES if v[0] not in p['series']]
    print(f'Series vacías: {len(vacias)} de {len(paises) * len(VARIABLES)}')
    for a in avisos[:40]:
        print('  AVISO', a)
    if len(avisos) > 40:
        print(f'  … y {len(avisos) - 40} avisos más')
    for f in fallos:
        print('  FALLO', f, file=sys.stderr)


if __name__ == '__main__':
    main()
