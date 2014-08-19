# A sample of 9 men yielded a sample average brain volume of 1,100cc and a standard deviation of 30cc. 
# What is the complete set of values of ??0 that a test of H0:??=??0 would fail to reject the null hypothesis 
# in a two sided 5% Students t-test?

n <- 9
mn <- 1100
s <- 30
a <- 0.05

mn + c(1, -1) * qt(1 - (a/2), n-1) * s/sqrt(n)
