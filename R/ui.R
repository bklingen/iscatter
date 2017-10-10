library(shiny)
library(shinyjs)
library(V8)
library(plotly)
library(rhandsontable)
library(readr)

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