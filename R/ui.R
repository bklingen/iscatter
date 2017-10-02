#' @import shiny
#' @import plotly
#' @import rhandsontable
#' 
#' @export

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