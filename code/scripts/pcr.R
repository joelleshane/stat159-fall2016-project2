credit <- read.csv("../../data/cred_f.csv")

load("../../data/test-sets.RData")

library(glmnet)
library(pls)
library("glmnet"")
library("pls"")
set.seed(17)
pcr <- pcr(test_data ~ test_balance, validation = "CV")

best_pcr <- pcr$validation$PRESS
plot(ridge)

save(coef(pcr), best_pcr, file = "../../data/pcr.RData")

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

source("../../functions/mean_squared.R")
mse_pcr <- Mean_squared_error(test_data$Balance, pcr_pred)

#fitting full data

y <- cred_f[,13]
x <- cred_f[,-13]
a <- as.matrix(cred_f)
b <- a[,13]
c <- a[,c(-1,-2,-13)]

final_pcr <- pcr(b ~ c)

save(coef(final_pcr), file = "../../data/full_data_ridge.RData")

sink("../../data/final-pcr.txt")
coef(final_pcr)
sink()

cat(“PCR:”, mse_pcr, “\n”, file = "../../data/mse.RData", append = TRUE)