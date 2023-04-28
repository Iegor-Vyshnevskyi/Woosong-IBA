# Install libraries
install.packages('tidyverse')
install.packages('janitor')
install.packages('tidyquant')
install.packages('patchwork')
install.packages('survival')
install.packages('survminer')

# Load libraries
library(tidyverse)
library(janitor)
library(tidyquant)
library(patchwork)
library(survival)
library(survminer)


# Load data
# First, set your working folder
setwd("C:/Users/user/OneDrive - kdis.ac.kr/Woosong_2022/Work/2023_spring/Introduction to Business Analytics/L11_Survival") 
# remember to change a path to your working folder.

customer_churn_tbl <- read_csv("customer_churn.csv") %>%
  clean_names() %>%
  mutate(churn = ifelse(churn == "Yes", 1, 0)) %>%
  mutate_if(is.character, as_factor)

# Dataset information
customer_churn_tbl

glimpse(customer_churn_tbl)

# Data seems to be bimodal
hist(customer_churn_tbl$churn)

# Tenure distribution
hist(customer_churn_tbl$tenure)

# Fitting the survival model:general KM ----
sfit_1 <- survfit(Surv(tenure, churn) ~ 1, data = customer_churn_tbl)

# Plotting the function KM
plot(sfit_1)

# Plotting the function KM (better way)
g1 <- ggsurvplot(
  sfit_1,
  conf.int = TRUE,
  data     = customer_churn_tbl
)

g1

# Fitting the survival model:specific KM model (1)
sfit_2 <- survfit(Surv(tenure, churn) ~ gender, data = customer_churn_tbl)

# Plotting the function KM
plot(sfit_2)

# Plotting the specific KM (better way)
g2 <- ggsurvplot(
  sfit_2,
  conf.int = TRUE,
  data     = customer_churn_tbl
)

g2

# Fitting the survival model:specific KM model (2)
sfit_3 <- survfit(Surv(tenure, churn) ~ contract, data = customer_churn_tbl)

# Plotting the function
plot(sfit_3)

# Plotting the specific KM (better way)
g3 <- ggsurvplot(
  sfit_3,
  conf.int = TRUE,
  data     = customer_churn_tbl
)

g3


# * BONUS #1: CUSTOMIZE WITH TIDYQUANT THEME TQ ----

g3$plot

g3$plot +
  theme_tq() +
  scale_fill_tq() +
  scale_color_tq() +
  labs(title = "Customer Churn Survival Plot")


# * BONUS #2: ADDING A RISK TABLE ----

g3 <- ggsurvplot(
  sfit_3,
  conf.int = TRUE,
  data     = customer_churn_tbl,
  risk.table = TRUE
)

g3_plot <- g3$plot +
  theme_tq() +
  scale_fill_tq() +
  scale_color_tq() +
  labs(
    title = "Customer Churn Survival Plot"
  )

g3_table <- g3$table +
  theme_tq() +
  scale_fill_tq() +
  scale_color_tq() +
  theme(panel.grid = element_blank())

g3_plot / g3_table + plot_layout(heights = c(2,1))

# * BONUS #3: FACETING BY GROUPS ----

g3 <- ggsurvplot_facet(
  sfit_3,
  conf.int = TRUE,
  data     = customer_churn_tbl,
  facet.by = "gender",
  nrow     = 1
)

g3 +
  theme_tq() +
  scale_fill_tq() +
  scale_color_tq() +
  labs(title = "Survival Plot by Customer Gender")






# Fitting the Cox model ----
Cox_mod <- coxph(Surv(tenure, churn) ~ contract, data = customer_churn_tbl)

# Summarizing the model
summary(Cox_mod)

# Fitting survfit()
Cox <- survfit(Cox_mod)
# Plotting the function
plot(Cox)


# Fit a Cox proportional hazards model
ggforest(Cox_mod, data = customer_churn_tbl)

  
  