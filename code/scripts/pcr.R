library(caret)
library(pls)
library(dplyr)

# sooure evaluation.R
source("../functions/evaluation.R")

# import train / test datast
load("../../data/credit_original_test_train.RData")

set.seed(1000)

model.pcr <- pcr(Balance ~ ., data = credit.train, validation = 'CV', scale = FALSE)
model.pcr.comps.min <- which.min(model.pcr$validation$PRESS)

# You can use the function validationplot(), with the argument val.type = "MSEP", on the outputs of pcr() and plsr().
summary(model.pcr)

# plot combs values

model.pcr.combs <- RMSEP(model.pcr)


# prediction using model.pcr
model.pcr.pred <- predict(model.pcr, ncomp = model.pcr.comps.min, newdata = credit.test)

# mse
model.pcr.mse <- get_mse(credit.test$Balance, model.pcr.pred)

# final coefficients
model.pcr.new <- pcr(Balance ~ ., data = credit.original, validation = 'CV', scale = FALSE)
model.pcr.coeff <- coef(model.pcr.new)

# save pcr
save(model.pcr, model.pcr.combs, model.pcr.mse, model.pcr.coeff, file = '../../data/pcr.RData')

