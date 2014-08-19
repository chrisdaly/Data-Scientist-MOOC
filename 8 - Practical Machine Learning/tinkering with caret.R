library(caret)
library(kernlab)
data(spam)

# create a parition such that the first 75% is the train set
inTrain <- createDataPartition(spam$type, p = 0.75, list = FALSE)
training <- spam[inTrain, ]
testing <- spam[-inTrain, ]

dim(training)

set.seed(32343)

# create a general linear model to fit the training data for the spam type, 
# with everything as predictors
modelFit <- train(type ~ ., data = training, method = "glm")
modelFit$finalModel

# use the model to predict the testing data
predictions <- predict(modelFit, newdata = testing)

# confusion matrix comparing predictions vs actual outcomes
confusionMatrix(predictions, testing$type)
