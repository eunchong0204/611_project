# Analysis

# Package
library(tidyverse)
source("utils.R")

# Importing data
df <- read_csv("data/ChronicKidneyDisease_EHRs_from_AbuDhabi.csv")

# Preprocess
df_subpop <- df[df$HistoryHTN == 1 & df$HistoryDiabetes == 1 & df$HTNmeds == 1, ]
df_subpop <- df_subpop[df_subpop$eGFRBaseline < 200,]
df_subpop <- dplyr::select(df_subpop, -TimeToEventMonths, -TIME_YEAR)

# Checking directroy
ensure_directory("data")

# Export data
write_csv(df_subpop, "data/ChronicKidneyDisease_EHRs_from_AbuDhabi_subpop.csv")
