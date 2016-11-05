library(dplyr)
library(car)

# Import Data
Credit <- read.csv("../../data/Credit.csv", header = TRUE)
Credit <- Credit[,2:12]

# loading all function files
files <- list.files("../functions/eda")

for (i in 1:length(files)) {
    source(paste0("../functions/eda/", files[i]))
}

# Explore Quantitative Variables

# Basic Summaries
quantitative_variables <- c("Income", "Limit", "Rating", "Cards", "Age", "Education", "Balance")
for (i in quantitative_variables) {
    quantitative_analysis(i)
}

# Matrix of correlations among all quantitative variables
sink("../../data/eda-quantitative-output.txt", append = TRUE)
cat(c("Matrix of correlations among all quantitative variables", "\n"), append = TRUE)
cor(Credit[quantitative_variables])
sink()

# Scatterplot matrix
png("../../images/scatterplot-matrix.png")
scatterplotMatrix(Credit[quantitative_variables], main = "Scatterplot Matrix")
dev.off()


# Explore Qualitative Variables
# Basic Summaries
qualitative_variables <- c("Gender", "Student", "Married", "Ethnicity")
for (i in qualitative_variables) {
    qualitative_analysis(i)
}

# Anova Relationship
sink("../../data/eda-qualitative-output.txt", append = TRUE)
cat(c("Anova's between Balance and all the qualitative variables", "\n"), append = TRUE)
summary(aov(Balance ~ Gender + Student + Married + Ethnicity, data = Credit))
sink()

# Conditional boxplots between Balance and the qualitative variables
for (i in qualitative_variables) {
    qualitative_analysis_extra(i)
}