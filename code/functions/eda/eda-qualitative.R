library(stats)
library(dplyr)
library(graphics)

# Explore Qualitative Variables

qualitative_analysis <- function(variable) {
	
	col <- which(names(Credit) == variable)
	
	# Select data
	data <- select(Credit, col)
	# Unlist data
	data <- unlist(data)

	sink("../../data/eda-qualitative-output.txt", append = TRUE)
	# Frequency Table - Frequency
	cat(c("Summary Statistics of", variable, "\n"), append = TRUE)
	cat(" \n", append = TRUE)
	cat(c("Frequency Table - Absolute Frequency", "\n"), append = TRUE)
	print(table(data))
	cat(" \n", append = TRUE)
	
	# Frequency Table - Relative Frequency
	cat(c("Frequency Table - Relative Frequency", "\n"), append = TRUE)
	print(table(data) / nrow(Credit))
	cat(" \n", append = TRUE)
	sink()
	
	# Barplot of Frequency Table
	png(paste0("../../images/barplot-", variable, ".png"))
	barplot(table(data), main = paste("Barplot of Frequency Table - ", variable), xlab = variable)
	dev.off()
}

