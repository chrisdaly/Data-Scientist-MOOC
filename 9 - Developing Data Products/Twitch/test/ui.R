library(UsingR)

diabetesRisk <- function(glucose) glucose / 200

shinyServer(
  function(input, output){
    output$inputvalue <- renderPrint({input$num})
    output$prediction <- renderPrint({diabetesRisk(input$num)})
  }
)
