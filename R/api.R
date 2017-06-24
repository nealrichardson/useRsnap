apiRoot <- "https://ec2.usersnap.com/angular/apikeys"

usURL <- function (segment, project=getOption("usersnap.project"), ...) {
    file.path(apiRoot, project, segment)
}

#' @importFrom httr GET
usAPI <- function (verb, url, config=list(), ...) {
    FUN <- get(verb, envir=asNamespace("httr"))
    x <- FUN(url, ..., config=c(usConfig(), config))
    return(handleUSResponse(x))
}

#' @importFrom httr http_status content
handleUSResponse <- function (resp) {
    if (resp$status_code >= 400L)  {
        msg <- http_status(resp)$message
        ## The API tends not to respond with anything else useful, so there's
        ## nothing to add to that message
        stop(msg, call.=FALSE)
    } else {
        return(content(resp))
    }
}

usGET <- function (url, ...) {
    usAPI("GET", url, ...)
}

#' @importFrom httr config
usConfig <- function () {
    return(config(cookie=getOption("usersnap.cookie")))
}
