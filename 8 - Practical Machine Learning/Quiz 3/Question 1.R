library(AppliedPredictiveModeling)
data(segmentationOriginal)
library(caret)
library(rpart)
install.packages(rattle)

set.seed(125)

# 1. Subset the data to a training set and testing set based on the Case variable in the data set.

inTrain <- createDataPartition(y = segmentationOriginal$Case, list = FALSE)
train <- subset(segmentationOriginal, Case == "Train")
test <- subset(segmentationOriginal, Case == "Test")

# 2. Set the seed to 125 and fit a CART model with the rpart method using all 
# predictor variables and default caret settings. 

modFit <- train(Class ~ ., data = train, method = "rpart")
modFit$finalModel

# 3. In the final model what would be the final model prediction for cases with the following variable values:

# Look at the output
# a. TotalIntench2 = 23,000; FiberWidthCh1 = 10; PerimStatusCh1=2       PS
# b. TotalIntench2 = 50,000; FiberWidthCh1 = 10;VarIntenCh4 = 100       WS
# c. TotalIntench2 = 57,000; FiberWidthCh1 = 8;VarIntenCh4 = 100        PS  
# d. FiberWidthCh1 = 8;VarIntenCh4 = 100; PerimStatusCh1=2              Not possible to predict


plot(modFit$finalModel, uniform = TRUE, main = "Classification Tree")
text(modFit$finalModel, use.n = TRUE, all = TRUE, cex = .8)

fancyRpartPlot(modFit$finalModel)
fancyRpartPlot(modFit)


predict(modFit, newdata = train)