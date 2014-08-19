library(caret)
library(AppliedPredictiveModeling)
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

IL_variables <- grep("^IL", names(training), value = TRUE)
preProc <- preProcess(training[, IL_variables], method = "pca", thresh = 0.9)
preProc

# Answer: 7
