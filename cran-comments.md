## Patch release
This is a patch release submission. In this version I have:

* Skipped a `sysfonts::font_add` font import call and two subsequent unit tests on Solaris builds and on non-TRAVIS-CI Linux builds where the given font is not available on the system and pre-installation cannot be ensured.

This was the only error in the build results. Package functionality was not otherwise affected.

* Also removed `dplyr` package from DESCRIPTION Imports, no longer needed. This fixes a NOTE previously thrown on Mac builds where `dplyr` was used only in unit testing and vignette building. But it is now removed entirely, including from tests and vignette.

## Test environments
* local Windows 10 install, R 3.4.2
* ubuntu 14.04 (on travis-ci), R 3.4.2
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a patch release.

## Downstream dependencies
I have also run R CMD check on downstream dependencies of memery 
(https://github.com/leonawicz/memery/blob/master/revdep/checks.rds). 
All packages passed.
