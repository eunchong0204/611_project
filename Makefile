PHONY: purge
PHONY: clean

purge: 
	rm data/*
	make clean

clean: 
	rm -r -f figures
	rm -f data/*_subpop.csv
	rm -f report.html

data/ChronicKidneyDisease_EHRs_from_AbuDhabi_subpop.csv: data_subpop.R utils.R
	Rscript data_subpop.R

figures/dist_allvariables.png: figure_dist_allvariables.R utils.R
	Rscript figure_dist_allvariables.R

figures/dist_allvariables_subpop.png: data/ChronicKidneyDisease_EHRs_from_AbuDhabi_subpop.csv figure_dist_allvariables_subpop.R utils.R
	Rscript figure_dist_allvariables_subpop.R

figures/boxplot.png: data/ChronicKidneyDisease_EHRs_from_AbuDhabi_subpop.csv figure_boxplot.R utils.R
	Rscript figure_boxplot.R

figures/odds_ratio.png: figure_odds_ratio.R utils.R description.R analysis.R
	Rscript figure_odds_ratio.R

report.html: data/ChronicKidneyDisease_EHRs_from_AbuDhabi_subpop.csv figures/dist_allvariables.png figures/dist_allvariables_subpop.png figures/boxplot.png figures/odds_ratio.png report.Rmd description.R analysis.R 
	Rscript -e 'rmarkdown::render("report.Rmd")'