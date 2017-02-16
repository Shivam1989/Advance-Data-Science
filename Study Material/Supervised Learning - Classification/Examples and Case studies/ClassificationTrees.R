library (ISLR)
attach (Carseats)
#Transform Sales variable to a binary variable
High = ifelse (Sales >8, "Yes ", " No ")
Carseats = data.frame(Carseats ,High)
head(Carseats)

#Use all other variables except Sales to fit a classification tree
library(tree)
tree = tree(High ~ . - Sales, Carseats)
summary(tree)

#Display the tree structure and node labels
plot(tree)
text(tree, pretty =0) #Pretty=0 includes the category names

#Split the dataset into a training set and a test set
set.seed (2)
train = sample (1: nrow(Carseats), 200)
Carseats.test = Carseats [-train,]
High.test = High[-train]
#Build the tree based on the training set
tree.train = tree(High ~ . - Sales, Carseats, subset = train)
#Evaluate its performance on the test data
tree.pred = predict(tree.train, Carseats.test, type = "class")
table(tree.pred, High.test)

#Determine the optimal level
set.seed (3)
#FUN = prune.misclass indicate that classification error rate is used to 
#guide the cross-validation and pruning process
cv.carseats = cv.tree(tree, FUN = prune.misclass)
names(cv.carseats)
cv.carseats

#Prune the tree
prune.carseats = prune.misclass(tree, best =9)
plot(prune.carseats)
text(prune.carseats, pretty =0)

#The pruned tree performance
prune.pred = predict(prune.carseats, Carseats.test, type = "class")
table(prune.pred, High.test)

#Export dataset
data(Carseats, package="ISLR")
write.csv(Carseats,"Carseats.csv")

