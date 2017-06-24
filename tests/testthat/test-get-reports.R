context("Get reports")

with_mock_API({
    test_that("Get reports", {
        reps <- getReports()
        expect_length(reps, 3)
    })

    test_that("Error handling", {
        expect_error(getReports(limit=-1),
            "Internal Server Error")
    })
})
