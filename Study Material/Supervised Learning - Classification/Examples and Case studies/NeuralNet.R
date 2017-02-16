attach(infert)
library(neuralnet)
neuralnet <- neuralnet(case ~ age + parity + induced + spontaneous, data=infert, 
                       hidden=3, err.fct="sse", linear.output=FALSE)
neuralnet$result.matrix
plot(neuralnet)

#Export dataset
data(infert)
write.csv(infert,"infert.csv")


