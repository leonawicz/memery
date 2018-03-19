context("memery")

test_that("package loading (.onLoad)", {
  expect_is(library(memery), "character")
})
