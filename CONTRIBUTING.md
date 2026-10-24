# Contribuir a cienciademetadatosR

Este documento es una guía para proponer un cambio en
cienciademetadatosR.

## Requerimientos técnicos

Si querés contribuir al código de cienciademetadatosR necesitás instalar
las dependencias del paquete. Para instalarlas es útil usar
`devtools::install_deps()`.

## Arreglar errores de escritura

Podés corregir errores de escritura, ortografía o gramática en la
documentación directamente desde la interfaz web de GitHub, siempre y
cuando los cambios se hagan en el archivo fuente.

Esto generalmente significa que tenés que editar los [comentarios de
roxygen2](https://roxygen2.r-lib.org/articles/roxygen2.html) en un
archivo `.R`, no en un archivo `.Rd`. Podés encontrar el archivo `.R`
que genera el `.Rd` leyendo el comentario de la primera línea.

## Cambios más grandes

Si querés hacer un cambio mayor, es buena idea abrir primero un issue y
asegurarte de que alguien del equipo esté de acuerdo en lo que hace
falta. Si encontraste un error, creá un issue que lo ilustre con un
ejemplo mínimo ([reprex](https://www.tidyverse.org/help/#reprex)). Esto
también te ayuda a escribir un test, si es necesario.

## Proceso de Pull requests

- Hacé un fork del paquete y clonalo en tu computadora. Si nunca lo
  hiciste, te recomendamos usar
  `usethis::create_from_github("joaquin0307/cienciademetadatosR", fork = TRUE)`.
- Instalá todas las dependencias de desarrollo con
  `devtools::install_dev_deps()` y asegurate de que el paquete pase el
  chequeo R CMD ejecutando `devtools::check()`. Si el chequeo no pasa
  completamente, es buena idea pedir ayuda antes de continuar.
- Creá una nueva rama de Git para tu pull request (PR). Recomendamos
  usar `usethis::pr_init("breve descripción del cambio")`.
- Hacé tus cambios, creá un commit con git y luego creá el PR ejecutando
  `usethis::pr_push()` y siguiendo las indicaciones de tu navegador. El
  título del PR debería describir brevemente el cambio. El cuerpo del PR
  debe contener “Arreglo \#número-de-issue”.
- Para los cambios que ve el usuario, agregá una descripción al
  principio de `NEWS.md` (justo debajo del primer encabezado). Seguí el
  estilo descrito en <https://style.tidyverse.org/news.html>.

## Estilo de código

- El código nuevo debe seguir la [guía de estilo de
  tidyverse](https://style.tidyverse.org). Podés usar el paquete
  [styler](https://cran.r-project.org/package=styler) para aplicarlo,
  pero no cambies el estilo de código que no tenga nada que ver con tu
  PR.
- Usamos [roxygen2](https://cran.r-project.org/package=roxygen2), con
  [sintaxis
  Markdown](https://cran.r-project.org/web/packages/roxygen2/vignettes/rd-formatting.html),
  para la documentación.
- Usamos [testthat](https://cran.r-project.org/package=testthat) para
  los tests. Las contribuciones que incluyen tests son más fáciles de
  aceptar.

## Código de Conducta

Este proyecto se publica con un [Código de Conducta para
Contribuyentes](https://joaquin0307.github.io/cienciademetadatosR/CODE_OF_CONDUCT.md).
Al participar, aceptás cumplir sus términos.
