# Consider a Poisson glm with an offset, t. So, for example, a model of the form 
# glm(count ~ x + offset(t), family = poisson) where x is a factor variable 
# comparing a treatment (1) to a control (0) and t is the natural log of a 
# monitoring time. What is impact of the coefficient for x if we fit the model 
# glm(count ~ x + offset(t2), family = poisson) where t2 <- log(10) + t? In 
# other words, what happens to the coefficients if we change the units of the 
# offset variable. (Note, adding log(10) on the log scale is multiplying by 10 
# on the original scale.)


data(mtcars)

fit1 <- lm(mpg ~ factor(cyl) + wt, data = mtcars)

