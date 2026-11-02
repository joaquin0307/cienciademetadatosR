#' Datos meteorológicos de estaciones del INTA
#'
#' Registros diarios de temperatura de 5 estaciones meteorológicas
#' (NH0046, NH0098, NH0437, NH0472 y NH0910) entre 2010 y 2017.
#' Los datos son del INTA (Instituto Nacional de Tecnología Agropecuaria).
#' Es un recorte de los datos originales,
#' pensado para usar en los ejemplos del paquete.
#'
#' @format Un data frame con 5 columnas:
#' \describe{
#'   \item{id}{Identificador de la estación.}
#'   \item{fecha}{Fecha de la medición.}
#'   \item{temperatura_abrigo_150cm}{Temperatura media del día, en °C.}
#'   \item{temperatura_abrigo_150cm_maxima}{Temperatura máxima del día, en °C.}
#'   \item{temperatura_abrigo_150cm_minima}{Temperatura mínima del día, en °C.}
#' }
#' @source INTA (Instituto Nacional de Tecnología Agropecuaria).
"estaciones"
