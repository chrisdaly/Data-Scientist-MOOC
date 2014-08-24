# Consider the mtcars data set. 
# Fit a model with mpg as the outcome that includes number of cylinders as a factor variable 
# and weight as confounder. 
# Give the adjusted estimate for the expected change in mpg comparing 8 cylinders to 4.

data(mtcars)

fit <- lm(mpg ~ factor(cyl) + wt, data = mtcars)

# factor(cyl)8  = -6.071 
# (intercept is cyl(4) off which cly(8) is compared)