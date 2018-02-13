## Update release
This is an update release submission. In this version I have:

* Fixed incorrectly specified testthat unit test conditional skip that was causing build failure on multiple systems.

I do not have access to all operating systems for testing, but I was able to simulate the conditional test skip on TRAVIS-CI Linux and on Windows (systems where the unit test normally is not skipped).
Given this, the fix appears successful; errors should no longer occur on the affected operating systems during CRAN checks.

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
