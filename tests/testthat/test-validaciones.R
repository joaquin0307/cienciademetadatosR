# Tests de los controles de los argumentos (issue de revisión de pares)

# --- datos ------------------------------------------------------------------

test_that("datos NULL da un error claro", {
  expect_error(tabla_resumen_temperatura(NULL), "no puede ser")
  expect_error(grafico_temperatura_mensual(NULL), "no puede ser")
})

test_that("datos que no son data frame dan error", {
  expect_error(tabla_resumen_temperatura("estaciones"), "tiene que ser un data frame")
  expect_error(grafico_temperatura_mensual(1:10), "tiene que ser un data frame")
})

test_that("datos sin filas dan error", {
  vacio <- estaciones[0, ]
  expect_error(tabla_resumen_temperatura(vacio), "no tiene filas")
  expect_error(grafico_temperatura_mensual(vacio), "no tiene filas")
})

test_that("datos sin las columnas necesarias dan error", {
  sin_columna <- estaciones[, c("id", "fecha")]
  expect_error(tabla_resumen_temperatura(sin_columna), "faltan columnas")
  expect_error(grafico_temperatura_mensual(sin_columna), "faltan columnas")
})

# --- ids --------------------------------------------------------------------

test_that("ids vacío o que no es texto da error", {
  expect_error(tabla_resumen_temperatura(estaciones, ids = character(0)), "no puede estar vac")
  expect_error(tabla_resumen_temperatura(estaciones, ids = 472), "tiene que ser texto")
  expect_error(grafico_temperatura_mensual(estaciones, ids = NULL), "no puede estar vac")
})

test_that("el error de ids inexistentes nombra las estaciones que faltan", {
  expect_error(
    tabla_resumen_temperatura(estaciones, ids = c("NH0472", "NH9999")),
    "NH9999"
  )
})

# --- gráfico: título y colores ----------------------------------------------

test_that("titulo tiene que ser un solo texto", {
  expect_error(grafico_temperatura_mensual(estaciones, ids = "NH0472", titulo = 123),
               "un solo texto")
  expect_error(grafico_temperatura_mensual(estaciones, ids = "NH0472", titulo = c("a", "b")),
               "un solo texto")
})

test_that("colores tiene que ser texto, alcanzar y existir", {
  expect_error(grafico_temperatura_mensual(estaciones, ids = "NH0472", colores = 1),
               "vector de texto")
  expect_error(grafico_temperatura_mensual(estaciones, ids = c("NH0472", "NH0910"),
                                           colores = "red"),
               "Faltan colores")
  expect_error(grafico_temperatura_mensual(estaciones, ids = "NH0472", colores = "rojito"),
               "no existen")
})

test_that("acepta colores en formato hexadecimal", {
  grafico <- grafico_temperatura_mensual(estaciones, ids = "NH0472", colores = "#1F77B4")
  expect_s3_class(grafico, "ggplot")
})

test_that("la temperatura tiene que ser numérica y la fecha válida", {
  texto <- estaciones
  texto$temperatura_abrigo_150cm <- as.character(texto$temperatura_abrigo_150cm)
  expect_error(grafico_temperatura_mensual(texto, ids = "NH0472"), "num")

  malas_fechas <- estaciones
  malas_fechas$fecha <- "no es una fecha"
  expect_error(grafico_temperatura_mensual(malas_fechas, ids = "NH0472"), "fecha")
})

# --- tabla: estaciones sin datos --------------------------------------------

test_that("avisa si una estación no tiene datos de temperatura", {
  sin_temp <- estaciones[estaciones$id == "NH0472", ]
  sin_temp$temperatura_abrigo_150cm <- NA_real_
  expect_warning(tabla_resumen_temperatura(sin_temp), "no tienen datos")
})

# --- leer_datos ---------------------------------------------------------------

test_that("leer_datos controla sus argumentos", {
  expect_error(leer_datos(), "Falta el argumento")
  expect_error(leer_datos("NH0472"), "Falta el argumento")
  expect_error(leer_datos(472, destino = tempfile()), "un solo texto")
  expect_error(leer_datos(c("NH0472", "NH0910"), destino = tempfile()), "un solo texto")
  expect_error(leer_datos("NH9999", destino = tempfile()), "No se encontr")
  expect_error(leer_datos("NH0472", destino = file.path(tempdir(), "no_existe", "x.csv")),
               "no existe")
})

test_that("leer_datos acepta el id en minúscula", {
  skip_if_offline()
  skip_on_cran()
  datos <- suppressMessages(leer_datos("nh0910", destino = tempfile(fileext = ".csv")))
  expect_equal(unique(datos$id), "NH0910")
})
