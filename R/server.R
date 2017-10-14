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
  
  df <- read_csv(file='data/fl_crime.csv')
  x <- ~Education
  y <- ~Crime
  
  reactives <- reactiveValues(data = df,
                              hovered = NA,
                              clicked = NA)
  
  output$table1 <- renderRHandsontable({
    rhandsontable(reactives$data, height = 450, rowHeaders = TRUE, hovered = reactives$hovered) %>%
      hot_table(stretchH = "all") %>%
      hot_cols(renderer = read_file(file = 'js/highlight.js'))
  })
  
  output$plot1 <- renderPlotly({
    plot_ly(reactives$data, x = x, y = y,
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
    new_row <- tribble(x, y, vals[1], vals[2])
    reactives$data <- bind_rows(new_row, reactives$data)
  })
}