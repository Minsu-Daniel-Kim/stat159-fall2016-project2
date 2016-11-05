library(caret)
library(dplyr)

credit <- read.csv("../../data/Credit.csv")
credit$X <- NULL
summary(credit)

### Pre-modeling Data Processing

## a) Dummy out categorical variables

# dummy out categorical variables
temp_credit <- model.matrix(Balance ~ ., data = credit)
Balance = credit$Balance
new_credit <- cbind(temp_credit[ ,-1], Balance = Balance)

# b) Mean Centering and Standardizing

# scaling and centering
Balance <- credit$Balance
scaled_credit <- scale(new_credit, center = TRUE, scale = TRUE)
scaled_credit <- as.data.frame(scaled_credit)


# export scaled data
write.csv(scaled_credit, file = "../../data/scaled-credit.csv", row.names = FALSE)

# split data set into 80% (training & validation) / 20% (testing)
set.seed(1000)
index <- createDataPartition(y = scaled_credit$Balance, p = 0.8, list = FALSE)
credit.original <- scaled_credit
credit.train <- scaled_credit[index, ]
credit.test <- scaled_credit[-index, ]

# sanity check
credit.test %>% nrow()
credit.train %>% nrow()

# save train and test dataset in credit_test_train.RData
save(credit.original, credit.train, credit.test, file = "../../data/credit_original_test_train.RData")

