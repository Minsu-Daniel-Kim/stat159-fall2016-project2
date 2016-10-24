library(testthat)
source("code/functions/evaluation.R")

context("Test for ols regression") 

test_that("Sum of Squared Total", {
  y = c(1,2,3)
  y_mean = mean(y)
  expect_equal(SST(y, y_mean), 2)
})

