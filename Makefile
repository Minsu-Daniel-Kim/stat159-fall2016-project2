# Declare the variables
D = data
C = code
S = code/scripts
R = report

# Declare PHONY targets
.PHONY: all data tests eda pre ols ridge lasso pcr plsr regressions report slides session clean

all: eda regressions report

data:
	curl -o $(D)/Advertising.csv "http://www-bcf.usc.edu/~gareth/ISL/Credit.csv"

tests: $(C)/test-that.R
	Rscript $(C)/test-that.R

eda: $(S)/eda-script.R
	cd $(S) && Rscript eda-script.R

pre: $(S)/preprocess.R
	cd $(S) && Rscript preprocess.R

ols: $(S)/ols.R
	cd $(S) && Rscript ols.R

ridge: $(S)/ridge.R
	cd $(S) && Rscript ridge.R

lasso: $(S)/lasso.R
	cd $(S) && Rscript lasso.R

pcr: $(S)/pcr.R
	cd $(S) && Rscript pcr.R

plsr: $(S)/plsr.R
	cd $(S) && Rscript plsr.R

regressions:
	make ols
	make ridge
	make lasso
	make pcr
	make plsr

report: $(R)/report.Rmd
	cd $(R); Rscript -e 'library(rmarkdown); render("report.Rmd")'

#slides: will generate slides.html

session: $(S)/session-info-script.R
	cd $(S) && Rscript session-info-script.R

clean: 
	cd $(R) && rm -f report.pdf