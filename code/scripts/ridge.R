# sooure evaluation.R
source("code/functions/evaluation.R")

# import train / test datast
load("data/credit_original_test_train.RData")

# train the model using glmnet
set.seed(1000)
grid <- 10 ^ seq(10, -2, length = 100)
model.ridge.lambda <- cv.glmnet(as.matrix(select(credit.train, -Balance)), credit.train$Balance, nfolds = 10, intercept = FALSE, standardize = FALSE, lambda = grid, alpha = 0)
model.ridge <- glmnet(as.matrix(select(credit.train, -Balance)), credit.train$Balance, alpha = 0, lambda = model.ridge.lambda$lambda.min)

# plot lambda values
model.ridge.lambda <- model.ridge.lambda

# select the best lambda
model.ridge.lambda.min <- model.ridge.lambda$lambda.min

# prediction using model.ridge
model.ridge.pred <- predict(model.ridge,newx= as.matrix(select(credit.test, -Balance)),type="response",s= model.ridge.lambda.min)

# mse
model.ridge.mse <- get_mse(credit.test$Balance, model.ridge.pred) # 12938.43

# final coefficients
model.ridge <- glmnet(as.matrix(select(credit.original, -Balance)), credit.original$Balance, alpha = 0, lambda = model.ridge.lambda.min)
model.ridge.coeff <- coef(model.ridge)

# save ridge
save(model.ridge.lambda, model.ridge.lambda.min, model.ridge.mse, model.ridge.coeff, file = 'data/ridge.RData')


