# Figure_boxplot

# Library
library(tidyverse)
library(gridExtra)
source("utils.R")

# Prevent from generating Rplots.pdf
if(!interactive()) pdf(NULL)

# Importing data
df_subpop <- read_csv("data/ChronicKidneyDisease_EHRs_from_AbuDhabi_subpop.csv")
df_subpop_boxplot <- dplyr::select(df_subpop, eGFRBaseline, EventCKD35, ACEIARB)
df_subpop_boxplot$EventCKD35 <- as.factor(df_subpop_boxplot$EventCKD35)
df_subpop_boxplot$ACEIARB <- as.factor(df_subpop_boxplot$ACEIARB)

# Create Plots
p1 <- ggplot(df_subpop_boxplot, aes(x = EventCKD35, y = eGFRBaseline , group = EventCKD35, fill=EventCKD35)) + 
    geom_boxplot() +
    stat_summary(fun = "mean", geom = "point", shape = 5,
                 size = 3, color = "white")

p2 <- ggplot(df_subpop_boxplot, aes(x = ACEIARB, y = eGFRBaseline , group = ACEIARB, fill = ACEIARB)) + 
    geom_boxplot() +
    stat_summary(fun = "mean", geom = "point", shape = 5,
                 size = 3, color = "white")

# Combine
p <- grid.arrange(p1, p2, ncol=2)

# Checking directroy
ensure_directory("figures")

# Saving plot
ggsave("figures/boxplot.png", p, width = 7, height = 4)
