# Datos meteorológicos de estaciones del INTA

Registros diarios de temperatura de 5 estaciones meteorológicas (NH0046,
NH0098, NH0437, NH0472 y NH0910) entre 2010 y 2017. Es un recorte de los
datos descargados del repositorio del curso, pensado para usar en los
ejemplos del paquete.

Registros diarios de variables meteorologicas (temperatura, humedad,
viento, radiacion, entre otras) medidos en cinco estaciones.

## Usage

``` r
estaciones

estaciones
```

## Format

Un data frame con 5 columnas:

- id:

  Identificador de la estación.

- fecha:

  Fecha de la medición.

- temperatura_abrigo_150cm:

  Temperatura media del día, en °C.

- temperatura_abrigo_150cm_maxima:

  Temperatura máxima del día, en °C.

- temperatura_abrigo_150cm_minima:

  Temperatura mínima del día, en °C.

Un tibble con 20.425 filas y 35 variables:

- id:

  texto con el identificador de la estacion

- fecha:

  fecha de la medicion

- temperatura_abrigo_150cm:

  temperatura media en el abrigo meteorologico a 150 cm

- temperatura_abrigo_150cm_maxima:

  temperatura maxima en el abrigo a 150 cm

- temperatura_abrigo_150cm_minima:

  temperatura minima en el abrigo a 150 cm

- temperatura_intemperie_5cm_minima:

  temperatura minima a la intemperie a 5 cm

- temperatura_intemperie_50cm_minima:

  temperatura minima a la intemperie a 50 cm

- temperatura_suelo_5cm_media:

  temperatura media del suelo a 5 cm de profundidad

- temperatura_suelo_10cm_media:

  temperatura media del suelo a 10 cm de profundidad

- temperatura_inte_5cm:

  temperatura a la intemperie a 5 cm

- temperatura_intemperie_150cm_minima:

  temperatura minima a la intemperie a 150 cm

- humedad_suelo:

  humedad del suelo

- precipitacion_pluviometrica:

  precipitacion registrada por el pluviometro

- granizo:

  registro de granizo

- nieve:

  registro de nieve

- heliofania_efectiva:

  horas de sol efectivas

- heliofania_relativa:

  heliofania relativa (proporcion de horas de sol sobre las posibles)

- tesion_vapor_media:

  tension de vapor media

- humedad_media:

  humedad relativa media

- humedad_media_8_14_20:

  humedad relativa media calculada con las observaciones de las 8, 14 y
  20 horas

- rocio_medio:

  temperatura media del punto de rocio

- duracion_follaje_mojado:

  duracion del follaje mojado

- velocidad_viento_200cm_media:

  velocidad media del viento a 200 cm

- direccion_viento_200cm:

  direccion del viento a 200 cm

- velocidad_viento_1000cm_media:

  velocidad media del viento a 1000 cm

- direccion_viento_1000cm:

  direccion del viento a 1000 cm

- velocidad_viento_maxima:

  velocidad maxima del viento

- presion_media:

  presion atmosferica media

- radiacion_global:

  radiacion solar global

- radiacion_neta:

  radiacion neta

- evaporacion_tanque:

  evaporacion medida en tanque

- evapotranspiracion_potencial:

  evapotranspiracion potencial

- profundidad_napa:

  profundidad de la napa freatica

- horas_frio:

  horas de frio acumuladas en el dia

- unidad_frio:

  unidades de frio acumuladas en el dia

## Source

<https://github.com/rse-r/intro-programacion/tree/main/datos>

Repositorio del curso: <https://github.com/rse-r/intro-programacion>
