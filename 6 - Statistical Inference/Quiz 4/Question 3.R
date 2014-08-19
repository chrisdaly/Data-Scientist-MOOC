# Researchers conducted a blind taste test of Coke versus Pepsi. 
# Each of four people was asked which of two blinded drinks given in random order that they preferred. 
# The data was such that 3 of the 4 people chose Coke. Assuming that this sample is representative, 
# report a P-value for a test of the hypothesis that Coke is preferred to Pepsi using a one sided exact test.

# note: "alternative = two.sided" would account for the alternative hypothesis that pepsi is prefered to coke too
# therefore specify greater
binom.test(c(3, 1), p = 0.5, alternative = "greater")
