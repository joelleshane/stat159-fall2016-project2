# Downloading the data and fixing the variables to factor form when applicable for the models.

credit <- read.csv("http://www-bcf.usc.edu/~gareth/ISL/Credit.csv")
temp_credit <- model.matrix(Balance ~ ., data = credit)
new_credit <- cbind(temp_credit[,-1], Balance = credit$Balance)

scaled_credit <- scale(new_credit, center= TRUE, scale= TRUE)
write.csv(new_credit, file = "../../data/cred_f.csv")
