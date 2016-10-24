# Declare the variables
D = data
C = code
S = code/scripts
R = report

# Declare PHONY targets
.PHONY: all data tests eda ols ridge lasso pcr plsr regressions report slides session clean

all: eda regressions report

data:
	curl -o $(D)/Advertising.csv "http://www-bcf.usc.edu/~gareth/ISL/Credit.csv"

tests: $(C)/test-that.R
	Rscript $(C)/test-that.R

eda: $(S)/eda-script.R
	cd $(S) && Rscript eda-script.R

ols: OLS regression

ridge: Rdige Regression

lasso: Lasso Regression

pcr: Principal Components Regression

plsr: Partial Least Squares Regression

regressions: ols ridge lasso pcr plsr

report: $(R)/report.Rmd
	cd $(R); Rscript -e 'library(rmarkdown); render("report.Rmd")'

slides: will generate slides.html

session: will generate session-info.txt

clean: 
	cd $(R) && rm -f report.pdf