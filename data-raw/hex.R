#install.packages("hexSticker")
library(hexSticker)
library(ggplot2)
pkg <- basename(getwd())
img <- "data-raw/hexsubplot.png"
out <- paste0(c("data-raw/", "inst/"), pkg, ".png")

hex_plot <- function(out, mult = 1){
  sticker(img, 1, 1, 0.75, 0.75, "", h_size = mult * 1.4, h_fill = "white",
          h_color = "purple", url = paste0("leonawicz.github.io/", pkg), u_color = "black", u_size = mult * 3,
          filename = out)
  # overwrite file for larger size
  ggsave(out, width = mult*43.9, height = mult*50.8, bg = "transparent", units = "mm")
}

hex_plot(out[1], 4) # multiplier for larger sticker size
hex_plot(out[2])
