context("meme")

suppressPackageStartupMessages({
  library(dplyr)
  library(ggplot2)
})

d <- data_frame(x = seq(0, 2*pi, length.out = 100), y = sin(x))
d <- bind_rows(d, d) %>% mutate(group = rep(c("Cat A", "Cat B"), each = 100))
p <- ggplot(d, aes(x, y)) + geom_line(colour = "dodgerblue", size = 2) +
  geom_point(colour = "orange", size = 2) + facet_wrap(~group) +
  labs(title = "A plot", subtitle = "Plot subtitle", caption = "Figure 1. A caption.")

test_that("meme runs as expected", {
  web <- "http://www.memeaholic.me/wp-content/uploads/2013/04/philosoraptor1.png" # a png version
  loc <- system.file("philosoraptor.jpg", package = "memery")

  expect_error(meme("in", "lab", "out"), "`img` must be a jpg or png. Check file extension.")
  expect_error(meme("in.jpg", "lab", "out"), "Output must be a jpg or png. Check file extension.")
  expect_error(meme(local, c("lab1", "lab2"), "out.jpg", label_pos = text_position(1)),
               "`label_pos` list elements must be same length as `label`.")

  x <- "NULL"
  out <- c("meme_test.png", "meme_test.jpg")
  lab <- c("This is a test.", "This is a test with a longer text string.")
  expect_is(meme(loc, lab[1], out[1]), x)
  expect_is(meme(loc, lab, out[1]), x)
  expect_is(meme(loc, lab[1], out[2]), x)
  expect_is(meme(loc, lab, out[2]), x)
  expect_is(meme(web, lab[1], out[1]), x)
  expect_is(meme(web, lab, out[1]), x)
  expect_is(meme(web, lab[1], out[2]), x)
  expect_is(meme(web, lab, out[2]), x)

  expect_is(meme(loc, lab[1], out[1], width = 400, height = 300), x)
  expect_is(meme(loc, lab[1], out[2], width = 400, height = 300), x)

  fam <- "Arial"
  sysfonts::font_add(fam, "arial.ttf")
  expect_is(meme(loc, lab[1], out[1], family = fam), x)
  expect_is(meme(loc, lab[1], out[2], family = fam), x)

  expect_is(meme(loc, lab[1], out[1], family = "mono", inset = p, inset_bg = list()), x)
  file.remove(out)
})
