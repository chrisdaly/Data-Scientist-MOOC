n <- 9
mn <- -2
# s <- ?



# A diet pill is given to 9 subjects over six weeks. 
# The average difference in weight (follow up - baseline) is -2 pounds. 
# What would the standard deviation of the difference in weight have to be 
# for the upper endpoint of the 95% T confidence interval to touch 0? 

# TConfidenceinterval at .9725 and DF = n-1 = 8
# Tconf <- mn + c(-1, 1) * qt(alpha, n-1) * s / sqrt(n)
s <- 2*3/2.306
qt(0.975, 8)
