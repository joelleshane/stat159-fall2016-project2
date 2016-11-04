.PHONY: all
.PHONY: data data/cred_f
.PHONY: tests
.PHONY: eda
.PHONY: ols
.PHONY: ridge
.PHONY: lasso
.PHONY: pcr
.PHONY: plsr
.PHONY: regressions
.PHONY: report
.PHONY: slides
.PHONY: session
.PHONY: clean

# all: eda regressions report/report.pdf

all: data data/cred_f data/test-sets eda lasso regressions tests slides report session

data:
	curl -o data/Credit.csv "http://www-bcf.usc.edu/~gareth/ISL/Credit.csv"

data/cred_f: data/Credit.csv 
	cd code/scripts; Rscript as-factor.R

data/test-sets: data/Credit.csv data/cred_f.csv
	cd code/scripts; Rscript gen-sets.R

#tests:

tests: 
	RScript -e "library(testthat) ; test_file('test-that.R')"

#exploratory data analysis using (eda-script.R)

eda: data/Credit.csv code/scripts/eda-script.R
	cd code/scripts; Rscript eda-script.R 


#OLS regression using (ols-reg.R)

# ols: data/Credit.csv code/scripts/ols-reg.R
# 	cd code/scripts; Rscript ols-reg.R

#Ridge Resgression using (ridge.R)

#ridge: data/Credit.csv code/scripts/ridge.R
#       cd code/scripts; Rscript ridge.R

# lasso regression (lasso.R)

lasso: data/cred_f.csv data/train.csv data/test.csv code/scripts/lasso.R
	cd code/scripts; Rscript lasso.R

#Principal Components Regression (pcr.R)

# pcr: data/Credit.csv code/scripts/pcr.R
#         cd code/scripts; Rscript pcr.R

# Partial Least Squares Regression (PLSR.R)

# plsr: data/Credit.csv code/scripts/PLSR.R
#         cd code/scripts; Rscript -e PLSR.R

#regression (all five types of regressions)

# regressions:
# 	make ols ridge lasso pcr plsr analysis

# report/report.pdf: report/report.Rmd
# 	cd report; R -e "rmarkdown::render('report/report.Rmd')" 
# report/report.Rmd:
# 	cd  report; cat sections/*.Rmd

# clean:
# 	rm -f report/report.*
