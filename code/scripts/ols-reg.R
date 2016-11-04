cred_f <- read.csv("../../data/cred_f.csv")
cred_f <- cred_f[-1]

# OLS

ols <- lm(Balance ~ Income + Limit + Rating + Cards + Age + Education + GenderFemale + StudentYes + MarriedYes + EthnicityAsian, data = as.data.frame(cred_f))

summary(ols)

sink("../../data/OLS.txt")
summary(ols)
sink()
a <- coef(ols)
save(a, file = "../../data/OLS.RData")

load("../../data/test-sets.RData")
test_balance <- as.data.frame(test)[,13]
test_data <- as.data.frame(test[,-1])

ols_pred <- predict(ols, newdata = test_data, se.fit = FALSE, type = "res")
save(ols_pred, file = "../../data/ols_pred.RData")

source("../functions/mean_squared.R")

mse_ols <- Mean_squared_error(test_data$Balance, ols_pred) 

sink("../../data/ols.txt")
summary(ols)
mse_ols
sink()