
library(pls)
library(reshape2)
# load model data
load("../../data/ols.RData")
load("../../data/ridge.RData")
load("../../data/lasso.RData")
load("../../data/plsr.RData")
load("../../data/pcr.RData")

# table of regression coefficients for all methods ols, ridge, lasso, pcr, and plsr

coeff_table <- matrix(cbind(model.ols.coeff, model.ridge.coeff, as.matrix(model.lasso.coeff), rbind(0, matrix(model.pcr.coeff)), rbind(0, matrix(model.plsr.coeff))), ncol = 5)
colnames(coeff_table) <- c('ols', 'ridge', 'lasso', 'pcr', 'plsr')
coeff_table <- as.data.frame(coeff_table)

# table of regression mse for all methods ols, ridge, lasso, pcr, and plsr
mse_table <- data.frame(mse = c(model.ols.mse, model.ridge.mse, model.lasso.mse, model.pcr.mse, model.plsr.mse))
rownames(mse_table) <- c('ols', 'ridge', 'lasso', 'pcr', 'plsr')
mse_table

save(coeff_table, mse_table, file = "../../data/report.RData")

# Plot cross validation errors
png("../../images/pcr-cross-validation.png")
validationplot(model.pcr, val.type = "MSEP", main = "PCR: cross-validation errors")
dev.off()

png("../../images/plsr-cross-validation.png")
validationplot(model.plsr, val.type = "MSEP", main = "PLSR: cross-validation errors")
dev.off()

# plot combs values
png("../../images/pcr-combs.png")
plot(model.pcr.combs, legendpos = "topright")
dev.off()

png("../../images/plsr-combs.png")
plot(model.plsr.combs, legendpos = "topright")
dev.off()


