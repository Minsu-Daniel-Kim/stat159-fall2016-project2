library(dplyr)
library(caret)

credit <- read.csv("data/Credit.csv")
credit$X <- NULL
summary(credit)

### Pre-modeling Data Processing

## a) Dummy out categorical variables

# dummy out categorical variables
temp_credit <- model.matrix(Balance ~ ., data = credit)

# removing column of ones, and appending Balance
Balance = credit$Balance
new_credit <- temp_credit[ ,-1]

# b) Mean Centering and Standardizing

# scaling and centering
scaled_credit <- scale(new_credit, center = TRUE, scale = TRUE)
scaled_credit <- cbind(scaled_credit, Balance)
# export scaled data
write.csv(scaled_credit, file = "data/scaled-credit.csv", row.names = FALSE)

