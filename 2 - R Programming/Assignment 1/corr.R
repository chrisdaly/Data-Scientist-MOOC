corr <- function(directory = getwd(), threshold = 0) {
        ## 'directory' is a character vector of length 1 indicating
        ## the location of the CSV files

        ## 'threshold' is a numeric vector of length 1 indicating the
        ## number of completely observed observations (on all
        ## variables) required to compute the correlation between
        ## nitrate and sulfate; the default is 0

        ## Return a numeric vector of correlations

	# set the directory
	setwd(directory)
	
	# data frame of the monitor and their complete observations
	data_ <- complete(directory)

	# find the monitors with obs above the threshold
	mons <- data_$id[(data_$nobs > threshold)]
	
	# format the filenames
	filenames <- sprintf("%03d.csv", mons)
	
	# find the length of the monitors vector
	len = length(mons)
	
	# counter
	i <- 1

	# construct the sulfate and nitrate summary vectors
	sulf <- vector(mode = "numeric", length = len)
	nitr <- vector(mode = "numeric", length = len)

	# construct the correlation vector
	correl <- vector(mode = "numeric", length = len)

	# for each monitor
	for (monitor in filenames){
		
		# read the csv file
		data_ <- read.csv(monitor)

		# filter the entries for both columns
		sulf <- !is.na(data_$sulfate)
		nitr <- !is.na(data_$nitrate)

		# add the results
		total <- nitr + sulf

		# get the nitr-sulf values
		sulf_ <- data_$sulfate[total==2]
		nitr_ <- data_$nitrate[total==2]

		# get the correlation and append to correl
		correl[i] <- cor(sulf_, nitr_)

		# increment counter
		i <- i + 1
	}
	
	correl
	

}