sidebar <- dashboardSidebar(
  sidebarSearchForm(textId = "sidebarSearch", buttonId = "sidebarSearchButton", label = "Search Transactions"),
  dateRangeInput(inputId = "dateSelectorInput", label = "Select Dates", start = transactionsView.start, end = transactionsView.end, 
                 min = as.Date(min(transactions$date)), max = as.Date(max(transactions$date)), 
                 format = "yyyy-mm-dd",
                 startview = "year",
                 weekstart = 0,
                 language = "en",
                 separator = " to ",
                 width = NULL,
                 autoclose = TRUE),
  sidebarMenu(
    HTML("<li class='header'>DASHBOARDS/REPORTS</li>"),
    menuItem(text = "Transactions View", tabName = "transactionsView", icon = icon("th")),
    menuItem(text = "Income View", tabName = "incomeView", icon = icon("th")),
    menuItem(text = "Budgets", tabName = "budgetView", icon = icon("building")),
    menuItem(text = "Category Spending", tabName = "categoryView", icon = icon("building")),
    menuItem(text = "Balances", tabName = "balanceView", icon = icon("building")),
    menuItem('Dashboard Gallery', tabName = 'y', icon = icon('line-chart'),
             menuItem('Dashboard a',
                      tabName = 'a',
                      icon = icon('line-chart')),
             menuItem('Dashboard b',
                      tabName = 'b',
                      icon = icon('line-chart'),
                      menuSubItem('l',
                                  tabName = 'l',
                                  icon = icon('line-chart')),
                      menuSubItem('m',
                                  tabName = 'm',
                                  icon = icon('line-chart'))),
             menuItem('Dashboard c',
                      tabName = 'c',
                      icon = icon('line-chart'))
    ), 
    menuItem(text = "Amazon Transactions", tabName = "amazonTransactionsView", icon = icon("dashboard")),
    menuItem(text = "Dev Ref", tabName = "devRef", icon = icon("sticky-note")), 
    HTML("<li class='header'>HELP TOPICS</li>"),
    menuItem(text = "Help", tabName = "help", icon = icon("life-ring")),
    menuItem(text = "Release Notes", tabName = "releaseNotes", icon = icon("sticky-note"))
    )
  
  )

  