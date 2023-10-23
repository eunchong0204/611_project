library(tidyverse)
library(reshape2)
source("utils.R")

# Importing data
df <- read_csv("data/ChronicKidneyDisease_EHRs_from_AbuDhabi.csv")

# Manipulate data
df <- df[df$HistoryHTN == 1 & df$HistoryDiabetes == 1 & df$HTNmeds == 1, ]
df_ps <- df
df_ps <- select(df_ps, -EventCKD35, -TimeToEventMonths, -TIME_YEAR, -HistoryHTN, -HTNmeds, -HistoryDiabetes)

# Propensity Score
model <- glm(ACEIARB ~ ., data = df_ps, family = "binomial")
pred_probs <- predict(model, newdata = df_ps, type="response")
pred_probs <- as.data.frame(pred_probs)
pred_probs$ACEIARB <- df_ps$ACEIARB

# Drawing plot
p <- ggplot(data = pred_probs, aes(x = pred_probs)) + 
  geom_histogram(aes(fill=factor(ACEIARB))) 

# Checking directroy
ensure_directory("figures")

# Saving plot
ggsave("figures/ps_logistic.png", p)
