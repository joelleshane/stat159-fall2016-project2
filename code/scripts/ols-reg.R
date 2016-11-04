credit <- read.csv("../../data/cred_f.csv")

ols <- lm(Balance ~ Income + Limit + Rating + Cards + Age + Education + GenderFemale + StudentYes + MarriedYes + EthnicityAsian, data = as.data.frame(cred_f))

summary(ols)
OLS <- coef(ols)
save(OLS, file = "../../data/OLS.RData")

load("../../data/test-sets.RData")
test_balance <- as.data.frame(test)[,13]
test_data <- as.data.frame(test[,c(-1,-13)])
predict(ols, newdata = test_data, type = "response")

Mean Squared Error 