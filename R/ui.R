library(shiny)
library(shinyjs)
library(V8)
library(plotly)
library(rhandsontable)
library(readr)

ui <- fluidPage(
  useShinyjs(),
  extendShinyjs(script = 'js/focus.js'),
  
  sidebarLayout(
    sidebarPanel(
      rHandsontableOutput(outputId = "table")
    ),
    
    mainPanel(
      plotlyOutput(outputId = "plot")
    )
  )
)