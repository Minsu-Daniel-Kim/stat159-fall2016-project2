
load("data/ols.RData")
load("data/ridge.RData")
load("data/pcr.RData")

# data/plsr.RData
# data/lasso.RData 
# will be added

# table of regression coefficients for all methods ols, ridge, lasso, pcr, and plsr
coeff_table <- cbind(model.ols.coeff, model.ridge.coeff, rbind(NA, matrix(model.pcr.coeff)))
colnames(coeff_table) <- 