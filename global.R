
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
  mutate(Amount = parse_number(Amount), Account = factor(Account), `Account #` = factor(`Account #`)) %>% 
  dplyr::select(c('Date', 'Amount', 'Category', 'Description')) %>%
  janitor::clean_names()

amazon_transaction_history <- read_csv("data/amazon_transactions_2021.csv") %>%
  mutate(`Order Date` = as.Date(parse_date_time(`Order Date`, "m/d/y"))) %>%
  mutate(`Shipment Date` = as.Date(parse_date_time(`Shipment Date`, "m/d/y"))) %>%
  mutate(`Item Total` = -as.numeric(gsub("\\$", "", `Item Total`))) %>%
  mutate(`Category` = as.factor(`Category`)) %>%
  select(c("Order ID", "Item Total", "Order Date", "Shipment Date", "Category", "Title")) %>%
  clean_names()

amazon_orders <- amazon_transaction_history %>%
  group_by(order_date, shipment_date, order_id) %>%
  summarise(item_total = sum(item_total))

# Source scripts ----------------------------------------------------------
# source("functions/dataGrabber.R", local = TRUE)

source("assets/ui/header.R", local = TRUE)
source("assets/ui/sidebar.R", local = TRUE)
source("assets/ui/body.R", local = TRUE)
# source("assets/ui/transactionsView.R", local = TRUE)