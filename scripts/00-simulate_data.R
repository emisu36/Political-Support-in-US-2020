#### Preamble ####
# Purpose: Simulates Data for Election
# Author: Ping-Jen (Emily) Su
# Date: 15 Mar 2024 
# Contact: emily.su@mail.utoronto.ca
# License: MIT
# Pre-requisites: Variable name unknown, but data can be found


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(853)

num_obs <- 1000

us_political_preferences <- tibble(
  age = sample(0:3, size = num_obs, replace = TRUE),
  gender = sample(0:1, size = num_obs, replace = TRUE),
  support_prob = ((age + gender) / 5),
) |>
  mutate(
    supports_biden = if_else(runif(n = num_obs) < support_prob, "yes", "no"),
    age = case_when(
      age == 0 ~ "18-29",
      age == 1 ~ "30-44",
      age == 2 ~ "45-64",
      age == 3 ~ "65 and over",
    ),
    gender = if_else(gender == 0, "Male", "Female")
  ) |>
  select(-support_prob, supports_biden, gender, age)



