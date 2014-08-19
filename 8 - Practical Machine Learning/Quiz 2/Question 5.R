library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

set.seed(3433)

## grep the predictors starting with 'IL'
IL_str <- grep("^IL", colnames(training), value = TRUE)

## make a subset of these predictors
predictors_IL <- predictors[, IL_str]

# create a new DF of predictors and diagnosis
df <- data.frame(diagnosis, predictors_IL)

# create a training and testing set from this DF
inTrain = createDataPartition(df$diagnosis, p = 3/4)[[1]]
training = df[inTrain, ]
testing = df[-inTrain, ]

## train the data using the first method
modelFit <- train(diagnosis ~ ., method = "glm", data = training)


predictions <- predict(modelFit, newdata = testing)

## get the confusion matrix for the first method
C1 <- confusionMatrix(predictions, testing$diagnosis)
print(C1)


A1 <- C1$overall[1]

## do similar steps with PCA
modelFit <- train(training$diagnosis ~ ., method = "glm", data = training,
                  preProcess = "pca", 
                  Control = trainControl(preProcOptions = list(thresh = 0.8)))

C2 <- confusionMatrix(testing$diagnosis, predict(modelFit, testing))
print(C2)

