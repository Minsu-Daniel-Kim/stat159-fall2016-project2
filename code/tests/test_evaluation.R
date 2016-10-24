library(testthat)
source("code/functions/evaluation.R")

context("Test for evalution functions") 

test_that("total sum of squares", {
  y <- c(1,2,3)
  y_mean <- mean(y)
  expect_equal(SST(y, y_mean), 2)
})

test_that("regression sum of squares", {
  y <- c(1,2,3)
  y_mean = mean(y)
  expect_equal(SSR(y, y_mean), 2)
})

test_that("r-squared", {
  
  y <- c(1,2,3)
  y_estimate <- c(1, 2, 3)
  expect_equal(rsquared(y, y_estimate), 1)
  
})