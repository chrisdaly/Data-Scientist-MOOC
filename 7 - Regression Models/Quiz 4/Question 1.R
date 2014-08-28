# Consider the space shuttle data ?shuttle in the MASS library. 
# Consider modeling the use of the autolander as the outcome (variable name use). 
# Fit a logistic regression model with autoloader (variable auto) use (labeled 
# as "auto" 1) versus not (0) as predicted by wind sign (variable wind). 
# Give the estimated odds ratio for autoloader use comparing head winds, 
# labeled as "head" in the variable headwind (numerator) to tail winds (denominator).

library(MASS)
data(shuttle)

# convert outcome to 0 = noauto, 1 = auto
shuttle$use <- factor(shuttle$use, levels = c("auto", "noauto"), labels = c(1, 0))

fit <- glm(use ~ wind - 1, data = shuttle, family = "binomial")
summary(fit)

windhead <- fit$coef[1]
windtail <- fit$coef[2]

# Since predict() gives us log odds, we will have to convert to probabilities. 
# To convert log odds to probabilities use
# exp(lodds)/(1+exp(lodds)).
# lodds <- predict(fit, data.frame(use = 0, wind = 0))
# exp(lodds)/(1+exp(lodds))
exp(windhead)/(1+exp(windtail))


# Question 2
# Consider the previous problem. Give the estimated odds ratio for autoloader 
# use comparing head winds (numerator) to tail winds (denominator) adjusting for 
# wind strength from the variable magn.

