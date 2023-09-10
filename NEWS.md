# memery 0.5.7

* Added required package alias in documentation.

# memery 0.5.6

* More fixes for CRAN submission after package was archived.

# memery 0.5.5

* More changes to address issues that only show up on CRAN but not on CRAN Win Builder.

# memery 0.5.4

* Set unit tests to not run on CRAN.

# memery 0.5.3

* Bug fixes and improvements to examples and tests.

# memery 0.5.2

* Made `meme_gif` faster.

# memery 0.5.1

* Added `bg` pass through to graphics devices for edge case where meme background image has transparency.

# memery 0.5.0

* Added package hex logo.
* Added the `car_shiny` function for recreating the (ca)R Shiny promotional anaylst meme animated gif. Given that it is a gif, `magick` and ImageMagick are required for this function to work.
* Fixed formatting issues in some of the documentation.
* Switched some help doc examples to `dontrun` to avoid generating large images increasing package size.
* Updated unit tests.
* Added `lintr` to Suggests field in DESCRIPTION per CRAN maintainer request regarding `testthat` unit tests.

# memery 0.4.2

* Fixed incorrectly specified `testthat` unit test that was causing build failure on some systems.

# memery 0.4.1

* Minor fix to framerate frame selection options for animated gifs in packaged Shiny demo app.
* Minor updates to documentation.

# memery 0.4.0

* Update example Shiny app to account for presence/absence of `magick` package and launch an appropriately configured app in the browser (gif/no gif support and related options).
* Example app test plot now only generates when app is launched in an R session where there are no ggplot objects in the global environment created by the user. If there are, then the test plot is not made. The test plot is also now only generated within the server environment and not added to the global environment.
* Added app and animated gif content to introduction vignette.
* Updated functions, examples and documentation.

# memery 0.3.1.9000

* Added `magick` to DESCRIPTION file Suggests field. The package is not required unless you are trying to read a gif image and save a gif meme using `meme_gif`. I consider this a minor use case so I have given memes based around gifs a unique function that wraps around `meme` rather than adding the gif-specific functionality directly to `meme`. If using `meme_gif`, you will need to install `magick` if not already installed. `magick` depends on the ImageMagick software so you will also have to install this dependency on your system. Aside from `meme_gif`, there is no need for ImageMagick.
* `meme_gif` accepts a frames per second argument, `fps`, and a frame number argument, `frame`.
* Added example Shiny app, launched via `memeApp`.
* Updated unit tests, documentation and vignette.

# memery 0.3.1

* Updated unit tests. A couple tests requiring installation of other font families are run on Windows and Mac as well as on Linux via Travis-CI where pre-installation of fonts can be ensured. Otherwise these tests are skipped (Other Linux environments as well as Solaris).
* `dplyr` packaged removed since it is no longer used (at this time) in examples and tests. This was leading to a `NOTE` on Mac builds.

# memery 0.3.0.9000

* Copied DESCRIPTION file Description field content to `memery` help documentation details.
* Updated readme.
* Updated vignette.

# memery 0.3.0

* Breaking changes: updated some arguments for `meme` and `text_position`.
* Attempts to load Impact font on package load or to use any fonts with `meme` when not installed on the system now fail gracefully, falling back on `serif`.
* `showtext`, `showtextdb` and `sysfonts` are now fully loaded ahead of `memery`.
* Font sizing adjustments have been made to attempt to maintain as consistent as possible a text display on jpg vs. png outputs. Better anti-aliasing may be achieved using png, particularly regarding the text, though they will be fairly similar.
* Added introduction vignette content.
* Added templates to `inset_background` and `inset_position` helpers.
* Added `size` and `margin` arguments to `inset_position` for additional user control of inset templates.
* Added resource image file for examples and testing.
* Added unit tests.
* Minor bug fixes.
* Update documentation.

# memery 0.2.0

* Breaking changes: updated several `meme` arguments.
* Text size, font family, color and shadow color may now be vectors like `label`.
* Further improved viewport behavior and inset plot integration along with integration of semi-transparent rounded-corner background box for option plot region.
    * The new box can be adjusted in terms of background and border color and corner radius via `inset_bg` in `meme`.
    * Updated `memetheme`.
* Added convenience functions that provide the default settings for `meme` label positioning and inset plot positioning and background style.
* Minor bug fixes.
* Update documentation.

# memery 0.1.6

* Vectorized `label` and `label_pos` arguments for `meme` text.
* Improved viewport behavior.
* Update documentation.

# memery 0.1.5

* Refactored `meme` code, add/remove arguments, add error checking.
* Updated documentation.

# memery 0.1.0

* Added `meme` function.
* Added documentation.
* Updated readme.

# memery 0.0.0.9000

* Initialized package scaffolding.
