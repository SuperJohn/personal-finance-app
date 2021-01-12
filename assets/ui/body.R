body <- dashboardBody(
  
  useShinyjs(),
  fluidRow(
    tabItems(
      tabItem(tabName = "transactionsView", source("assets/ui/transactionsView.R", local = TRUE)[1]),
      tabItem(tabName = "incomeView", source("assets/ui/incomeView.R", local = TRUE)[1]),
      tabItem(tabName = "budgetView", source("assets/ui/budgetView.R", local = TRUE)[1]),
      tabItem(tabName = "amazonTransactionsView", source("assets/ui/amazonTransactionsView.R", local = TRUE)[1]),
      tabItem(tabName = "devRef", source("assets/ui/devRef.R", local = TRUE)[1]),
      tabItem(tabName = "releaseNotes", source("assets/ui/releaseNotes.R", local = TRUE)[1]),
      tabItem(tabName = "leaseSummary"),
      tabItem(tabName = "riskManagement"),
      tabItem(tabName = "occupancy"),
      tabItem(tabName = "help")
      
    )
  )
)