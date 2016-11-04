##########################
# LASSO REGRESSION
##########################


#load in train and test set

test <- read.csv("../../data/test.csv")
test <- test[,-1]
train <- read.csv("../../data/train.csv")
train <- train[,-1]


#load in the package for the regression
library(glmnet)


grid <- 10^seq(10, -2, length = 100)
set.seed(4815)

#alpha = 1 means its a lasso
lasso <- cv.glmnet(as.matrix(train[,-12]),y=train[,12],alpha=1,
                   intercept=FALSE, standardize=FALSE, lambda=grid)

lasso_best_lambda <- lasso$lambda.min


save(lasso, lasso_best_lambda, file="../../data/lasso.RData")


sink("../../data/lasso.txt")
lasso
lasso_best_lambda
sink()


png("../../images/Lasso.png")
plot(lasso, main = "Lasso Model - Cross Validation MSE")
dev.off()

load("../../data/test-sets.RData")

newx <- as.matrix(test_data[,-12])

lasso_pred <- predict(lasso, newx=newx, s= "lambda.min", type="response")
save(lasso_pred, file="../../data/lasso_pred.RData")

source("../../functions/mean-squared.R")

MSE_lasso <- Mean_squared_error(test_data[12],lasso_pred)

cat("Lasso:", MSE_lasso, "\n", file="../../data/mse.RData", append=TRUE)

cred_f <- read.csv("../../data/cred_f.csv")

final_lasso <- glmnet(x=as.matrix(cred_f[,c(-1, -2, -14)]), y=as.matrix(cred_f[,14]), intercept = FALSE, standardize = FALSE, lambda=lasso$lambda.min, alpha=1)

save(final_lasso, file="../../data/final_lasso.RData")

coef_l <- coef(final_lasso)

sink("../../data/final_lasso.txt")
coef_l
sink()

