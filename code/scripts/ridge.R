credit <- read.csv("../../data/cred_f.csv")

load("../../data/test-sets.RData")

library(glmnet)
set.seed(173)
grid <- 10^seq(10, -2, length = 100)
ridge <- cv.glmnet(as.matrix(train[,-13]), train[,13], intercept = FALSE, standardize = FALSE, lambda = grid, alpha = 0)


ridge_best_lambda <- ridge$lambda.min

save(ridge, ridge_best_lambda, file = "../../data/ridge.RData")

png("../../images/Ridge.png")
plot(ridge, main = "Ridge Model - Cross Validation MSE")
dev.off()

ridge_pred <- predict(ridge, newx = as.matrix(test_data), s = "lambda.min", type = "res")
save(ridge_pred, file = "../../data/ridge_pred.RData")

sink("../../data/ridge.txt")
coef(ridge)
ridge_best_lambda
sink()

# MSE of Ridge

source("../../functions/mean_squared.R")
mse_ridge <- Mean_squared_error(test_data$Balance, ridge_pred)

cat(“Ridge:”, mse_ridge, “\n”, file = "../../data/mse.RData", append = TRUE)

# Fitting the data to the full data

y <- cred_f[,13]
x <- cred_f[,-13]

final_ridge <- glmnet(x, y, intercept = FALSE, standardize = FALSE, lambda = ridge$lambda.min, alpha = 0)

save(coef(final_ridge), file = "../../data/full_data_ridge.RData")
