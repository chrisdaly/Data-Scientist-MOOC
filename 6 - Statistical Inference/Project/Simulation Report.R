library(knitr)
library(plotrix)

# set the random seed
set.seed(1230)
par(xpd=NA)

# set the experiment values
lambda <- .2; n <- 40

# prepare the device for a 2x2 plot
par(mfrow = c(2,2))

# generate the random variables for these n values
for (no_sim in c(10, 100, 1000, 10000)){
  
  # clear the vectors
  mean_values <- NULL; mean_sds <- NULL
  
  for (i in 1:no_sim){
    # calculate the mean & sd of all the sample means
    values <- rexp(n, lambda)
    means <- mean(values); sds <- sd(values)
    mean_values  <- c(mean_values, means); mean_sds <- c(mean_sds, sds)
  }

  myhist <- hist(mean_values , freq = TRUE, xlim = c(2, 8), 
                 main = paste("Histogram of", no_sim, "simulations"), xlab = "Values")
}
  
# no_sim = 10,000 - histogram of probability density
par(mfrow = c(1,1))
myhist <- hist(mean_values , freq = FALSE, xlim = c(2, 8), ylim = c(0, .55), 
               breaks = 25, main = paste("Probability density function for", no_sim, "simulations"), 
               xlab = "Values")

# calculate the total mean and standard deviation of the aggregated samples
avg <- mean(mean_values)
s <- sd(mean_values)

# plot the average value from the data set
abline(v = avg , col = "steelblue", lwd = 3, lty = 2)

# plot the expected value of an exponential distribution
abline(v = 5, col = "red", lwd = 3, lty = 9)

# plot the theoretical normal distribution for the data set
x <- seq(min(mean_values ), max(mean_values ), length = 100) 
y <- dnorm(x, mean = avg, sd = s)
curve(dnorm(x, mean = avg, sd = s), 
      col = "gray", lwd = 3, lty = 3, add = TRUE)

legend('topright', c("Expected value", "Actual mean", "Normal distrubution"), 
       lty=1, col=c('red', 'steelblue', "gray"), bty='n', cex=.75)


sd(mean_values)
qqnorm(mean_values, col = "lightskyblue1")
qqline(mean_values)

# rerun for no_sim <- 100
no_sim <- 100

mean_values <- NULL; mean_sds <- NULL

for (i in 1:no_sim){
  # calculate the mean & sd of all the sample means
  values <- rexp(n, lambda)
  means <- mean(values); sds <- sd(values)
  mean_values  <- c(mean_values, means); mean_sds <- c(mean_sds, sds)
}
# construct 95% confidence interval for each simulation
upper <- mean_values +  1.96 * (mean_sds/sqrt(n))
lower <- mean_values -  1.96 * (mean_sds/sqrt(n))
sum(lower < 5 & 5 < upper)/no_sim * 100


index <- c(1:no_sim)
# data.frame(index, upper, lower)

plot(index, upper, ylim = c(0, 10), type = "n", xlab = "Index", ylab = "Mean", 
     main = "Plot of confidence interval coverage for 100 simulations")

segments(index, upper, index, lower, col = "steelblue", lwd = 3)
#ablineclip(h = 5, col = "red", lwd = 2, lty = 2)
text(-8, 5, expression(paste("", mu, "")), cex = 1.5)
ablineclip(h=5, x1 = -2.5, lty = 2, col="red")