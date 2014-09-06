library(MASS)
data(shuttle)

# convert outcome to 0 = noauto, 1 = auto
shuttle$use <- factor(shuttle$use, levels = c("auto", "noauto"), labels = c(1, 0))

# Question 2
# Consider the previous problem. Give the estimated odds ratio for autoloader 
# use comparing head winds (numerator) to tail winds (denominator) adjusting for 
# wind strength from the variable magn.

fit2 <- glm(use ~ wind + magn - 1, data = shuttle, family = "binomial")
summary(fit)

windhead2 <- fit2$coef[1]
windtail2 <- fit2$coef[2]

exp(windtail2)/exp(windhead2)
