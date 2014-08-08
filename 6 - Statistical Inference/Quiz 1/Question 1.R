x <- 1:4
p <- x/sum(x)
temp <- rbind(x, p)
rownames(temp) <- c("X", "Prob")
temp

mean <- 1.0 * .1 + 2.0 * .2 + 3.0 * .3 + 4.0 * .4