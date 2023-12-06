# Figure_odds_ratio

# Library
source("analysis.R")
source("description.R")
library(tidyverse)
library(reshape2)
source("utils.R")
library(forcats)
install.packages("forcats")

# Create data frame
boxLabels = c("AIPTW", "Fisher_subpop", "Fisher")
df_odds_graph <- data.frame(boxLabels = forcats::fct_inorder(boxLabels), 
                 boxOdds = c(ate_odds, estimate_subpop, estimate), 
                 boxCILow = c(lb, ci_lower_subpop, ci_lower), 
                 boxCIHigh = c(ub, ci_upper_subpop, ci_upper))

# Create Plot
p <- ggplot(df_odds_graph, aes(x = boxOdds, y = boxLabels)) + 
        geom_vline(aes(xintercept = 1), size = .25, linetype = "dashed") + 
        geom_errorbarh(aes(xmax = boxCIHigh, xmin = boxCILow), size = .5, height = 
                           .2, color = "gray50") +
        geom_point(size = 3.5, color = "orange") +
        scale_x_continuous(breaks = seq(0, 25, 5), labels = seq(0, 25, 5),
                           limits = c(0, 25)) +
        theme_bw()+
        theme(panel.grid.minor = element_blank()) +
        ylab("") +
        xlab("Odds Ratio") +
        ggtitle("Odds Ratio of CKD in ACEI/ARB compared to Non-ACEI/ARB")

# Checking directroy
ensure_directory("figures")

# Saving plot
ggsave("figures/odds_ratio.png", p, width = 7, height = 4)
