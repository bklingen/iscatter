#' @import shiny
#' @import plotly
#' @import rhandsontable
#' @import tidyverse
#' @import utils
#' 
#' @export

server <- function(input, output) {
  
  data <- reactiveValues(data = read.csv(system.file("extdata", "fl_crime.csv", package = "iscatter")))
  
  output$table <- renderRHandsontable({
    eventdata <- event_data("plotly_hover", source = "source")
    
    if(is.null(eventdata)) {
      rhandsontable(data$data)
      
    } else {
      hovered <- as.numeric(eventdata$pointNumber)[1] + 1
      print(hovered)
      rhandsontable(data$data, myindex = hovered) %>%
        hot_cols(renderer = "function(instance, td, row, col, prop, value, cellProperties) {
          Handsontable.TextCell.renderer.apply(this, arguments);
          if (instance.params) {
            hrows = instance.params.myindex
            hrows = hrows instanceof Array ? hrows : [hrows] 
          }
          if (instance.params && hrows.includes(row)) td.style.background = 'lightblue';
        }
        ")
    }
  })
  
  output$plot <- renderPlotly({
    plot_ly(data$data, x = ~Education, y = ~Crime,
            type = "scatter", hoverinfo = "text", source = "source",
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