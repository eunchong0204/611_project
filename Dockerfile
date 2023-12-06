FROM rocker/verse
RUN Rscript --no-restore --no-save -e "install.packages('reshape2')"
RUN Rscript --no-restore --no-save -e "install.packages('SuperLearner')"
RUN Rscript --no-restore --no-save -e "install.packages('markdown')"
RUN Rscript --no-restore --no-save -e "install.packages('xgboost')"
RUN Rscript --no-restore --no-save -e "install.packages('arm')"
RUN Rscript --no-restore --no-save -e "install.packages('randomForest')"