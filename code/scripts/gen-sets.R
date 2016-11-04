# Generate sets of test and train data

credit <- read.csv("../../data/cred_f.csv")
set.seed(1738)
train_indicies <- sample(1:400, 300)
train <- cred_f[train_indicies,]
test <- cred_f[-train_indicies,]
test_balance <- as.matrix(test)[,13]
test_data <- as.matrix(test[,-1])

save(train, test, test_balance, test_data, file = "../../data/test-sets.RData")
