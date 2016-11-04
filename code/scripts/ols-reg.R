credit <- read.csv("../../data/cred_f.csv")

# OLS

ols <- lm(Balance ~ Income + Limit + Rating + Cards + Age + Education + GenderFemale + StudentYes + MarriedYes + EthnicityAsian, data = as.data.frame(cred_f))

summary(ols)

sink("../../data/OLS.txt")
summary(ols)
sink()

save(coef(ols), file = "../../data/OLS.RData")

load("../../data/test-sets.RData")
test_balance <- as.data.frame(test)[,13]
test_data <- as.data.frame(test[,-1])

ols_pred <- predict(ols, newdata = test_data, se.fit = FALSE, type = "res")
save(old_pred, file = "../../data/ols_pred.RData")

source("../../functions/mean_squared.R")

mse_ols <- Mean_squared_error(test_data$Balance, ols_pred) 
cat(“OLS:”, mse_ols, “\n”, file = "../../data/mse.RData", append = TRUE)

sink("../../data/ols.txt")
summary(ols)
ols_mse
sink()