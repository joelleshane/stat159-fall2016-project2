credit <- read.csv("../../data/cred_f.csv")
quan_credit <- credit[,2:7]

b <- aov(Balance ~ Income + Limit + Rating + Cards + Age + Education, data = credit)

sums <- c(summary(quan_credit$Income), summary(quan_credit$Limit), summary(quan_credit$Rating), summary(quan_credit$Cards), summary(quan_credit$Age), summary(quan_credit$Education))

sums <- array(sums, dim = c(6,6,1))

labels <- (c("Income", "Limit", "Rating", "Cards", "Age", "Education"))
dimnames(sums)[[2]] <- labels
dimnames(sums)[[1]] <- c("Min", "1st Quantile", "Median", "Mean", "3rd Quantile", "Max")

sds <- c()
for (i in 1:ncol(quan_credit)){
sds[i] <- sd(quan_credit[[i]]) 
}

png(file = "../../images/histogram-income.png")
hist(credit$Income, main = "Histogram of Income", xlab = "Income")
dev.off()

png(file = "../../images/histogram-limit.png")
hist(credit$Limit, main = "Histogram of Limit", xlab = "Limit")
dev.off()

png(file = "../../images/histogram-rating.png")
hist(credit$Rating, main = "Histogram of Rating", xlab = "Rating")
dev.off()

png(file = "../../images/histogram-cards.png")
hist(credit$Cards, main = "Histogram of Cards", xlab = "Cards")
dev.off()

png(file = "../../images/histogram-age.png")
hist(credit$Age, main = "Histogram of Age", xlab = "Age")
dev.off()

png(file = "../../images/histogram-education.png")
hist(credit$Education, main = "Histogram of Education", xlab = "Education")
dev.off()

png(file = "../../images/boxplot-income.png")
boxplot(credit$Income, main = "Boxplot of Income", xlab = "Income")
dev.off()

png(file = "../../images/boxplot-limit.png")
boxplot(credit$Limit, main = "Boxplot of Limit", xlab = "Limit")
dev.off()

png(file = "../../images/boxplot-rating.png")
boxplot(credit$Rating, main = "Boxplot of Rating", xlab = "Rating")
dev.off()

png(file = "../../images/boxplot-cards.png")
boxplot(credit$Cards, main = "Boxplot of Cards", xlab = "Cards")
dev.off()

png(file = "../../images/boxplot-age.png")
boxplot(credit$Age, main = "Boxplot of Age", xlab = "Age")
dev.off()

png(file = "../../images/boxplot-education.png")
boxplot(credit$Education, main = "Boxplot of Education", xlab = "Education")
dev.off()

png(file = "../../images/boxplot-income.png")
boxplot(credit$Income, main = "Boxplot of Income", xlab = "Income")
dev.off()

a <- cor(quan_credit)

qual_credit <- credit[,c(8:11)]

library("plyr")
gender <- count(qual_credit[,1])
gender_freq <- gender$freq / sum(gender$freq)

student <- count(qual_credit[,2])
student_freq <- student$freq / sum(student$freq)
married <- count(qual_credit[,3])
married_freq <- married$freq / sum(married$freq)
race <- count(qual_credit[,4])
race_freq <- race$freq / sum(race$freq)

png("../../images/barplot-gender.png")
barplot(gender_freq, names.arg = c("male", "female"))
dev.off()

png("../../images/barplot-student.png")
barplot(student_freq, names.arg = c("Not Student", "Student"))
dev.off()

png("../../images/barplot-married.png")
barplot(married_freq, names.arg = c("Unmarried", "Married"))
dev.off()

png("../../images/barplot-race.png")
barplot(race_freq, names.arg = c("African-American", "Caucasian", "Asain"))
dev.off()


sink(file = "../../data/eda-output.txt")
sums
a
b
gender_freq
race_freq
student_freq
married_freq
sink()