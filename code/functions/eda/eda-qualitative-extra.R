qualitative_analysis_extra <- function(variable) {
	
	col <- which(names(Credit) == variable)
	
	# Select data
	data <- select(Credit, col)
	# Unlist data
	data <- unlist(data)

	# Conditional boxplots between Balance and the qualitative variables
	balance <- unlist(Credit$Balance)

	png(paste0("../../images/conditional-boxplot-", variable, ".png"))
  	boxplot(balance ~ data, main = paste("Conditional boxplots between Balance and", variable))
  	dev.off()

}