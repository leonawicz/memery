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
#' This example app launches with animated gif support and relevant initial example gif if the magick package is installed.
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
#' All ggplot objects that exist in the global environment when the app is launched propagate a selection menu in app for use as inset plots to overlay meme image backgrounds.
#' If there are no ggplot objects in the global environment, one named \code{memery_testplot} will be created within the app environment and will appear in the selection menu instead.
#'
#' A meme can be saved from an app by right-clicking on the image in your web browser and selecting the save option just like with any other web images.
#'
#' @export
#'
#' @examples
#' \dontrun{memeApp()}
memeApp <- function(){
  shiny::runApp(system.file("shiny", "memeApp", package = "memery"))
}

.no_magick <- "The `magick` package must be installed to use `meme_gif`."

.check_for_magick <- function(){
  "magick" %in% utils::installed.packages()
}
