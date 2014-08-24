library(ggplot2)

# data(ToothGrowth)

summary(ToothGrowth)

dose <- ToothGrowth$dose
supp <- ToothGrowth$supp
len <- ToothGrowth$len

# Load the ToothGrowth data and perform some basic exploratory data analyses 
# Provide a basic summary of the data.
# Use confidence intervals and hypothesis tests to compare tooth growth by supp and dose. (Use the techniques from class even if there's other approaches worth considering)
# State your conclusions and the assumptions needed for your conclusions.
par(mfrow = c(1,2))

p1 <- ggplot(ToothGrowth, aes(x = factor(dose), y = len, fill = factor(dose))) 
p1 + geom_boxplot() + guides(fill=FALSE) + facet_grid(. ~ supp)

p2 <- ggplot(ToothGrowth, aes(x = factor(supp), y = len, fill = factor(supp))) 
p2 + geom_boxplot() + guides(fill=FALSE) + facet_grid(. ~ dose)

# calculate the mean and sd of each dosage and supplement
dosages_means <- aggregate(ToothGrowth$len, by = list(ToothGrowth$dose), FUN = mean)
dosages_sds <- aggregate(ToothGrowth$len, by = list(ToothGrowth$dose), FUN = sd)
  
Supplements_means <- aggregate(ToothGrowth$len, by = list(ToothGrowth$supp), FUN = mean)
Supplements_sds <- aggregate(ToothGrowth$len, by = list(ToothGrowth$supp), FUN = sd)

# split the data up by dosages
d0.5 <- subset(ToothGrowth, dose == 0.5)
d1.0 <- subset(ToothGrowth, dose == 1.0)
d2.0 <- subset(ToothGrowth, dose == 2.0)

# conduct a t test between supplements
test0.5 <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = d0.5)
test0.5$p.value; test0.5$conf

test1.0 <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = d1.0)
test1.0$p.value; test1.0$conf

test2.0 <- t.test(len ~ supp, paired = FALSE, var.equal = FALSE, data = d2.0)
test2.0$p.value; test2.0$conf



