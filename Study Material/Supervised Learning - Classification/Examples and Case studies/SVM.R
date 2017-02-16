library (ISLR)
names(Khan)
dim(Khan$xtrain)
dim(Khan$xtest)
length(Khan$ytrain)
length(Khan$ytest)

#Predict cancer subtype
library (e1071)
data = data.frame( x = Khan$xtrain, y = as.factor(Khan$ytrain))
svm = svm(y ~., data=data, kernel = "linear", cost = 10)
summary(svm)

table(svm$fitted, data$y)

#Support vector classifier's performance on the test observations
data.test = data.frame(x = Khan$xtest, y = as.factor(Khan$ytest))
pred = predict(svm, newdata = data.test)
table(pred, data.test$y)

#Export dataset
data(Khan, package="ISLR")
write.csv(Khan$xtrain,"Khan_xtrain.csv")
write.csv(Khan$xtest,"Khan_xtest.csv")
write.csv(Khan$ytrain,"Khan_ytrain.csv")
write.csv(Khan$ytest,"Khan_ytest.csv")