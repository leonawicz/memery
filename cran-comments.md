## Update release
This is an update release submission. In this version I have:

* Added a demo Shiny app for the package. This app has its own package dependencies that are not otherwise required by this package. These packages have been added to the DESCRIPTION Imports field for demo app functionality:
    * shiny
    * shinycssloaders
    * shinyBS
    * colourpicker

* Added animated gif support as an OPTIONAL functionality. It is a small, niche functionality used by only one package function. Therefore I do not want to require users to install the `magick` package and the external ImageMagick software on their system just because this optional edge case exists. I have added the `magick` package to the DESCRIPTION Suggests field. If a user attempts to use this animated gif functionality without installing `magick` and ImageMagick, they will be gracefully notified at the console of these additional, optional installation requirements. There are no errors or unexpected behavior.

## Test environments
* local Windows 10 install, R 3.4.3
* ubuntu 14.04 (on travis-ci), R 3.4.3
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes

* This is an update release.

## Downstream dependencies
I have also run R CMD check on downstream dependencies of memery 
(https://github.com/leonawicz/memery/blob/master/revdep/checks.rds). 
All packages passed.
