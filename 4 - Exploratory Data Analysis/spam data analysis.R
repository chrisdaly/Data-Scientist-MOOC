library(kernlab)

#  load cleaned data set
data(spam)
str(spam[, 1:5])

# perform subsampling
set.seed(3435)
trainIndicator = rbinom(4601, size = 1, prob = 0.5)
table(trainIndicator)

# use part of data for model and the other part for prediction
trainSpam = spam[trainIndicator == 1, ]
testSpam = spam[trainIndicator == 0, ]

# explore data
names(trainSpam)
table(trainSpam$type)

# exploratory plots
# capitalAve = average number of capital letters
plot(trainSpam$capitalAve ~ trainSpam$type)

plot(log10(trainSpam$capitalAve + 1) ~ trainSpam$type)

# see what words cluster together (note: senstitive to skewness in 
# distribution of individual variables)
hCluster = hclust(dist(t(trainSpam[, 1:57])))
plot(hCluster)

# redo clustering algorthim after a transformation of the predictor space
hClusterUpdated = hclust(dist(t(log10(trainSpam[, 1:55] + 1))))
plot(hClusterUpdated)

trainSpam$numType = as.numeric(trainSpam$type) - 1
costFunction = function(x, y) sum(x != (y > 0.5))
cvError = rep(NA, 55)

library(boot)

for (i in 1:55){
  # try to fit a general model (logistic regression model) using just 1 variable
  lmFormula = reformulate(names(trainSpam)[i], response = "numType")
  glmFit = glm(lmFormula, family = "binomial", data = trainSpam)
  cvError[i] = cv.glm(trainSpam, glmFit, costFunction, 2)$delta[2]
}

# error with the minim cross-validated error
names(trainSpam)[which.min(cvError)]

# use the best model from the group
predictionModel = glm(numType ~ charDollar, family = "binomial", data = trainSpam)

# get predictions on the test set
predictionTest = predict(predictionModel, testSpam)
predictedSpam = rep("nonspam", dim(testSpam)[1])

# classify as "spam" for those with prob > 0.5
predictedSpam[predictionModel$fitted > 0.5] = "spam"

# classifictation table - diagonal elements are discrepancies
table(predictedSpam, testSpam$type)

# error rate
( 61 + 458)/(1346 + 458 + 449)
