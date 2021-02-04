mainPanel(
  
  ### TAB-PANELS ###
  fluidRow(
    infoBox("Cash MTD", "$12,030", icon = icon("credit-card")),
    infoBox("Debt MTD", "$14,030", icon = icon("credit-card")),
    infoBox("Savings MTD", "$1,530", icon = icon("credit-card"))
  ),
  
  fluidRow(
    box(title = "Account Balances", status = "primary", solidHeader = TRUE, width = 12, 
        highchartOutput("accountBalancePlot")
        # highchartOutput("plotBudgetTreeMap")
    )
  )
  
)