#' Tabla resumen de temperaturas por estación
#'
#' Calcula, para cada estación, la temperatura mínima y máxima registradas,
#' y el promedio y el desvío estándar de la temperatura media.
#'
#' @param datos Data frame con datos meteorológicos diarios. Debe tener las
#'   columnas `id`, `temperatura_abrigo_150cm`,
#'   `temperatura_abrigo_150cm_maxima` y `temperatura_abrigo_150cm_minima`.
#'   Por ejemplo, [estaciones].
#' @param ids Vector con los identificadores de las estaciones a resumir.
#'   Por defecto, todas las estaciones de `datos`.
#'
#' @return Un data frame con una fila por estación y las columnas `id`,
#'   `temp_minima`, `temp_maxima`, `promedio` y `desvio`.
#' @export
#'
#' @examples
#' tabla_resumen_temperatura(estaciones, ids = "NH0472")
#' tabla_resumen_temperatura(estaciones, ids = c("NH0472", "NH0910"))
#' tabla_resumen_temperatura(estaciones)
tabla_resumen_temperatura <- function(datos, ids = unique(datos$id)) {

  #verificamos que datos sea realmente un conjunto de datos
  if (!is.data.frame(datos)) {
    cli::cli_abort(c(
      "{.arg datos} debe ser un data frame.",
      "x" = "Se recibio {.cls {class(datos)}}."
    ))
  }
  #chequeamos que el conjunto de datos tenga las columnas especificas
  # que necesitamos para aplicar la funcion
  columnas <- c("id", "temperatura_abrigo_150cm",
                "temperatura_abrigo_150cm_maxima", "temperatura_abrigo_150cm_minima")
  faltan_columnas <- setdiff(columnas, names(datos))
  if (length(faltan_columnas) > 0) {
    cli::cli_abort(c(
      "A {.arg datos} le faltan columnas necesarias.",
      "x" = "Falta(n): {.field {faltan_columnas}}."
    ))
  }
  if (length(ids) == 0) {
    cli::cli_abort("{.arg ids} tiene que tener al menos una estacion.")
  }

  faltantes <- setdiff(ids, datos$id)
  if (length(faltantes) > 0) {
    cli::cli_abort("No se encontraron estas estaciones en {.arg datos}: {faltantes}.")
  }

  datos |>
    dplyr::filter(id %in% ids) |>
    dplyr::group_by(id) |>
    dplyr::summarise(
      temp_minima = min(temperatura_abrigo_150cm_minima, na.rm = TRUE),
      temp_maxima = max(temperatura_abrigo_150cm_maxima, na.rm = TRUE),
      promedio    = mean(temperatura_abrigo_150cm, na.rm = TRUE),
      desvio      = stats::sd(temperatura_abrigo_150cm, na.rm = TRUE)
    )
}
