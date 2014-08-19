n <- 18
mn_treated <- -3; mn_placebo <- 1
s_treated <- 1.5; s_placebo <- 1.8
n_x <- 9; n_y <- 9

# calucate the df for unequal variances
s_x <- s_treated; s_y <- s_placebo

df_num <- ((s_x^2/n_x) + (s_y^2/n_y))^2
df_denom <- ((s_x^2/n_x)^2/(n_x-1) + (s_y^2/n_y)^2/(n_y-1))

df <- df_num/df_denom

# calculate the pooled variance
sp <- sqrt(((n_x-1) * s_treated^2 + (n_y-1) * s_placebo^2) / (n_x + n_y - 2))

# calculate the confidence interval interval
(mn_treated - mn_placebo) + c(-1, 1) * qt(0.95, df) * sp * sqrt(1/n_x + 1/n_y)