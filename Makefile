.PHONY: all
.PHONY: data
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

all: eda regressions report/report.pdf

data:
	curl -o data/Credit.csv "http://www-bcf.usc.edu/~gareth/ISL/Credit.csv"

tests:

#exploratory data analysis using (eda-script.R)

eda: data/Credit.csv code/scripts/eda-script.R
	cd code/scripts; Rscript -e eda-script.R 


#OLS regression using (ols-reg.R)

ols: data/Credit.csv code/scripts/ols-reg.R
        cd code/scripts; Rscript -e ols-reg.R

#Ridge Resgression using (ridge.R)

ridge: data/Credit.csv code/scripts/ridge.R
        cd code/scripts; Rscript -e ridge.R

# lasso regression (lasso.R)

lasso: data/Credit.csv code/scripts/lasso.R
        cd code/scripts; Rscript -e lasso.R

#Principal Components Regression (pcr.R)

pcr: data/Credit.csv code/scripts/pcr.R
        cd code/scripts; Rscript -e pcr.R

# Partial Least Squares Regression (PLSR.R)

plsr: data/Credit.csv code/scripts/PLSR.R
        cd code/scripts; Rscript -e PLSR.R

#regression (all five types of regressions)

regressions:

report:  
	R -e "rmarkdown::render('report/report.Rmd')" 

clean:
	rm -f report/report.pdf
