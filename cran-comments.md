## Resubmission
This is a resubmission. In this version I have:

* Added single quotes around referenced package names in DESCRIPTION file description field.

Previous resubmission requirements met:

* Updated the DESCRIPTION to the requested formatting and style and clarified how this package differs from related packages.
* Removed `dontrun` wrappers from examples that do not individually take too long to execute.
   * `donttest` is still used for some examples of `meme` calls that represent simpler versions whose internal processing is effectively encapsulated by the most complex call example, which is tested. This is done in an attempt to keep example execution time to a minimum.

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
