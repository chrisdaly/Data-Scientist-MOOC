# Using a knot point at 0, fit a linear model that looks like a hockey stick 
# with two lines meeting at x=0. Include an intercept term, x and the knot point 
# term. What is the estimated slope of the line after 0?

x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)

# lin.mod <- lm(y ~ x)
# segmented.mod <- segmented(lin.mod, seg.Z = ~ x, psi = 0)
# 
# summary(segmented.mod)
# 
# plot(x, y)
# plot(segmented.mod, add = TRUE)

x <- -5:5
y <- c(5.12, 3.93, 2.67, 1.87, 0.52, 0.08, 0.93, 2.05, 2.54, 3.87, 4.97)
lhs <- function(x) ifelse(x < 0,0-x,0) # basis function 1 (lhs = left hockey stick)
rhs <- function(x) ifelse(x > 0,x-0,0) # basis function 2 (rhs = right hockey stick)
gb <- lm(y ~ lhs(x) + rhs(x))
x <- seq(-5,5,by=1)
py <- gb$coef[1]+gb$coef[2]*lhs(x)+gb$coef[3]*rhs(x)
lines(x, py)