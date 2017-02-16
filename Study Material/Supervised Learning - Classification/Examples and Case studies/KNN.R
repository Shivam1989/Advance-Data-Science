#look up the structure of the dataset#
data("iris")
str(iris)
head(iris)
table(iris$Species)

#Mix up dataset#
set.seed(9850)
group<- runif(nrow(iris))
iris<- iris[order(group),]
summary(iris[, c(1,2,3,4)])

#Normalization#
normalize<-function(x)(return((x-min(x))/(max(x)-min(x))))
iris_n<-as.data.frame(lapply(iris[,c(1,2,3,4)],normalize))
summary(iris_n)

#Separate training&testing dataset
iris_train<-iris_n[1:129, ]
iris_test<-iris_n[130:150, ]
iris_train_target<-iris[1:129,5]
iris_test_target<-iris[130:150,5]

# fit in knn algorithm
require(class)
m1<- knn(train= iris_train, test= iris_test, cl=iris_train_target, k=13)

#result and comparison 
table(iris_test_target,m1)
