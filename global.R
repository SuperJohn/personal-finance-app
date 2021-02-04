
# Packages and libraries --------------------------------------------------
suppressMessages(library(shiny))            # Required to build and run shiny applications
suppressMessages(library(shinydashboard))   # Required to create dashboard based on AdminLTE
suppressMessages(library(shinyBS))          # Required for Bootstrap javascript
suppressMessages(library(shinyjs))          # Required for javascript & shiny integration
suppressMessages(library(janitor))
suppressMessages(library(lubridate))
suppressMessages(library(hms))
suppressMessages(library(reshape2))
suppressMessages(library(tidyverse))
# visualization libraries
suppressMessages(library(treemap))
suppressMessages(library(d3treeR))
suppressMessages(library(plotly))
suppressMessages(library(highcharter))      # Required for chart generation
suppressMessages(library(DT))               # Required for data table generation
suppressMessages(library(d3Dashboard))
suppressMessages(library(htmlwidgets))
suppressMessages(library(htmltools))
suppressMessages(library(pivottabler))
suppressMessages(library(forecast))

# Options -----------------------------------------------------------------
options(scipen = 999)             # Disables scientific notation

source("config.R", local = TRUE)
source("settings.R", local = TRUE)

# Load data ---------------------------------------------------------------
tiller_categories_data <- read_csv("data/categories.csv", col_types = category_col_types)
tiller_transactions <- read_csv("data/transactions.csv", col_types = transactions_col_types)
balance_history <- read_csv("data/balance_history.csv", col_types = balance_history_col_types)
john_amazon_items <- read_csv("data/amazon_transactions_2021.csv", col_types = amazon_orders_col_types)
sarah_amazon_items <- read_csv("data/sarah_amazon_items.csv", col_types = amazon_orders_col_types)

# run script that defines datasets used throughout application
source("functions/formats.R", local = TRUE)
suppressWarnings(source("functions/dataLoader.R", local = TRUE))
# load script to create bullet graphs
source("assets/ui/bulletGraph.R", local = TRUE) # bulletgraph()
source("assets/ui/Rbulletgraph.R", local = TRUE) # bullet.graph(incidents) 

# Source scripts ----------------------------------------------------------
source("settings.R", local = TRUE)
source("assets/ui/header.R", local = TRUE)
source("assets/ui/sidebar.R", local = TRUE)
source("assets/ui/body.R", local = TRUE)