#### Preamble ####
# Purpose: Tests for dataset
# Author: Ping-Jen (Emily) Su
# Date: 15 Mar 2024 
# Contact: emily.su@mail.utoronto.ca
# License: MIT
# Pre-requisites: Given the analysis data is cleaned properly
# Any other information needed?


#### Work space setup ####
library(tidyverse)
library(testthat) 
library(here) 


#### Test data ####
analysis_data <- read_parquet("data/analysis_data/analysis_data.parquet")


# Test to ensure the data frame exists after loading.
test_that("Data frame is created", {
  expect_true(exists("analysis_data"))
})

# Verify that the data frame contains the specific columns expected.
test_that("Data frame has correct columns", {
  expect_true(all(c("voted_for", "gender", "age_group") %in% names(analysis_data)))
})

# Check the class/type of variables in the data frame to match expectations.
test_that("Check class", {
  expect_type(analysis_data$age, "integer")
  expect_type(analysis_data$gender, "character")
  expect_type(analysis_data$voted_for, "integer")
})
# Verify that the 'gender' column contains only the specified categories.
test_that("Gender levels are correctly assigned", {
  expect_setequal(unique(analysis_data$gender), c("Male", "Female"))
})

# Confirm that the 'voted_for' column only contains the values "Clinton" or "Trump".
test_that("'voted_for' contains only 'Biden' or 'Trump'", {
  expect_true(all(analysis_data$voted_for %in% c("Biden", "Trump")))
})

# Check that the data frame has the exact number of rows expected (1000).
test_that("Check number of observations is correct", {
  expect_equal(nrow(analysis_data), 43554)
})

# Ensure every row in the data frame is complete, with no missing values.
test_that("Check complete", {
  expect_true(all(complete.cases(analysis_data)))
})

