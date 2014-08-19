data(mtcars)

# Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (in 1,000 lbs). 
# A "short" ton is defined as 2,000 lbs.
# Construct a 95% confidence interval for the expected change in mpg per 1 short ton increase in weight.
# Give the lower endpoint.

# to get an increase of 1 short tonne, divide by 2
wt <- (1/2) * mtcars$wt
mpg <- mtcars$mpg

fit <- lm(mpg ~ wt)

sumCoef <- summary(fit)$coefficients

sumCoef[2,1] + c(-1, 1) * qt(.95, df = fit$df) * sumCoef[2, 2]
