library(shiny)
library(shinyjs)
library(V8)
library(rhandsontable)
library(readr)

ui <- fluidPage(
  useShinyjs(),
  extendShinyjs(script = "js/focus.js"),
  
  sidebarLayout(
    sidebarPanel(
      rHandsontableOutput(outputId = "table1")
    ),
    
    mainPanel(
      div(
        style = "position:relative",
        plotOutput(outputId = "plot1",
                   hover = hoverOpts("plot1_hover", delay = 100, delayType = "debounce"),
                   click = clickOpts("plot1_click")),
        uiOutput("plot1_tooltip")
      )
    )
  )
)