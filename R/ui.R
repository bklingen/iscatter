#' @import shiny
#' @import plotly
#' @import rhandsontable

ui <- fluidPage(
  
  sidebarLayout(
    
    sidebarPanel(
      rHandsontableOutput(outputId = "table")
    ),
    
    mainPanel(
      plotlyOutput(outputId = "plot")
    )
  )
)