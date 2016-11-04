library(stats)
library(dplyr)

# Explore Qualitative Variables

qualitative_analysis <- function(variable) {
	
	col <- which(names(Credit) == variable)
	
	# Select data
	data <- select(Credit, col)

	# Frequency Table - Frequency
	table(data)
	
	# Frequency Table - Relative Frequency
	table(data) / nrow(Credit)
	
	# Barplot of Frequency Table
	png(paste0("images/barplot-", variable, ".png"))
	barplot(table(data), main = paste("Barplot of Frequency Table - ", variable))
	dev.off()
}

