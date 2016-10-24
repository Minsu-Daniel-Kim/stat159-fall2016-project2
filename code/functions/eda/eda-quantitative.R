library(stats)

# Explore Quantitative Variables

quantitative_analysis <- function(variable) {
	# Minimum, Maximum, Range
	min(Credit$variable)
	max(Credit$variable)
	range(Credit$variable)

	# Median, First and Third quartiles, and interquartile range (IQR)
	median(Credit$variable)
	quantile(Credit$variable, probs = seq(0, 1, 0.25))
	IQR(Credit$variable)

	# Mean and Standard Deviation
	mean(Credit$variable)
	sd(Credit$variable)

	# Histograms and boxplots
	png(paste("images/histogram-", variable, ".png"))
	hist(Credit$variable, main = paste('"Histogram of ', variable, '"'), xlab = paste("'", variable, '"'))
	dev.off()
	
	png(paste("images/boxplot-", variable, ".png"))
	boxplot(Credit$variable, col = "lightgray", main = paste('"Boxplot of ', variable, '"'), xlab = paste("'", variable, '"'))
	dev.off()
}

