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

  validar_datos(datos, c("id", "fecha", "temperatura_abrigo_150cm"))
  validar_ids(ids, datos)
  validar_texto(titulo, "titulo")

  if (!is.numeric(datos$temperatura_abrigo_150cm)) {
    cli::cli_abort(c(
      "La columna {.field temperatura_abrigo_150cm} tiene que ser num\u00e9rica.",
      "x" = "Es de clase {.cls {class(datos$temperatura_abrigo_150cm)}}."
    ))
  }

  fechas <- tryCatch(suppressWarnings(as.Date(datos$fecha)), error = function(e) NA)
  if (all(is.na(fechas))) {
    cli::cli_abort(c(
      "No se pudo interpretar la columna {.field fecha} como fecha.",
      "i" = "Las fechas tienen que tener el formato {.val AAAA-MM-DD}, por ejemplo {.val 2015-03-21}."
    ))
  }

  n_estaciones <- length(unique(ids))
  if (!is.null(colores)) {
    if (!is.character(colores)) {
      cli::cli_abort(c(
        "{.arg colores} tiene que ser un vector de texto.",
        "i" = "Por ejemplo: {.code colores = c(\"steelblue\", \"firebrick\")}."
      ))
    }
    if (length(colores) < n_estaciones) {
      cli::cli_abort(c(
        "Faltan colores: hay {n_estaciones} estaci{?\u00f3n/ones} y pasaste {length(colores)} color{?es}.",
        "i" = "Pas\u00e1 un color por estaci\u00f3n, o dej\u00e1 {.code colores = NULL} para elegirlos al azar."
      ))
    }
    invalidos <- colores[!colores %in% grDevices::colors() & !grepl("^#[0-9A-Fa-f]{6}$", colores)]
    if (length(invalidos) > 0) {
      cli::cli_abort(c(
        "Estos colores no existen en R: {.val {invalidos}}.",
        "i" = "Pod\u00e9s ver los nombres v\u00e1lidos con {.fn colors}, o usar c\u00f3digos como {.val #1F77B4}."
      ))
    }
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
