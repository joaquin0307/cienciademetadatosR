test_that("descarga y lee los datos de una estacion", {
  skip_if_offline()
  skip_on_cran()

  destino <- tempfile(fileext = ".csv")
  datos <- suppressMessages(leer_datos("NH0910", destino = destino))

  expect_true(file.exists(destino))
  expect_s3_class(datos, "data.frame")
  expect_true("temperatura_abrigo_150cm" %in% names(datos))
  expect_equal(unique(datos$id), "NH0910")
  expect_gt(nrow(datos), 0)
})
