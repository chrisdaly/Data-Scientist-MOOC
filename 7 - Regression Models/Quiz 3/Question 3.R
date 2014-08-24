# Consider the mtcars data set. 
# Fit a model with mpg as the outcome that considers number of cylinders as a factor 
# variable and weight as confounder. Consider the model with an interaction between 
# cylinders and weight and one without. Give the P-value for the likelihood ratio 
# test comparing the two models and suggest a model using 0.05 as a type I error 
# rate significance benchmark.

data(mtcars)

fit1 <- lm(mpg ~ factor(cyl) + wt, data = mtcars)
fit2 <- lm(mpg ~ factor(cyl) + wt + interaction(cyl, wt), data = mtcars)

# To compare model we usually use an anova table
# anova null hypothesis says that both models are the same.
compare <- anova(fit1, fit2)
compare$Pr
