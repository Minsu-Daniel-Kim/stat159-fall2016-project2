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
	title <- substitute(expression("Histogram of " + x), list(x = variable))
	xlab <- substitute(expression("'" + x + "'"), list(x = variable))
	hist(Credit$variable, main = title, xlab = xlab)
	dev.off()
	
	png(paste("images/boxplot-", variable, ".png"))
	title <- substitute(expression("Boxplot of " + x), list(x = variable))	
	xlab <- substitute(expression(x), list(x = variable))
	boxplot(Credit$variable, col = "lightgray", main = title, xlab = xlab)
	dev.off()
}

