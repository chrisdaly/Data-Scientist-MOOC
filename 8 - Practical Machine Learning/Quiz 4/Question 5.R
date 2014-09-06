set.seed(3523)
library(AppliedPredictiveModeling)
data(concrete)
inTrain = createDataPartition(concrete$CompressiveStrength, p = 3/4)[[1]]
training = concrete[ inTrain,]
testing = concrete[-inTrain,]

# Set the seed to 325 and fit a support vector machine using the e1071 package 
# to predict Compressive Strength using the default settings. Predict on the 
# testing set. What is the RMSE?

set.seed(325)

library(e1071)
library(caret)

fit <- train(CompressiveStrength ~ ., data = training, method = "svmRadial")

prediction <- predict(fit, testing)

accuracy(prediction, testing$CompressiveStrength)
