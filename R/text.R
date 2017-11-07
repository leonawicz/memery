#' Default meme text position
#'
#' Convenience function for meme text position in a meme plot.
#'
#' This function takes an integer 1 or 2 and returns, respectively, top or symmetrical top and bottom meme text position arguments.
#' This function is used as the default for the \code{label_pos} argument in \code{meme}.
#' It is provided if you do not want to bother with specifying coordinates and exact placement does not matter.
#' It is not intended for placement of more than two meme text labels and any value other than 1 or 2 returns an error.
#'
#' @param n integer, number of meme text labels.
#'
#' @return a list of meme text label position arguments: \code{w} (width), \code{h} (height), and \code{x} and \code{y} coordinates.
#' @export
#'
#' @examples
#' text_position(1)
#' text_position(2)
text_position <- function(n){
  if(!n %in% c(1, 2)) stop("`n` must be 1 or 2.")
  x <- list(w = 0.9, h = 0.3, x = 0.5, y = 0.9)
  y <- list(w = 0.9, h = 0.3, x = 0.5, y = 0.1)
  switch(n, "1" = x, "2" = purrr::transpose(list(x, y)) %>% purrr::map(unlist))
}


# Adapted from stextGrob gridExtra v0.9.1 by Baptiste Auguie
# Does not appear to be available in current gridExtra.
# Minor adjustments made.
.shadowGrob <- function (label, fontfamily = "Impact", col = "white", shadow = "black",
                         r = 0.015, x = grid::unit(0.5, "npc"), y = grid::unit(0.5, "npc"),
                         just = "center", hjust = NULL, vjust = NULL, rot = 0, check.overlap = FALSE,
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
