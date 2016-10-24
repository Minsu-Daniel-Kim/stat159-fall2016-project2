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

# train the model 
model.lm <- train(Balance~., data=credit, trControl=train_control, method="lm")
