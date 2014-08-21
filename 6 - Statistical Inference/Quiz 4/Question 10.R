# The Daily Planet ran a recent story about Kryptonite poisoning in the water supply after a recent event in Metropolis. 
# Their usual field reporter, Clark Kent, called in sick and so Lois Lane reported the story. 
# Researchers sampled 288 individuals and found mean blood Kryptonite levels of 44, both measured in Lex Luthors per milliliter (LL/ml). 
# They compared this to 288 sampled individuals from Gotham city who had an average level of 42.04. 
# About what is the Pvalue for a two sided Z test of the relevant hypothesis? Assume that the standard deviation is 12 for both groups.


n <- 288
n_treated <- 288; n_placebo <- 288
mn_treated <- 44; mn_placebo <- 42.04
s <- 12

# get the standard error
std_error <- s * sqrt(1/n_treated + 1/n_placebo)

# get the z value (difference in means expressed in deviations)
z <- (mn_treated-mn_placebo)/std_error

# two sided - what's likely hood of getting those values
2 * pnorm(-abs(z))
