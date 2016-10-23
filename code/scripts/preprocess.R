
library(dplyr)

data <- read.csv("data/Credit.csv")
data$X <- NULL
summary(data)
View(data)
