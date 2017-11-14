#' @rdname meme
#' @export
meme_gif <- function(img, label, file, size = 1, family = "Impact", col = "white", shadow = "black",
                     label_pos = text_position(length(label)),
                     inset = NULL, ggtheme = memetheme(), inset_bg = inset_background(),
                     inset_pos = inset_position(), width, height, mult = 1, fps = 10){
  if(!"magick" %in% utils::installed.packages()){
    return(message("The `magick` package and the ImageMagick software must be installed to use `meme_gif`."))
  }
  is_gif <- utils::tail(strsplit(img, "\\.")[[1]], 1) == "gif"
  if(!is_gif) stop("`img` is not a gif. Use `meme` instead of `meme_gif`.")
  x <- magick::image_read(img)
  n <- length(x)
  tmpfiles <- file.path(tempdir(), paste0("gif_frame_", gsub(" ", "0", format(1:n, width = 3)), ".png"))
  purrr::walk2(1:n, tmpfiles, ~magick::image_write(magick::image_convert(x[.x], "png"), .y))
  cat("Merging meme with", n, "gif frames")
  no_width <- missing(width) # nolint
  no_height <- missing(height) # nolint
  purrr::walk(tmpfiles, ~({
    img0 <- file0 <- .x
    cat(".")
    if(no_width & no_height){
      meme(img0, label, file0, size, family, col, shadow, label_pos,
           inset, ggtheme, inset_bg, inset_pos, mult = mult)
    } else if(no_width){
      meme(img0, label, file0, size, family, col, shadow, label_pos,
           inset, ggtheme, inset_bg, inset_pos, height = height, mult = mult)
    } else if(no_height){
      meme(img0, label, file0, size, family, col, shadow, label_pos,
           inset, ggtheme, inset_bg, inset_pos, width = width, mult = mult)
    } else {
      meme(img0, label, file0, size, family, col, shadow, label_pos,
           inset, ggtheme, inset_bg, inset_pos, width = width, height = height, mult = mult)
    }
  })
  )
  cat("\nSaving meme...")
  frames <- magick::image_read(tmpfiles)
  file.remove(tmpfiles)
  x <- magick::image_animate(frames, fps = fps)
  magick::image_write(x, file)
  cat("\nDone.\n")
  invisible()
}
