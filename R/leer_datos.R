#' Descargar datos de una estación meteorológica
#'
#' Descarga el archivo con los datos diarios de una estación desde el
#' repositorio del curso, lo guarda en `destino` y lo devuelve como data frame.
#'
#' @param id_estacion Texto con el identificador de la estación
#'   (por ejemplo `"NH0472"`).
#' @param destino Ruta del archivo donde se guardan los datos descargados.
#'
#' @return Un data frame (tibble) con los datos diarios de la estación.
#' @export
#'
#' @examples
#'
#' \donttest{
#' datos <- leer_datos("NH0472", destino = tempfile(fileext = ".csv"))
#' head(datos)
#'
#' }
#'
leer_datos <- function(id_estacion, destino) {
  #si el id estacion es un vector, o pasan un numero (x ejemplo), lo controlamos
  if (!is.character(id_estacion) || length(id_estacion) != 1) {
    cli::cli_abort(c(
      "{.arg id_estacion} debe ser un solo texto.",
      "x" = "Se recibio {.cls {class(id_estacion)}} de largo {length(id_estacion)}."
    ))
  }
  #controlamos la ruta
  if (!dir.exists(dirname(destino))) {
    cli::cli_abort("La carpeta {.path {dirname(destino)}} no existe.")
  }

  url_NH <- paste0(
    "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/",
    id_estacion, ".csv"
  )

  if (!id_estacion %in% c("NH0046", "NH0098", "NH0437", "NH0472", "NH0910")) {
    cli::cli_abort("No se encontr\u00f3 la estaci\u00f3n {id_estacion}.")
  }

  utils::download.file(url = url_NH, destfile = destino, mode = "wb", quiet = TRUE)
  readr::read_csv(destino, show_col_types = FALSE)
}
