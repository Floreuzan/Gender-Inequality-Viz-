source("library.R")

#### Read data ####


### 1) Employment ###
#This data looks at how many men and women are in paid work, who works full-time.
# Employment  : Employment/population ratio, by sex and age group
# Age Group 15-64
# 46 countries
# 10 years: 1990, 1995, 2000, 2005, 2010, 2015, 2016, 2017, 2018, 2019
# Unit: Percentage
Employment <- read.csv("Data/Employment.csv", 
                       header = TRUE,
                       stringsAsFactors = FALSE,
                       check.names = FALSE)

# Employment  : Unemployment/population ratio, by sex and age group
# Age Group 15-64
# 46 countries
# 10 years: 1990, 1995, 2000, 2005, 2010, 2015, 2016, 2017, 2018, 2019
# Unit: Percentage
Unemployment <-read.csv("Data/Unemployment.csv", 
                        header = TRUE, 
                        stringsAsFactors = FALSE,
                        check.names = FALSE)


### 2) Education ###
# Enrollment rate by age  : Enrollment rate by age group by gender
# Age group 20-24
# 43 countries
# 4 years: 2015, 2016, 2017, 2018
# 	Total tertiary education (ISCED2011 levels 5 to 8) Full- and part-time:
#   1) Short-Cycle tertiary education
#   2) Bachelor's or equivalent level
#   3) Master's or equivalent level
#   4) Doctoral or equivalent level
Enrolment <-read.csv("Data/Enrolment rate.csv", 
                     header = TRUE, 
                     stringsAsFactors = FALSE,
                     check.names = FALSE)
# Math performance
Math_perf <-read.csv("Data/Mathematics performance.csv", 
                     header = TRUE,
                     stringsAsFactors = FALSE,
                     check.names = FALSE) 
# Reading performance
Read_perf <-read.csv("Data/Reading performance.csv", 
                     header = TRUE,
                     stringsAsFactors = FALSE,
                     check.names = FALSE)
# Science performance
Science_perf <-read.csv("Data/Science performance.csv", 
                        header = TRUE,
                        stringsAsFactors = FALSE,
                        check.names = FALSE)


### 3) Entrepreneurship ###
# This indicator covers two factors which are important when starting a business:
#Financial account holders : This indicator is the number of men (women) aged 15+ who report having an account (by themselves or together with someone else) at a bank or another type of financial institution, or report having personally used a mobile money service in the past 12 months, divided by the total number of men (women) aged 15+.
#Borrowing : This indicator is the number of men (women) aged 15+ who report borrowing money to start a business over the last 12 months, divided by the total number of men (women) aged 15+ in this sex.
#This indicator is measured by gender in percentage of total employed men or women. 
Starting_business <- read.csv("Data/Starting a business.csv", 
                              header = TRUE, 
                              stringsAsFactors = FALSE,
                              check.names = FALSE)

# Those who are self-employed with employees are people whose primary activity is self-employment and who employ others. The incorporated self-employed are only partly or non-included in the counts of self-employed in several countries. This indicator is measured by gender as percentage of total employment.
Self_employed <-read.csv("Data/Self-employed with employees.csv", 
                         header = TRUE, 
                         stringsAsFactors = FALSE,
                         check.names = FALSE)

# For each group (men/women), the indicator is defined as the share of self-employed aged 20-29 among all employed workers aged 20-29 in this group.
Young_self_employed <-read.csv("Data/Young self-employed.csv", 
                               header = TRUE, 
                               stringsAsFactors = FALSE,
                               check.names = FALSE)


#### Cleaning data ####


### Rename the variable COUNTRY ### 
names(Employment)[names(Employment) == "﻿COU"] <-"COUNTRY"
names(Unemployment)[names(Unemployment) == "﻿COU"] <-"COUNTRY"

names(Enrolment)[names(Enrolment) == "﻿COUNTRY"] <- "COUNTRY"
names(Math_perf)[names(Math_perf) == "﻿LOCATION"] <- "COUNTRY"
names(Read_perf)[names(Read_perf) == "﻿LOCATION"] <- "COUNTRY"
names(Science_perf)[names(Science_perf) == "﻿LOCATION"] <- "COUNTRY"

names(Starting_business)[names(Starting_business) == "﻿LOCATION"] <- "COUNTRY"
names(Self_employed)[names(Self_employed) == "﻿LOCATION"] <- "COUNTRY"
names(Young_self_employed)[names(Young_self_employed) == "﻿LOCATION"] <- "COUNTRY"

### Rename the variable YEAR ###
names(Enrolment)[names(Enrolment) == "YEAR"] <- "TIME"

### Rename the variable SEX ### 
names(Employment)[names(Employment) == "SUBJECT"] <-"SEX"
names(Unemployment)[names(Unemployment) == "SUBJECT"] <-"SEX"

names(Math_perf)[names(Math_perf) == "SUBJECT"] <-"SEX"
names(Read_perf)[names(Read_perf)  == "SUBJECT"] <-"SEX"
names(Science_perf)[names(Science_perf) == "SUBJECT"] <-"SEX"

names(Starting_business)[names(Starting_business) == "SUBJECT"] <-"SEX"
names(Self_employed)[names(Self_employed) == "SUBJECT"] <-"SEX"
names(Young_self_employed)[names(Young_self_employed) == "SUBJECT"] <-"SEX"

### Select gender option: "MEN" and "WOMEN" ###
Enrolment$SEX <- gsub("M", "MEN", Enrolment$SEX)
Enrolment$SEX <- gsub("F", "WOMEN", Enrolment$SEX)
Math_perf$SEX <- gsub("BOY", "MEN", Math_perf$SEX)
Math_perf$SEX <- gsub("GIRL", "WOMEN", Math_perf$SEX)
Read_perf$SEX <- gsub("BOY", "MEN", Read_perf$SEX)
Read_perf$SEX <- gsub("GIRL", "WOMEN", Read_perf$SEX)
Science_perf$SEX <- gsub("BOY", "MEN", Science_perf$SEX)
Science_perf$SEX <- gsub("GIRL", "WOMEN", Science_perf$SEX)

Starting_business$SEX <- gsub("MONEY_MEN", "MEN",Starting_business$SEX)
Starting_business$SEX <- gsub("MONEY_WOMEN", "WOMEN", Starting_business$SEX)
Young_self_employed$SEX <- gsub("20_29_MEN", "MEN",Young_self_employed$SEX)
Young_self_employed$SEX <- gsub("20_29_WOMEN", "WOMEN", Young_self_employed$SEX)

Math_perf <- subset(Math_perf, SEX!= "TOT")
Read_perf <- subset(Read_perf, SEX!= "TOT")
Science_perf <- subset(Science_perf, SEX!= "TOT")

### Change the variable VALUE to the name of each dataset ###
names(Employment)[names(Employment) == "Value"] <- "Employment"
names(Unemployment)[names(Unemployment) == "Value"] <- "Unemployment"

names(Enrolment)[names(Enrolment) == "Value"] <- "Enrolment"
names(Math_perf)[names(Math_perf) == "Value"] <- "Math_perf"
names(Read_perf)[names(Read_perf) == "Value"] <- "Read_perf"
names(Science_perf)[names(Science_perf) == "Value"] <- "Science_perf"

names(Starting_business)[names(Starting_business) == "Value"] <- "Starting_business"
names(Self_employed)[names(Self_employed) == "Value"] <- "Self_employed"
names(Young_self_employed)[names(Young_self_employed) == "Value"] <- "Young_self_employed"


#### Select the column of interest ####


### Select the variables: Location, SUbject, Time, Value of the datasets ###
(Employment <- Employment[,c(1,5,9,17)])
(Unemployment <- Unemployment[,c(1,5,9,17)])

Enrolment <- subset(Enrolment, AGE == "Y15T19")
(Enrolment <- Enrolment[,c(1, 7, 13, 15)])
(Math_perf <- Math_perf[,-c(2, 4, 5, 8)])
(Read_perf <- Read_perf[,-c(2, 4, 5, 8)])
(Science_perf <- Science_perf[,-c(2, 4, 5, 8)])

(Starting_business <- Starting_business[, -c(2,4,5,8)])
(Self_employed <- Self_employed[,-c(2, 4, 5, 8)])
(Young_self_employed <- Young_self_employed[,c(1, 3, 6, 7)])


#### Merge the datasets ####


df <- merge(merge(merge(merge(merge(merge(merge(merge(Employment, Unemployment, by=c("COUNTRY", "SEX", "TIME"), all = TRUE),
                                                Enrolment, by=c("COUNTRY", "SEX", "TIME"), all = TRUE),
                                          Math_perf, by=c("COUNTRY", "SEX", "TIME"), all = TRUE),
                                    Read_perf, by=c("COUNTRY", "SEX", "TIME"), all = TRUE),
                              Science_perf, by=c("COUNTRY", "SEX", "TIME"), all = TRUE),
                        Starting_business, by=c("COUNTRY", "SEX", "TIME"), all = TRUE),
                  Self_employed, by=c("COUNTRY", "SEX", "TIME"), all = TRUE),
            Young_self_employed, by=c("COUNTRY", "SEX", "TIME"), all = TRUE)

### pivot longer the dataset ###
df <- df %>%
  pivot_longer(c("Employment",
                 "Unemployment",
                 "Enrolment",
                 "Math_perf",
                 "Read_perf",
                 "Science_perf",
                 "Starting_business",
                 "Self_employed",
                 "Young_self_employed"), names_to = "Category", values_to = "Value")

### Add a theme with values Employment/Education/Entrepreneurship ###
df <- df %>%
  mutate(Sector = ifelse(Category %in% c("Employment", "Unemployment"), "Employment",
                        ifelse(Category%in% c("Enrolment", "Math_perf", "Read_perf", "Science_perf"), "Education", 
                               ifelse(Category%in% c("Starting_business", "Self_employed", "Young_self_employed"), "Entrepreneurship",  NA))))

### Change the country code to the standard 3 letters one ###
df$COUNTRY <- countrycode(df$COUNTRY, origin = 'iso3c', destination = 'country.name') 

df <- na.omit(df) 
save(df, file = "data/gender_wage_gap_by_sector.RData")