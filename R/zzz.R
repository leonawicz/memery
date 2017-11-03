.onLoad <- function(libname, pkgname){
  suppressMessages(extrafont::font_import(pattern = "impact", prompt = FALSE))
  if(.Platform$OS.type == "windows") extrafont::loadfonts("win", quiet = TRUE)
}
