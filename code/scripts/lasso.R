# sooure evaluation.R
source("code/functions/evaluation.R")

# import train / test datast
load("data/credit_original_test_train.RData")

# train the model using glmnet
set.seed(1000)
grid <- 10 ^ seq(10, -2, length = 100)
model.lasso.lambda <- cv.glmnet(as.matrix(select(credit.train, -Balance)), credit.train$Balance, nfolds = 10, intercept = FALSE, standardize = FALSE, lambda = grid, alpha = 1)
model.lasso <- glmnet(as.matrix(select(credit.train, -Balance)), credit.train$Balance, alpha = 1, lambda = model.lasso.lambda$lambda.min)

# plot lambda values
model.lasso.lambda <- model.lasso.lambda

# select the best lambda
model.lasso.lambda.min <- model.lasso.lambda$lambda.min

# prediction using model.lasso
model.lasso.pred <- predict(model.lasso,newx= as.matrix(select(credit.test, -Balance)),type="response",s= model.lasso.lambda.min)

# mse
model.lasso.mse <- get_mse(credit.test$Balance, model.lasso.pred)

# final coefficients
model.lasso <- glmnet(as.matrix(select(credit.original, -Balance)), credit.original$Balance, alpha = 1, lambda = model.lasso.lambda.min)
model.lasso.coeff <- coef(model.lasso)

# save lasso
save(model.lasso.lambda, model.lasso.lambda.min, model.lasso.mse, model.lasso.coeff, file = 'data/lasso.RData')