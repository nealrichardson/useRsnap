context("Get reports")

with_mock_API({
    test_that("Get reports", {
        reps <- getReports()
        expect_length(reps, 3)
    })

    test_that("Get reports by state", {
        active <- getReports(state="open")
        expect_identical(vapply(active, function (x) x$closed, logical(1)),
            c(FALSE, FALSE, FALSE))
        closed <- getReports(state="closed")
        expect_identical(vapply(closed, function (x) x$closed, logical(1)),
            c(TRUE, TRUE))
    })

    test_that("Error handling", {
        expect_error(getReports(state="Georgia"),
            "'arg' should be one of")
        expect_error(getReports(limit=-1),
            "Internal Server Error")
    })
})
