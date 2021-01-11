sidebar <- dashboardSidebar(
  sidebarSearchForm(textId = "sidebarSearch", buttonId = "sidebarSearchButton", label = "Search Transactions"),
  sidebarMenu(
    HTML("<li class='header'>DASHBOARDS/REPORTS</li>"),
    menuItem(text = "Transactions View", tabName = "transactionsView", icon = icon("globe")),
    menuItem(text = "Amazon Transactions", tabName = "amazonTransactionsView", icon = icon("globe")),
    menuItem(text = "Income View", tabName = "incomeView", icon = icon("building")),
    menuItem(text = "Summary View", tabName = "occupancy", icon = icon("briefcase")),
    menuItem(text = "Monthly Budgets", tabName = "riskManagement", icon = icon("bomb")),
    menuItem(text = "Dev Ref", tabName = "devRef", icon = icon("sticky-note")), 
    HTML("<li class='header'>HELP TOPICS</li>"),
    menuItem(text = "Help", tabName = "help", icon = icon("life-ring")),
    menuItem(text = "Release Notes", tabName = "releaseNotes", icon = icon("sticky-note"))
    )
  
  )

  