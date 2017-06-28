#' Query Your Usersnaps
#'
#' @param state Include "open" or "closed" reports. Default is `NULL`, which is
#' queries both open and closed reports.
#' @param ... query parameters to include. There's no documentation, but known
#' parameters are (1) includeapikey, which should always be `"false"`; (2)
#' offset; (3) limit; and (4) search, which gets filled in with the "state"
#' query, if provided, like `'[{"type":"state","id":"open"}]'`. You
#' can also specify a "project" to query against a project other than your
#' default.
#' @return A list of report entries.
#' @export
#' @importFrom utils modifyList
#' @examples
#' \dontrun{
#' reps <- getReports(state="open")
#' }
getReports <- function (state=NULL, ...) {
    dots <- list(...)
    if (!is.null(state)) {
        ## NB: if there's already a "search" in ..., this will overwrite it
        dots$search <- paste0('[{"type":"state","id":"',
            match.arg(state, c("open", "closed")), '"}]')
    }
    query <- modifyList(list(
        includeapikey="false",
        offset=0,
        limit=10
    ), dots)
    return(usGET(usURL("reports", ...), query=query)$data)
}


# Report entity: usGET(usURL(file.path("reports", ticketnr)))$data; can optionally include "search" query (I guess for next/prev, which we don't care about here)
