library(UsingR)
data(galton)

diabetesRisk <- function(glucose) glucose / 200

shinyServer(
  function(input, output){
    output$inputvalue <- renderPrint({input$glucose})
    output$prediction <- renderPrint({diabetesRisk(input$glucose)})
    
    output$newHist <- renderPlot({
      hist(galton$child, xlab="child height", col="lightblue", main="Histogram")
      mu <- input$mu
      lines(c(mu, mu), c(0, 200), col="red", lwd=5)
      mse <- mean((galton$child - mu)^2)
      text(62, 150, paste("mu = ", mu))
      text(62, 140, paste("MSE = ", round(mse, 2)))
    })
  }
)
