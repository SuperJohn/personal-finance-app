body <- dashboardBody(
  
  useShinyjs(),
  fluidRow(
    tabItems(
      tabItem(tabName = "transactionsView", source("assets/ui/transactionsView.R", local = TRUE)[1]),
      tabItem(tabName = "releaseNotes", source("assets/ui/releaseNotes.R", local = TRUE)[1]),
      tabItem(tabName = "leaseSummary"),
      tabItem(tabName = "riskManagement"),
      tabItem(tabName = "occupancy"),
      tabItem(tabName = "help")
      
    )
  )
)