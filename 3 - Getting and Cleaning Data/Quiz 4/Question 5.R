library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn) 

# How many values were collected in 2012? 
# How many values were collected on Mondays in 2012?

# format the dates to show day and year
values <- format(sampleTimes, "%a %Y")

length(grep("2012", values))
length(grep("Mon 2012", values))


# alternative
values_2012 <- grep("2012", sampleTimes)
length(values_2012)

