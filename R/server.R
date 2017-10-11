library(shiny)
library(shinyjs)
library(plotly)
library(rhandsontable)
library(readr)

server <- function(input, output) {
  data <- read_csv(file='data/fl_crime.csv')
  reactives <- reactiveValues(hovered = NA)
  
  output$table <- renderRHandsontable({
    eventdata <- event_data("plotly_hover", source = "source")
    hovered <- as.numeric(eventdata$pointNumber)[1]
    if(!is.na(hovered)) reactives$hovered <- hovered
    rhandsontable(data, height = 450, rowHeaders=TRUE, hovered = reactives$hovered) %>%
      hot_table(stretchH="all") %>%
      hot_cols(renderer = read_file(file='js/highlight.js'))
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
    hovered <- reactives$hovered
    if(is.na(hovered)) return(NULL)
    js$focus("table", hovered)
  })
}