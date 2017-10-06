#' @import shiny
#' @import plotly
#' @import rhandsontable
#' 
#' @export

ui <- fluidPage(
  
  sidebarLayout(
    
    sidebarPanel(
      rHandsontableOutput(outputId = "table"),
      includeScript("R/www/focus.js")
      #tags$head(tags$script(type="text/javascript", src="focus.js"))
    ),
    
    mainPanel(
      plotlyOutput(outputId = "plot")
    )
  )
)