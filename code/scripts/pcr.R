library(caret)
library(dplyr)
library(pls)
source("code/functions/evaluation.R")

# import train / test datast
load("data/credit_original_test_train.RData")

model.pcr <- pcr(Balance ~ ., data = credit.train, validation = 'CV', scale = FALSE)
model.pcr.comps.min <- which.min(model.pcr$validation$PRESS)

# You can use the function validationplot(), with the argument val.type = "MSEP", on the outputs of pcr() and plsr().
summary(model.pcr)
validationplot(model.pcr, val.type = "MSEP")

# plot combs values

model.prc.combs.plot <- plot(RMSEP(model.pcr), legendpos = "topright")


# prediction using model.pcr
model.pcr.pred <- predict(model.pcr, ncomp = model.pcr.comps.min, newdata = credit.test)

# mse
model.pcr.mse <- get_mse(credit.test$Balance, model.pcr.pred)

# final coefficients
model.pcr <- pcr(Balance ~ ., data = credit.original, validation = 'CV', scale = FALSE)
model.pcr.coeff <- coef(model.pcr)

# save pcr
save(model.prc.combs.plot, model.pcr.mse, model.pcr.coeff, file = 'data/pcr.RData')

