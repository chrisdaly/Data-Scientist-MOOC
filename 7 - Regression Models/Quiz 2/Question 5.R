data(mtcars)

# Consider again the mtcars data set and a linear regression model with mpg as predicted by weight (1,000 lbs). 
# A new car is coming weighing 3000 pounds. 
# Construct a 95% prediction interval for its mpg.
# What is the upper endpoint?
wt <- mtcars$wt
mpg <- mtcars$mpg

fit <- lm(mpg ~ wt, mtcars)

newdata <- data.frame(wt = 3)
x <- predict(fit, newdata, interval = ("prediction"))
