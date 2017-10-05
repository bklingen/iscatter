#' @import shiny
#' @import plotly
#' @import rhandsontable
#' @import tidyverse
#' @import utils
#' 
#' @export

server <- function(input, output) {
  
  df <- read.csv(system.file("extdata", "fl_crime.csv", package = "iscatter"))
  reactives <- reactiveValues(data = df)
  
  output$table <- renderRHandsontable({
    if(is.null(event_data("plotly_hover", source = "source"))) {
      rhandsontable(df, width = 550, height = 550)
      
    } else {
      reactives$data %>%
        rhandsontable(width = 550, height = 550, hovered = 0) %>%
        hot_rows(fixedRowsTop = 1) %>%
        hot_cols(renderer = renderer(type = "highlight"))
    }
  })
  
  output$plot <- renderPlotly({
    plot_ly(df, x = ~Education, y = ~Crime,
            type = "scatter", hoverinfo = "text", source = "source",
            text = ~paste0("County: ", County, "<br>",
                           "Education: ", Education, "<br>",
                           "Crime: ", Crime, "<br>",
                           "Urbanization: ", Urbanization.Categorical, " (", Urbanization.Percent, "%)"))
  })
  
  observeEvent(event_data("plotly_hover", source = "source"), {
    eventdata <- event_data("plotly_hover", source = "source")
    
    if(!is.null(eventdata)) {
      hovered <- as.numeric(eventdata$pointNumber)[1]+1
      reactives$data <- moveToTop(df, hovered)
    }
  })
}