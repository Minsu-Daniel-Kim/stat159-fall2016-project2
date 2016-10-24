library(caret)
library(dplyr)

# import preprocessed credit file
credit <- read.csv("data/scaled-credit.csv")

# split data set into 80% (training & validation) / 20% (testing)
index <- createDataPartition(y = credit$Balance, p = 0.8, list = FALSE)
credit.train <- credit[index, ]
credit.test <- credit[-index, ]

# sanity check
credit.test %>% nrow()
credit.train %>% nrow()

train_control<- trainControl(method="cv", number=10)

# train the model using caret
model.lasso1 <- train(Balance~., data=credit.train, trControl=train_control, method="lasso")
model.lasso1$results

# prediction using model.lasso1
model.lasso1.pred <- predict(model.lasso1, credit.test)
rsquared(credit.test$Balance, model.lasso1.pred)

# train the model using glmnet
set.seed(1000)
grid <- 10 ^ seq(10, -2, length = 100)
model.lasso2.lambda <- cv.glmnet(as.matrix(select(credit.train, -Balance)), credit.train$Balance, nfolds = 10, intercept = FALSE, standardize = FALSE, lambda = grid, alpha = 1)
model.lasso2 <- glmnet(as.matrix(select(credit.train, -Balance)), credit.train$Balance, alpha = 1, lambda = model.lasso2.lambda$lambda.min)

# prediction using model.lasso1
model.lasso2.pred <- predict(model.lasso2,newx= as.matrix(select(credit.test, -Balance)),type="response",s= model.lasso2.lambda$lambda.min)
rsquared(credit.test$Balance, model.lasso2.pred)
