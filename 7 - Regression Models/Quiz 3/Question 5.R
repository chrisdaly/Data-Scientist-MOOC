# Consider the following data set

x <- c(0.586, 0.166, -0.042, -0.614, 11.72)
y <- c(0.549, -0.026, -0.127, -0.751, 1.344)

# Give the hat diagonal for the most influential point

fit <- lm(y ~ x)
hatvalues(fit)