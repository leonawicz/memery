.onLoad <- function(libname, pkgname){
  suppressMessages(extrafont::font_import(pattern = "impact", prompt = FALSE))
}
