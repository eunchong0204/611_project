# Analysis

# Package
library(tidyverse)
library(SuperLearner)
library(xgboost)
library(arm)

# 1. Data 
## Importing data
df_subpop <- read_csv("data/ChronicKidneyDisease_EHRs_from_AbuDhabi_subpop.csv")

## For g(w)=p(A|W)
df_subpop_g <- dplyr::select(df_subpop, -EventCKD35, -HistoryHTN, -HTNmeds, -HistoryDiabetes)
## For Qbar(a,w)=E(Y|A,W)
df_subpop_qbar <- dplyr::select(df_subpop, -HistoryHTN, -HTNmeds, -HistoryDiabetes)

# 2. Fit SuperLearner
## Learner candidates
SL.lib <- c("SL.glm", "SL.xgboost", "SL.randomForest")

## For g(w)=p(A|W)
set.seed(611)
fit_g <- SuperLearner(Y=df_subpop_g$ACEIARB, X=data.frame(dplyr::select(df_subpop_g, -ACEIARB)), 
                      SL.library = SL.lib,
                      family = binomial(),
                      method = "method.AUC",
                      verbose = TRUE)

## For Qbar(a,w)=E(Y|A,W)
set.seed(611)
fit_qbar <- SuperLearner(Y=df_subpop_qbar$EventCKD35, X=data.frame(dplyr::select(df_subpop_qbar, -EventCKD35)), 
                      SL.library = SL.lib,
                      family = binomial(),
                      method = "method.AUC",
                      verbose = TRUE)

# Get Superlearner fits
## Estimates of g(w)=p(A|W)
gw <- fit_g$SL.predict

## Estimates of Qbar(1,w)=E(Y|1,W) and Qbar(0,w)=E(Y|0,W)
newdata_0 <- data.frame(dplyr::select(df_subpop_qbar, -EventCKD35)) %>% mutate(ACEIARB=rep(0,nrow(df_subpop_qbar))) 
newdata_1 <- data.frame(dplyr::select(df_subpop_qbar, -EventCKD35)) %>% mutate(ACEIARB=rep(1,nrow(df_subpop_qbar))) 
qbar0 <- predict(fit_qbar, newdata = newdata_0)
qbar1 <- predict(fit_qbar, newdata = newdata_1)

# calculate ATE
aiptw_0 <- mean(qbar0$pred) + mean((1-df_subpop_qbar$ACEIARB)/(1-gw) * (df_subpop_qbar$EventCKD35 - qbar0$pred))
aiptw_1 <- mean(qbar1$pred) + mean(df_subpop_qbar$ACEIARB/gw * (df_subpop_qbar$EventCKD35 - qbar1$pred))

# Calculate Causal odds ratio
ate_odds <- round((aiptw_1/(1-aiptw_1))/(aiptw_0/(1-aiptw_0)), digits = 4)

# Calculate 95% Confidence interval for odds ratio
## Formula: (1 - EY0aiptw) / EY0aiptw / (1 - EY1aiptw)^2 * D1 - EY1aiptw / (1 - EY1aiptw) / EY0aiptw^2 * D0
d1 <- qbar1$pred + df_subpop_qbar$ACEIARB/gw * (df_subpop_qbar$EventCKD35 - qbar1$pred)
d0 <- qbar0$pred + (1-df_subpop_qbar$ACEIARB)/(1-gw) * (df_subpop_qbar$EventCKD35 - qbar0$pred)
ic <- (1 - aiptw_0) / aiptw_0 / (1 - aiptw_1)^2 * d1 - aiptw_1 / (1 - aiptw_1) / aiptw_0^2 * d0
## Upper bound
ub <- round(ate_odds + 1.96*sqrt(var(ic)/173), digits=4)
## Lower bound
lb <- round(ate_odds - 1.96*sqrt(var(ic)/173), digits=4)
