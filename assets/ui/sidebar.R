sidebar <- dashboardSidebar(
  sidebarSearchForm(textId = "sidebarSearch", buttonId = "sidebarSearchButton", label = "Search Transactions"),
  sidebarMenu(
    HTML("<li class='header'>DASHBOARDS/REPORTS</li>"),
    menuItem(text = "Transactions View", tabName = "transactionsView", icon = icon("th")),
    menuItem(text = "Amazon Transactions", tabName = "amazonTransactionsView", icon = icon("dashboard")),
    menuItem(text = "Income View", tabName = "incomeView", icon = icon("th")),
    menuItem(text = "Budget View", tabName = "budgetView", icon = icon("building"), badgeLabel = "new", badgeColor = "green"),
    menuItem(text = "Category View", tabName = "categoryView", icon = icon("building"), badgeLabel = "new", badgeColor = "green"),
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
    
    menuItem(text = "Summary View", tabName = "occupancy", icon = icon("briefcase"), badgeLabel = "TBD", badgeColor = "navy"),
    menuItem(text = "Monthly Budgets", tabName = "riskManagement", icon = icon("bomb"), badgeLabel = "TBD", badgeColor = "navy"),
    menuItem(text = "Dev Ref", tabName = "devRef", icon = icon("sticky-note")), 
    HTML("<li class='header'>HELP TOPICS</li>"),
    menuItem(text = "Help", tabName = "help", icon = icon("life-ring")), badgeLabel = "TBD", badgeColor = "navy",
    menuItem(text = "Release Notes", tabName = "releaseNotes", icon = icon("sticky-note"), badgeLabel = "TBD", badgeColor = "navy")
    )
  
  )

  