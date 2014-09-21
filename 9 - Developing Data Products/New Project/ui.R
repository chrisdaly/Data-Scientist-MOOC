library(shiny)

# Define UI for application that draws a plot
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Irish Baby Names"),
  
  # Sidebar with a slider input for the mean, sd and obs
  sidebarLayout(
    sidebarPanel(
      
      img(src = "baby.png", height = 488, width = 426),
      
      br(),
      br(),
      
      p("Compare the popularity of names over the years by specifiying sex in the 
        drop down box and moving the slider bars to change the year and number of names."),
      
      sliderInput("year",
                  "Year:",
                  min = 1998,
                  max = 2013,
                  value = 2013),
      
      sliderInput("number",
                  "Number:",
                  min = 1,
                  max = 20,
                  value = 1),
      
      selectInput(inputId = "sex",
                  label = "Sex:",
                  choices = c("Male" = "boys", 
                              "Female" = "girls"),
                  selected = "boys"),
      
      p("Data obtained from ",
        a("Central Statistics Office.", 
          href = "http://www.cso.ie/px/pxeirestat/database/eirestat/Irish%20Babies%20Names/Irish%20Babies%20Names_statbank.asp"))
           
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot")
#       verbatimTextOutput("year"),
#       verbatimTextOutput("sex"),
#       verbatimTextOutput("number")
    )
  )
))