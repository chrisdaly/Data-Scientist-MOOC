n <- 9
mn <- 1100
s <- 30


# 95% confidence means 5% remaning in both tails
# i.e. .025 in each
mn + c(-1, 1) * qt(.975, n-1) * s / sqrt(n)
