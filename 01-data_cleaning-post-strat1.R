#### Preamble ####
# Purpose: Prepare and clean the survey data downloaded from ACS census data
# Author: Pablo Mercado, Benjamin Zhang, Daniel Leung, Diane Kim
# Data: 22 October 2020
# Contact: pablo.mercado@mail.utoronto.ca
# License: MIT
# Pre-requisites: 
# - Need to have downloaded the ACS data and saved it to inputs/data
# - Don't forget to gitignore it!
setwd("C:/Users/Poe Mercado/Desktop/U of T pdfs/year 3/STA304/Problem set 3")

#### Workspace setup ####
library(haven)
library(tidyverse)

# Read in the raw data.

raw_data <- read_dta("inputs/usa_00002.dta")
survey_data <- read_csv("outputs/survey_data.csv")

# Add the labels
raw_data <- labelled::to_factor(raw_data)

# Just keep some variables that may be of interest (change 
# this depending on your interests)
reduced_data1 <- 
  raw_data %>% 
  select(stateicp,
         race, 
         educ,
         ftotinc) %>%
  filter(stateicp != "state groupings (1980 urban/rural sample)",
         stateicp != "military/mil. reservations",
         stateicp != "state not identified") %>%
  mutate(race =
           ifelse(race == "white", "Caucasian", "Not Caucasian"))
  
         
#### What's next? ####

## Here I am only splitting cells by age, but you 
## can use other variables to split by changing
## count(age) to count(age, sex, ....)

reduced_data1$ftotinc[reduced_data1$ftotinc <= 14999] = "$0 - $15k: living in poverty"
reduced_data1$ftotinc[reduced_data1$ftotinc %in% 15000:34999] = "$15k - $35k: low income"
reduced_data1$ftotinc[reduced_data1$ftotinc %in% 35000:69999] = "$35k - $70k: middle class"
reduced_data1$ftotinc[reduced_data1$ftotinc %in% 70000:149999] = "$70 - $150k: upper middle class"
reduced_data1$ftotinc[reduced_data1$ftotinc %in% 150000:1500000] = "$150k+ : upper class"

reduced_data1$stateicp <- gsub("connecticut","CT",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("maine","ME",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("massachusetts","MA",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("new hampshire","NH",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("rhode island","RI",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("vermont","VT",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("delaware","DE",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("new jersey","NJ",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("new york","NY",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("pennsylvania","PA",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("illinois","IL",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("indiana","IN",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("michigan","MI",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("ohio","OH",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("wisconsin","WI",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("iowa","IA",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("kansas","KS",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("minnesota","MN",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("missouri","MO",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("nebraska","NE",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("north dakota","ND",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("south dakota","SD",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("virginia","VA",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("alabama","AL",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("arKS","AR",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("florida","FL",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("georgia","GA",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("louisiana","LA",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("mississippi","MS",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("north carolina","NC",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("south carolina","SC",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("texas","TX",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("kentucky","KY",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("maryland","MD",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("west VA","WV",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("arizona","AZ",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("colorado","CO",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("idaho","ID",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("montana","MT",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("nevada","NV",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("new mexico","NM",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("utah","UT",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("wyoming","WY",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("california","CA",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("oregon","OR",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("washington","WA",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("alaska","AK",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("hawaii","HI",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("oklahoma","OK",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("tennessee","TN",reduced_data1$stateicp)
reduced_data1$stateicp <- gsub("district of columbia","DC",reduced_data1$stateicp)

reduced_data1$educ <- gsub("n/a or no schooling", "No highschool diploma", reduced_data1$educ, fixed=TRUE)
reduced_data1$educ <- gsub("nursery school to grade 4", "No highschool diploma", reduced_data1$educ, fixed=TRUE)
reduced_data1$educ <- gsub("grade 5, 6, 7, or 8", "No highschool diploma", 
                           reduced_data1$educ, fixed=TRUE)
reduced_data1$educ <- gsub("grade 9", "No highschool diploma", 
                           reduced_data1$educ, fixed=TRUE)
reduced_data1$educ <- gsub("grade 10", "No highschool diploma", 
                           reduced_data1$educ, fixed=TRUE)
reduced_data1$educ <- gsub("grade 11", "No highschool diploma", 
                           reduced_data1$educ, fixed=TRUE)
reduced_data1$educ <- gsub("grade 12", "No highschool diploma", 
                           reduced_data1$educ, fixed=TRUE)
reduced_data1$educ <- gsub("1 year of college","Highschool diploma" , reduced_data1$educ, fixed=TRUE)
reduced_data1$educ <- gsub("2 years of college", "Highschool diploma",reduced_data1$educ, fixed=TRUE)
reduced_data1$educ <- gsub("3 years of college", "Highschool diploma",reduced_data1$educ, fixed=TRUE)
reduced_data1$educ <- gsub("4 years of college", "Undergraduate degree", reduced_data1$educ, fixed=TRUE)
reduced_data1$educ <- gsub("5+ years of college", "Graduate degree or more", reduced_data1$educ, fixed=TRUE)


# Saving the census data as a csv file in my
# working directory
write_csv(reduced_data1, "outputs/census_data.csv")



         