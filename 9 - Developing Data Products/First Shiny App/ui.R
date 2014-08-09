library(shiny)

shinyUI(
  pageWithSidebar(
  
  # application title
  headerPanel("Child Height MSE"),
  
  sidebarPanel(
    # label, printed label, default values, step values
    # numericInput('glucose', 'Glucose mg/dl', 90, min = 50, max = 200, step = 5),
    
    #submitButton('Submit'),
    
    sliderInput('mu', 'Guess the mean', value = 70, min = 62, max = 74, step = 0.05)
  ),
  
  mainPanel(
    h3('Barchart of child height'),  
    plotOutput('newHist')
  )
  )
)