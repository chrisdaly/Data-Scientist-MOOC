library(shiny)

shinyUI(
  pageWithSidebar(
    
    # application title
    headerPanel("Test"),
    
    sidebarPanel(
      # label, printed label, default values, step values
      numericInput('num', 'Number', 90, min = 50, max = 200, step = 5),
      
      submitButton('Submit'),
      
#       sliderInput('mu', 'Guess at the mean', value = 70, min = 62, max = 74, step = 0.05)
    ),
    
    mainPanel(
      h3('Results'),
      h4('You entered'),
      verbatimTextOutput("inputValue"),
      h4('Which resulted in a prediction of'),
      verbatimTextOutput("prediction"),
      
      plotOutput('newHist')
    )
  )
)