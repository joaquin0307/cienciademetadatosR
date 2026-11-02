# Controles internos que usan las funciones del paquete.
# No se exportan: son solo para uso interno.

#' Revisar que `datos` sea un data frame válido
#'
#' @param datos Objeto que pasó la persona.
#' @param columnas Columnas que tiene que tener `datos`.
#' @param call Entorno de la función que llamó, para que el error
#'   muestre el nombre de esa función.
#' @noRd
validar_datos <- function(datos, columnas, call = rlang::caller_env()) {
  if (is.null(datos)) {
    cli::cli_abort(c(
      "{.arg datos} no puede ser {.code NULL}.",
      "i" = "Pas\u00e1 un data frame, por ejemplo {.code estaciones}."
    ), call = call)
  }

  if (!is.data.frame(datos)) {
    cli::cli_abort(c(
      "{.arg datos} tiene que ser un data frame.",
      "x" = "Pasaste un objeto de clase {.cls {class(datos)}}.",
      "i" = "Pod\u00e9s usar el dataset {.code estaciones} o el resultado de {.fn leer_datos}."
    ), call = call)
  }

  if (nrow(datos) == 0) {
    cli::cli_abort(c(
      "{.arg datos} no tiene filas.",
      "i" = "Revis\u00e1 que los datos se hayan le\u00eddo correctamente."
    ), call = call)
  }

  faltan <- setdiff(columnas, names(datos))
  if (length(faltan) > 0) {
    cli::cli_abort(c(
      "A {.arg datos} le faltan columnas necesarias.",
      "x" = "No se encontr\u00f3: {.field {faltan}}.",
      "i" = "Tiene que tener: {.field {columnas}}."
    ), call = call)
  }

  invisible(TRUE)
}

#' Revisar que `ids` sea válido y que existan en `datos`
#' @noRd
validar_ids <- function(ids, datos, call = rlang::caller_env()) {
  if (is.null(ids) || length(ids) == 0) {
    cli::cli_abort(c(
      "{.arg ids} no puede estar vac\u00edo.",
      "i" = "Indic\u00e1 al menos una estaci\u00f3n, por ejemplo {.val NH0472}."
    ), call = call)
  }

  if (!is.character(ids)) {
    cli::cli_abort(c(
      "{.arg ids} tiene que ser texto.",
      "x" = "Pasaste un objeto de clase {.cls {class(ids)}}.",
      "i" = "Escrib\u00ed los ids entre comillas, por ejemplo {.code ids = \"NH0472\"}."
    ), call = call)
  }

  faltantes <- setdiff(ids, datos$id)
  if (length(faltantes) > 0) {
    cli::cli_abort(c(
      "No se encontraron estas estaciones en {.arg datos}: {.val {faltantes}}.",
      "i" = "Las estaciones disponibles son: {.val {unique(datos$id)}}."
    ), call = call)
  }

  invisible(TRUE)
}

#' Revisar que un argumento sea un solo texto
#' @noRd
validar_texto <- function(x, nombre, call = rlang::caller_env()) {
  if (is.null(x) || !is.character(x) || length(x) != 1 || is.na(x)) {
    cli::cli_abort(c(
      "{.arg {nombre}} tiene que ser un solo texto.",
      "x" = "Pasaste un objeto de clase {.cls {class(x)}} y largo {length(x)}.",
      "i" = "Por ejemplo: {.code {nombre} = \"texto\"}."
    ), call = call)
  }
  invisible(TRUE)
}
