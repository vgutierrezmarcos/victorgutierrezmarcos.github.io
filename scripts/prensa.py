#!/usr/bin/env python3
"""Banco de medios para leer prensa económica en los idiomas de la oposición.

Escribe oposicion/datos/prensa-medios.json: los medios curados de cada idioma
(inglés y los ocho segundos idiomas del 2.º ejercicio de TCEE) con su fuente
RSS de economía, si se leen gratis o son de pago, y las palabras clave que el
conector usa para quedarse solo con lo económico y para la temática.

Los artículos no se guardan aquí: el conector (articulos_idioma) lee las
fuentes del idioma pedido en el momento, con caché de media hora. Este script
solo mantiene la lista; con --comprobar abre cada fuente y marca «ok: false» las
que ya no responden (el conector se las salta). Lo ejecuta cada lunes
.github/workflows/prensa-medios.yml. A mano:

    python3 scripts/prensa.py --comprobar     # comprueba las fuentes y escribe el JSON
    python3 scripts/prensa.py                 # escribe el JSON sin comprobar

Criterio para entrar: medio de referencia o institución pública, con sección de
economía o con contenido económico frecuente; nada sensacionalista ni de
propaganda. «acceso»: libre (gratis), limitado (unos artículos gratis al mes o
parte en abierto) o pago (muro de pago). Solo biblioteca estándar.

Autor: Víctor Gutiérrez Marcos
"""
import concurrent.futures as cf
import json
import os
import re
import sys
import urllib.request
from datetime import datetime, timezone
from pathlib import Path

RAIZ = Path(__file__).resolve().parent.parent
SALIDA = RAIZ / 'oposicion/datos/prensa-medios.json'

_CAS = Path.home() / '.config/oposicion-red/cas.pem'
if _CAS.exists() and 'SSL_CERT_FILE' not in os.environ:
    os.environ['SSL_CERT_FILE'] = str(_CAS)

IDIOMAS = {
    'en': 'inglés', 'fr': 'francés', 'de': 'alemán', 'it': 'italiano', 'pt': 'portugués',
    'ru': 'ruso', 'zh': 'chino', 'ar': 'árabe', 'ja': 'japonés',
}

# id, idioma, nombre, país, acceso, tipo (prensa | institucional | analisis),
# general (True: la fuente mezcla temas y hay que filtrar por palabras de economía), rss.
MEDIOS = [
    # Inglés
    ('economist', 'en', 'The Economist (Finance & economics)', 'Reino Unido', 'pago', 'prensa', False, 'https://www.economist.com/finance-and-economics/rss.xml'),
    ('economist-briefing', 'en', 'The Economist (Briefing)', 'Reino Unido', 'pago', 'prensa', True, 'https://www.economist.com/briefing/rss.xml'),
    ('ft', 'en', 'Financial Times (Global economy)', 'Reino Unido', 'pago', 'prensa', False, 'https://www.ft.com/global-economy?format=rss'),
    ('wsj', 'en', 'The Wall Street Journal (Economy)', 'Estados Unidos', 'pago', 'prensa', False, 'https://feeds.content.dowjones.io/public/rss/socialeconomyfeed'),
    ('bloomberg', 'en', 'Bloomberg (Economics)', 'Estados Unidos', 'pago', 'prensa', False, 'https://feeds.bloomberg.com/economics/news.rss'),
    ('nyt', 'en', 'The New York Times (Economy)', 'Estados Unidos', 'limitado', 'prensa', False, 'https://rss.nytimes.com/services/xml/rss/nyt/Economy.xml'),
    ('bbc', 'en', 'BBC News (Business)', 'Reino Unido', 'libre', 'prensa', False, 'https://feeds.bbci.co.uk/news/business/rss.xml'),
    ('guardian', 'en', 'The Guardian (Economics)', 'Reino Unido', 'libre', 'prensa', False, 'https://www.theguardian.com/business/economics/rss'),
    ('npr', 'en', 'NPR (Economy)', 'Estados Unidos', 'libre', 'prensa', False, 'https://feeds.npr.org/1017/rss.xml'),
    ('project-syndicate', 'en', 'Project Syndicate', 'Internacional', 'limitado', 'analisis', True, 'https://www.project-syndicate.org/rss'),
    ('voxeu', 'en', 'CEPR VoxEU (columnas)', 'Internacional', 'libre', 'analisis', False, 'https://cepr.org/rss/vox-content'),
    ('bruegel', 'en', 'Bruegel', 'Unión Europea', 'libre', 'analisis', False, 'https://www.bruegel.org/rss.xml'),
    ('bce-blog', 'en', 'Banco Central Europeo (blog)', 'Unión Europea', 'libre', 'institucional', False, 'https://www.ecb.europa.eu/rss/blog.html'),
    ('bpi', 'en', 'Banco de Pagos Internacionales (discursos de bancos centrales)', 'Internacional', 'libre', 'institucional', False, 'https://www.bis.org/doclist/cbspeeches.rss'),
    # Francés
    ('lemonde', 'fr', 'Le Monde (Économie)', 'Francia', 'limitado', 'prensa', False, 'https://www.lemonde.fr/economie/rss_full.xml'),
    ('lemonde-mondiale', 'fr', 'Le Monde (Économie mondiale)', 'Francia', 'limitado', 'prensa', False, 'https://www.lemonde.fr/economie-mondiale/rss_full.xml'),
    ('lefigaro', 'fr', 'Le Figaro (Économie)', 'Francia', 'limitado', 'prensa', False, 'https://www.lefigaro.fr/rss/figaro_economie.xml'),
    ('latribune', 'fr', 'La Tribune', 'Francia', 'limitado', 'prensa', False, 'https://www.latribune.fr/feed.xml'),
    ('alteco', 'fr', 'Alternatives Économiques', 'Francia', 'pago', 'prensa', False, 'https://www.alternatives-economiques.fr/rss.xml'),
    ('france24-fr', 'fr', 'France 24 (Éco/Tech)', 'Francia', 'libre', 'prensa', False, 'https://www.france24.com/fr/%C3%A9co-tech/rss'),
    ('rfi-fr', 'fr', 'RFI (Économie)', 'Francia', 'libre', 'prensa', False, 'https://www.rfi.fr/fr/%C3%A9conomie/rss'),
    ('letemps', 'fr', 'Le Temps (Économie)', 'Suiza', 'pago', 'prensa', False, 'https://www.letemps.ch/economie.rss'),
    ('ledevoir', 'fr', 'Le Devoir (Économie)', 'Canadá', 'limitado', 'prensa', False, 'https://www.ledevoir.com/rss/section/economie.xml'),
    ('lapresse', 'fr', 'La Presse (Affaires)', 'Canadá', 'libre', 'prensa', False, 'https://www.lapresse.ca/affaires/rss'),
    ('jeuneafrique', 'fr', 'Jeune Afrique (Économie et entreprises)', 'África', 'limitado', 'prensa', False, 'https://www.jeuneafrique.com/rubriques/economie-entreprises/feed/'),
    # Alemán
    ('faz', 'de', 'Frankfurter Allgemeine Zeitung (Wirtschaft)', 'Alemania', 'limitado', 'prensa', False, 'https://www.faz.net/rss/aktuell/wirtschaft/'),
    ('handelsblatt', 'de', 'Handelsblatt', 'Alemania', 'pago', 'prensa', False, 'https://www.handelsblatt.com/contentexport/feed/wirtschaft'),
    ('sz', 'de', 'Süddeutsche Zeitung (Wirtschaft)', 'Alemania', 'limitado', 'prensa', False, 'https://rss.sueddeutsche.de/rss/Wirtschaft'),
    ('spiegel', 'de', 'Der Spiegel (Wirtschaft)', 'Alemania', 'limitado', 'prensa', False, 'https://www.spiegel.de/wirtschaft/index.rss'),
    ('zeit', 'de', 'Die Zeit (Wirtschaft)', 'Alemania', 'limitado', 'prensa', False, 'https://newsfeed.zeit.de/wirtschaft/index'),
    ('tagesschau', 'de', 'Tagesschau (Wirtschaft)', 'Alemania', 'libre', 'prensa', False, 'https://www.tagesschau.de/wirtschaft/index~rss2.xml'),
    ('dw-de', 'de', 'Deutsche Welle (Wirtschaft)', 'Alemania', 'libre', 'prensa', False, 'https://rss.dw.com/xml/rss-de-eco'),
    ('nzz', 'de', 'Neue Zürcher Zeitung (Wirtschaft)', 'Suiza', 'limitado', 'prensa', False, 'https://www.nzz.ch/wirtschaft.rss'),
    ('standard', 'de', 'Der Standard (Wirtschaft)', 'Austria', 'libre', 'prensa', False, 'https://www.derstandard.at/rss/wirtschaft'),
    ('ifo', 'de', 'ifo Institut', 'Alemania', 'libre', 'analisis', False, 'https://www.ifo.de/rss.xml'),
    ('bundesbank', 'de', 'Deutsche Bundesbank', 'Alemania', 'libre', 'institucional', True, 'https://www.bundesbank.de/service/rss/de/633286/feed.rss'),
    # Italiano
    ('sole24ore', 'it', 'Il Sole 24 Ore (Economia)', 'Italia', 'pago', 'prensa', False, 'https://www.ilsole24ore.com/rss/economia.xml'),
    ('sole24ore-mondo', 'it', 'Il Sole 24 Ore (Mondo)', 'Italia', 'pago', 'prensa', True, 'https://www.ilsole24ore.com/rss/mondo.xml'),
    ('repubblica', 'it', 'la Repubblica (Economia)', 'Italia', 'limitado', 'prensa', False, 'https://www.repubblica.it/rss/economia/rss2.0.xml'),
    ('ansa', 'it', 'ANSA (Economia)', 'Italia', 'libre', 'prensa', False, 'https://www.ansa.it/sito/notizie/economia/economia_rss.xml'),
    ('ilpost', 'it', 'Il Post (Economia)', 'Italia', 'libre', 'prensa', False, 'https://www.ilpost.it/economia/feed/'),
    ('lavoce', 'it', 'lavoce.info', 'Italia', 'libre', 'analisis', False, 'https://www.lavoce.info/feed/'),
    ('bancaditalia', 'it', "Banca d'Italia", 'Italia', 'libre', 'institucional', False, 'https://www.bancaditalia.it/util/index.rss.html'),
    # Portugués
    ('publico', 'pt', 'Público (Economia)', 'Portugal', 'limitado', 'prensa', False, 'https://feeds.feedburner.com/PublicoEconomia'),
    ('negocios', 'pt', 'Jornal de Negócios', 'Portugal', 'pago', 'prensa', False, 'https://www.jornaldenegocios.pt/rss'),
    ('eco', 'pt', 'ECO', 'Portugal', 'libre', 'prensa', False, 'https://eco.sapo.pt/feed/'),
    ('observador', 'pt', 'Observador (Economia)', 'Portugal', 'limitado', 'prensa', False, 'https://observador.pt/seccao/economia/feed/'),
    ('rtp', 'pt', 'RTP Notícias (Economia)', 'Portugal', 'libre', 'prensa', False, 'https://www.rtp.pt/noticias/rss/economia'),
    ('valor', 'pt', 'Valor Econômico', 'Brasil', 'pago', 'prensa', False, 'https://valor.globo.com/rss/valor'),
    ('folha', 'pt', 'Folha de S.Paulo (Mercado)', 'Brasil', 'limitado', 'prensa', False, 'https://feeds.folha.uol.com.br/mercado/rss091.xml'),
    ('estadao', 'pt', 'Estadão (Economia)', 'Brasil', 'limitado', 'prensa', False, 'https://www.estadao.com.br/arc/outboundfeeds/feeds/rss/sections/economia/'),
    ('g1', 'pt', 'g1 (Economia)', 'Brasil', 'libre', 'prensa', False, 'https://g1.globo.com/rss/g1/economia/'),
    ('dw-pt', 'pt', 'Deutsche Welle (português)', 'Alemania', 'libre', 'prensa', True, 'https://rss.dw.com/xml/rss-br-all'),
    # Ruso
    ('kommersant', 'ru', 'Коммерсантъ (Экономика)', 'Rusia', 'libre', 'prensa', False, 'https://www.kommersant.ru/RSS/section-economics.xml'),
    ('kommersant-fin', 'ru', 'Коммерсантъ (Финансы)', 'Rusia', 'libre', 'prensa', False, 'https://www.kommersant.ru/RSS/section-finance.xml'),
    ('vedomosti', 'ru', 'Ведомости (Экономика)', 'Rusia', 'limitado', 'prensa', False, 'https://www.vedomosti.ru/rss/rubric/economics'),
    ('rbc', 'ru', 'РБК', 'Rusia', 'libre', 'prensa', True, 'https://rssexport.rbc.ru/rbcnews/news/30/full.rss'),
    ('interfax', 'ru', 'Интерфакс', 'Rusia', 'libre', 'prensa', True, 'https://www.interfax.ru/rss.asp'),
    ('thebell', 'ru', 'The Bell', 'Internacional', 'libre', 'prensa', False, 'https://thebell.io/feed'),
    ('bbc-ru', 'ru', 'Би-би-си (Русская служба)', 'Reino Unido', 'libre', 'prensa', True, 'https://feeds.bbci.co.uk/russian/rss.xml'),
    ('dw-ru', 'ru', 'Deutsche Welle (по-русски)', 'Alemania', 'libre', 'prensa', True, 'https://rss.dw.com/xml/rss-ru-all'),
    ('meduza', 'ru', 'Meduza', 'Internacional', 'libre', 'prensa', True, 'https://meduza.io/rss/all'),
    # Chino
    ('ftchinese', 'zh', 'FT中文网', 'Reino Unido', 'limitado', 'prensa', True, 'https://www.ftchinese.com/rss/news'),
    ('rfi-zh', 'zh', '法广 RFI (经贸)', 'Francia', 'libre', 'prensa', False, 'https://www.rfi.fr/cn/%E7%BB%8F%E8%B4%B8/rss'),
    ('bbc-zh', 'zh', 'BBC中文', 'Reino Unido', 'libre', 'prensa', True, 'https://feeds.bbci.co.uk/zhongwen/simp/rss.xml'),
    ('dw-zh', 'zh', '德国之声 DW', 'Alemania', 'libre', 'prensa', True, 'https://rss.dw.com/xml/rss-chi-all'),
    ('cna', 'zh', '中央社 (財經)', 'Taiwán', 'libre', 'prensa', False, 'https://feeds.feedburner.com/rsscna/finance'),
    ('mingpao', 'zh', '明報 (經濟)', 'Hong Kong', 'libre', 'prensa', False, 'https://news.mingpao.com/rss/pns/s00004.xml'),
    # Árabe
    ('aawsat', 'ar', 'الشرق الأوسط (اقتصاد)', 'Arabia Saudí', 'libre', 'prensa', False, 'https://aawsat.com/feed/economy'),
    ('aljazeera', 'ar', 'الجزيرة نت (اقتصاد)', 'Catar', 'libre', 'prensa', False, 'https://www.aljazeera.net/aljazeerarss/a7c186be-1baa-4bd4-9d80-a84db769f779/73d0e1b4-532f-45ef-b135-bfdff8b8cab9'),
    ('france24-ar', 'ar', 'فرانس 24 (اقتصاد)', 'Francia', 'libre', 'prensa', False, 'https://www.france24.com/ar/%D8%A7%D9%82%D8%AA%D8%B5%D8%A7%D8%AF/rss'),
    ('bbc-ar', 'ar', 'بي بي سي عربي', 'Reino Unido', 'libre', 'prensa', True, 'https://feeds.bbci.co.uk/arabic/rss.xml'),
    ('dw-ar', 'ar', 'دويتشه فيله عربية', 'Alemania', 'libre', 'prensa', True, 'https://rss.dw.com/xml/rss-ar-all'),
    # Japonés
    ('nikkei', 'ja', '日本経済新聞 (経済)', 'Japón', 'pago', 'prensa', False, 'https://assets.wor.jp/rss/rdf/nikkei/economy.rdf'),
    ('nikkei-business', 'ja', '日経ビジネス', 'Japón', 'pago', 'prensa', False, 'https://business.nikkei.com/rss/sns/nb.rdf'),
    ('nhk', 'ja', 'NHK (経済)', 'Japón', 'libre', 'prensa', False, 'https://www3.nhk.or.jp/rss/news/cat5.xml'),
    ('asahi', 'ja', '朝日新聞 (経済)', 'Japón', 'limitado', 'prensa', False, 'https://www.asahi.com/rss/asahi/business.rdf'),
    ('yomiuri', 'ja', '読売新聞 (経済)', 'Japón', 'limitado', 'prensa', False, 'https://assets.wor.jp/rss/rdf/yomiuri/economy.rdf'),
    ('toyokeizai', 'ja', '東洋経済オンライン', 'Japón', 'libre', 'prensa', True, 'https://toyokeizai.net/list/feed/rss'),
    ('bbc-ja', 'ja', 'BBCニュース 日本語', 'Reino Unido', 'libre', 'prensa', True, 'https://feeds.bbci.co.uk/japanese/rss.xml'),
    ('boj', 'ja', '日本銀行', 'Japón', 'libre', 'institucional', False, 'https://www.boj.or.jp/rss/whatsnew.xml'),
]

# Palabras que delatan contenido económico (en minúsculas; se buscan como
# subcadena en el título y el extracto). Solo se aplican a las fuentes «general».
ECONOMIA = {
    'en': ['econom', 'inflation', 'gdp', 'growth', 'recession', 'interest rate', 'central bank', 'fed ', 'ecb', 'tariff', 'trade', 'budget', 'deficit', 'debt', 'tax', 'jobs', 'unemployment', 'wage', 'market', 'bank', 'imf', 'oil', 'currency', 'dollar', 'export', 'import', 'invest', 'fiscal', 'monetary', 'productivity', 'price'],
    'fr': ['économ', 'inflation', 'pib', 'croissance', 'récession', 'taux', 'banque centrale', 'bce', 'droits de douane', 'commerce', 'budget', 'déficit', 'dette', 'impôt', 'fiscal', 'chômage', 'emploi', 'salaire', 'marché', 'banque', 'fmi', 'pétrole', 'monnaie', 'export', 'import', 'investiss', 'prix'],
    'de': ['wirtschaft', 'konjunktur', 'inflation', 'bip', 'wachstum', 'rezession', 'zins', 'notenbank', 'zentralbank', 'ezb', 'zoll', 'zölle', 'handel', 'haushalt', 'defizit', 'schulden', 'steuer', 'arbeitslos', 'beschäftigung', 'lohn', 'löhne', 'markt', 'bank', 'iwf', 'öl', 'währung', 'export', 'import', 'investition', 'preis'],
    'it': ['econom', 'inflazione', 'pil', 'crescita', 'recessione', 'tassi', 'banca centrale', 'bce', 'dazi', 'commercio', 'bilancio', 'deficit', 'debito', 'tasse', 'fisco', 'disoccupazione', 'occupazione', 'salari', 'mercat', 'banca', 'fmi', 'petrolio', 'valuta', 'export', 'import', 'investiment', 'prezzi'],
    'pt': ['econom', 'inflação', 'pib', 'crescimento', 'recessão', 'juros', 'banco central', 'bce', 'tarifa', 'comércio', 'orçamento', 'défice', 'déficit', 'dívida', 'imposto', 'fiscal', 'desemprego', 'emprego', 'salári', 'mercado', 'banco', 'fmi', 'petróleo', 'moeda', 'exporta', 'importa', 'investiment', 'preço'],
    'ru': ['эконом', 'инфляц', 'ввп', 'рост', 'рецесс', 'ставк', 'центробанк', 'цб ', 'банк россии', 'пошлин', 'торгов', 'бюджет', 'дефицит', 'долг', 'налог', 'безработ', 'занятост', 'зарплат', 'рынок', 'рынк', 'банк', 'мвф', 'нефт', 'газ', 'рубл', 'валют', 'экспорт', 'импорт', 'инвест', 'санкц', 'цен'],
    'zh': ['经济', '經濟', '通胀', '通膨', 'gdp', '增长', '增長', '衰退', '利率', '央行', '关税', '關稅', '贸易', '貿易', '预算', '預算', '赤字', '债务', '債務', '税', '稅', '失业', '失業', '就业', '就業', '工资', '市场', '市場', '银行', '銀行', 'imf', '石油', '汇率', '匯率', '出口', '进口', '進口', '投资', '投資', '财政', '財政', '价格', '股'],
    'ar': ['اقتصاد', 'تضخم', 'الناتج المحلي', 'نمو', 'ركود', 'فائدة', 'البنك المركزي', 'المركزي', 'رسوم جمركية', 'تجار', 'ميزانية', 'موازنة', 'عجز', 'دين', 'ديون', 'ضريب', 'بطالة', 'توظيف', 'أجور', 'سوق', 'أسواق', 'بنك', 'صندوق النقد', 'نفط', 'النفط', 'عملة', 'دولار', 'صادرات', 'واردات', 'استثمار', 'أسعار'],
    'ja': ['経済', '景気', 'インフレ', '物価', 'gdp', '成長', '不況', '金利', '日銀', '中央銀行', '関税', '貿易', '予算', '赤字', '債務', '国債', '税', '失業', '雇用', '賃金', '賃上げ', '市場', '銀行', 'imf', '原油', '円安', '円高', '為替', '輸出', '輸入', '投資', '財政', '株'],
}

# Temáticas (las que puede pedir el opositor) y sus palabras en cada idioma.
TEMATICAS = {
    'macroeconomia': {
        'nombre': 'Coyuntura y crecimiento',
        'en': ['gdp', 'growth', 'recession', 'inflation', 'outlook', 'econom', 'productivity', 'unemployment'], 'fr': ['pib', 'croissance', 'récession', 'inflation', 'conjoncture', 'prévision'],
        'de': ['bip', 'wachstum', 'rezession', 'inflation', 'konjunktur', 'prognose'], 'it': ['pil', 'crescita', 'recessione', 'inflazione', 'congiuntura', 'previsioni'],
        'pt': ['pib', 'crescimento', 'recessão', 'inflação', 'conjuntura', 'previs'], 'ru': ['ввп', 'рост экономики', 'рецесс', 'инфляц', 'прогноз'],
        'zh': ['gdp', '增长', '增長', '衰退', '通胀', '通膨', '经济', '經濟'], 'ar': ['الناتج المحلي', 'نمو', 'ركود', 'تضخم', 'توقعات'], 'ja': ['gdp', '成長', '景気', 'インフレ', '物価', '見通し'],
    },
    'politica_monetaria': {
        'nombre': 'Política monetaria y bancos centrales',
        'en': ['central bank', 'interest rate', 'rate cut', 'rate hike', 'fed ', 'federal reserve', 'ecb', 'bank of england', 'monetary'], 'fr': ['banque centrale', 'taux', 'bce', 'fed', 'monétaire'],
        'de': ['zentralbank', 'notenbank', 'zins', 'ezb', 'fed', 'geldpolitik'], 'it': ['banca centrale', 'tassi', 'bce', 'fed', 'monetari'],
        'pt': ['banco central', 'juros', 'selic', 'bce', 'fed', 'monetári'], 'ru': ['ставк', 'центробанк', 'банк россии', 'цб', 'фрс', 'денежно-кредит'],
        'zh': ['央行', '利率', '降息', '加息', '美联储', '聯準會', '货币政策'], 'ar': ['البنك المركزي', 'الفائدة', 'الاحتياطي الفيدرالي', 'السياسة النقدية'], 'ja': ['日銀', '金利', '利上げ', '利下げ', '中央銀行', 'frb', '金融政策'],
    },
    'politica_fiscal': {
        'nombre': 'Presupuestos, deuda e impuestos',
        'en': ['budget', 'deficit', 'debt', 'tax', 'fiscal', 'spending', 'bond'], 'fr': ['budget', 'déficit', 'dette', 'impôt', 'fiscal', 'dépenses'],
        'de': ['haushalt', 'defizit', 'schulden', 'steuer', 'ausgaben', 'anleihe'], 'it': ['bilancio', 'manovra', 'deficit', 'debito', 'tasse', 'fisco', 'spesa'],
        'pt': ['orçamento', 'défice', 'déficit', 'dívida', 'imposto', 'fiscal', 'despesa'], 'ru': ['бюджет', 'дефицит', 'долг', 'налог', 'расход'],
        'zh': ['预算', '預算', '赤字', '债务', '債務', '税', '稅', '财政', '財政'], 'ar': ['ميزانية', 'موازنة', 'عجز', 'دين', 'ديون', 'ضريب'], 'ja': ['予算', '赤字', '国債', '債務', '税', '財政'],
    },
    'comercio': {
        'nombre': 'Comercio internacional y aranceles',
        'en': ['tariff', 'trade', 'export', 'import', 'wto', 'supply chain', 'sanction'], 'fr': ['droits de douane', 'commerce', 'export', 'import', 'omc', 'sanction'],
        'de': ['zoll', 'zölle', 'handel', 'export', 'import', 'wto', 'lieferkette', 'sanktion'], 'it': ['dazi', 'commercio', 'export', 'import', 'wto', 'sanzion'],
        'pt': ['tarifa', 'comércio', 'exporta', 'importa', 'omc', 'sanç'], 'ru': ['пошлин', 'торгов', 'экспорт', 'импорт', 'вто', 'санкц'],
        'zh': ['关税', '關稅', '贸易', '貿易', '出口', '进口', '進口', '制裁'], 'ar': ['رسوم جمركية', 'تجار', 'صادرات', 'واردات', 'عقوبات'], 'ja': ['関税', '貿易', '輸出', '輸入', '制裁', 'サプライチェーン'],
    },
    'finanzas': {
        'nombre': 'Mercados financieros y banca',
        'en': ['bank', 'stock', 'market', 'bond', 'investor', 'shares', 'currency', 'dollar'], 'fr': ['banque', 'bourse', 'marché', 'obligat', 'investisseur', 'monnaie'],
        'de': ['bank', 'börse', 'aktie', 'anleihe', 'anleger', 'märkte', 'währung'], 'it': ['banca', 'borsa', 'mercat', 'spread', 'btp', 'investitori', 'valuta'],
        'pt': ['banco', 'bolsa', 'mercado', 'ações', 'investidor', 'câmbio', 'dólar'], 'ru': ['банк', 'бирж', 'рынок', 'акци', 'облигац', 'рубл', 'валют'],
        'zh': ['银行', '銀行', '股', '市场', '市場', '债券', '債券', '汇率', '匯率'], 'ar': ['بنك', 'بورصة', 'سوق', 'أسهم', 'سندات', 'عملة', 'دولار'], 'ja': ['銀行', '株', '市場', '債券', '為替', '円安', '円高'],
    },
    'energia': {
        'nombre': 'Energía y materias primas',
        'en': ['oil', 'gas', 'energy', 'opec', 'commodit', 'copper', 'gold', 'climate'], 'fr': ['pétrole', 'gaz', 'énergie', 'opep', 'matières premières', 'climat'],
        'de': ['öl', 'gas', 'energie', 'opec', 'rohstoff', 'klima'], 'it': ['petrolio', 'gas', 'energia', 'opec', 'materie prime', 'clima'],
        'pt': ['petróleo', 'gás', 'energia', 'opep', 'commodit', 'clima'], 'ru': ['нефт', 'газ', 'энерг', 'опек', 'сырь', 'климат'],
        'zh': ['石油', '天然气', '能源', '欧佩克', '大宗商品', '气候'], 'ar': ['نفط', 'النفط', 'غاز', 'طاقة', 'أوبك', 'سلع'], 'ja': ['原油', 'ガス', 'エネルギー', 'opec', '資源', '気候'],
    },
    'trabajo': {
        'nombre': 'Empleo y salarios',
        'en': ['jobs', 'unemployment', 'wage', 'labour', 'labor', 'workers', 'strike', 'pension'], 'fr': ['chômage', 'emploi', 'salaire', 'travail', 'grève', 'retraite'],
        'de': ['arbeitslos', 'beschäftigung', 'lohn', 'löhne', 'arbeitsmarkt', 'streik', 'rente'], 'it': ['disoccupazione', 'occupazione', 'salari', 'lavoro', 'sciopero', 'pension'],
        'pt': ['desemprego', 'emprego', 'salári', 'trabalho', 'greve', 'pensõ', 'reforma'], 'ru': ['безработ', 'занятост', 'зарплат', 'труд', 'пенси'],
        'zh': ['失业', '失業', '就业', '就業', '工资', '薪资', '劳动', '養老'], 'ar': ['بطالة', 'توظيف', 'وظائف', 'أجور', 'العمال', 'تقاعد'], 'ja': ['失業', '雇用', '賃金', '賃上げ', '労働', '年金'],
    },
    'union_europea': {
        'nombre': 'Unión Europea',
        'en': ['eu ', 'european union', 'brussels', 'european commission', 'eurozone', 'euro area'], 'fr': ['ue ', 'union européenne', 'bruxelles', 'commission européenne', 'zone euro'],
        'de': ['eu-', 'eu ', 'europäische union', 'brüssel', 'eu-kommission', 'eurozone'], 'it': ['ue ', 'unione europea', 'bruxelles', 'commissione europea', 'eurozona'],
        'pt': ['ue ', 'união europeia', 'bruxelas', 'comissão europeia', 'zona euro'], 'ru': ['евросоюз', ' ес ', 'еврокомисс', 'еврозон'],
        'zh': ['欧盟', '歐盟', '欧元区', '歐元區', '欧洲委员会'], 'ar': ['الاتحاد الأوروبي', 'بروكسل', 'المفوضية الأوروبية', 'منطقة اليورو'], 'ja': ['eu', '欧州連合', '欧州委員会', 'ユーロ圏'],
    },
    'desarrollo': {
        'nombre': 'Emergentes, desarrollo y organismos internacionales',
        'en': ['imf', 'world bank', 'emerging', 'developing', 'africa', 'poverty', 'aid', 'g20'], 'fr': ['fmi', 'banque mondiale', 'émergent', 'développement', 'afrique', 'pauvreté', 'aide', 'g20'],
        'de': ['iwf', 'weltbank', 'schwellenländer', 'entwicklung', 'afrika', 'armut', 'g20'], 'it': ['fmi', 'banca mondiale', 'emergenti', 'sviluppo', 'africa', 'povertà', 'g20'],
        'pt': ['fmi', 'banco mundial', 'emergente', 'desenvolvimento', 'áfrica', 'pobreza', 'g20', 'brics'], 'ru': ['мвф', 'всемирный банк', 'развивающ', 'африк', 'бедност', 'брикс', 'g20'],
        'zh': ['imf', '世界银行', '新兴', '发展中', '非洲', '贫困', '金砖', 'g20'], 'ar': ['صندوق النقد', 'البنك الدولي', 'الناشئة', 'تنمية', 'أفريقيا', 'فقر', 'مجموعة العشرين'], 'ja': ['imf', '世界銀行', '新興国', '途上国', 'アフリカ', '貧困', 'g20'],
    },
}


def comprobar(m):
    """Abre la fuente y cuenta las entradas; (ok, detalle)."""
    url = m[7]
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0 (compatible; victorgutierrezmarcos.es prensa)'})
        with urllib.request.urlopen(req, timeout=30) as r:
            cuerpo = r.read().decode('utf-8', 'replace')
        n = len(re.findall(r'<item[\s>]|<entry[\s>]', cuerpo))
        return (n > 0, f'{n} entradas')
    except Exception as e:  # noqa: BLE001
        return (False, str(e)[:100])


def main():
    anterior = {}
    if SALIDA.exists():
        try:
            anterior = {m['id']: m for m in json.loads(SALIDA.read_text(encoding='utf-8')).get('medios', [])}
        except Exception:
            anterior = {}
    estado = {}
    if '--comprobar' in sys.argv:
        with cf.ThreadPoolExecutor(12) as ex:
            for m, r in zip(MEDIOS, ex.map(comprobar, MEDIOS)):
                estado[m[0]] = r
    hoy = datetime.now(timezone.utc).strftime('%Y-%m-%d')
    medios = []
    for (mid, idioma, nombre, pais, acceso, tipo, general, rss) in MEDIOS:
        previo = anterior.get(mid, {})
        if mid in estado:
            ok, detalle = estado[mid]
            # Una caída suelta no basta: se marca rota la segunda semana seguida.
            fallos = 0 if ok else previo.get('fallos', 0) + 1
        else:
            ok, detalle, fallos = previo.get('ok', True), None, previo.get('fallos', 0)
        medios.append({
            'id': mid, 'idioma': idioma, 'nombre': nombre, 'pais': pais, 'acceso': acceso, 'tipo': tipo,
            'general': general, 'rss': rss, 'ok': fallos < 2, 'fallos': fallos,
        })
        if mid in estado and not estado[mid][0]:
            print(f'  FALLA {mid:20} {detalle}')
    datos = {
        'idiomas': IDIOMAS,
        'accesos': {'libre': 'gratis', 'limitado': 'unos artículos gratis al mes o parte en abierto', 'pago': 'con suscripción'},
        'medios': medios,
        'economia': ECONOMIA,
        'tematicas': TEMATICAS,
    }
    previo_txt = SALIDA.read_text(encoding='utf-8') if SALIDA.exists() else ''
    nuevo_txt = json.dumps(datos, ensure_ascii=False, indent=1) + '\n'
    if nuevo_txt == previo_txt:
        print('Sin cambios.')
    else:
        SALIDA.parent.mkdir(parents=True, exist_ok=True)
        SALIDA.write_text(nuevo_txt, encoding='utf-8')
        print(f'Escrito {SALIDA.relative_to(RAIZ)}')
    por_idioma = {}
    for m in medios:
        por_idioma.setdefault(m['idioma'], []).append(m)
    for i, ms in por_idioma.items():
        print(f"  {IDIOMAS[i]:10} {len(ms):2} medios ({sum(m['acceso'] == 'libre' for m in ms)} libres), {sum(not m['ok'] for m in ms)} rotos")
    print(f'Comprobado el {hoy}.' if estado else 'Sin comprobar las fuentes (usa --comprobar).')


if __name__ == '__main__':
    main()
