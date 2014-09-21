# read in the 1999 data, ignoring the # comments for now
pm0 <- read.table("./data/RD_501_88101_1999-0.txt", comment.char = "#", 
                  header = FALSE, sep = "|", na.strings = "")

dim(pm0)
str(pm0)
head(pm0)

# get the columns names, (just a string)
cnames <- readLines("./data/RD_501_88101_1999-0.txt", 1)

# split on the line, it's a fixed pattern, not a regular expression
cnames <- strsplit(cnames, "|", fixed = TRUE)

# strsplit returns a list, therefore assign to first element of list
names(pm0) <- cnames[[1]]

head(pm0)

# since column names contain spaces they are not valid for referencing
names(pm0) <- make.names(cnames[[1]])

# take out PM2.5 values
x0 <- pm0$Sample.Value

class(x0)
str(x0)
summary(x0)

# what % is na
mean(is.na(x0))*100

# read in the 2012 data, ignoring the # comments for now
pm1 <- read.table("./data/RD_501_88101_2012-0.txt", comment.char = "#", 
                  header = FALSE, sep = "|", na.strings = "")

dim(pm1)

# same number of columns as 1999, therefore same names
names(pm1) <- make.names(cnames[[1]])

x1 <- pm1$Sample.Value

# what % is na
mean(is.na(x1))*100

# compare PM2.5 values for both years
summary(x1)
summary(x0)

# notice some extreme outliers, a negative value (not possible), and a huge value
# of 985

# median decrease for whole country, but larger spread
# less na values
boxplot(x0, x1)
boxplot(log10(x0), log10(x1))

# remove negative values with a logical vector
negative <- x1 < 0
str(negative)
sum(negative, na.rm = TRUE)
mean(negative, na.rm = TRUE) * 100
# 2% of values are negative

dates <- pm1$Date
str(dates)

# convert to date format
dates <- as.Date(as.character(dates), format = "%Y%m%d")

# histogram of dates by month
hist(dates, "month")

# check when negative values occur
hist(dates[negative], "month")

# look at just one monitor from both years
# look at all of the monitors in NY county, plucking out the county code & site id
site0 <- unique(subset(pm0, State.Code == 36, c(County.Code, Site.ID)))
site1 <- unique(subset(pm1, State.Code == 36, c(County.Code, Site.ID)))

# merge county code & site id
site0 <- paste(site0[, 1], site0[, 2], sep = ".")
site1 <- paste(site1[, 1], site1[, 2], sep = ".")

length(site0)
length(site1)

# notice they have different number of monitors 
# need to get common monitors between them
both <- intersect(site0, site1)

# put variable in the original data frames
pm0$county.site <- with(pm0, paste(County.Code, Site.ID, sep = "."))
pm1$county.site <- with(pm1, paste(County.Code, Site.ID, sep = "."))

# subset the DF to be just NY and one of the special monitors in both
cnt0 <- subset(pm0, State.Code == 36 & county.site %in% both)
cnt1 <- subset(pm1, State.Code == 36 & county.site %in% both)

# split the DF by monitor, & count how many rows are in each
sapply(split(cnt0, cnt0$county.site), nrow)
sapply(split(cnt1, cnt1$county.site), nrow)

# check how many observations are in each monitor and pick the best
pm0sub <- subset(pm0, State.Code == 36 & County.Code == 63 & Site.ID == 2008)
pm1sub <- subset(pm1, State.Code == 36 & County.Code == 63 & Site.ID == 2008)

# ensure that the counts match sapply results
dim(pm0sub) 
dim(pm1sub)

# plot the dates and PM values for monitor observations
dates0 <- pm0sub$Date
dates0 <- as.Date(as.character(dates0), "%Y%m%d")
x0sub <- pm0sub$Sample.Value
plot(dates0, x0sub)

dates1 <- pm1sub$Date
dates1 <- as.Date(as.character(dates1), "%Y%m%d")
x1sub <- pm1sub$Sample.Value
plot(dates1, x1sub)

# plot the 2 graphs side by side
par(mfrow = c(1,2), mar= c(4, 4, 2, 1))
plot(dates0, x0sub, pch = 20)
abline(h = median(x0sub, na.rm = TRUE))
plot(dates1, x1sub, pch = 20)
abline(h = median(x1sub, na.rm = TRUE))

# note the different axes - misleading
# calculate the range of observations
rng <- range(x0sub, x1sub, na.rm = TRUE)

# plot the 2 graphs side by side again with y limit
par(mfrow = c(1,2), mar= c(4, 4, 2, 1))
plot(dates0, x0sub, pch = 20, ylim = rng)
abline(h = median(x0sub, na.rm = TRUE))
plot(dates1, x1sub, pch = 20, ylim = rng)
abline(h = median(x1sub, na.rm = TRUE))

# note: the average value and the extreme spikes have gone down

# look at individual states
# get the average PM2.5 value for each state
mn0 <- with(pm0, tapply(Sample.Value, State.Code, mean, na.rm = TRUE))
mn1 <- with(pm1, tapply(Sample.Value, State.Code, mean, na.rm = TRUE))

# DFs with each state and respective mean
d0 <- data.frame(state = names(mn0), mean = mn0)
d1 <- data.frame(state = names(mn1), mean = mn1)

# merge DFs
mrg <- merge(d0, d1, by = "state")
dim(mrg)

# plot the change for each state between 1999 & 2012
par(mfrow = c(1, 1))
with(mrg, plot(rep(1999, 53), mrg[, 2], xlim = c(1998, 2013)))
with(mrg, points(rep(2012, 53), mrg[, 3]))
segments(rep(1999, 53), mrg[, 2], rep(2012, 53), mrg[, 3])


