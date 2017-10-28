#' memery: Internet memes for data analysts.
#'
#' The memery package is used for generating internet memes that may optionally include a superimposed inset plot.
#' It also offers the classic Impact font family with shadow/outline effect for the meme text label.
#'
#' @docType package
#' @name memery
NULL

# Adapted from stextGrob gridExtra v0.9.1 by Baptiste Auguie
# Does not appear to be available in current gridExtra.
# Minor adjustments made.
.shadowGrob <- function (label, fontfamily = "Impact", col = "white", shadow = "black",
                       r=0.015, x = unit(0.5, "npc"), y = unit(0.5, "npc"),
                       just = "centre", hjust = NULL, vjust = NULL, rot = 0, check.overlap = FALSE,
                       default.units = "npc", name = NULL, gp = grid::gpar(), vp = NULL){
  let <- grid::textGrob("a", gp = gp, vp = vp)
  wlet <- grid::grobWidth(let)
  hlet <- grid::grobHeight(let)
  tg <- grid::textGrob(label = label, x = x, y = y, gp = grid::gpar(col = col, fontfamily = fontfamily),
                       just = just, hjust = hjust, vjust = vjust, rot = rot,
                       check.overlap = check.overlap, default.units = default.units)
  tgl <- c(lapply(seq(0, 2*pi, length = 144), function(theta){
    grid::textGrob(label = label, x = x+cos(theta)*r*wlet,
             y = y + sin(theta)*r*hlet, gp = grid::gpar(col = shadow, fontfamily = fontfamily),
             just = just, hjust = hjust, vjust = vjust, rot = rot,
             check.overlap = check.overlap, default.units = default.units)}), list(tg)) # nolint
  grid::gTree(children = do.call(grid::gList, tgl), vp = vp, name = name, gp = gp)
}

.shadow <- function(...){
  g <- .shadowGrob(...)
  grid::grid.draw(g)
  invisible(g)
}

memetheme <- ggplot2::theme(
  panel.grid.major = ggplot2::element_line(size = 0.5, color = "grey"),
  plot.title = ggplot2::element_text(hjust = 0.5),
  axis.line = ggplot2::element_line(size = 0.7, color = "black"),
  axis.ticks.length = ggplot2::unit(0.35, "cm"), legend.position = "bottom",
  legend.justification = "right", legend.title = ggplot2::element_blank(),
  legend.text = ggplot2::element_text(size = 14), text = ggplot2::element_text(size = 18),
  panel.spacing.x = ggplot2::unit(0.25, "cm"),
  plot.margin = ggplot2::unit(c(0.5, 1, 0.5, 0.5), "cm"),
  strip.text = ggplot2::element_text(size = 14))

#' Generate a meme
#'
#' Generate a meme with a background image, text label and optional plot.
#'
#' This function generates a meme, returning the plot or saving it to disk. The plot may optionally include
#' an inset plot by passing a ggplot object to \code{g}. This makes the memes more fun for data analysts.
#'
#' @param img path to image file. May be \code{.png} or \code{.jpg}.
#' @param g a ggplot object. This is an optional inset plot and may be excluded.
#' @param label character, meme text.
#' @param size labele size.
#' @param fontfamily character, defaults to \code{"Impact"}, the classic meme font.
#' @param col label color.
#' @param shadow label shadow/outline color.
#' @param file character, output file. The meme plot is returned if \code{file} is missing.
#' @param width numeric, width of overall meme plot in pixels. If missing, taken from \code{img} size.
#' @param height numeric, height of overall meme plot in pixels. If missing, taken from \code{img} size.
#' @param mult numeric, a multiplier. Used to adjust width and height.
#' Typically set less than one when relying on \code{img} for meme plot width and height but \code{img} is large.
#' @param g_pos list of position elements for the \code{g} inset plot.
#' @param label_pos list of position elements for the meme text.
#' @param ggtheme optional ggplot2 theme. If ignored, the default \code{memery} ggplot2 theme is used.
#' @param panel_background color, overrides theme. Should be semi-transparent.
#' @param plot_background color, overrides theme. Should be semi-transparent.
#'
#' @return a plot. Alternatively saved to disk (nothing returned).
#' @export
#'
#' @examples
#' \dontrun{meme("image.png", ggObject, "My first memery meme!")}
meme <- function(img, g, label, size = 7, fontfamily = "Impact", col = "white", shadow = "black",
                 file, width, height, mult = 1,
                 g_pos = list(width = 0.9, height = 0.6, x = 0.5, y = 0.35),
                 label_pos = list(width = 0.9, height = 0.3, x = 0.5, y = 0.9),
                 ggtheme, panel_background = "#FFFFFF50", plot_background = "#FFFFFF50"){
  if(fontfamily == "Impact") extrafont::font_import(pattern = "impact", prompt = FALSE)
  ext <- tail(strsplit(img, "\\.")[[1]], 1)
  if(!ext %in% c("jpeg", "jpg", "png")) stop("`img` must be a jpg or png. Check file extension.")
  if(ext %in% c("jpeg", "jpg")) img <- jpeg::readJPEG(img)
  if(ext == "png") img <- png::readPNG(img)
  g0 <- grid::rasterGrob(img, interpolate = TRUE)
  rc <- dim(img)[1:2]
  if(missing(ggtheme)) ggtheme <- memetheme
  g <- g + ggtheme + ggplot2::theme(panel.background = element_rect(fill = panel_background),
                           plot.background = element_rect(fill = plot_background),
                           aspect.ratio = g_pos$height / g_pos$width)
  if(missing(width)) width <- rc[2]
  if(missing(height)) height <- rc[1]
  width <- width*mult
  height <- height*mult
  p0 <- ggplot2::ggplot(data.frame(x = c(0, 1), y = c(0, 1)), aes(x, y)) +
    ggplot2::annotation_custom(g0, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
    cowplot::theme_nothing()
  if(!missing(file)) Cairo::CairoPNG(file, height = height, width = width)
  grid::grid.newpage()
  vp_back <- grid::viewport(width = 1, height = 1, x = 0.5, y = 0.5)
  vp_plot <- grid::viewport(width = g_pos$width, height = g_pos$height, x = g_pos$x, y = g_pos$y)
  vp_text <- grid::viewport(width = label_pos$width, height = label_pos$height,
                            x = label_pos$x, y = label_pos$y)
  print(p0, vp = vp_back)
  print(g, vp = vp_plot)
  grid::pushViewport(vp_text)
  .shadow(label, gp = grid::gpar(cex = size), fontfamily = fontfamily, col = col, shadow = shadow)
  if(!missing(file)) dev.off()
  invisible()
}
