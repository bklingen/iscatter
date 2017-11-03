library(shiny)
library(shinyjs)
library(ggplot2)
library(rhandsontable)
library(readr)
library(tibble)
library(dplyr)

proxThreshold <- 5

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
    pt <- reactives$data %>%
      mutate(idx = as.numeric(rownames(.))) %>%
      nearPoints(coordinfo = hover, threshold = proxThreshold, maxpoints = 1)
    req(nrow(pt) != 0)
    
    max <- nrow(hot_to_r(input$table1)) - 1
    reactives$hovered <- pt$idx - 1
    if(reactives$hovered < 2) reactives$hovered <- 2
    js$focus("table1", reactives$hovered, max)
    
    left_pct <- (hover$x - hover$domain$left) / (hover$domain$right - hover$domain$left)
    top_pct <- (hover$domain$top - hover$y) / (hover$domain$top - hover$domain$bottom)
    
    left_px <- hover$range$left + left_pct * (hover$range$right - hover$range$left)
    top_px <- hover$range$top + top_pct * (hover$range$bottom - hover$range$top)
    
    wellPanel(
      style = paste0("position:absolute; z-index:100; background-color: rgba(245, 245, 245, 0.85); ",
                     "left:", left_px + 2, "px; top:", top_px + 2, "px;"),
      p(HTML(with(pt, paste0("<b>County:</b> ", County, "<br>",
                             "<b>Education:</b> ", Education, "<br>",
                             "<b>Crime:</b> ", Crime, "<br>",
                             "<b>Urbanization:</b> ", Urbanization.Categorical, " (", Urbanization.Percent, "%)")))))
  })
  
  observeEvent(input$plot1_click, {
    click <- input$plot1_click
    
    ptNearby <- reactives$data %>%
      mutate(idx = as.numeric(rownames(.))) %>%
      nearPoints(coordinfo = click, threshold = proxThreshold, maxpoints = 1)
    
    if (nrow(ptNearby) == 0)
      reactives$data <- add_row(reactives$data, Education = click$x, Crime = click$y, .before = 1)
    else {
      reactives$data <- reactives$data[-ptNearby$idx, ]
      reactives$hovered <- NA
    }
  })
}