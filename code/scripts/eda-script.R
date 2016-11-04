library(stats)
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
quantitative_variables <- c("Income", "Limit", "Rating", "Cards", "Age", "Education", "Balance")
for (i in quantitative_variables) {
    quantitative_analysis(i)
}

# Explore Qualitative Variables
qualitative_variables <- c("Gender", "Student", "Married", "Ethnicity")
for (i in qualitative_variables) {
    qualitative_analysis(i)
}