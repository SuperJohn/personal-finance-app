
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

# Load required packages new
suppressMessages(library(janitor))
suppressMessages(library(lubridate))
suppressMessages(library(hms))
suppressMessages(library(tidyr))
suppressMessages(library(stringr))
suppressMessages(library(readr))
suppressMessages(library(forcats))
suppressMessages(library(dplyr))
suppressMessages(library(tibble))
suppressMessages(library(ggplot2))

# Options -----------------------------------------------------------------
options(scipen = 999)             # Disables scientific notation

source("config.R", local = TRUE)

# Load data ---------------------------------------------------------------

setwd("~/Documents/dev/personal_finance")
tiller_categories_data <- read_delim("data/Tiller Personal Finance - Categories.tsv", "\t", escape_double = FALSE, locale = locale(), trim_ws = TRUE)
tiller_transactions <- read_delim("data/Tiller Personal Finance - Transactions.tsv", "\t", escape_double = FALSE, locale = locale(), trim_ws = TRUE)
john_amazon_items <- read_csv("data/amazon_transactions_2021.csv")
sarah_amazon_items <- read_csv("data/sarah_amazon_items.csv")


source("functions/dataLoader.R", local = TRUE)

# Source scripts ----------------------------------------------------------

source("assets/ui/header.R", local = TRUE)
source("assets/ui/sidebar.R", local = TRUE)
source("assets/ui/body.R", local = TRUE)