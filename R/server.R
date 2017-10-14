library(shiny)
library(shinyjs)
library(plotly)
library(rhandsontable)
library(readr)
library(tibble)
library(dplyr)

server <- function(input, output, session) {
  session$onSessionEnded(stopApp)
  
  session$onFlushed(function() {
    js$observe_clicks("plot1")
  })
  
  reactives <- reactiveValues(data = read_csv(file='data/fl_crime.csv'),
                              hovered = NA)
  
  output$table1 <- renderRHandsontable({
    rhandsontable(reactives$data, height = 450, rowHeaders = TRUE, hovered = reactives$hovered) %>%
      hot_table(stretchH = "all") %>%
      hot_cols(renderer = read_file(file = 'js/highlight.js'))
  })
  
  output$plot1 <- renderPlotly({
    plot_ly(reactives$data, x = ~Education, y = ~Crime,
            type = "scatter", hoverinfo = "text", source = "source",
            text = ~paste0("County: ", County, "<br>",
                           "Education: ", Education, "<br>",
                           "Crime: ", Crime, "<br>",
                           "Urbanization: ", Urbanization.Categorical, " (", Urbanization.Percent, "%)"))
  })
  
  observeEvent(event_data("plotly_hover", source = "source"), {
    eventdata <- event_data("plotly_hover", source = "source")
    hovered <- as.numeric(eventdata$pointNumber)[1]
    if(!is.na(hovered)) reactives$hovered <- hovered
    js$focus("table1", hovered)
  })
  
  observeEvent(input$clicked, {
    vals <- round(input$clicked, digits = 1)
    reactives$data <- bind_rows(data_frame(Education = vals[1], Crime = vals[2]), reactives$data)
  })
}