PHONY: purge
PHONY: clean

purge: 
	rm data/*
	make clean

clean: 
	rm figures/*

figures/dist_allvariables.png: figure_dist_allvariables.R
	Rscript figure_dist_allvariables.R

figures/dist_allvariables_subpop.png: figure_dist_allvariables_subpop.R
	Rscript figure_dist_allvariables_subpop.R

figures/ps_logistic.png: figure_ps_logistic.R
	Rscript figure_ps_logistic.R