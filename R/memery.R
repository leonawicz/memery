#' memery: Internet memes for data analysts.
#'
#' The memery package generates internet memes that optionally include a superimposed inset plot and other atypical features,
#' combining the visual impact of an attention-grabbing meme with graphic results of data analysis.
#'
#' The package differs from related packages that focus on imitating and reproducing standard memes.
#' Some packages do this by interfacing with online meme generators whereas others achieve this natively.
#' This package takes the latter approach. It does not interface with online meme generators or require any authentication with external websites.
#' It reads images directly from local files or via URL and meme generation is done by the package.
#'
#' While this is similar to the 'meme' package available on CRAN, it differs in that the focus is on
#' allowing for non-standard meme layouts and hybrids of memes mixed with graphs.
#' While this package can be used to make basic memes like an online meme generator would produce,
#' it caters primarily to hybrid graph-meme plots where the meme presentation can be seen as a backdrop highlighting
#' foreground graphs of data analysis results.
#'
#' The package also provides support for an arbitrary number of meme text labels with arbitrary size, position and other attributes
#' rather than restricting to the standard top and/or bottom text placement.
#' This is useful for proper aesthetic interleaving of plots of data between meme image backgrounds and overlain text labels.
#' The package offers a selection of templates for graph placement and appearance with respect to the underlying meme.
#' Graph templates also permit additional template-specific customization.
#'
#' Animated gif support is provided but this is optional and functional only if the \code{magick} package is installed.
#'
#' @docType package
#' @name memery
NULL

#' @import showtext
#' @importFrom magrittr %>%
NULL

#' Run memery example app
#'
#' Launch the memery example app in your browser.
#'
#' This example app launches with animated gif support and relevant initial example gif if the magick package and ImageMagick software are installed on the user's system.
#' Otherwise, a simplified version of the app that does not provide gif support launches and starting images must be jpg or png.
#'
#' Due to how \code{meme_gif} works, gifs will not display in a hosted app, i.e., on \code{shinyapps.io}.
#' Memes based on gifs with many frames also take longer to render. By default, the app is set to render any animated gif input into a static meme using only the first frame in the animated gif.
#' If it takes one second to render a single frame, expect it to take about 43 seconds to render the 43-frame example animated gif that comes preloaded in the app.
#' If the user wishes to wait, the input control menu for output frames can be switched from first frame to all frames.
#'
#' While jpg and png memes will display in a hosted app like on \code{shinyapps.io}, the impact font will also not likely be available on a given server.
#' For all these reasons this packaged app is not hosted elsewhere. The best and intended experience is to use the app locally via the \code{memery} package.
#'
#' Setting \code{testplot = TRUE} will add one example ggplot object, \code{memery_testplot}, to the R session global environment for use in the app when the app launches.
#' This option exists if a user wishes to quickly view the example without first making their own ggplot objects.
#' This can be left as \code{FALSE} when ggplot objects already exist in the current R session.
#' In either case, any ggplot objects present in the global environment when you run the app propagate the selection menu in the app as available inset plots.
#' A message will be returned to the console if \code{memeApp} is called with the default \code{testplot = FALSE} and there are no ggplot objects in the global environment with which to propagate the in-app list.
#'
#' A meme can be saved from an app by right-clicking on the image in your web browser and selecting the save option just like with any other web images.
#'
#' @param testplot logical, an example inset plot that can be used to demo the app if there are no ggplot objects in the global environment. See details.
#'
#' @export
#'
#' @examples
#' \dontrun{memeApp(testplot = FALSE)}
memeApp <- function(testplot = FALSE){
  if(testplot) .memeApp_examplePlot()
  shiny::runApp(system.file("shiny", "memeApp", package = "memery"))
}

.no_magick <- "The `magick` package and the ImageMagick software must be installed to use `meme_gif`."

.check_for_magick <- function(){
  "magick" %in% utils::installed.packages()
}

.memeApp_examplePlot <- function(){
  if(!exists("memery_testplot", envir = .GlobalEnv)){
    x <- seq(0, 2*pi, length.out = 50)
    panels <- rep(c("A sine wave...", "MORE SINE WAVE!"), each = 50)
    d <- data.frame(x = x, y = sin(x), grp = panels)
    p <- ggplot2::ggplot(d, ggplot2::aes(x, y)) + ggplot2::geom_line(colour = "white", size = 2) +
      ggplot2::geom_point(colour = "orange", size = 1) + ggplot2::facet_wrap(~grp) +
      ggplot2::labs(title = "The wiggles", subtitle = "Plots for cats", caption = "Figure 1. Gimme sine waves.")
    assign("memery_testplot", p, envir = .GlobalEnv)
  }
}
