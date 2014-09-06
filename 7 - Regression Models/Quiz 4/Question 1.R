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

fit1 <- glm(use ~ wind - 1, data = shuttle, family = "binomial")
summary(fit)

windhead <- fit1$coef[1]
windtail <- fit1$coef[2]

exp(windtail)/exp(windhead)


0.031
1.327
-0.031
0.969

