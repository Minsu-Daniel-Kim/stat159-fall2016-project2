library(caret)
library(dplyr)
library(pls)
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

# train the model using caret
model.pcr1 <- train(Balance~., data=credit.train, trControl=train_control, method="pcr")
model.pcr1$results

# prediction using model.ridge1
model.pcr1.pred <- predict(model.pcr1, credit.test)
rsquared(credit.test$Balance, model.pcr1.pred)



# You can use the function validationplot(), with the argument val.type = "MSEP", on the outputs of pcr() and plsr().

