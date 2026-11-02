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

  validar_datos(datos, c("id", "temperatura_abrigo_150cm",
                         "temperatura_abrigo_150cm_maxima",
                         "temperatura_abrigo_150cm_minima"))
  validar_ids(ids, datos)

  sin_datos <- datos |>
    dplyr::filter(id %in% ids) |>
    dplyr::group_by(id) |>
    dplyr::filter(all(is.na(temperatura_abrigo_150cm))) |>
    dplyr::pull(id) |>
    unique()
  if (length(sin_datos) > 0) {
    cli::cli_warn(c(
      "Estas estaciones no tienen datos de temperatura: {.val {sin_datos}}.",
      "i" = "Sus valores en la tabla van a ser {.code NA} o {.code Inf}."
    ))
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
