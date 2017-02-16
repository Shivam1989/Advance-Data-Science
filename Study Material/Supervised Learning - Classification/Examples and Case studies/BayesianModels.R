data(Affairs, package="AER")
# Transform affairs into a dichotomous factor
Affairs$ynaffair[Affairs$affairs > 0] <- 1
Affairs$ynaffair[Affairs$affairs == 0] <- 0
Affairs$ynaffair <- factor(Affairs$ynaffair,
                           levels=c(0,1),
                           labels=c("No","Yes"))

# Split the data into training and test
smp_size = floor(0.7 * nrow(Affairs))
set.seed(123)
train_ind = sample(seq_len(nrow(Affairs)), size = smp_size)
train = Affairs[train_ind, ]
test = Affairs[-train_ind, ]


# Bayesian logistic regression model using brms 
library (brms)
fit1 <- brm(ynaffair ~ age + yearsmarried + religiousness + rating,
            data=train, family="bernoulli")
summary(fit1)
# Make predcitions on test data
predictions = predict(fit1, test)
pred = rep("No",length(predictions[,'Estimate']))
# Set the cutoff value =0.5
pred[predictions[,'Estimate']>=0.5] = "Yes"
# Classification matrix
library(caret)
confusionMatrix(test$ynaffair, pred)


# Bayesian logistic regression model using rstanarm
library(rstanarm)
fit2 <- stan_glm(ynaffair ~ age + yearsmarried + religiousness + rating,
                 data=Affairs, family=binomial(link = "logit"))
summary(fit2)


