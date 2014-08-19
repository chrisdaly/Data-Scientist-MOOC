# A pharmaceutical company is interested in testing a potential blood pressure lowering medication. 
# Their first examination considers only subjects that received the medication at baseline then two weeks later. 
# The data are as follows (SBP in mmHg)

baseline <- c(140, 138, 150, 148, 135)
week2 <- c(132, 135, 151, 146, 130)
results <- data.frame(baseline, week2)

# Consider testing the hypothesis that there was a mean reduction in blood pressure? 
# Give the P-value for the associated two sided test.

t.test(x = results$baseline, y = results$week2, alternative = "two.sided", paired = TRUE)
