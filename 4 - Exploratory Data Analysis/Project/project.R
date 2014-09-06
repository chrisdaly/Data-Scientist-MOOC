# check if a data folder exists; if not then create one
if (!file.exists("data")) {dir.create("data")}

# file URL & destination file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "./data/power_consumption.zip"

# download the file & note the time
download.file(fileUrl, destfile)
dateDownloaded <- date()

# set the file to read
d <- file("./data/household_power_consumption.txt", "r");

# read in the data until date
data_ <- read.table(text = grep("^[1,2]/2/2007", readLines(d), value = TRUE), 
                sep = ";", skip = 0, na.strings = "?", stringsAsFactors = FALSE)

# rename the columns
names(data_) <- c("date", "time", "active_power", "reactive_power", "voltage",
                 "intensity", "sub_metering_1", "sub_metering_2", 
                 "sub_metering_3")

# add a new date-time formated column
data_$new_time <- as.POSIXct(paste(data_$date, data_$time), format = "%d/%m/%Y %T")

# plot 1 - histogram
hist(data_$active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", 
     col = "red",
     freq = TRUE)

# plot 2 - line graph
plot(new_time, data_$active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)" )

# plot 3 - 
plot(new_time, data_$sub_metering_1, type = "l")
plot(new_time, data_$sub_metering_2, col = "red", type = "l", add = TRUE)
plot(new_time, data_$sub_metering_2, col = "blue", type = "l", add = TRUE)
legend("topright")

with(data_, {
  plot(new_time, sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(new_time, sub_metering_2, col = "red")
  lines(new_time, sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), cex = 0.8, lty = 1,
         legend = c("Sub_metering_1", 
                    "Sub_metering_2",
                    "Sub_metering_3"))
  
  })


par(mfrow = c(2, 2))
with(data_, {
  plot(new_time, active_power, type = "l", xlab = "", ylab = "Global Active Power")
  plot(new_time, voltage, type = "l", xlab = "", ylab = "Global Active Power")
  plot(new_time, sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
  lines(new_time, sub_metering_2, col = "red")
  lines(new_time, sub_metering_3, col = "blue")
  legend("topright", col = c("black", "red", "blue"), cex = 0.7, lty = 1,
         legend = c("Sub_metering_1", 
                    "Sub_metering_2",
                    "Sub_metering_3"))
  plot(new_time, reactive_power, type = "l", xlab = "", ylab = "Global Reactive Power")
  
})
