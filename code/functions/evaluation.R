
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


get_mse <- function(y, y_estimate) {
  result = mean((y - y_estimate) ^ 2)
}
