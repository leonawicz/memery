
<!-- README.md is generated from README.Rmd. Please edit that file -->

# memery <img src="man/figures/logo.png" style="margin-left:10px;margin-bottom:5px;" width="120" align="right">

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/)
[![R-CMD-check](https://github.com/leonawicz/memery/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/leonawicz/memery/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/leonawicz/memery/graph/badge.svg)](https://app.codecov.io/gh/leonawicz/memery)
[![CRAN
status](https://www.r-pkg.org/badges/version/memery)](https://CRAN.R-project.org/package=memery)
[![CRAN
downloads](https://cranlogs.r-pkg.org/badges/grand-total/memery)](https://cran.r-project.org/package=memery)
[![Github
Stars](https://img.shields.io/github/stars/leonawicz/memery.svg?style=social&label=Github)](https://github.com/leonawicz/memery)
<!-- badges: end -->

## Make memorable plots with `memery`.

The `memery` package generates internet memes that optionally include a
superimposed inset plot and other atypical features, combining the
visual impact of an attention-grabbing meme with graphic results of data
analysis.

The package differs from related packages that focus on imitating and
reproducing standard memes. Some packages do this by interfacing with
online meme generators whereas others achieve this natively. This
package takes the latter approach. It does not interface with online
meme generators or require any authentication with external websites. It
reads images directly from local files or via URL and meme generation is
done by the package.

While this is similar to the `meme` package available on CRAN, it
differs in that the focus is on allowing for non-standard meme layouts
and hybrids of memes mixed with graphs. While this package can be used
to make basic memes like an online meme generator would produce, it
caters primarily to hybrid graph-meme plots where the meme presentation
can be seen as a backdrop highlighting foreground graphs of data
analysis results.

The package also provides support for an arbitrary number of meme text
labels with arbitrary size, position and other attributes rather than
restricting to the standard top and/or bottom text placement. This is
useful for proper aesthetic interleaving of plots of data between meme
image backgrounds and overlain text labels. The package offers a
selection of templates for graph placement and appearance with respect
to the underlying meme. Graph templates also permit additional
template-specific customization. Animated gif support is provided but
this is optional and functional only if the `magick` package is
installed.

![](https://leonawicz.github.io/memery/articles/meme4d.jpg)

## Installation

Install the CRAN release of `memery` with

``` r
install.packages("memery")
```

Install the development version from GitHub with

``` r
# install.packages("remotes")
remotes::install_github("leonawicz/memery")
```

See the
[vignette](https://leonawicz.github.io/memery/articles/memery.html) for
an overview with usage examples.

## Citation

Matthew Leonawicz (2024). memery: Internet Memes for Data Analysts. R
package version 0.6.0. <https://CRAN.R-project.org/package=memery>

## Contribute

Contributions are welcome. Contribute through GitHub via pull request.
Please create an issue first if it is regarding any substantive feature
add or change.

------------------------------------------------------------------------

Please note that the `memery` project is released with a [Contributor
Code of
Conduct](https://github.com/leonawicz/memery/blob/master/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.
