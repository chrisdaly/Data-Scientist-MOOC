complete <- function(directory = getwd(), id = 1:332) {
	        
      ## Return a data frame of the form:
      ## id nobs
      ## 1  117
      ## 2  1041

	# set the directory
	# setwd(directory)
	
	# format the filenames
	filenames <- sprintf("%03d.csv", id)

	# get the length of the ids
	len <- length(id)	
	
	# counter
	i <- 1

	# construct the id vector
	id <- c(id)

	# construct the nobs vector
	nobs <- vector(mode = "numeric", length = len)
	
	# for each monitor
	for (monitor in filenames){

		# read the csv file
		data <- read.csv(monitor)

		# filter the entries for both columns
		sulf <- !is.na(data$sulfate)
		nitr <- !is.na(data$nitrate)
		
		# add the results
		total <- nitr + sulf

		# filter so that both are true
		complete <- total[total==2]
		
		# count the entries
		amount <- length(complete)

		# append the amount to nobs
		nobs[i] <- amount

		# increment counter
		i <- i + 1
	}
	
	# construct the data frame
	output <- data.frame(id, nobs)

	print(output)

}