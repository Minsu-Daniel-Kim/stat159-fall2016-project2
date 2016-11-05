
# SST is the total sum of squares
SST <- function(y, y_mean) {
  
  return(sum((y - y_mean) ^ 2))
  
}

# SSR is the regression sum of squares
SSR <- function(y_estimated, y_mean) {
  
  return(sum((y_estimated - y_mean) ^ 2))
  
}

# SSE

SSE <- function(y, y_estimated) {
  return(sum((y - y_estimated) ^ 2))
}

# r-squared
rsquared <- function(y, y_estimated) {
  
  y_mean = mean(y)
  sst <- SST(y, y_mean)
  sse <- SSE(y, y_estimated)
  result <- 1 - (sse/sst)
  # ssr <- SSR(y_estimated, y_mean)
  return(result)
}

<<<<<<< HEAD
get_mse <- function(y, y_estimate) {
  result = mean((y - y_estimate) ^ 2)
=======
mse <- function(y, y_estimate) {
  result = sum((y - y_estimate) ^ 2) / length(y)
>>>>>>> 87ba2a4dbfc6a83f4c3996c5cecbd0cfde250663
  return(result)
}
