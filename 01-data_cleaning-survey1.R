#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from voterstudygroup.com
# Author: Pablo Mercado, Benjamin Zhang, Daniel Leung, Diane Kim
# Data: 22 October 2020
# Contact: pablo.mercado@mail.utoronto.ca, benny.zhang@mail.utoronto.ca,
#          dian.kim@mail.utoronto.ca, danielck.leung@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the data from X and save the folder that you're 
# interested in to inputs/data 
# - Don't forget to gitignore it!
setwd("C:/Users/Poe Mercado/Desktop/U of T pdfs/year 3/STA304/Problem set 3")

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
         state) %>%
  drop_na(household_income, vote_2020, race_ethnicity, education, state) 


#### What else???? ####
# Maybe make some age-groups?
# Maybe check the values?
# Is vote a binary? If not, what are you going to do?

reduced_data<-
  reduced_data %>%
  mutate(vote_trump = 
           ifelse(vote_2020=="Donald Trump", 1, 0),
         race_ethnicity = 
           ifelse(race_ethnicity != "White", "Not Caucasian", "Caucasian"))

reduced_data$household_income <- gsub("Less than $14,999","$0 - $15k, living in poverty",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$15,000 to $19,999","$15k - $35k: low income",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$20,000 to $24,999","$15k - $35k: low income",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$25,000 to $29,999","$15k - $35k: low income",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$30,000 to $34,999","$15k - $35k: low income",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$35,000 to $39,999","$35k - $70k: middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$40,000 to $44,999","$35k - $70k: middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$45,000 to $49,999","$35k - $70k: middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$50,000 to $54,999","$35k - $70k: middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$55,000 to $59,999","$35k - $70k: middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$60,000 to $64,999","$35k - $70k: middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$65,000 to $69,999","$35k - $70k: middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$70,000 to $74,999","$70 - $150k: upper middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$75,000 to $79,999","$70 - $150k: upper middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$80,000 to $84,999","$70 - $150k: upper middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$85,000 to $89,999","$70 - $150k: upper middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$90,000 to $94,999","$70 - $150k: upper middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$95,000 to $99,999","$70 - $150k: upper middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$100,000 to $124,999","$70 - $150k: upper middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$125,000 to $149,999","$70 - $150k: upper middle class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$150,000 to $174,999","$150k+ : upper class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$175,000 to $199,999","$150k+ : upper class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$200,000 to $249,999","$150k+ : upper class",reduced_data$household_income,fixed = TRUE)
reduced_data$household_income <- gsub("$250,000 and above","$150k+ : upper class",reduced_data$household_income,fixed = TRUE)

reduced_data$education <- gsub("3rd Grade or less", "No highschool diploma", reduced_data$education, fixed=TRUE)
reduced_data$education <- gsub("Middle School - Grades 4 - 8", "No highschool diploma", reduced_data$education, fixed=TRUE)
reduced_data$education <- gsub("Completed some high school", "No highschool diploma", reduced_data$education, fixed=TRUE)
reduced_data$education <- gsub("High school graduate", "Highschool diploma", reduced_data$education, fixed=TRUE)
reduced_data$education <- gsub("Other post high school vocational training", "Highschool diploma", reduced_data$education, fixed=TRUE)
reduced_data$education <- gsub("Completed some college, but no degree", "Highschool diploma", reduced_data$education, fixed=TRUE)
reduced_data$education <- gsub("Completed some college, but no degree", "Highschool diploma", reduced_data$education, fixed=TRUE)
reduced_data$education <- gsub("Associate Degree", "Highschool diploma", reduced_data$education, fixed=TRUE)
reduced_data$education <- gsub("College Degree (such as B.A., B.S.)", "Undergraduate degree", reduced_data$education, fixed=TRUE)
reduced_data$education <- gsub("Completed some graduate, but no degree", "Undergraduate degree", reduced_data$education, fixed=TRUE)
reduced_data$education <- gsub("Masters degree", "Graduate degree or more", reduced_data$education, fixed=TRUE)
reduced_data$education <- gsub("Doctorate degree", "Graduate degree or more", reduced_data$education, fixed=TRUE)


# Saving the survey/sample data as a csv file in my
# working directory
write_csv(reduced_data, "outputs/survey_data.csv")

