best <- function(state, outcome) {
  
  # read the outcome csv data
  data_ <-  read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  # store the entire state column
  col_state <- data_$State
  
  # vector for states
  states <- getStates(col_state)
    
  # vector for outcomes
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  # validate the inputs
  validate(state, "state", states)
  validate(outcome, "outcome", outcomes)
  
  # split the data into different states
  x <- split(data_, data_$State)
  
  # hospitals in the state
  hospitals <- x[[state]]$Hospital.Name
  
  # find the outcome column
  outcome_col <- getOutcomeColNum(outcome)
   
  # outcome rates in the state
  rates <- x[[state]][[outcome_col]]
  
  # convert the rates from factor to numeric (also converts to N/A)
  rates <- as.numeric(as.character(rates))
    
  # construct a data frame
  output <- data.frame(hospitals, rates)
   
  # sort the data frame in ascending order 
  output <- output[with(output, order(rates, decreasing=FALSE)),]
  
  # return hospital name in that state with lowest 30-day death
  best <- output[1,]$hospital
  as.vector(best)
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

