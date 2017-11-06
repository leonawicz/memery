#' Generate a meme
#'
#' Generate a meme with a background image, text label and optional inset graphic.
#'
#' @details
#' This function generates and saves a meme as a jpg or png file.
#'
#' \subsection{Fonts}{
#' Memes use the Impact font by default. This is a Windows font.
#' If using \code{memery} on Linux for example, you would have to first install the font if not already installed on the system.
#' If Impact or any other font family passed to \code{meme}, e.g. \code{family = "Consolas"}, is not installed on an operating system,
#' \code{meme} will ignore it and fall back on \code{family = "serif"} internally.
#' If unfamiliar, explore the documentation and examples available for the \code{showtext} and \code{sysfonts} packages, which \code{merery} leverages.
#' }
#'
#' \subsection{Text labels}{
#' List elements in \code{label_pos} must all be the same length and must match the length of \code{label}.
#' This is provided for generality but is most suited to length-2 cases; the use of meme title/subtitle or top/bottom text pairs.
#' Similarly, \code{size}, \code{family}, \code{col} and \code{shadow} may be vectorized.
#' For example, top and bottom text can have different font size and family and the font text and shadow can be different colors.
#' }
#'
#' \subsection{Inset graphic}{
#' The meme plot may optionally include an inset plot by passing a ggplot object to \code{inset}.
#' This makes the memes more fun for data analysts. See examples.
#'
#' The plotting region containing \code{inset} is a specific viewport in the \code{grid} layout.
#' \code{inset_bg} is a list of arguments that affect the background of this part of the meme plot.
#' They define a rectangle that by default is semi-transparent with rounded corners and no border color.
#' This can be changed via the list arguments \code{fill}, \code{col} and \code{r}.
#'
#' The inset plot \code{inset} is placed above this layer and also fills the region.
#' The default ggplot2 theme used my \code{meme}, \code{\link{memetheme}}, uses transparent ggplot plot and panel background fill and plot border color
#' that allow the background viewport rectangle and its rounded corners to show through.
#' The default theme also has no plot margins.
#' If you supply a different theme via \code{ggtheme}, you can provide different plot and panel background fill and plot border color as part of the theme.
#' For similar no-margin themes, if the plot background fill or border color are not fully transparent,
#' set the viewport rectangle corner radius to zero so that rounded corners do not show inside the panel background.
#' For opaque plot background fill this will not matter.
#' Of course, the plot and panel background fill should still be transparent or semi-transparent if occupying a large amount of the total meme plot area
#' or it will obscure the meme image itself. An alternative is to use \code{inset} as, for example,
#' a tiny thumbnail in the corner of the meme plot, in which case full opacity is not necessarily an issue.
#' If you do not want to override the theme of your plot and do not wish to pass a theme explicitly by \code{ggtheme}, you can set \code{ggtheme = NULL}
#' }
#'
#' \subsection{Dimensions and image processing}{
#' Specifying \code{width} and \code{height} is not required. By default, output file dimensions are taken from the input file, \code{img}.
#' However, these arguments can be used to override the default dimension matching. The aspect ratio is fixed so if you change the two
#' disproportionately, you will increasing the canvas, adding bars on two sides; it will not stretch the image.
#'
#' \code{mult} can be set less than one if relying on \code{img} dimension for meme plot width and height and \code{img} is large.
#' It is equivalent to scaling proportionately with \code{width} and \code{height} maintaining the original aspect ratio.
#' Whether or not \code{width} and/or \code{height} are provided, \code{mult} is always applied (defaults to \code{mult = 1}).
#'
#' Beyond this basic resizing to help control output file size, it is not the intent of \code{memery} to offer general image processing capabilities.
#' If adjustments to source images are desired, you should use a dedicated package for image processing.
#' \code{magick} is recommended.
#' }
#'
#' @param img path to image file, png or jpg.
#' @param label character, meme text. May be a vector, matched to \code{label_pos}.
#' @param file output file, png or jpg.
#' @param size label size. Actual size affected by image size (i.e., \code{cex}).
#' @param family character, defaults to \code{"Impact"}, the classic meme font. See details.
#' @param col label color.
#' @param shadow label shadow/outline color.
#' @param label_pos named list of position elements for the meme text \code{w}, \code{h}, \code{x} and \code{y}. Each element may be a vector. See details.
#' @param inset a ggplot object. This is an optional inset plot and may be excluded.
#' @param ggtheme optional ggplot2 theme. If ignored, the default \code{memery} ggplot2 theme is used.
#' @param inset_bg a list of background settings for the plotting region containing \code{inset}. See details.
#' @param inset_pos named list of position elements for the \code{inset} inset plot: \code{w}, \code{h}, \code{x} and \code{y}.
#' @param width numeric, width of overall meme plot in pixels. If missing, taken from \code{img} size.
#' @param height numeric, height of overall meme plot in pixels. If missing, taken from \code{img} size.
#' @param mult numeric, a multiplier. Used to adjust width and height. See details.
#'
#' @export
#'
#' @examples
#' \dontrun{
#' img <- system.file("philosoraptor.jpg", package = "memery")
#' meme(img, "My first memery meme!", "meme.png")
#' }
meme <- function(img, label, file, size = 1, family = "Impact", col = "white", shadow = "black",
                 label_pos = text_position(length(label)),
                 inset = NULL, ggtheme = memetheme(), inset_bg = inset_background(),
                 inset_pos = inset_position(), width, height, mult = 1){
  if(!family %in% sysfonts::font_families()) family <- "serif"
  n <- length(label)
  if(!all(sapply(label_pos, length) == n))
    stop("`label_pos` list elements must be same length as `label`.")
  ext <- utils::tail(strsplit(img, "\\.")[[1]], 1)
  ext2 <- utils::tail(strsplit(file, "\\.")[[1]], 1)
  .check_ext(ext, ext2)
  f <- if(ext %in% c("jpeg", "jpg")) jpeg::readJPEG else png::readPNG
  if(substr(img, 1, 4) == "http"){
    x <- tempfile()
    utils::download.file(img, x, mode = "wb", quiet = TRUE)
    img <- f(x)
    file.remove(x)
  } else {
    img <- f(img)
  }

  g0 <- grid::rasterGrob(img, interpolate = TRUE)
  rc <- dim(img)[1:2]
  if(!missing(inset) && !is.null(ggtheme)) inset <- inset + ggtheme
  if(missing(width)) width <- rc[2]
  if(missing(height)) height <- rc[1]
  width <- width*mult
  height <- height*mult
  base_size_multiplier <- 3.5
  if(missing(size)) size <- 1
  if(ext2 == "jpg") size <- (3 / 4) * size
  size <- size * base_size_multiplier
  if(n > 1){
    size <- rep(size, length.out = n)
    family <- rep(family, length.out = n)
    col <- rep(col, length.out = n)
    shadow <- rep(shadow, length.out = n)
  }

  p0 <- ggplot2::ggplot(data.frame(x = c(0, 1), y = c(0, 1)), ggplot2::aes_string("x", "y")) +
    ggplot2::annotation_custom(g0, xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf) +
    cowplot::theme_nothing()
  if(ext2 == "png") Cairo::CairoPNG(file, width = width, height = height)
  if(ext2 == "jpg") grDevices::jpeg(file, width = width, height = height, type = "cairo")
  showtext::showtext_begin()
  grid::grid.newpage()
  vp_back <- grid::viewport(width = 1, height = 1, x = 0.5, y = 0.5)
  if(!missing(inset))
    vp_plot <- grid::viewport(width = inset_pos$w, height = inset_pos$h, x = inset_pos$x, y = inset_pos$y)
  vp_text <- purrr::map(seq_along(label_pos$w),
                        ~grid::viewport(width = label_pos$w[.x], height = label_pos$h[.x],
                                        x = label_pos$x[.x], y = label_pos$y[.x]))
  print(p0, vp = vp_back)
  if(!missing(inset)){
    grid::pushViewport(vp_plot)
    if(is.null(inset_bg$fill)) inset_bg$fill <- inset_background()$fill
    if(is.null(inset_bg$col)) inset_bg$col <- inset_background()$col
    if(is.null(inset_bg$r)) inset_bg$r <- inset_background()$r
    grid::grid.roundrect(r = inset_bg$r, gp = grid::gpar(fill = inset_bg$fill, col = inset_bg$col))
    grid::popViewport()
    print(inset, vp = vp_plot)
  }
  for(i in seq_along(vp_text)){
    grid::pushViewport(vp_text[[i]])
    .shadow(label[i], gp = grid::gpar(cex = size[i]), fontfamily = family[i], col = col[i], shadow = shadow[i])
    grid::popViewport()
  }
  showtext::showtext_end()
  grDevices::dev.off()
  invisible()
}

.check_ext <- function(inext, outext){
  stop_ext <- "must be a jpg or png. Check file extension."
  if(!inext %in% c("jpeg", "jpg", "png")) stop(paste("`img`", stop_ext))
  if(!outext %in% c("jpg", "png")) stop(paste("Output", stop_ext))
}
