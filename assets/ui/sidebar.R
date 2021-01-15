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
    menuItem(text = "Transactions View", tabName = "transactionsView", icon = icon("money-check-alt")),
    menuItem(text = "Income View", tabName = "incomeView", icon = icon("money-bill-alt")),
    menuItem(text = "Budgets", tabName = "budgetView", icon = icon("hat-wizard")),
    menuItem(text = "Category Spending", tabName = "categoryView", icon = icon("chart-area")),
    menuItem('Dashboard Gallery', tabName = 'y', icon = icon('fighter-jet'),
             menuItem('Magic Dashboard',
                      tabName = 'a',
                      icon = icon('magic')),
             menuItem('Gems Dashboard',
                      tabName = 'b',
                      icon = icon('gem'),
                      menuSubItem('Candy Canes',
                                  tabName = 'Candy Canes',
                                  icon = icon('candy-cane')),
                      menuSubItem('Beers',
                                  tabName = 'Beers',
                                  icon = icon('beer'))),
             menuItem('Explosive Dashboard',
                      tabName = 'Explosive Dashboard',
                      icon = icon('bomb'))
    ), 
    HTML("<li class='header'>HELP TOPICS</li>"),
    menuItem(text = "Dev Ref", tabName = "devRef", icon = icon("laptop-code")), 
    menuItem(text = "Help", tabName = "help", icon = icon("life-ring")),
    menuItem(text = "Release Notes", tabName = "releaseNotes", icon = icon("sticky-note"))
    )
  
  )

  