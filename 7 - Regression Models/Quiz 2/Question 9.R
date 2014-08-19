# Refer back to the mtcars data set with mpg as an outcome and weight (wt) as the predictor. 
# About what is the ratio of the the sum of the squared errors, 
# ???ni=1(Yi???Y^i)2 when comparing a model with just an intercept (denominator) to the model with the intercept and slope (numerator)?

data(mtcars)


lm(y ~ offset(x))
fit <- lm(mpg ~ wt, mtcars)

anova(fit)
(847.73)/(847.73 + 278.32)

# another method = get Multiple R-squared from summary of lm ( didn't work)??
fit <- lm(mpg ~ wt, mtcars)
fit2 <- lm(mpg ~ offset(wt), mtcars)
a <- summary(fit)
