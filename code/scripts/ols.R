# sooure evaluation.R
source("../functions/evaluation.R")

# import train / test datast
load("../../data/credit_original_test_train.RData")

## 10-fold CV
train_control <- trainControl(
  method = "cv",
  number = 10)

model.ols <- train(Balance~., data=credit.train, trControl=train_control, method="lm")
model.ols.pred <- predict(model.ols, credit.test)

# mse
model.ols.mse <- get_mse(credit.test$Balance, model.ols.pred)

# final coefficients
model.ols <- train(Balance~., data=credit.train, trControl=train_control, method="lm")
model.ols.summary <- summary(model.ols)
model.ols.coeff <- model.ols.summary$coefficients[,1]

# save ridge
save(model.ols.mse, model.ols.coeff, file = '../../data/ols.RData')

