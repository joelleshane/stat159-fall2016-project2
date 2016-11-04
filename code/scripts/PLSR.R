##########################
# PLSR
##########################


library(pls)


#run model with training data
test <- read.csv("../../data/test.csv")
test <- test[,-1]
train <- read.csv("../../data/train.csv")
train <- train[,-1]

plsr_model <- plsr(as.matrix(train[,12])~as.matrix(train[,-12]), validation="CV")
best_plsr <-which(plsr_model$validation$PRESS == min(plsr_model$validation$PRESS))

save(plsr_model, best_plsr, file="../../data/plsr.RData")

sink("../../data/plsr.txt")
plsr_model
best_plsr
sink()

png("../../images/plsr.png")
validationplot(plsr_model, val.type="MSEP", main = "PLSR Model - Cross Validation MSE")
dev.off()


plsr_pred <- predict(plsr_model, ncomp = best_plsr,  newdata =as.matrix(test[,-12]), s = "validation$PRESS", type = "response")

save(plsr_pred, file="../../data/plsr-pred.RData")


source("../../functions/mean-squared.R")

MSE_plsr <- Mean_squared_error(test[,12], plsr_pred)

cat("PLSR:", MSE_plsr, "\n", file="../../data/mse.RData", append=TRUE)

cred_f <- read.csv("../../data/cred_f.csv")

final_plsr <- plsr(as.matrix(cred_f[,14]) ~ as.matrix(cred_f[,c(-1, -2, -14)]) , ncomp=best_plsr)

save(final_plsr, file="../../data/final-plsr.RData")

coef_plsr <- coef(final_plsr)

sink("../../data/final-plsr.txt")
coef_plsr
sink()

