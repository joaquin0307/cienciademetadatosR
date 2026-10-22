# Tabla resumen de temperaturas por estación

Calcula, para cada estación, la temperatura mínima y máxima registradas,
y el promedio y el desvío estándar de la temperatura media.

## Usage

``` r
tabla_resumen_temperatura(datos, ids = unique(datos$id))
```

## Arguments

- datos:

  Data frame con datos meteorológicos diarios. Debe tener las columnas
  `id`, `temperatura_abrigo_150cm`, `temperatura_abrigo_150cm_maxima` y
  `temperatura_abrigo_150cm_minima`. Por ejemplo,
  [estaciones](https://joaquin0307.github.io/cienciademetadatosR/reference/estaciones.md).

- ids:

  Vector con los identificadores de las estaciones a resumir. Por
  defecto, todas las estaciones de `datos`.

## Value

Un data frame con una fila por estación y las columnas `id`,
`temp_minima`, `temp_maxima`, `promedio` y `desvio`.

## Examples

``` r
tabla_resumen_temperatura(estaciones, ids = "NH0472")
#> # A tibble: 1 × 5
#>   id     temp_minima temp_maxima promedio desvio
#>   <chr>        <dbl>       <dbl>    <dbl>  <dbl>
#> 1 NH0472          -6        40.6     19.0   5.94
tabla_resumen_temperatura(estaciones, ids = c("NH0472", "NH0910"))
#> # A tibble: 2 × 5
#>   id     temp_minima temp_maxima promedio desvio
#>   <chr>        <dbl>       <dbl>    <dbl>  <dbl>
#> 1 NH0472        -6          40.6     19.0   5.94
#> 2 NH0910        -7.5        43       18.0   6.22
tabla_resumen_temperatura(estaciones)
#> # A tibble: 5 × 5
#>   id     temp_minima temp_maxima promedio desvio
#>   <chr>        <dbl>       <dbl>    <dbl>  <dbl>
#> 1 NH0046        -5.7        38.8     17.5   6.05
#> 2 NH0098        -6.4        42       19.1   5.86
#> 3 NH0437        -3.4        41.5     20.5   5.76
#> 4 NH0472        -6          40.6     19.0   5.94
#> 5 NH0910        -7.5        43       18.0   6.22
```
