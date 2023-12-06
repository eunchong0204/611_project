# Figure_dist_allvariable_subpop

# Library
library(tidyverse)
library(reshape2)
source("utils.R")

# Importing data
df_subpop <- read_csv("data/ChronicKidneyDisease_EHRs_from_AbuDhabi_subpop.csv")

# Melting
melt_df_subpop <- melt(df_subpop, id = "ACEIARB")

# Drawing plot
p <- ggplot(data = melt_df_subpop, aes(x = value)) + 
      geom_histogram(aes(fill=factor(ACEIARB))) + 
      facet_wrap(~variable, scales = "free")

# Checking directroy
ensure_directory("figures")

# Saving plot
ggsave("figures/dist_allvariables_subpop.png", p, width = 10, height = 5)
