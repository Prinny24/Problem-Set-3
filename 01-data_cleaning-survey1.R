#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from voterstudygroup.com
# Author: Pablo Mercado, Benjamin Zhang, Daniel Leung, Diane Kim
# Data: 22 October 2020
# Contact: pablo.mercado@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from X and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!


#### Workspace setup ####
library(haven)
library(tidyverse)

# Read in the raw data (You might need to change this if you use a different dataset)
raw_data <- read_dta("inputs/ns20200625.dta")
# Add the labels
raw_data <- labelled::to_factor(raw_data)
# Just keep some variables
reduced_data <- 
  raw_data %>% 
  select(vote_2020,
         race_ethnicity,
         household_income,
         education,
         state)


#### What else???? ####
# Maybe make some age-groups?
# Maybe check the values?
# Is vote a binary? If not, what are you going to do?

reduced_data<-
  reduced_data %>%
  mutate(vote_trump = 
           ifelse(vote_2020=="Donald Trump", 1, 0),
         vote_biden = 
           ifelse(vote_2020=="Joe Biden", 1, 0),
         )



# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_data, "outputs/survey_data.csv")

