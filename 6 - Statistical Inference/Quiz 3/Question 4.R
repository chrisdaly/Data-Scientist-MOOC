n <- 20
mn_new <- 3; mn_old <- 5
var_new <- 0.6; var_old <- 0.68

sp <- sqrt((9 * var_new  + 9 * var_old) / (10 + 10 - 2))

(mn_new - mn_old) + c(-1, 1) * qt(0.975, n - 2) * sp * sqrt(1/10 + 1/10)
