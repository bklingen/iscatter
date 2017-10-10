#' @import shiny
#' @importFrom shinyjs js
#' @import plotly
#' @import rhandsontable
#' @import readr
#' @import dplyr
#' @import utils
#' 
#' @export

server <- function(input, output) {
  data <- read_csv(system.file("extdata", "fl_crime.csv", package = "iscatter"))
  reactives <- reactiveValues(hovered = -1)
  
  output$table <- renderRHandsontable({
    if(is.null(event_data("plotly_hover", source = "source"))) {
      rhandsontable(data, width = 550, height = 550)
      
    } else {
      data %>%
        rhandsontable(width = 550, height = 550, hovered = reactives$hovered) %>%
        hot_cols(renderer = read_file(system.file("js", "highlight.js", package = "iscatter")))
    }
  })
  
  output$plot <- renderPlotly({
    plot_ly(data, x = ~Education, y = ~Crime,
            type = "scatter", hoverinfo = "text", source = "source",
            text = ~paste0("County: ", County, "<br>",
                           "Education: ", Education, "<br>",
                           "Crime: ", Crime, "<br>",
                           "Urbanization: ", Urbanization.Categorical, " (", Urbanization.Percent, "%)"))
  })
  
  observeEvent(event_data("plotly_hover", source = "source"), {
    eventdata <- event_data("plotly_hover", source = "source")
    validate(need(eventdata, "Event data not found"))
    hovered <- as.numeric(eventdata$pointNumber)[1]
    js$focus("table", hovered)
    reactives$hovered <- hovered
  })
}