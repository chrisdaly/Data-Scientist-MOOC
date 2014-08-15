library(lattice)
library(knitr)
library(xtable)

# Part 1
###############################

# check if a data folder exists; if not then create one
if (!file.exists("data")) {dir.create("data")}

# file URL and destination file
fileUrl <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
destfile <- "./data/activity.zip"

# download the file and note the time
download.file(fileUrl, destfile = destfile)
dateDownloaded <- date()

# from the zip file, read out the containing csv file
data_ <- read.csv(unz("./data/activity.zip", "activity.csv"))

# assign variables to the columns
steps <- data_$steps
date <- data_$date
interval <- data_$interval

# filter to isolate non-NA values
filter <- !is.na(steps)

# apply the steps filter to the date vector
filter_steps <- steps[filter]
filter_date <- date[filter]

# create a factor vector for the non-NA days
days_factor <- factor(filter_date)

# get the total number of steps for each day
total_steps <- tapply(filter_steps, days_factor, FUN = sum)

# plot a histogram of the total number of steps taken each day
histogram(total_steps, breaks = 10, 
          xlab = "Total number of steps per day", 
          main = "Distribution of total steps per day", 
          col = "lightblue", 
          type = "count")

# calculate the mean and median of the distribution
mean_original <- mean(total_steps)
median_original <- median(total_steps)


# Part 2
###############################

# create a factor vector for the time intervals
interval_factor <- factor(interval)
levels <- nlevels(interval_factor)
interval_factor <- factor(interval)[1:levels]

# calculate the average number of steps for each 5 minute period
average_steps <- tapply(steps, factor(interval), FUN = mean, na.rm = TRUE)
average_steps <- sapply(average_steps, simplify = array, round, 2)

scales=list( x=list(at = seq(0, 2400, 200)))     
   
# plot the time series
xyplot(as.numeric(average_steps) ~ interval[1:288], 
       type = "l", 
       xlab = "Time interval",
       ylab = "Average steps", 
       main = "Time series - average steps vs time interval", 
       scales = scales)


# create a data frame of average steps and time interval
df_steps_interval <- data.frame(interval_factor, average_steps)

# sort df to get the row with the maximum amount of average steps
df_steps_interval <- df_steps_interval[order(df_steps_interval$average_steps, 
                                             decreasing = TRUE),]

# the first row contains the relevant time interval
time_interval_max <- df_steps_interval$interval_factor[1]

# convert the factor to a character and then to numeric
time_interval_max <- as.numeric(as.character(time_interval_max))


# Part 3
###############################
# number of NA values in original dataset
length(steps[is.na(steps)])

# take a copy of the original steps vector
new_steps <- steps

# fill in each NA value by taking the average for that time interval
for (i in which(sapply(new_steps, is.na))) {
  
  # set the value to the equivalent value in the average vector
  if (i <= 288){
    new_steps[i] <- average_steps[i]
  } 
  
  # wrap around 288 (avg time only has 24 hours of data) and add one because 
  # R is non-zero index
  else{
    j <- i%%288 + 1
    new_steps[i] <- average_steps[j]
  }
  
}

# create a factor vector for all of the days
new_days_factor <- factor(new_steps)

# get the total number of steps for each day
new_total_steps <- tapply(new_steps, new_days_factor, FUN = sum)

# plot a histogram of the total number of steps taken each day
histogram(new_total_steps, breaks = 10, 
          xlab = "Total number of steps per day", 
          main = "Distribution of total steps per day after imputted values", 
          col = "lightblue",
          type = "count")

# calculate the mean and median of the distribution
mean_new <- mean(new_total_steps)
median_new <- median(new_total_steps)


original <- c(mean_original, median_original)
new_ <- c(mean_new, median_new)
summary <- data.frame(original, new_)
rownames(summary)<-c("mean", "median")
xtable(summary)

# Part 4
###############################

# convert the date vector from factor type to date
date_new <- as.Date(date)

# determine the day of the week for each date
whichDay <- weekdays(date_new)

# weekend day vector to compare with
weekendDays <- c("Saturday", "Sunday")

# construct a DF for these 4 values
DF <- data.frame(date_new, interval_factor, new_steps, whichDay)

# add a logical column to indicate whether a day ot type weekend/weekday
isWeekend <- DF$whichDay %in% weekendDays

# convert isWeekend to a factor variable
DF$dayType = factor(isWeekend,labels = c("Weekday","Weekend"))

# plot the time series
xyplot(DF$new_steps ~ interval | DF$dayType, layout = c(2, 1), type = "l", 
       xlab = "Time interval", ylab = "Number of steps", 
       main = "Time series of numer of steps vs time interval" )
