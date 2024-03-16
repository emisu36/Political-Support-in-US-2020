#### Preamble ####
# Purpose: Downloads and saves the data from data base of harvard
# Author: Ping-Jen (Emily) Su
# Date: 15 Mar 2024 
# Contact: emily.su@mail.utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: Data is found on website


#### Workspace setup ####
library(dataverse)
library(tidyverse)


#### Download data ####
ces2020 <-
  get_dataframe_by_name(
    filename = "CES20_Common_OUTPUT_vv.csv",
    dataset = "10.7910/DVN/E9N6PH",
    server = "dataverse.harvard.edu",
    .f = read_csv
  ) |> 
  select(votereg, CC20_410, gender, educ, birthyr)


#### Save data ####
write_csv(ces2020, "data/raw_data/ces2020.csv")


