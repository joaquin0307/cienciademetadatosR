# Gráfico de la temperatura media mensual

Calcula la temperatura media de cada mes para cada estación y la grafica
con una línea por estación.

## Usage

``` r
grafico_temperatura_mensual(
  datos,
  ids = unique(datos$id),
  colores = NULL,
  titulo = "Temperatura"
)
```

## Arguments

- datos:

  Data frame con datos meteorológicos diarios. Debe tener las columnas
  `id`, `fecha` y `temperatura_abrigo_150cm`. Por ejemplo,
  [estaciones](https://joaquin0307.github.io/cienciademetadatosR/reference/estaciones.md).

- ids:

  Vector con los identificadores de las estaciones a graficar. Por
  defecto, todas las estaciones de `datos`.

- colores:

  Vector de colores, uno por estación. Si es `NULL`, se eligen colores
  al azar.

- titulo:

  Título del gráfico.

## Value

Un gráfico de `ggplot2`.

## Examples

``` r
grafico_temperatura_mensual(estaciones, ids = c("NH0472", "NH0910"))


grafico_temperatura_mensual(
  estaciones,
  ids = c("NH0472", "NH0910"),
  colores = c("steelblue", "firebrick"),
  titulo = "Temperatura media mensual"
)
```
