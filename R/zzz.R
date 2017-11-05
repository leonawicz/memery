.onLoad <- function(libname, pkgname){
  tryCatch(sysfonts::font_add("Impact", "impact.ttf"), error = function(e) invisible())
}
