library(caret)
library(gbm)
set.seed(3433)
library(AppliedPredictiveModeling)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

# Set the seed to 62433 and predict diagnosis with all the other variables using 
# a random forest ("rf"), boosted trees ("gbm") and linear discriminant analysis 
# ("lda") model. Stack the predictions together using random forests ("rf"). 
# What is the resulting accuracy on the test set? Is it better or worse than 
# each of the individual predictions?

set.seed(62433)

# create models
fit1 <- train(diagnosis ~ ., data = training, method = "rf", trControl = trainControl(number = 4))
fit2 <- train(diagnosis ~ ., data = training, method = "gbm")
fit3 <- train(diagnosis ~ ., data = training, method = "lda")

# predict test
predict1 <- predict(fit1, newdata = testing)
predict2 <- predict(fit2, newdata = testing)
predict3 <- predict(fit3, newdata = testing)

# combine predictions
DF_combined <- data.frame(predict1, predict2, predict3, diagnosis = testing$diagnosis) # training$diagnosis?
fit_combined <- train(diagnosis ~ ., data = DF_combined, method = "rf")
predict4 <- predict(fit_combined, newdata = testing)

# confusion matrixes
c1 <- confusionMatrix(predict1, testing$diagnosis)
c2 <- confusionMatrix(predict2, testing$diagnosis)
c3 <- confusionMatrix(predict3, testing$diagnosis)
c4 <- confusionMatrix(predict4, testing$diagnosis)

print(paste(c1$overall[1], c2$overall[1], c3$overall[1], c4$overall[1]))

