#' Gráfico de la temperatura media mensual
#'
#' Calcula la temperatura media de cada mes para cada estación y la grafica
#' con una línea por estación.
#'
#' @param datos Data frame con datos meteorológicos diarios. Debe tener las
#'   columnas `id`, `fecha` y `temperatura_abrigo_150cm`. Por ejemplo,
#'   [estaciones].
#' @param ids Vector con los identificadores de las estaciones a graficar.
#'   Por defecto, todas las estaciones de `datos`.
#' @param colores Vector de colores, uno por estación. Si es `NULL`, se eligen
#'   colores al azar.
#' @param titulo Título del gráfico.
#'
#' @return Un gráfico de `ggplot2`.
#' @export
#'
#' @examples
#' grafico_temperatura_mensual(estaciones, ids = c("NH0472", "NH0910"))
#'
#' grafico_temperatura_mensual(
#'   estaciones,
#'   ids = c("NH0472", "NH0910"),
#'   colores = c("steelblue", "firebrick"),
#'   titulo = "Temperatura media mensual"
#' )
grafico_temperatura_mensual <- function(datos, ids = unique(datos$id),
                                        colores = NULL, titulo = "Temperatura") {

  faltantes <- setdiff(ids, datos$id)
  if (length(faltantes) > 0) {
    cli::cli_abort("No se encontraron estas estaciones en {.arg datos}: {faltantes}.")
  }

  datos <- datos |>
    dplyr::filter(id %in% ids) |>
    dplyr::mutate(mes = lubridate::month(as.Date(fecha))) |>
    dplyr::group_by(mes, id) |>
    dplyr::summarise(prom = mean(temperatura_abrigo_150cm, na.rm = TRUE),
                     .groups = "drop")

  if (is.null(colores)) {
    colores <- sample(grDevices::colors(), dplyr::n_distinct(datos$id))
  }

  ggplot2::ggplot(datos, ggplot2::aes(x = mes, y = prom, color = id)) +
    ggplot2::geom_line() +
    ggplot2::scale_color_manual(values = colores) +
    ggplot2::scale_x_continuous(breaks = 1:12) +
    ggplot2::labs(x = "mes", y = "promedio", title = titulo)
}
