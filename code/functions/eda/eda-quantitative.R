library(stats)
library(dplyr)

# Explore Quantitative Variables

quantitative_analysis <- function(variable) {
	# Select data
	data <- select(Credit, variable)
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
	png(paste("images/histogram-", variable, ".png"))
	title <- substitute(expression("Histogram of " + x), list(x = variable))
	xlab <- substitute(expression("'" + x + "'"), list(x = variable))
	hist(data, main = title, xlab = xlab)
	dev.off()
	
	png(paste("images/boxplot-", variable, ".png"))
	title <- substitute(expression("Boxplot of " + x), list(x = variable))	
	xlab <- substitute(expression(x), list(x = variable))
	boxplot(data, col = "lightgray", main = title, xlab = xlab)
	dev.off()
}

