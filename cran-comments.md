## Test environments
* local Windows 10 install, R 4.0.3
* ubuntu 16.04 (on travis-ci), R 4.0.3
* win-builder (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes

This is a resubmission for an archived package.

 CRAN-related fixes:

* Fixed remaining "additional issues" that ***don't show up on Win Builder*** but do on CRAN once published; this appeared to be due to unavailability of a graphics device, but it is no longer needed.
* Fixed additional issues raised by reviewer on prior resubmission: now using `requireNamespace()` instead of `installed.packages()`, fixed documentation where there were missing return value entries.
