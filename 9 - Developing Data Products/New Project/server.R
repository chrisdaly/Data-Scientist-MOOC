library(shiny)
library(ggplot2)
library(pxR)

source('./helper/testing.R')

# Define server logic required to draw a histogram
shinyServer(
  
  function(input, output) {
    
    # Expression that generates a histogram. The expression is
    # wrapped in a call to renderPlot to indicate that:
    #
    #  1) It is "reactive" and therefore should re-execute automatically
    #     when inputs change
    #  2) Its output type is a plot
    
    output$distPlot <- renderPlot({
      
      # Extract input values
      year <- input$year
      sex  <- input$sex
      number    <- input$number
      
      output$year <- renderPrint(year)
      output$sex <- renderPrint(sex)
      output$number <- renderPrint(number)
      
      getNames(sex, number, year) 
    })
  })
