Mean_squared_error <- function(actual, predicted){
y = c()
for (i in 1:length(actual)) {
y[i] = (actual[i] - predicted[i])^2 }
return (sum(y)/length(actual)) }