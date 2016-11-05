# sooure evaluation.R
source("../functions/evaluation.R")

# import train / test datast
load("../../data/credit_original_test_train.RData")


# 10-fold cross validation
model.plsr <- plsr(Balance ~ ., data = credit.train, validation = 'CV', scale = FALSE)

# Plot cross-validation erros
validationplot(model.plsr, val.type = "MSEP", main = "PLSR: cross-validation errors")

# plot combs values
model.plsr.combs <- RMSEP(model.plsr)


# Select the "best" model
model.plsr$validation$PRESS
model.plsr.comps.min <- which.min(model.plsr$validation$PRESS)
model.plsr.comps.min


# Prediction for test set
model.plsr.pred <- predict(model.plsr, ncomp = model.plsr.comps.min, newdata = credit.test)

# mse
model.plsr.mse <- get_mse(credit.test$Balance, model.plsr.pred)

# Refit the model on full data set 
model.plsr <- plsr(Balance ~ ., data = credit.original, validation = 'CV', scale = FALSE)
model.plsr.coeff <- coef(model.plsr)


# Save info to RData
save(model.plsr.combs, model.plsr.mse, model.plsr.coeff, file = "../../data/plsr.RData")
