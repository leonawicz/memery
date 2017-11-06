#' Meme plot inset templates
#'
#' Templates for the position and background of a ggplot inset.
#'
#' \code{inset_position} and \code{inset_background} assist with some basic options for position and background of the optional ggplot inset graphic.
#' \code{inset_templates} can be used to view the available templates. See examples.
#' If a template is not available to suit your needs, provide your own argument list to \code{meme}.
#'
#' @param type character, name of template.
#' @name inset
#'
#' @return a list of arguments passed to either \code{inset_pos} or \code{inset_background} in \code{meme}.
#'
#' @examples
#' inset_templates("position")
#' inset_templates("background")
#' inset_position()
#' inset_background()
NULL

#' @export
#' @rdname inset
inset_position <- function(type = "default"){
  if(!type %in% inset_templates("position")) stop("Invalid inset position template.")
  switch(type,
         default = list(w = 0.95, h = 0.6, x = 0.5, y = 0.325)
  )
}

#' @export
#' @rdname inset
inset_background <- function(type = "default"){
  if(!type %in% inset_templates("background")) stop("Invalid inset background template.")
  switch(type,
         default = list(fill = "#FFFFFF50", col = NA, r = grid::unit(0.025, "snpc"))
  )
}

#' @export
#' @rdname inset
inset_templates <- function(type){
  switch(type,
         position = c("default", "topleft"),
         background = c("default")
  )
}

#' Default meme theme
#'
#' The default ggplot2 theme for meme plots.
#'
#' @param base_col the base color for all title text and axis lines and ticks.
#'
#' @return a ggplot2 theme.
#' @export
memetheme <- function(base_col = "white"){
  ggplot2::theme(
    panel.grid.major = ggplot2::element_line(size = 0.5, colour = "grey"),
    title = ggplot2::element_text(colour = base_col, hjust = 0),
    axis.text = ggplot2::element_text(colour = base_col),
    axis.ticks = ggplot2::element_line(colour = base_col),
    axis.line = ggplot2::element_line(size = 0.7, colour = base_col),
    axis.ticks.length = ggplot2::unit(0.35, "cm"), legend.position = "bottom",
    legend.justification = "right", legend.title = ggplot2::element_blank(),
    legend.text = ggplot2::element_text(size = 14), text = ggplot2::element_text(size = 18),
    plot.title = ggplot2::element_text(size = 20),
    panel.spacing.x = ggplot2::unit(0.25, "cm"),
    plot.margin = ggplot2::unit(c(0.25, 0.5, 0.25, 0.25), "cm"),
    strip.text = ggplot2::element_text(size = 14),
    panel.background = ggplot2::element_rect(fill = NA),
    plot.background = ggplot2::element_rect(fill = NA, colour = NA))
}
