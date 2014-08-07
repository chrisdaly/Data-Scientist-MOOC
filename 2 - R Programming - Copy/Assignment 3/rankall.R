rankall <- function(outcome, num = "best") {
  
  # read the outcome csv data
  data_ <-  read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # store the entire state column
  col_state <- data_$State
  
  # vector for states
  total_states <- getStates(col_state)
  
  # vector for outcomes
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  # validate the inputs
  validate(outcome, "outcome", outcomes)
  
  # split the data into different states
  data_split <- split(data_, data_$State)
  
  # get the length of the state vector
  l <- length(total_states)
  
  # create vectors for the DF
  hospital <- numeric(l)
  state <- character(l)
  
  # add values to the vectors
  for (i in 1:l) {
    
    hospital[i] <- rankhospital(total_states[i], outcome, data_split, num)
    state[i] <- total_states[i]
  }
  
  # create the dataframe
  data.frame(hospital, state, stringsAsFactors=FALSE)
  
}

rankhospital <- function(state, outcome, data_split,  num = "best") {
  
  # split the data into different states
  data_split <- split(data_, data_$State)
  
  # hospitals in the state
  hospitals <- data_split[[state]]$Hospital.Name
  
  # find the outcome column
  outcome_col <- getOutcomeColNum(outcome)
  
  # outcome rates in the state
  rates <- data_split[[state]][[outcome_col]]
  
  # convert the rates from factor to numeric (also converts to N/A)
  rates <- as.numeric(as.character(rates))
  
  # rank vector
  ranks <- 1:length(rates)
  
  # construct a data frame
  output <- data.frame(hospitals, rates)
  
  # remove NA rows
  output <- output[complete.cases(output),]
  
  # sort the data frame in ascending order 
  output <- output[with(output, order(rates, hospitals)),]
  
  # add the rank column
  output$Rank <- 1:length(output$rates)
  
  # interpret the num input
  num <- getRealNum(num, output$Rank)
  
  # if the input is greater than the ranks, return NA
  if (is.na(num) == TRUE){
    return(NA)
  }
  
  # return the desired hospital rank
  desired <- output[num,]$hospital
  as.vector(desired)
}

# checks if an element is part of a group
validate <- function(element, type, group){
  
  # check if the element is in the group
  if (!is.element(element, group)){
    
    # error message template
    message <- "invalid %"
    
    # substitute the element type into error message
    stop(gsub("%", type, message))
  }
}

# compiles a list of states
getStates <- function(state_list){
  
  # vector for states
  states <- c()
  
  for (each in state_list){
    
    # if a state is not already included in the vector
    if (!is.element(each, states)){
      
      # append it
      states <- c(states, each)
    }
  }
  
  states
}

# takes the outcome input and finds its row in the csv file
getOutcomeColNum <-function(outcome){
  if ((outcome == "heart attack") == TRUE) {
    return(11)
  } else if ((outcome == "heart failure") == TRUE) {
    return(17)
  } else if ((outcome == "pneumonia") == TRUE) {
    return(23)
  } 
}

# takes the num input and converts it to an integer
getRealNum <-function(num, col){
  len <- length(col)
  
  if ((num == "best") == TRUE) {
    return(1)
  } 
  
  else if ((num == "worst") == TRUE) {
    return(len)
  } 
  
  else  {
    if (num < len){
      return(num)
    }
    else {
      return(NA)
    }
  }
  
}