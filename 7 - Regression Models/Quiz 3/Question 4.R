# Consider the mtcars data set. 
# Fit a model with mpg as the outcome that includes number of cylinders as a 
# factor variable and weight inlcuded in the model as
lm(mpg ~ I(wt * 0.5) + factor(cyl), data = mtcars)
# How is the wt coefficient interpretted?


# note : ton = 2 tonnes
# The estimated expected change in MPG per one ton increase in weight for a specific number of cylinders (4, 6, 8).

