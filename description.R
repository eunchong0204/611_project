# Description

# Library
library(tidyverse)
library(reshape2)
source("utils.R")

# Importing data
df <- read_csv("data/ChronicKidneyDisease_EHRs_from_AbuDhabi.csv")
df <- df[df$eGFRBaseline < 200,]
df_subpop <- read_csv("data/ChronicKidneyDisease_EHRs_from_AbuDhabi_subpop.csv")


# For the whole population
## Contingency table
df_subset <- dplyr::select(df, ACEIARB, EventCKD35)
df_subset$ACEIARB <- factor(df_subset$ACEIARB, levels=c(1,0))
df_subset$EventCKD35 <- factor(df_subset$EventCKD35, levels=c(1,0))
contingencytable <- table(df_subset)

## Fisher's Exact test
trt_event_fisher <- fisher.test(contingencytable)
estimate <- round(trt_event_fisher$estimate, digits=4)
ci_lower <- round(trt_event_fisher$conf.int[1], digits=4)
ci_upper <- round(trt_event_fisher$conf.int[2], digits=4)


# For subpopulation
## Contingency table
df_subpop_subset <- dplyr::select(df_subpop, ACEIARB, EventCKD35)
df_subpop_subset$ACEIARB <- factor(df_subpop_subset$ACEIARB, levels=c(1,0))
df_subpop_subset$EventCKD35 <- factor(df_subpop_subset$EventCKD35, levels=c(1,0))
contingencytable_subpop <- table(df_subpop_subset)

## Fisher's Exact test
trt_event_fisher_subpop <- fisher.test(contingencytable_subpop)
estimate_subpop <- round(trt_event_fisher_subpop$estimate, digits=4)
ci_lower_subpop <- round(trt_event_fisher_subpop$conf.int[1], digits=4)
ci_upper_subpop <- round(trt_event_fisher_subpop$conf.int[2], digits=4)