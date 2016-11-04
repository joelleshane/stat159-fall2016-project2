source("functions/mean-squared.R")

context("Test functions of MSE")

test_that("Mean_squared_error works as expected", {
x <- c(1,2,3)
y <- c(4,5,6)
expect_equal(Mean_squared_error(x,y), 9)
 expect_length(Mean_squared_error(x,y), 1)
  expect_type(Mean_squared_error(x,y), 'double')

})