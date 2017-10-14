library(shiny)
library(shinyjs)
library(V8)
library(plotly)
library(rhandsontable)
library(readr)

ui <- fluidPage(
  useShinyjs(),
  extendShinyjs(script = "js/focus.js"),
  extendShinyjs(script = "js/observe_clicks.js"),
  
  sidebarLayout(
    sidebarPanel(
      rHandsontableOutput(outputId = "table1")
    ),
    
    mainPanel(
      plotlyOutput(outputId = "plot1")
    )
  )
)