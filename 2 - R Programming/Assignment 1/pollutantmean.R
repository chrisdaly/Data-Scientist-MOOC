
pollutantmean <- function(directory, pollutant, id = 1:332) {
	## Returns the mean of the pollutant across all monitors list
	## in the 'id' vector (ignoring NA values)
	
	# set the directory
	setwd(directory)
	
	# format the filenames
	filenames <- sprintf("%03d.csv", id)

	# value to keep track of the total pollutant, and amount of them
	total <- 0
	amount <- 0

	# for each monitor
	for (monitor in filenames){
		
		# read the csv file
		data <- read.csv(monitor)

		# find the pollutant column
		col <- data[[pollutant]]
	
		# get the mean of the pollutant column
		avg <- sum(col, na.rm=TRUE)

		# update the total
		total <- total + avg

		# get the number of non-NA entries per column
		num = NROW(na.omit(col))

		# update the amount
		amount <- amount + num
	}
	
	# return the total mean
	total / amount	
}

