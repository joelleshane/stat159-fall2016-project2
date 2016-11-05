cred_f <- read.csv("../../data/cred_f.csv")

load("../../data/test-sets.RData")
test <- read.csv("../../data/test.csv")
train <- read.csv("../../data/train.csv")
test <- test[,-1]
test_balance <- as.matrix(test[,12])
test_data <- as.matrix(test[,-12])

library(glmnet)
library(pls)
library("glmnet")
library("pls")
set.seed(17)
pcr <- pcr(test_balance ~ test_data, validation = "CV")

best_pcr <- pcr$validation$PRESS
a <- coef(pcr)

save(a, best_pcr, file = "../../data/pcr.RData")

sink("../../data/pcr.txt")
pcr
best_pcr
sink()

png("../../images/pcr.png")
validationplot(pcr, val.type = "MSEP", main = "PCR Model")
dev.off()

#Testing best model
 
pcr_pred <- predict(pcr, newdata = test_data, s = "validation$PRESS", type = "res")

## MSE of PCR

source("../functions/mean_squared.R")
mse_pcr <- Mean_squared_error(test_balance, pcr_pred)
save(mse_pcr, file = "../../data/mse-pcr.txt")

#fitting full data

cred_f <- cred_f[,-1]
y <- cred_f[,13]
x <- cred_f[,-13]
a <- as.matrix(cred_f)
b <- a[,13]
c <- a[,c(-1,-2,-13)]

final_pcr <- pcr(b ~ c)
j <- coef(final_pcr)
save(j, file = "../../data/full_data_ridge.RData")

sink("../../data/final-pcr.txt")
coef(final_pcr)
sink()