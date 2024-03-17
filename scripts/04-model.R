#### Preamble ####
# Purpose: Models for logistics regression between gender, age and vote choice
# Author: Ping_Jen (Emily) Su
# Date: 15 Mar 2024 
# Contact: emily.su@mail.utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: The analysis_data has correct variables
# Any other information needed? Preassumption for logistics regression satisfied


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
analysis_data <- read_parquet("data/analysis_data/analysis_data.parquet")

set.seed(886)

analysis_data <- 
  ces2020 |> 
  slice_sample(n = 1000)


### Model data ####
first_model <-
  stan_glm(
    formula = voted_for ~ gender + age_group,
    data = analysis_data,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 886
  )

prior_summary(first_model)

#### Save model ####
saveRDS(
  first_model,
  file = "models/first_model.rds"
)


