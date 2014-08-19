library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

ggplot(data = training, aes(x = Superplasticizer)) + geom_histogram() + theme_bw()

# Answer: The log transform does not reduce the skewness of the non-zero values of SuperPlasticizer