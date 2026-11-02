#' Descargar datos de una estación meteorológica
#'
#' Descarga el archivo con los datos diarios de una estación desde el
#' repositorio del curso, lo guarda en `destino` y lo devuelve como data frame.
#'
#' @param id_estacion Texto con el identificador de la estación
#'   (por ejemplo `"NH0472"`). Las estaciones disponibles son NH0046,
#'   NH0098, NH0437, NH0472 y NH0910.
#' @param destino Ruta del archivo donde se guardan los datos descargados.
#'   La carpeta tiene que existir.
#'
#' @return Un data frame (tibble) con los datos diarios de la estación.
#' @export
#'
#' @examples
#' \donttest{
#' datos <- leer_datos("NH0472", destino = tempfile(fileext = ".csv"))
#' head(datos)
#' }
leer_datos <- function(id_estacion, destino) {
  disponibles <- c("NH0046", "NH0098", "NH0437", "NH0472", "NH0910")

  if (missing(id_estacion)) {
    cli::cli_abort(c(
      "Falta el argumento {.arg id_estacion}.",
      "i" = "Indic\u00e1 una estaci\u00f3n, por ejemplo {.code leer_datos(\"NH0472\", destino = \"NH0472.csv\")}."
    ))
  }
  if (missing(destino)) {
    cli::cli_abort(c(
      "Falta el argumento {.arg destino}.",
      "i" = "Indic\u00e1 d\u00f3nde guardar el archivo, por ejemplo {.code destino = \"NH0472.csv\"}."
    ))
  }

  validar_texto(id_estacion, "id_estacion")
  validar_texto(destino, "destino")

  id_estacion <- toupper(id_estacion)

  if (!id_estacion %in% disponibles) {
    cli::cli_abort(c(
      "No se encontr\u00f3 la estaci\u00f3n {.val {id_estacion}}.",
      "i" = "Las estaciones disponibles son: {.val {disponibles}}."
    ))
  }

  carpeta <- dirname(destino)
  if (!dir.exists(carpeta)) {
    cli::cli_abort(c(
      "La carpeta {.path {carpeta}} no existe.",
      "i" = "Cre\u00e1 la carpeta primero o eleg\u00ed otra ruta en {.arg destino}."
    ))
  }

  url_NH <- paste0(
    "https://raw.githubusercontent.com/rse-r/intro-programacion/main/datos/",
    id_estacion, ".csv"
  )

  tryCatch(
    utils::download.file(url = url_NH, destfile = destino, mode = "wb", quiet = TRUE),
    error = function(e) {
      cli::cli_abort(c(
        "No se pudieron descargar los datos de {.val {id_estacion}}.",
        "i" = "Revis\u00e1 tu conexi\u00f3n a internet e intent\u00e1 de nuevo."
      ), parent = e)
    }
  )

  cli::cli_inform(c("v" = "Datos de {.val {id_estacion}} guardados en {.path {destino}}."))
  readr::read_csv(destino, show_col_types = FALSE)
}
