#' Query Your Usersnaps
#'
#' @param ... query parameters to include. There's no documentation, but known
#' parameters are (1) includeapikey, which should always be `"false"`; (2)
#' offset; (3) limit; and (4) search, which by default is
#' `'[{"type":"state","id":"open"}]'`, the default in the Usersnap GUI. You
#' can also specify a "project" to query against a project other than your
#' default.
#' @return A list of report entries.
#' @export
#' @importFrom utils modifyList
getReports <- function (...) {
    query <- modifyList(list(
        includeapikey="false",
        offset=0,
        limit=10,
        search='[{"type":"state","id":"open"}]'
    ), list(...))
    return(usGET(usURL("reports", ...), query=query)$data)
}
