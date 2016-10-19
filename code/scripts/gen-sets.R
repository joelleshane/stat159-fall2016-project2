# Generate sets of test and train data

credit <- read.csv("../../data/cred_f.csv")
set.seed(1738)
train_indicies <- sample(1:400, 300)
train <- cred_f[train_indicies,]
test <- cred_f[-train_indicies,]

save(train, test, file = "../../data/test-sets.RData")
