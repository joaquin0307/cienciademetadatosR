# Descargar datos de una estación meteorológica

Descarga el archivo con los datos diarios de una estación desde el
repositorio del curso, lo guarda en `destino` y lo devuelve como data
frame.

## Usage

``` r
leer_datos(id_estacion, destino)
```

## Arguments

- id_estacion:

  Texto con el identificador de la estación (por ejemplo `"NH0472"`).

- destino:

  Ruta del archivo donde se guardan los datos descargados.

## Value

Un data frame (tibble) con los datos diarios de la estación.

## Examples

``` r
# \donttest{
datos <- leer_datos("NH0472", destino = tempfile(fileext = ".csv"))
head(datos)
#> # A tibble: 6 × 35
#>   id     fecha      temperatura_abrigo_150cm temperatura_abrigo_150cm_maxima
#>   <chr>  <date>                        <dbl>                           <dbl>
#> 1 NH0472 1961-07-01                     11.1                            13.4
#> 2 NH0472 1961-07-02                      5.5                            10.5
#> 3 NH0472 1961-07-03                      6                              10.8
#> 4 NH0472 1961-07-04                     NA                              NA  
#> 5 NH0472 1961-07-05                     12.4                            14.8
#> 6 NH0472 1961-07-06                     11                              16.5
#> # ℹ 31 more variables: temperatura_abrigo_150cm_minima <dbl>,
#> #   temperatura_intemperie_5cm_minima <dbl>,
#> #   temperatura_intemperie_50cm_minima <dbl>,
#> #   temperatura_suelo_5cm_media <lgl>, temperatura_suelo_10cm_media <lgl>,
#> #   temperatura_inte_5cm <lgl>, temperatura_intemperie_150cm_minima <lgl>,
#> #   humedad_suelo <lgl>, precipitacion_pluviometrica <dbl>, granizo <dbl>,
#> #   nieve <dbl>, heliofania_efectiva <dbl>, heliofania_relativa <dbl>, …
# }
```
