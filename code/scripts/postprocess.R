# load model data
load("data/ols.RData")
load("data/ridge.RData")
load("data/lasso.RData")
load("data/plsr.RData")
load("data/pcr.RData")

# table of regression coefficients for all methods ols, ridge, lasso, pcr, and plsr
coeff_table <- cbind(model.ols.coeff, model.ridge.coeff, model.lasso.coeff, rbind(NA, matrix(model.pcr.coeff)), rbind(NA, matrix(model.plsr.coeff)))
colnames(coeff_table) <- c('ols', 'ridge', 'lasso', 'pcr', 'plsr')

# table of regression mse for all methods ols, ridge, lasso, pcr, and plsr
mse_table <- data.frame(mse = c(model.ols.mse, model.ridge.mse, model.lasso.mse, model.pcr.mse, model.plsr.mse))
rownames(mse_table) <- c('ols', 'ridge', 'lasso', 'pcr', 'plsr')

