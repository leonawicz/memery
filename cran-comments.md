## Resubmission
This is a resubmission. In this version I have:

* Updated the DESCRIPTION to the requested formatting and style and clarified how this package differs from related packages.
* Removed `dontrun` wrappers from examples that do not take too long to execute.
   * Also added more thorough examples with comments for the main package function, `meme`.

## Test environments
* local Windows 10 install, R 3.4.2
* ubuntu 14.04 (on travis-ci), R 3.4.2
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.

## Downstream dependencies
I have also run R CMD check on downstream dependencies of memery 
(https://github.com/leonawicz/memery/blob/master/revdep/checks.rds). 
All packages passed.
