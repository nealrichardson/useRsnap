# useRsnap: An R Client for the 'Usersnap' API

[![Build Status](https://travis-ci.org/nealrichardson/useRsnap.png?branch=master)](https://travis-ci.org/nealrichardson/useRsnap)  [![codecov](https://codecov.io/gh/nealrichardson/useRsnap/branch/master/graph/badge.svg)](https://codecov.io/gh/nealrichardson/useRsnap)
[![Build status](https://ci.appveyor.com/api/projects/status/xjj5ic9e3tmr6s1b/branch/master?svg=true)](https://ci.appveyor.com/project/nealrichardson/usersnap/branch/master)
[![cran](https://www.r-pkg.org/badges/version-last-release/useRsnap)](https://cran.r-project.org/package=useRsnap)

[Usersnap](http://usersnap.com/) is a web application error reporting tool. This package
provides an R interface to its API, allowing you to query it and work with
its responses.

A disclaimer: Usersnap says that they "currently do not offer API access." There is no API documentation, no guarantees of API stability, and no acceptable use guidelines. This package is, shall we say, inspired by how their web application uses their unpublished API. It works but lacks some of the niceties of a client for an officially published API.

## Installing

<!-- If you're putting `useRsnap` on CRAN, it can be installed with

    install.packages("useRsnap") -->

The pre-release version of the package can be pulled from GitHub using the [devtools](https://github.com/hadley/devtools) package:

    # install.packages("devtools")
    devtools::install_github("nealrichardson/useRsnap")

## Getting started

To access the Usersnap API, you'll need to get an authentication cookie, and then you'll need to provide it as an "option". You may also set your default "project" name for convenience.

Because this is not a published API, there's not a nice way to get an API access token for reuse. The current solution is to log into Usersnap in your web browser, then open the inspector and go to the network tab. Look for requests made at `ec2.usersnap.com`--if you don't see any, select a project, browse somewhere in your Usersnap page, or refresh so that you can collect some network requests. Once you've found one, look at the request details, and find the "Request Headers" section. One of the fields there will be "Cookie", and it will probably have a lot of stuff in it, values separated by semicolon. Look for the one that starts with `bugrep=`: that's the one you want. Copy that.

Set these in your current session with

    options(usersnap.cookie="bugrep=SOMELONGHASH", usersnap.project="your-project-name")

or put that in your `.Rprofile` for use in every session.

Grabbing the authentication cookie this way has other drawbacks aside from the inconvenience. It appears that cookies are valid for 30 days, so you may need to re-authenticate and update your option/.Rprofile accordingly.

### Endpoints supported

* `getReports`: the query that powers the list view of reports within a project.

## For developers

The repository includes a Makefile to facilitate some common tasks.

### Running tests

`$ make test`. Requires the [httptest](https://github.com/nealrichardson/httptest) package. You can also specify a specific test file or files to run by adding a "file=" argument, like `$ make test file=api`. `test_package` will do a regular-expression pattern match within the file names. See its documentation in the [testthat](https://github.com/hadley/testthat) package.

### Updating documentation

`$ make doc`. Requires the [roxygen2](https://github.com/klutometis/roxygen) package.
