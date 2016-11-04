library(caret)
library(dplyr)
library(pls)
source("../../code/functions/evaluation.R")


# import preprocessed credit file
credit <- read.csv("../../data/scaled-credit.csv")

# split data set into 80% (training & validation) / 20% (testing)
set.seed(1000)
index <- createDataPartition(y = credit$Balance, p = 0.8, list = FALSE)
credit.train <- credit[index, ]
credit.test <- credit[-index, ]

# sanity check
credit.test %>% nrow()
credit.train %>% nrow()

# 10-fold cross validation
model.plsr <- plsr(Balance ~ ., data = credit.train, validation = 'CV', scale = FALSE)
model.plsr$validation$PRESS

# Plot cross-validation erros
png("../../images/plsr-cross-validation.png")
validationplot(model.plsr, val.type = "MSEP", main = "PLSR: cross-validation errors")
dev.off()

# Select the "best" model
min(model.plsr$validation$PRESS)
plsr_best_model <- match(min(model.plsr$validation$PRESS), model.plsr$validation$PRESS)
plsr_best_model

# Prediction for test set
model.plsr.pred <- predict(model.plsr, ncomp = plsr_best_model, newdata=credit.test)
rsquared(credit.test$Balance, model.plsr.pred)

# Refit the model on full data set 
model.plsr.refit <- plsr(Balance ~ ., data = credit, scale = FALSE, ncomp = plsr_best_model)
plsr_coef <- coef(model.plsr.refit)

# Save info to RData
save(model.plsr, plsr_best_model, model.plsr.pred, model.plsr.refit, plsr_coef, file = "../../data/plsr.RData")
