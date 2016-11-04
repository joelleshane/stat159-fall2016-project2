credit <- read.csv("../../data/cred_f.csv")

load("../../data/test-sets.RData")
cred_f <- read.csv("../../data/cred_f.csv")
load("../../data/test-sets.RData")
test <- read.csv("../../data/test.csv")
train <- read.csv("../../data/train.csv")
test <- test[,-1]
train <- train[,-1]
test_balance <- as.matrix(test[,12])

library(glmnet)
set.seed(173)
grid <- 10^seq(10, -2, length = 100)
ridge <- cv.glmnet(as.matrix(train[,-12]), train[,12], intercept = FALSE, standardize = FALSE, lambda = grid, alpha = 0)


ridge_best_lambda <- ridge$lambda.min

save(ridge, ridge_best_lambda, file = "../../data/ridge.RData")

png("../../images/Ridge.png")
plot(ridge, main = "Ridge Model - Cross Validation MSE")
dev.off()

ridge_pred <- predict(ridge, newx = as.matrix(test_data[,-12]), s = "lambda.min", type = "res")
save(ridge_pred, file = "../../data/ridge_pred.RData")

sink("../../data/ridge.txt")
coef(ridge)
ridge_best_lambda
sink()

# MSE of Ridge

source("../functions/mean_squared.R")
mse_ridge <- Mean_squared_error(test_balance, ridge_pred)


# Fitting the data to the full data

cred_f <- cred_f[,-1]
y <- as.matrix(cred_f[,13])
x <- as.matrix(cred_f[,c(-1-13)])

final_ridge <- glmnet(x, y, intercept = FALSE, standardize = FALSE, lambda = ridge$lambda.min, alpha = 0)

a <- coef(final_ridge)
save(a, file = "../../data/full_data_ridge.RData")
