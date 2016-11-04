library(stats)
library(dplyr)

# Explore Quantitative Variables

quantitative_analysis <- function(variable) {
	
    col <- which(names(Credit) == variable)
	
	# Select data
	data <- select(Credit, col)
	# Unlist data
	data <- unlist(data)
	
	sink("../../data/eda-quantitative-output.txt", append = TRUE)
	# Minimum, Maximum, Range
	cat(c("Summary Statistics of", variable, "\n"), append = TRUE)
	cat(" \n", append = TRUE)
	cat(c("Min", "\n"), append = TRUE)
	print(min(data))
	cat(c("Max", "\n"), append = TRUE)
	print(max(data))
	cat(c("Range", "\n"), append = TRUE)
	print(range(data))
	cat(" \n", append = TRUE)

	# Median, First and Third quartiles, and interquartile range (IQR)
	cat(c("Median", "\n"), append = TRUE)
	print(median(data, na.rm = TRUE))
	cat(c("Quantile", "\n"), append = TRUE)
	print(quantile(data, probs = seq(0, 1, 0.25)))
	cat(c("IQR", "\n"), append = TRUE)
	print(IQR(data))
	cat(" \n", append = TRUE)

	# Mean and Standard Deviation
	cat(c("Mean", "\n"), append = TRUE)
	print(mean(data))
	cat(c("Standard Deviation", "\n"), append = TRUE)
	print(sd(data))
	cat(" \n", append = TRUE)
	sink()

	# Histograms and boxplots
	png(paste0("../../images/histogram-", variable, ".png"))
	hist(data, main = paste("Histogram of", variable), xlab = variable)
	dev.off()
	
	png(paste0("../../images/boxplot-", variable, ".png"))
	boxplot(data, main = paste("Boxplot of", variable), xlab = variable)
	dev.off()
}

