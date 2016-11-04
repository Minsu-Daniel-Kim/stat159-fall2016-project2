library(caret)
library(dplyr)
source("code/functions/evaluation.R")
# import preprocessed credit file
credit <- read.csv("data/scaled-credit.csv")

# split data set into 80% (training & validation) / 20% (testing)
set.seed(1000)
index <- createDataPartition(y = credit$Balance, p = 0.8, list = FALSE)
credit.train <- credit[index, ]
credit.test <- credit[-index, ]

# sanity check
credit.test %>% nrow()
credit.train %>% nrow()

# 10-fold cross validation
train_control<- trainControl(method="cv", number=10)

# train the model
model.lm <- train(Balance~., data=credit.train, trControl=train_control, method="lm")
model.lm.pred <- predict(model.lm, credit.test)
model.lm.summary <- summary(model.lm)
model.lm$results
