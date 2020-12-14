
# Packages and libraries --------------------------------------------------
suppressMessages(library(shiny))            # Required to build and run shiny applications
suppressMessages(library(shinydashboard))   # Required to create dashboard based on AdminLTE
suppressMessages(library(shinyBS))          # Required for Bootstrap javascript
suppressMessages(library(dplyr))             # Required for data manipulation & processing
suppressMessages(library(shinyjs))          # Required for javascript & shiny integration
suppressMessages(library(highcharter))      # Required for chart generation
suppressMessages(library(leaflet))          # Required for leaflet map generation
suppressMessages(library(DT))               # Required for data table generation
suppressMessages(library(stringi))          # Required for string manipulation
suppressMessages(library(xts))              # Required for time series generation
suppressMessages(library(REdaS))            # Required to convert degrees to radians for location selection
suppressMessages(library(tidyr))            # Required for table nesting
suppressMessages(library(readr))            # Required for table nesting



# Load required packages.
library(janitor)
library(lubridate)
library(hms)
library(tidyr)
library(stringr)
library(readr)
library(forcats)
# library(RcppRoll)
library(dplyr)
library(tibble)



# Options -----------------------------------------------------------------
options(sqldf.driver = "SQLite")  # Prevents RMySQL conflicts
options(scipen = 999)             # Disables scientific notation

source("config.R", local = TRUE)

# Load data ---------------------------------------------------------------
# load("data/properties.Rda")     # Contains property information

transactions <- read_delim("data/Tiller Personal Finance - Transactions.tsv", "\t", escape_double = FALSE, locale = locale(), trim_ws = TRUE) %>% 
  readr::type_convert() %>%
  mutate(Date = mdy(Date), Month = mdy(Month), Week = mdy(Week), `Categorized Date` = mdy(`Categorized Date`), `Date Added` = mdy(`Date Added`), Category = factor(Category)) %>%
  mutate(Amount = str_remove(Amount, regex("\\$", ignore_case = TRUE))) %>%
  mutate(Amount = parse_number(Amount), Account = factor(Account), `Account #` = factor(`Account #`))

# Set libPaths.
# .libPaths("/Users/superjohn/Documents/exploratory/R/4.0")

# financialmapping$EXP2 <- as.factor(as.character(financialmapping$EXP2))
# Turn net room area into numeric
# room.list.archibus$Net.Rm.Area <- gsub(",", "", room.list.archibus$Net.Rm.Area)
# room.list.archibus$Net.Rm.Area <- as.numeric(as.character(room.list.archibus$Net.Rm.Area))

# wo <- read.csv("data/wo.csv", stringsAsFactors = FALSE)   # Contains work order for Regional
# wo$date_originated <- as.Date(wo$date_originated, format = "%m/%d/%Y")

# Restrict financial data to only accounts allowed (includes Green Street temporarily while explainable variance is figured out)
rboOwned <- list(82303,82357,82399,82363,82362,82388,82375,80043,82324,82344,82343,82330,82301,82315,82304,80508) # Added Bostonia (80508 7.28.17)
# financials1 <- financials %>% filter(ACCTDESC %in% acctdesc)
