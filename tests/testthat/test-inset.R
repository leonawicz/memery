context("inset")

pos <- c("default", "tl", "tr", "br", "bl", "center")
bg <- c("default", "op", "sq", "opsq", "blank")

test_that("inset_position returns as expected", {
  expect_identical(inset_position(pos[1]), list(w = 0.975, h = 0.6, x = 0.5, y = 0.325))
  expect_identical(inset_position(pos[2]), list(w = 0.2, h = 0.2, x = 0.125, y = 0.875))
  expect_identical(inset_position(pos[3]), list(w = 0.2, h = 0.2, x = 0.875, y = 0.875))
  expect_identical(inset_position(pos[4]), list(w = 0.2, h = 0.2, x = 0.875, y = 0.125))
  expect_identical(inset_position(pos[5]), list(w = 0.2, h = 0.2, x = 0.125, y = 0.125))
  expect_identical(inset_position(pos[6]), list(w = 0.2, h = 0.2, x = 0.5, y = 0.5))
  expect_error(inset_position("a"), "Invalid inset position template.")
})

test_that("inset_background returns as expected", {
  default <- list(fill = "#FFFFFF50", col = NA, r = grid::unit(0.025, "snpc"))
  op <- list(fill = "#FFFFFF", col = NA, r = grid::unit(0.025, "snpc"))
  sq <- list(fill = "#FFFFFF50", col = NA, r = grid::unit(0, "snpc"))
  opsq <- list(fill = "#FFFFFF", col = NA, r = grid::unit(0, "snpc"))
  blank <- list(fill = NA, col = NA, r = grid::unit(0, "snpc"))

  purrr::walk2(bg, list(default, op, sq, opsq, blank), ~expect_identical(inset_background(.x), .y))
  expect_error(inset_background("a"), "Invalid inset background template.")
})

test_that("inset_templates returns as expected", {
  expect_identical(inset_templates("position"), pos)
  expect_identical(inset_templates("background"), bg)
})
