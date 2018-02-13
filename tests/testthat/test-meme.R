context("meme")

suppressPackageStartupMessages(library(ggplot2))

x <- seq(0, 2*pi, length.out = 50)
panels <- rep(c("Plot A", "Plot B"), each = 50)
d <- data.frame(x = x, y = sin(x), grp = panels)
p <- ggplot(d, aes(x, y)) + geom_line(colour = "dodgerblue", size = 2) +
  geom_point(colour = "orange", size = 2) + facet_wrap(~grp) +
  labs(title = "A plot", subtitle = "Plot subtitle", caption = "Figure 1. A caption.")

web <- "http://www.memeaholic.me/wp-content/uploads/2013/04/philosoraptor1.png" # a png version
loc <- system.file("philosoraptor.jpg", package = "memery")
x <- "NULL"
out <- c("meme_test.png", "meme_test.jpg")
lab <- c("What to call my R package?", "Perhaps...")

test_that("meme runs as expected", {
  expect_error(meme("in", "lab", "out"), "`img` must be a jpg or png. Check file extension.")
  expect_error(meme("in.jpg", "lab", "out"), "Output must be a jpg or png. Check file extension.")
  expect_error(meme(local, c("lab1", "lab2"), "out.jpg", label_pos = text_position(1)),
               "`label_pos` list elements must be same length as `label`.")

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

  expect_is(meme(loc, lab[1], out[1], family = "mono", inset = p, inset_bg = list()), x)
  expect_is(meme(loc, lab[1], out[1], inset = p, inset_pos = inset_position("blq")), x)
  p2 <- ggplot(data.frame(x = rnorm(10000)), aes(x)) +
    geom_density(adjust = 2, size = 1) + cowplot::theme_nothing()
  pos <- list(w = 0.2, h = 0.2, x = 0.125, y = 0.125)
  expect_is(meme(loc, lab[1], out[1], family = "mono", inset = p2,
                 inset_bg = list(fill = "dodgerblue", col = "black"), inset_pos = pos), x)
  file.remove(out)
})

test_that("meme runs with added font family", {
  sysname <- tolower(Sys.info()[["sysname"]]) # Skip on Solaris. Skip on Linux if not TRAVIS.
  if(!sysname %in% c("windows", "mac"))#, "linux") || (sysname == "linux" && !identical(Sys.getenv("TRAVIS"), "true")))
    skip("Skipping test on current system.")

  fam <- "Arial"
  sysfonts::font_add(fam, "arial.ttf")
  expect_is(meme(loc, lab[1], out[1], family = fam), x)
  expect_is(meme(loc, lab[1], out[2], family = fam), x)
  file.remove(out)
})

test_that("meme_gif runs as expected", {
  pos <- list(w = rep(0.9, 2), h = rep(0.3, 2), x = rep(0.5, 2), y = c(0.9, 0.75))
  img <- "http://forgifs.com/gallery/d/228621-4/Cat-wiggles.gif"

  if("magick" %in% installed.packages()){
    s <- c(1.5, 0.75)
    f <- 1:2
    meme_gif(img, lab, "out.gif", size = s, label_pos = pos,
             inset = p, inset_bg = list(fill = "#00BFFF50"), mult = 0.5, fps = 20, frame = f)
    meme_gif(img, lab, "out.gif", size = s, label_pos = pos, width = 200,
             inset = p, inset_bg = list(fill = "#00BFFF50"), fps = 20, frame = f)
    meme_gif(img, lab, "out.gif", size = s, label_pos = pos, height = 200,
             inset = p, inset_bg = list(fill = "#00BFFF50"), fps = 20, frame = f)
    meme_gif(img, lab, "out.gif", size = s, label_pos = pos, width = 200, height = 200,
             inset = p, inset_bg = list(fill = "#00BFFF50"), fps = 20, frame = f)
    file.remove("out.gif")
  } else {
    msg <- "The `magick` package and the ImageMagick software must be installed to use `meme_gif`."
    expect_message(
      meme_gif(img, lab, "out.gif", size = c(1.5, 0.75), label_pos = pos,
               inset = p, inset_bg = list(fill = "#00BFFF50"), mult = 0.5, fps = 20), msg)
  }
})
