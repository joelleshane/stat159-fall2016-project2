credit <- read.csv("../../data/cred_f.csv")

ols <- lm(Balance ~ Income + Limit + Rating + Cards + Age + Education + GenderFemale + StudentYes + MarriedYes + EthnicityAsian, data = as.data.frame(cred_f))

summary(ols)