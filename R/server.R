#' @import shiny
#' @import plotly
#' @import rhandsontable
#' @import tidyverse
#' @import utils

server <- function(input, output) {

  x <- read.csv(system.file("extdata", "fl_crime.csv", package = "iscatter"))
  
  output$table <- renderRHandsontable({
    x %>% head() %>% rhandsontable()
  })
    
  output$plot <- renderPlotly({
    plot_ly(x, x = ~Education, y = ~Crime, type = "scatter")
  })
}