library(stats)
library(dplyr)

# Explore Quantitative Variables

quantitative_analysis <- function(variable) {

	col <- which(names(Credit) == variable)
	
	# Select data
	data <- select(Credit, col)
	
	# Minimum, Maximum, Range
	min(data)
	max(data)
	range(data)

	# Median, First and Third quartiles, and interquartile range (IQR)
	median(data)
	quantile(data, probs = seq(0, 1, 0.25))
	IQR(data)

	# Mean and Standard Deviation
	mean(data)
	sd(data)

	# Histograms and boxplots
	png(paste0("images/histogram-", variable, ".png"))
	hist(data, main = paste("Histogram of ", variable), xlab = variable)
	dev.off()
	
	png(paste("images/boxplot-", variable, ".png"))
	boxplot(data, main = paste("Boxplot of ", variable), xlab = variable)
	dev.off()
}

