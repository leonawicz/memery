#' The ca(R) Shiny promotional meme
#'
#' Recreate the ca(R) Shiny promotional meme using different plots, frame rate
#' or output size.
#'
#' This function offers limited control over customization; it is intended as a
#' canned example. For additional customization, use this function's source code
#' in an R script where you can easily alter other values.
#'
#' After writing the first layer of output to `file`, `file` is recursively read
#' and written again two more times in order to add all layers to the animated
#' gif, since the underlying `meme()` function does not accept vectorized inset
#' plots.
#'
#' The Shiny logo is by RStudio.
#'
#' @param file character, output filename.
#' @param p1 ggplot object for top half of (ca)R Shiny meme.
#' @param p2 ggplot object for bottom half of (ca)R Shiny meme.
#' @param fps integer, frames per second.
#' @param test_frame logical, keep only the first frame. Ideal for saving time
#' during testing.
#' @param mult numeric, factor by which to multiply the output meme dimensions.
#' Use conservatively.
#'
#' @return nothing is returned, but a file is saved to disk.
#' @export
#'
#' @examples
#' library(ggplot2)
#' file <- "memery-car-shiny.gif" # outfile
#' set.seed(1)
#' p1 <- ggplot(data.frame(x = rbeta(100000, 10, 3)), aes(x)) +
#'   geom_histogram(colour = "white", fill = "#88888880", size = 1, bins = 30)
#'
#' means <- (8:1)^3
#' sds <- 10*(8:1)
#' d <- data.frame(
#'   x = rep(factor(1:8), each = 100),
#'   y = unlist(purrr::map2(means, sds, ~rnorm(100, .x, .y) / 200))
#' )
#'
#' p2 <- ggplot(d, aes(x, y)) +
#'   geom_boxplot(colour = "white", fill = "#5495CF80", outlier.colour = NA) +
#'   geom_point(shape = 21, colour = "white", fill = "#5495CF80", size = 1,
#'              position = position_jitter(0.15)) +
#'   scale_x_discrete(expand = c(0, 0.02)) + scale_y_continuous(expand = c(0.02, 0)) +
#'   theme_void() +
#'   theme(plot.margin = unit(rep(5, 4), "mm"),
#'         panel.grid.major = element_line(colour = "#FFFFFF50", linetype = 2),
#'         panel.grid.minor = element_line(colour = "#FFFFFF50", linetype = 2))
#'
#' \dontrun{car_shiny(file, p1, p2, test_frame = TRUE)}
car_shiny <- function(file, p1 = NULL, p2 = NULL, fps = 10, test_frame = FALSE, mult = 1){
  logo <- "https://camo.githubusercontent.com/5b211a0a8995a521765e786af420066dae36cbce/68747470733a2f2f7777772e7273747564696f2e636f6d2f77702d636f6e74656e742f75706c6f6164732f323031342f30342f7368696e792e706e67" # nolint
  x <- tempfile()
  utils::download.file(logo, x, mode = "wb", quiet = TRUE)
  logo <- png::readPNG(x)
  file.remove(x)
  logo <- grid::rasterGrob(logo, interpolate = TRUE)
  logo <- ggplot2::qplot(geom = "blank") +
    ggplot2::annotation_custom(logo, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
    ggplot2::theme_void() + ggplot2::theme(panel.background = ggplot2::element_rect(colour = "transparent"))
  frame <- ifelse(test_frame, 1, 0)
  img <- "https://github.com/leonawicz/DataVisExamples/blob/master/packages/memery-car-shiny-bg.gif?raw=true"
  x <- tempfile(fileext = ".gif")
  utils::download.file(img, x, mode = "wb", quiet = TRUE)
  ipos <- list(w = 0.95, h = 0.45, x = 0.5, y = 0.75)
  ibg <- list(fill = "#FFFFFF50", col = "#888888")
  meme_gif(x, "", file = file, inset = p1, inset_pos = ipos, inset_bg = ibg,
           ggtheme = ggplot2::theme_void(), mult = mult, frame = frame, fps = fps)
  file.remove(x)
  img <- file
  ipos <- list(w = 0.95, h = 0.45, x = 0.5, y = 0.25)
  ibg <- list(fill = "#5495CF80", col = "white")
  meme_gif(img, "", file = file, inset = p2, inset_pos = ipos, inset_bg = ibg,
           ggtheme = NULL, frame = frame, fps = fps)

  pos <- list(w = rep(0.9, 3), h = rep(0.3, 3), x = c(0.5, 0.49, 0.915), y = c(0.97, 0.03, 0.03))
  ipos <- list(w = 0.15, h = 0.15, x = 0.075, y = 0.0725)
  ibg <- list(fill = NA, col = NA, r = grid::unit(0, "snpc"))
  txt <- c("When all you want is the same old plot", "When you wanna hit switches, use", "R Shiny")
  meme_gif(img, txt, file, size = 0.5 * mult * c(1.5, 1.275, 1.275),
       col = c("white", "white", "#5495CF"), shadow = c("black", "black", "white"),
       label_pos = pos, inset = logo, inset_pos = ipos, inset_bg = ibg, frame = frame, fps = fps)
  invisible()
}
