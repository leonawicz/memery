library(shiny)
library(shinythemes)
library(shinycssloaders)
library(shinyBS)
library(colourpicker)
library(memery)
library(ggplot2)

if(!exists("sineplot", envir = .GlobalEnv)){
  x <- seq(0, 2*pi, length.out = 50)
  panels <- rep(c("A sine wave...", "MORE SINE WAVE!"), each = 50)
  d <- data.frame(x = x, y = sin(x), grp = panels)
  sineplot <- ggplot(d, aes(x, y)) + geom_line(colour = "white", size = 2) +
    geom_point(colour = "orange", size = 1) + facet_wrap(~grp) +
    labs(title = "The wiggles", subtitle = "Plots for cats", caption = "Figure 1. Gimme sine waves.")
  assign("sineplot", sineplot, envir = .GlobalEnv)
}

txt <- c("R plots for cats", "Sine wave sine wave sine wave sine wave")
def_img <- "http://forgifs.com/gallery/d/228621-4/Cat-wiggles.gif"
def_fps <- 20
pos_opts <- inset_templates("position")
names(pos_opts) <- c("Default", paste(
  c("Top left", "Top right", "Bottom right", "Bottom left"), rep(c("thumbnail", "quadrant"), each = 4)),
  "Center thumbnail")

ui <- fluidPage(theme = shinytheme("slate"), title = "Memery package",
  fluidRow(
   column(4, h3("Make memorable plots with memery")),
   column(4, div(
     textInput("image_url", NULL, def_img, placeholder = paste("Example:", def_img), width = "100%"),
     style = "padding-top:20px;")),
   column(4, div(
     actionButton("go_btn", "Generate meme", class = "btn-info", width = "100%"),
     style = "padding-top:20px;"))
  ),
  fluidRow(
    column(4,
      fluidRow(
        column(6,
          wellPanel(
            textInput("l1", "Primary text", txt[1], placeholder = txt[1], width = "100%"),
            numericInput("size1", "Size", 1, 0.1, 10, 0.1, width = "100%"),
            colourInput("l1_col", "Color", "white", allowTransparent = TRUE),
            colourInput("l1_shadow", "Shadow", "black", allowTransparent = TRUE),
            bsModal("l1_pos", "Primary text coordinates", "l1_pos_btn", size = "medium",
             fluidRow(
               column(6, sliderInput("l1_x", "X", 0, 1, 0.5, 0.05, width = "100%")),
               column(6, sliderInput("l1_y", "Y", 0, 1, 0.9, 0.05, width = "100%"))
             )
            ),
            actionButton("l1_pos_btn", "Position", class = "btn-primary", width = "100%")
          )
        ),
        column(6,
          wellPanel(
            textInput("l2", "Secondary text", txt[2], placeholder = txt[2], width = "100%"),
            numericInput("size2", "Size", 1, 0.1, 10, 0.1, width = "100%"),
            colourInput("l2_col", "Color", "white", allowTransparent = TRUE),
            colourInput("l2_shadow", "Shadow", "black", allowTransparent = TRUE),
            bsModal("l2_pos", "Secondary text coordinates", "l2_pos_btn", size = "medium",
             fluidRow(
               column(6, sliderInput("l2_x", "X", 0, 1, 0.5, 0.05, width = "100%")),
               column(6, sliderInput("l2_y", "Y", 0, 1, 0.1, 0.05, width = "100%"))
             )
            ),
            actionButton("l2_pos_btn", "Position", class = "btn-primary", width = "100%")
          )
        )
      ),
      wellPanel(
        fluidRow(
          column(6,
            uiOutput("ggobjects"),
            colourInput("inset_bg_fill", "Inset background", "#FFFFFF80", allowTransparent = TRUE),
            sliderInput("isize", "Thumbnail size", 0.2, 0.5, 0.2, 0.01, width = "100%"),
            bsTooltip("isize", "Applies to corner and center thumbnail insets."),
            numericInput("radius", "Inset corner radius", 0.025, 0, 1, 0.005, width = "100%"),
            uiOutput("image_fps")
          ),
          column(6,
            selectInput("inset_pos", "Inset position", pos_opts, width = "100%"),
            colourInput("inset_bg_col", "Inset border", "#FFFFFF00", allowTransparent = TRUE),
            sliderInput("imar", "Inset margin", 0, 0.2, 0.025, 0.005, width = "100%"),
            bsTooltip("imar", "Applies to all non-default insets."),
            numericInput("mult", "Image scaling", 1, 0.1, 5, 0.1, width = "100%"),
            bsTooltip("mult", "Shrink large source images or multiply small ones."),
            uiOutput("image_frame")
          )
        )
      )
    ),
    column(8,
      bsCollapse(id = "sources", open = "inputview",
        bsCollapsePanel(
          "Source image and inset plot", value = "inputview",
          fluidRow(
            column(6, h4("Image"), uiOutput("image", width = "100%")),
            column(6, h4("Inset"), plotOutput("inset_plot"))
          ),
          style = "primary")
      ),
      conditionalPanel("input.go_btn !== 0", fluidRow(column(12, h4("Meme plot"), withSpinner(plotOutput("meme_plot")))))
    )
  ), br()
)

server <- function(input, output) {

  output$ggobjects = renderUI({
    obs <- ls(envir = .GlobalEnv)
    gg <- c("", obs[purrr::map_lgl(obs, ~any(class(get(.x, envir = .GlobalEnv)) == "ggplot"))])
    selectInput("ggob", "Inset plot", gg, selected = "sineplot", width = "100%")
  })

  img_ext <- reactive({
    req(input$image_url)
    tail(strsplit(input$image_url, "\\.")[[1]], 1)
  })

  img_src <- reactive({
    req(input$image_url)
    if(!img_ext() %in% c("jpeg", "jpg", "png", "gif")) return()
    input$image_url
  })

  output$image = renderUI({
    tags$img(src = img_src(), height = "400px")
  })

  output$image_fps = renderUI({
    if(img_ext() == "gif") sliderInput("fps", "FPS", 1, 30, def_fps, 1, width = "100%")
  })

  output$image_frame = renderUI({
    if(img_ext() == "gif") tagList(
      selectInput("frame", "Frame", c("First" = 1, "All" = 0), width = "100%"),
      bsTooltip("frame", "Retaining gif frames takes longer to process.")
    )
  })

  output$inset_plot = renderPlot({
    req(input$ggob)
    if(input$ggob != "") get(input$ggob, envir = .GlobalEnv)
  })

  lab_pos <- reactive({
    p1x <- input$l1_x
    p1y <- input$l1_y
    p2x <- input$l2_x
    p2y <- input$l2_y
    if(is.null(p1x)) p1x <- 0.5
    if(is.null(p1y)) p1y <- 0.9
    if(is.null(p2x)) p2x <- 0.5
    if(is.null(p2y)) p2y <- 0.1
    list(w = rep(0.9, 2), h = rep(0.3, 2), x = c(p1x, p2x), y = c(p1y, p2y))
  })

  output$meme_plot = renderImage({
    input$go_btn
    isolate({
      l <- c(input$l1, input$l2)
      s <- c(input$size1, input$size2)
      l_col <- c(input$l1_col, input$l2_col)
      l_shadow <- c(input$l1_shadow, input$l2_shadow)
      p <- if(is.null(input$ggob) || input$ggob == "") NULL else get(input$ggob)
      if(is.null(p)){
        bg <- inset_background("blank")
      } else {
        bg <- list(fill = input$inset_bg_fill, col = input$inset_bg_col, r = grid::unit(input$radius, "snpc"))
      }
      ipos <- inset_position(input$inset_pos, size = input$isize, margin = input$imar)

      ext <- img_ext()
      if(ext == "jpeg") ext <- "jpg"
      outfile <- tempfile(fileext = paste0(".", ext))
      if(ext == "gif"){
        fps <- if(is.null(input$fps)) 20 else input$fps
        frame_num <- if(is.null(input$frame)) 1 else input$frame
        meme_gif(img_src(), l, outfile, size = s, col = l_col, shadow = l_shadow, label_pos = lab_pos(),
                 inset = p, inset_bg = bg, inset_pos = ipos, mult = input$mult, fps = fps, frame = frame_num)
      } else {
        meme(img_src(), l, outfile, size = s, col = l_col, shadow = l_shadow, label_pos = lab_pos(),
             inset = p, inset_bg = bg, inset_pos = ipos, mult = input$mult)
      }

      list(src = outfile, contentType = paste0("image/", ext), alt = "Meme plot output")
    })
  }, deleteFile = TRUE)
}

shinyApp(ui = ui, server = server)
