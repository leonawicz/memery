## Update release
This is an update release submission. In this version I have:

* Fixed a minor bug related to animated gif framerate options not being selectable in the demo Shiny app included in the package.
* Skipped an unnecessary unit test on Solaris systems that cannot pass the Solaris CRAN check without additional system font libraries available.

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
