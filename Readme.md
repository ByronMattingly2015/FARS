# COURSERA: [Building R Packages](https://www.coursera.org/learn/r-packages/)
[Week 4](https://www.coursera.org/learn/r-packages/home/week/4): Peer-graded Assignment   
Byron Mattingly   
GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007   

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ByronMattingly2015/FARS?branch=master&svg=true)](https://ci.appveyor.com/project/ByronMattingly2015/FARS)

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/ByronMattingly2015/FARS?branch=master&svg=true)](https://ci.appveyor.com/project/ByronMattingly2015/FARS)

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/yronMattingly2015/FARS?svg=true)]((https://ci.appveyor.com/api/projects/status/github/ByronMattingly2015/)

## Create an Example Package in R 

Package: fars
GitHub:  https://github.com/ByronMattingly2015/FARS

## Data Source

The functions will be using data from the US National Highway Traffic Safety 
Administration's [Fatality Analysis Reporting System](https://www.nhtsa.gov/research-data/fatality-analysis-reporting-system-fars),
which is a nationwide census providing the American public yearly data regarding
fatal injuries suffered in motor vehicle traffic crashes.

## Please note
* My understanding is that a mentor (when this course had one!) had posted earlier that AppVeyor would be equally accepted as Travis CI (which is no longer "free" for open source projects and now costs $64 / month for the "hobbyist" edition at the time this project was built!).
* While Travis is used for Continuous (CI) of Linux-based systems, AppVeyor is is used for CI of Windows-based systems and is still free to use for Open-source projects.
* Refer to "3.11 Continuous Integration" and "3.12 Cross Platform Development", pp. 230-240 in <em>Mastering Software Development in R (2017-08-15)</em> by Roger D. Peng, Sean Kross and Brooke Anderson for more on using Travis and AppVeyor.

## Review Criteria

For this assignment you'll submit a link to the [GitHub repository](https://github.com/ByronMattingly2015/FARS) which contains
your package. This assessment will ask reviewers the following questions:

* Does this package contain the correct [R file(s) under the R/ directory](https://github.com/ByronMattingly2015/FARS/tree/master/R)?   
* Does this package contain a 
[man/](https://github.com/ByronMattingly2015/FARS/tree/master/man) with a corresponding directory of documentation files?
* Does this package contain a 
[vignette/](https://github.com/ByronMattingly2015/FARS/blob/master/vignettes/fars.Rmd) 
which provides a meaningful description of the package and how it should be 
used?
* Does this package have at least one test included in the [tests/](https://github.com/ByronMattingly2015/FARS/tree/master/tests/testthat) directory?
* Does this package have a [NAMESPACE](https://github.com/ByronMattingly2015/FARS/blob/master/NAMESPACE) file?
* Does the README.md file for this directory have a <s>Travis badge</s>[AppVeyor badge](https://ci.appveyor.com/project/ByronMattingly2015/FARS)?
* Is the build of this package passing on <s>Travis badge</s>[AppVeyor badge](https://ci.appveyor.com/project/ByronMattingly2015/FARS)?
* Are the build logs for this package on <s>Travis badge</s>[AppVeyor badge](https://(https://ci.appveyor.com/project/ByronMattingly2015/FARS) free of any errors, warnings, or notes?

## Links:
* [8.3 Raw Data file](https://r-pkgs.org/data.html#sec-data-extdata) explains how to use inst/extdata.
* [Writing an R package from scratch](https://hilaryparker.com/2014/04/29/writing-an-r-package-from-scratch/)    
* [Github: roxygen2](https://github.com/klutometis/roxygen#roxygen2)   
* [Common `roxygen2` tags](https://bookdown.org/rdpeng/RProgDA/documentation.html#common-roxygen2-tags)
* [Text formatting reference sheet](https://cran.r-project.org/web/packages/roxygen2/vignettes/formatting.html)
* [Writing R Extensions](https://cran.r-project.org/doc/manuals/R-exts.html#Creating-R-packages)
* [Travis: Building R packages](https://docs.travis-ci.com/user/languages/r/)
* [Vignettes: long-form documentation](http://r-pkgs.had.co.nz/vignettes.html)
* [Package Development with devtools Cheat Sheet](https://www.rstudio.com/wp-content/uploads/2015/03/devtools-cheatsheet.pdf)
* [Customizing Package Build Options](https://support.rstudio.com/hc/en-us/articles/200486518-Customizing-Package-Build-Options)
* [Testing packages](http://r-pkgs.had.co.nz/tests.html)
