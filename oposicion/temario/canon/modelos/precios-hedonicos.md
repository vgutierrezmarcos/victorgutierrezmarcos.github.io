# Precios hedónicos (Court, 1939; Griliches, 1961; Rosen, 1974)

- **Área:** consumidor-producción · **Tema de referencia:** 3.A.8 (Demanda I) — revisado; lo tiene en el título y lo desarrolla con el modelo de Rosen.
- **Temas que lo usan:** 3.A.8 (desarrollo), 4.B.6 (resumen: valoración de bienes sin mercado en el ACB); 4.A.1 y 3.A.30 podrían citarlo para el ajuste por calidad del IPC.
- **Manuales de referencia:** Rosen (1974), *JPE*; Griliches (1971); Triplett (2006), *Handbook on Hedonic Indexes*; Boardman et al., *Cost-Benefit Analysis* (4.B.6).

## Presentación de referencia
Pregunta: ¿cuánto valoran los consumidores cada característica de un bien diferenciado?
Supuestos: mercado competitivo de un producto diferenciado descrito por $z=(z_1,\dots,z_k)$; precio $p(z)$; numerario $y$.
$$\max_{z,y}U(z,y)\ \text{s.a.}\ p(z)+y=\overline W\ \Rightarrow\ \frac{\partial U/\partial z_j}{\partial U/\partial y}=\frac{\partial p(z)}{\partial z_j}$$
Función de puja del consumidor $\theta(z;\overline U,\overline W)$ y de oferta del productor $\phi(z;\pi)$; $p(z)$ es la envolvente de ambas (lugar de equilibrios, no curva de demanda ni de oferta). Primera etapa: regresión hedónica $\ln p=\beta_0+\sum_j\beta_j z_j+u$ (precios implícitos); segunda etapa: demandas de características (problema de identificación).
Gráfico de referencia: `oposicion/temario/fuentes/3A08/graficos/funcion-hedonica-rosen.tex`.

## Cómo se adapta en cada tema
| Tema | Pregunta del tema | Profundidad | Qué contar / variante | Qué no repetir |
|---|---|---|---|---|
| 3.A.8 | Teoría y aplicaciones | desarrollo | Rosen completo, dos etapas, IPC con ajuste de calidad | — |
| 4.B.6 | Valorar efectos sin precio de mercado en el ACB | resumen | Regresión hedónica de precios de la vivienda para ruido, contaminación, zonas verdes; junto a coste de viaje y valoración contingente | El modelo de Rosen (remitir a 3.A.8) |

## Divergencias encontradas en el temario actual
- Atribución: 4.B.6 lo atribuye a Griliches (1971); canon: Court (1939) acuña, Griliches (1961) lo hace método, Rosen (1974) lo fundamenta.
- Notación de 3.A.8: $\theta$ (puja) choca con el parámetro CRRA si se adopta $\theta$ (ver `_notacion/consumidor-produccion.md`) y $\pi$ (beneficio) con la propuesta de $B$ para el beneficio. **[decidir]** (propuesta: $\Theta(z;\overline U,\overline W)$ y $\phi(z;B)$).
