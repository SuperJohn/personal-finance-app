
mainPanel(

  ### TAB-PANELS ###
  fluidRow(
    infoBox("Income YTD", "$12,323", icon = icon("credit-card")), # A static infoBox
    infoBoxOutput("progressBox"), # Dynamic infoBox
    infoBoxOutput("approvalBox") # Dynamic infoBox
  ),

  fluidRow(
        box(
          selectInput("incomeMonthSelect", label = "Select Income Month",
                      choices = c(budget.months),
                      selected = max(budget.months), multiple = FALSE)
        ),
        box(width = 6, status = "primary", solidHeader = TRUE, 
            selectInput("incomeChartSelect", label = "Select Income Chart Type",
                        choices = income.plots,
                        selected = income.plots.selected, multiple = FALSE)
            )
  ),
  
  fluidRow(
    ### INCOME CHART ###
    box(title = "Income Events", status = "primary", solidHeader = TRUE, width = 12, 
      plotOutput("plot_income_events_last6mo")
      )
    ), 
  fluidRow(
    box(title = "Income Transactions", status = "primary", solidHeader = TRUE, width = 12, 
      DT::dataTableOutput("incomeTransactions")
      )
  )
)
