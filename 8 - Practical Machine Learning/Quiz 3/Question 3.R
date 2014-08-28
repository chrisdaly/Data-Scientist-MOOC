library(caret)
library(pgmm)
data(olive)
olive = olive[,-1]
library(randomForest)

#Fit a classification tree where Area is the outcome variable. 
# Then predict the value of area for the following data frame using the tree command with all defaults

model <- train(Area ~ ., data = olive, method = "rpart2")

newdata = as.data.frame(t(colMeans(olive)))

predict(model, newdata = newdata)

# 2.875. It is strange because Area should be a qualitative variable - but tree 
# is reporting the average value of Area as a numeric variable in the leaf predicted for newdata