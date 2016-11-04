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

# mse
model.lm.test_mse <- get_mse(credit.test$Balance, model.lm.pred)
model.lm.test_mse #13876.11

# final coefficients
model.lm.summary <- summary(train(Balance~., data=credit, trControl=train_control, method="lm"))
model.lm.summary$coefficients[,1]

# (Intercept)             Income              Limit             Rating              Cards                Age          Education 
# 520.015000        -275.014651         440.650711         175.848092          24.305139         -10.589809          -3.434150 
# GenderFemale         StudentYes         MarriedYes     EthnicityAsian EthnicityCaucasian 
# -5.330027         127.884163          -4.162747           7.333463           5.059778 