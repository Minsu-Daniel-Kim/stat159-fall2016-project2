library(caret)
library(dplyr)
library(pls)

# sooure evaluation.R
source("../functions/evaluation.R")

# import train / test datast
load("../../data/credit_original_test_train.RData")


# 10-fold cross validation
set.seed(1000)
model.plsr <- plsr(Balance ~ ., data = credit.train, validation = 'CV', scale = FALSE)


# plot combs values
model.plsr.combs <- RMSEP(model.plsr)


# Select the "best" model
model.plsr$validation$PRESS
model.plsr.comps.min <- which.min(model.plsr$validation$PRESS)
model.plsr.comps.min


# Prediction for test set
# choose ncomp = 4
model.plsr.pred <- predict(model.plsr, ncomp = 4, newdata = credit.test)

# mse
model.plsr.mse <- get_mse(credit.test$Balance, model.plsr.pred)

# Refit the model on full data set 
model.plsr.new <- plsr(Balance ~ ., data = credit.original, validation = 'CV', scale = FALSE)
model.plsr.coeff <- coef(model.plsr.new)


# Save info to RData
save(model.plsr, model.plsr.combs, model.plsr.mse, model.plsr.coeff, file = "../../data/plsr.RData")
