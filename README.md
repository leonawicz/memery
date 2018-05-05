
<!-- README.md is generated from README.Rmd. Please edit that file -->
memery <a hef="https://github.com/leonawicz/memery/blob/master/data-raw/memery.png?raw=true" _target="blank"><img src="https://github.com/leonawicz/memery/blob/master/inst/memery.png?raw=true" style="margin-bottom:5px;" width="120" align="right"></a>
==========================================================================================================================================================================================================================================================

[![CRAN status](http://www.r-pkg.org/badges/version/memery)](https://cran.r-project.org/package=memery) [![CRAN downloads](http://cranlogs.r-pkg.org/badges/grand-total/memery)](https://cran.r-project.org/package=memery) [![Rdoc](http://www.rdocumentation.org/badges/version/memery)](http://www.rdocumentation.org/packages/memery) [![Travis-CI Build Status](https://travis-ci.org/leonawicz/memery.svg?branch=master)](https://travis-ci.org/leonawicz/memery) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/leonawicz/memery?branch=master&svg=true)](https://ci.appveyor.com/project/leonawicz/memery) [![Coverage Status](https://img.shields.io/codecov/c/github/leonawicz/memery/master.svg)](https://codecov.io/github/leonawicz/memery?branch=master) [![gitter](https://img.shields.io/badge/GITTER-join%20chat-green.svg)](https://gitter.im/leonawicz/memery)

Make memorable plots with `memery`.
-----------------------------------

The `memery` package generates internet memes that optionally include a superimposed inset plot and other atypical features, combining the visual impact of an attention-grabbing meme with graphic results of data analysis.

The package differs from related packages that focus on imitating and reproducing standard memes. Some packages do this by interfacing with online meme generators whereas others achieve this natively. This package takes the latter approach. It does not interface with online meme generators or require any authentication with external websites. It reads images directly from local files or via URL and meme generation is done by the package.

While this is similar to the 'meme' package available on CRAN, it differs in that the focus is on allowing for non-standard meme layouts and hybrids of memes mixed with graphs. While this package can be used to make basic memes like an online meme generator would produce, it caters primarily to hybrid graph-meme plots where the meme presentation can be seen as a backdrop highlighting foreground graphs of data analysis results.

The package also provides support for an arbitrary number of meme text labels with arbitrary size, position and other attributes rather than restricting to the standard top and/or bottom text placement. This is useful for proper aesthetic interleaving of plots of data between meme image backgrounds and overlain text labels. The package offers a selection of templates for graph placement and appearance with respect to the underlying meme. Graph templates also permit additional template-specific customization. Animated gif support is provided but this is optional and functional only if the 'magick' package and ImageMagick software are installed.

![](docs/articles/meme4d.jpg)

Installation
------------

You can install memery from CRAN with:

``` r
install.packages("memery")
```

You can install the latest development version from github with:

``` r
# install.packages('devtools')
devtools::install_github("leonawicz/memery")
```

See the [vignette](https://leonawicz.github.io/memery/articles/memery.html) for an overview with usage examples.
