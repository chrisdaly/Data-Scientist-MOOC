# If you fit a logistic regression model to a binary variable, for example use 
# of the autolander, then fit a logistic regression model for one minus the 
# outcome (not using the autolander) what happens to the coefficients?

library(MASS)
data(shuttle)


shuttle$auto <- as.numeric(shuttle$use=="auto")
fit <- glm(auto ~ wind,  binomial,  shuttle)
fit3 <- glm(1-auto ~ wind,  binomial, shuttle)
fit$coefficients
fit3$coefficients