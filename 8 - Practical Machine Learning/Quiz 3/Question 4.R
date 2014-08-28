library(ElemStatLearn)
data(SAheart)
set.seed(8484)
train = sample(1:dim(SAheart)[1],size=dim(SAheart)[1]/2,replace=F)
trainSA = SAheart[train,]
testSA = SAheart[-train,]

set.seed(13234)

#Then set the seed to 13234 and fit a logistic regression model (method="glm", 
# be sure to specify family="binomial") with Coronary Heart Disease (chd) as the 
# outcome and age at onset, current alcohol consumption, obesity levels, 
# cumulative tabacco, type-A behavior, and low density lipoprotein cholesterol 
# as predictors. Calculate the misclassification rate for your model using this 
# function and a prediction on the "response" scale:

model <- train(chd ~ age + alcohol + obesity + tobacco + typea + ldl, 
               data = trainSA, method = "glm", family = "binomial")

missClass = function(values,prediction){sum(((prediction > 0.5)*1) != values)/length(values)}

missClass(testSA$chd, predict(model, newdata = testSA))
missClass(trainSA$chd, predict(model, newdata = trainSA))

