
mainPanel(
  
  ### TAB-PANELS ###
  fluidRow(
    infoBox("Income YTD", "$174,030", icon = icon("credit-card")), # A static infoBox
    infoBoxOutput("progressBox"), # Dynamic infoBox
    infoBoxOutput("approvalBox") # Dynamic infoBox
  ),

  fluidRow(
    ### INCOME CHART ###
    box(title = "Income Events", status = "primary", solidHeader = TRUE, width = 12, 
        selectInput("incomeChartSelect", label = "Select Income Chart Type",
                    choices = c("Income Events YTD", "Total Income YTD", "Income By Source YTD"),
                    selected = "Income Events YTD", multiple = FALSE,
                    width = "100%"),
      plotOutput("plot_income_events_last6mo")
      )
    ), 
  fluidRow(
    box(title = "Income Transactions", status = "primary", solidHeader = FALSE, width = 12,
      DT::dataTableOutput("incomeTransactions")
    )
  )

)