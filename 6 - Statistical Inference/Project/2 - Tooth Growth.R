library(ggplot2)

data(ToothGrowth)

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

# compare dosages




  # create a new tidy DF with the average of each variable for each activity 
  # & subject
  DF_tidy <- aggregate(DF_new, list(DF_new$participant, DF_new$activity), mean)