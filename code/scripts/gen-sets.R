# Generate sets of test and train data

cred_f <- read.csv("../../data/cred_f.csv")
set.seed(1738)
train_indicies <- sample(1:400, 300)
train <- cred_f[train_indicies,]
train_data <- as.matrix(train[,c(-1,-2)])
test <- cred_f[-train_indicies,]
test_balance <- as.matrix(test)[,13]
<<<<<<< HEAD
test_data <- as.matrix(test[,-1])
=======
test_data <- as.matrix(test[,c(-1,-2)])

write.csv(train_data, file="../../data/train.csv")
write.csv(test_data, file="../../data/test.csv")
>>>>>>> 1092c19d2ab8ce4146953080897f8ce216818458

save(train, test, test_balance, test_data, file = "../../data/test-sets.RData")
