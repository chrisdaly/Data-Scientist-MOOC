# Infection rates at a hospital above 1 infection per 100 person days at risk are believed to be too high and are used as a benchmark. 
# A hospital that had previously been above the benchmark recently had 10 infections over the last 1,787 person days at risk. 
# About what is the one sided P-value for the relevant test of whether the hospital is *below* the standard?


# get probabilites per day
p1 <- 1/100
p2 <- 10/1787
n <- 1787

#s <- sqrt((p1 * (1 - p1)/n))

#ppois(p2, 1, lower.tail = TRUE)

# When the population size is much larger (at least 10 times larger) than the sample size, the standard deviation can be approximated by:
# ??p = sqrt[ P * ( 1 - P ) / n ] where n is the sample size
s <- sqrt((p1 * (1 - p1) / n))

# get the releveant quantile(lower) expressed in standard deviations
test_z = (p1 - p2) / s

pnorm(test_z, lower.tail = FALSE)