library(UsingR)
data(father.son)
x <- father.son$sheight
((mean(x) + c(-1, 1) * qnorm(0.975) * sd(x)/sqrt(length(x))))/12

x <- 5
t <- 94.32
lambda <- x/t
round(lambda + c(-1, 1) * qnorm(0.975) * sqrt(lambda/t), 3)

poisson.test(x, T = t)



x <- 10
t <- 60
lambda <- x/t
round(lambda + c(-1, 1) * qnorm(0.975) * sqrt(lambda/t), 3)

