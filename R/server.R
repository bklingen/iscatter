library(shiny)
library(shinyjs)
library(ggplot2)
library(rhandsontable)
library(readr)
library(tibble)
library(dplyr)

server <- function(input, output, session) {
  session$onSessionEnded(stopApp)
  
  reactives <- reactiveValues(data = read_csv(file='data/fl_crime.csv'),
                              hovered = NA)
  
  output$table1 <- renderRHandsontable({
    rhandsontable(reactives$data, height = 450, rowHeaders = TRUE, hovered = reactives$hovered) %>%
      hot_table(stretchH = "all") %>%
      hot_cols(renderer = read_file(file = 'js/highlight.js'))
  })
  
  output$plot1 <- renderPlot({
    ggplot(data = reactives$data, aes(x = Education, y = Crime)) +
      geom_point() +
      theme_bw(base_size = 20)
  })
  
  output$plot1_tooltip <- renderUI({
    hover <- input$plot1_hover
    point <- reactives$data %>%
      rownames_to_column("idx") %>%
      mutate(idx = as.numeric(idx)) %>%
      nearPoints(coordinfo = hover, threshold = 5, maxpoints = 1)
    req(nrow(point) != 0)

    reactives$hovered <- point$idx
    js$focus("table1", point$idx)
    
    left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
    top_pct <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)
    
    left_px <- hover$range$left + left_pct * (hover$range$right - hover$range$left)
    top_px <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)
    
    wellPanel(
      style = paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
                     "left:", left_px + 2, "px; top:", top_px + 2, "px;"),
      p(HTML(with(point, paste0("County: ", County, "<br>",
                                "Education: ", Education, "<br>",
                                "Crime: ", Crime, "<br>",
                                "Urbanization: ", Urbanization.Categorical, " (", Urbanization.Percent, "%)")))))
  })
}