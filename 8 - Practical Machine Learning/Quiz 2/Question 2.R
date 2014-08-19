library(AppliedPredictiveModeling)
data(concrete)
library(caret)
library(Hmisc)

set.seed(975)

inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]


splitOn <- cut2(training$Age, g = 4)

splitOn <- mapvalues(splitOn, 
                    from = levels(factor(splitOn)), 
                    to = c("red", "blue", "yellow", "green"))


# automatically includes index of samples
plot(training$CompressiveStrength, col = splitOn)

# Answer: There is a step-like pattern in the plot of outcome versus index in 
# the training set that isn't explained by any of the predictor variables so 
# there may be a variable missing.