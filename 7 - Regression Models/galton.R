library(UsingR); data(galton)
par(mfrow=c(1, 2))
hist(galton$child,col = "blue", breaks = 100)
hist(galton$parent,col = "blue", breaks = 100)

