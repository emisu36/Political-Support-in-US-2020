#### Preamble ####
# Purpose: Cleans the raw plane data for better format.
# Author: Ping-Jen (Emily) Su
# Date: 15 Mar 2024
# Contact: emily.su@mail.utoronto.ca 
# License: MIT
# Pre-requisites: Data is obtained from 01
# Any other information needed? 

#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Clean data ####
ces2020 <-
  read_csv(
    here::here("data/raw_data/ces2020.csv"),
    col_types =
      cols(
        "votereg" = col_integer(),
        "CC20_410" = col_integer(),
        "gender" = col_integer(),
        "birthyr" = col_integer()
      )
  )

ces2020


ces2020 <-
  ces2020 |>
  filter(votereg == 1,
         CC20_410 %in% c(1, 2)) |>
  mutate(
    voted_for = if_else(CC20_410 == 1, "Biden", "Trump"),
    voted_for = as_factor(voted_for),
    gender = if_else(gender == 1, "Male", "Female"),
    age = as.numeric(2020 - birthyr),
  age_group = case_when(
    age <= 29 ~ "18-29",
    age <= 44 & age > 29 ~ "30-44",
    age <= 64 & age > 44 ~ "45-64",
    age >= 65 ~ "65 and over",
  ),
  age_group = factor(
    age_group,
    levels = c(
      "18-29",
      "30-44",
      "45-64",
      "65 and over"
    )
  )
  ) |>
    select(voted_for, gender, age_group)
  
  
  #### Save data ####
  write_parquet(ces2020, "data/analysis_data/analysis_data.parquet")
  
