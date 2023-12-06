# Figure_dist_allvariable

# Library
library(tidyverse)
library(reshape2)
source("utils.R")

# Importing data
df <- read_csv("data/ChronicKidneyDisease_EHRs_from_AbuDhabi.csv")
df_subset <- dplyr::select(df, -TimeToEventMonths, -TIME_YEAR)

# Melting
melt_df_subset <- melt(df_subset, id = "ACEIARB")

# Drawing plot
p <- ggplot(data = melt_df_subset, aes(x = value)) + 
  geom_histogram(aes(fill=factor(ACEIARB))) + 
  facet_wrap(~variable, scales = "free")

# Checking directroy
ensure_directory("figures")

# Saving plot
ggsave("figures/dist_allvariables.png", p, width = 10, height = 5)
