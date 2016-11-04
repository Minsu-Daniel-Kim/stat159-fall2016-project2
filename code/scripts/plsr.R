library(caret)
library(dplyr)
library(pls)

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
validationplot(model.plsr, val.type = "MSEP")

# Select the "best" model
min(model.plsr$validation$PRESS)
plsr_best_model <- match(min(model.plsr$validation$PRESS), model.plsr$validation$PRESS)
plsr_best_model
