test_that("devuelve una fila por estación con las columnas esperadas", {
  tabla <- tabla_resumen_temperatura(estaciones, ids = c("NH0472", "NH0910"))

  expect_s3_class(tabla, "data.frame")
  expect_equal(nrow(tabla), 2)
  expect_named(tabla, c("id", "temp_minima", "temp_maxima", "promedio", "desvio"))
  expect_setequal(tabla$id, c("NH0472", "NH0910"))
})

test_that("sin ids resume todas las estaciones", {
  tabla <- tabla_resumen_temperatura(estaciones)
  expect_equal(nrow(tabla), length(unique(estaciones$id)))
})

test_that("los valores del resumen son coherentes", {
  tabla <- tabla_resumen_temperatura(estaciones, ids = "NH0472")

  expect_lte(tabla$temp_minima, tabla$promedio)
  expect_gte(tabla$temp_maxima, tabla$promedio)
  expect_gt(tabla$desvio, 0)
  expect_type(tabla$promedio, "double")
})

test_that("con un id que no existe da error", {
  expect_error(
    tabla_resumen_temperatura(estaciones, ids = "NO_EXISTE"),
    "No se encontr"
  )
})
