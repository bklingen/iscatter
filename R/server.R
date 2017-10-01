#' @import shiny
#' @import plotly
#' @import rhandsontable
#' @import tidyverse
#' @import utils

server <- function(input, output) {
  
  data <- reactiveValues(data = read.csv(system.file("extdata", "fl_crime.csv", package = "iscatter")))
  
  output$table <- renderRHandsontable({
    rhandsontable(data$data)
  })
  
  output$plot <- renderPlotly({
    plot_ly(data$data, x = ~Education, y = ~Crime, type = "scatter",
            hoverinfo = "text",
            text = ~paste0("County: ", County, "<br>",
                           "Education: ", Education, "<br>",
                           "Crime: ", Crime, "<br>",
                           "Urbanization: ", Urbanization.Categorical, " (", Urbanization.Percent, "%)"))
  })
  
  # Underlying data used both by the table and the plot. Note that the data are
  # updated after new user entry into the table.
  observeEvent(input$table, {
    data$data <- hot_to_r(input$table)
  })
}