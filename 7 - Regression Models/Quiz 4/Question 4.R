# Consider the insect spray data InsectSprays. Fit a Poisson model using spray 
# as a factor level. Report the estimated relative rate comapring spray A 
# (numerator) to spray B (denominator).

data(InsectSprays)

fit <- glm(count ~ spray  - 1, family = "poisson", data = InsectSprays)
exp(fit$coef[1])/exp(fit$coef[2])
