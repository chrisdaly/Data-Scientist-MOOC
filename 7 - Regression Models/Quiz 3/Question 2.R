# Consider the mtcars data set. 
# Fit a model with mpg as the outcome that includes number of cylinders as a factor 
# variable and weight as confounder. Compare the adjusted by weight effect of 8 
# cylinders as compared to 4 the unadjusted. What can be said about the effect?.


data(mtcars)

fit1 <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
fit2 <- lm(mpg ~ factor(cyl), data = mtcars)

fit2$coefficients[3]


#Holding weight constant, cylinder appears to have less of an impact on mpg than if weight is disregarded.