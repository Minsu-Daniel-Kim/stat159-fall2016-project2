# Declare the variables
D = data
C = code
S = code/scripts
T = code/tests
R = report
ST = report/sections/*.Rmd

# Declare PHONY targets
.PHONY: all data tests eda pre ols ridge lasso pcr plsr regressions post report slides session clean

all: eda regressions report

data:
	curl -o $(D)/Credit.csv "http://www-bcf.usc.edu/~gareth/ISL/Credit.csv"

tests: $(T)/test-evaluation.R
	cd $(T) && Rscript test-evaluation.R

eda: $(S)/eda-script.R
	cd $(S) && Rscript eda-script.R

# ------------------------------------------------------------------------------------------
# Data Preprocessing
# ------------------------------------------------------------------------------------------
pre: $(S)/preprocess.R
	cd $(S) && Rscript preprocess.R

# ------------------------------------------------------------------------------------------
# Run regression models
# ------------------------------------------------------------------------------------------
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

# ------------------------------------------------------------------------------------------
# Data Postprocessing
# ------------------------------------------------------------------------------------------
post: $(S)/postprocess.R
	cd $(S) && Rscript postprocess.R

# ------------------------------------------------------------------------------------------
# Generate report
# ------------------------------------------------------------------------------------------
report: $(ST)
	cat $(ST) > $(R)/report.Rmd
	cd $(R); Rscript -e "library(rmarkdown); render('report.Rmd', 'pdf_document')"

# ------------------------------------------------------------------------------------------
# Generate slides
# ------------------------------------------------------------------------------------------
slides: slides/slides.Rmd
	cd slides; Rscript -e 'library(rmarkdown); render("slides.Rmd")'

# ------------------------------------------------------------------------------------------
# Generate session information
# ------------------------------------------------------------------------------------------
session: $(S)/session-info-script.R
	cd $(S) && Rscript session-info-script.R

clean: 
	cd $(R) && rm -f report.pdf