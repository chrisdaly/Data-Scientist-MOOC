library(AppliedPredictiveModeling)
library(caret)
data(AlzheimerDisease)


adData = data.frame(diagnosis,predictors)
testIndex = createDataPartition(diagnosis, p = 0.50,list=FALSE)
training = adData[-testIndex,]
testing = adData[testIndex,]

