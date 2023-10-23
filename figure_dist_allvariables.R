library(tidyverse)
library(reshape2)
source("utils.R")

# Importing data
df <- read_csv("data/ChronicKidneyDisease_EHRs_from_AbuDhabi.csv")

# Melting
melt.df <- melt(df, id = "ACEIARB")

# Drawing plot
p <- ggplot(data = melt.df, aes(x = value)) + 
  geom_histogram(aes(fill=factor(ACEIARB))) + 
  facet_wrap(~variable, scales = "free")

# Checking directroy
ensure_directory("figures")

# Saving plot
ggsave("figures/dist_allvariables.png", p, width = 10, height = 5)
