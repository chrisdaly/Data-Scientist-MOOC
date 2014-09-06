set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

# Set the seed to 233 and fit a lasso model to predict Compressive Strength. 
# Which variable is the last coefficient to be set to zero as the penalty increases? 
# (Hint: it may be useful to look up ?plot.enet).
library(caret)

set.seed(233)


fit <- train(CompressiveStrength ~ ., data = training, method = "lasso")

# Since we are interested in the shrinkage of coefficients as the penalty(lambda) increases, "
# penalty" looks promising for an xvar argument value.
plot.enet(fit$finalModel, xvar = "penalty", use.color = TRUE)
