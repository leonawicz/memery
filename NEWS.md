# memery 0.3.0.9000

* Copied DESCRIPTION file Description field content to `memery` help documentation details.
* Updated readme.
* Updated vignette.

# memery 0.3.0 (Release date: 2017-11-09)

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
