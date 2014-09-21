library(ggplot2)
library(pxR)

# load the data sets
boys  <- read.px("./data/boys.px")
girls <- read.px("./data/girls.px")

# Function to pre-process the data
preProcess <- function(sex){
  
  # extract the relevant information based on user choice
  if (sex == "boys"){
    data <- boys$DATA$value
  }
  if (sex == "girls"){
    data <- girls$DATA$value
  }
  
  # Convert the dataframe into a long format manually
  l <- length(data$value)
  
  # initialize empty vector to hold amounts
  amount <- c()
  
  # If the row is odd then add the next row's value to it
  for (i in 1:l){
    if (i%%2 == 1){
      amount <- c(amount, data$value[i+1])
    }
  }
  
  # append the amount to the rank row
  DF <- with(data, subset(data, Statistic == "Rank of Name in Ireland (Number)"))
  DF$amount <- amount
  DF$Statistic <- NULL
  names(DF) <- c("Year", "Name", "Rank", "Amount")
  DF
}

# pre-process both the data sets
boys_data <- preProcess("boys")
girls_data <- preProcess("girls")

getNames <- function(sex, n, year) {
  
  # extract the relevant information based on user choice
  if (sex == "boys"){
    data <- boys_data
  }
  if (sex == "girls"){
    data <- girls_data
  }
  
  # get the names for the top n ranks for a specific year
  DF <- with(data, subset(data, Year == year & Rank %in% c(1:n)))
  names <- DF$Name
  
  # subset all years with this filter
  DF1 <- with(data, subset(data, Name %in% names))
  
  # Plot the graph
  p1 <- ggplot(data = DF1, aes(x = Year, y = Amount, fill = Name))
  
  # This is necessary since you want one line per samples rather than for each data point
  p1 + geom_line(aes(colour = Name, group = Name)) + 
    labs(title = 'Most Popular Baby Names 1998 - 2013',
         y = 'Number of babies', x = 'Year', fill = 'Name')
}