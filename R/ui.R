#' @import shiny
#' @import plotly
#' @import rhandsontable
#' @importFrom shinyjs useShinyjs extendShinyjs
#' @import V8
#' 
#' @export

ui <- fluidPage(
  useShinyjs(),
  extendShinyjs(script = system.file("js", "focus.js", package = "iscatter")),
  
  sidebarLayout(
    sidebarPanel(
      rHandsontableOutput(outputId = "table")
    ),
    
    mainPanel(
      plotlyOutput(outputId = "plot")
    )
  )
)