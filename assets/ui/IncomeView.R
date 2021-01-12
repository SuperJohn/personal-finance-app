
mainPanel(
  
  h2("Income Events"),
  plotOutput("plot_income_events_last6mo"), 
  
  h2("Income Transactions"),
  DT::dataTableOutput("incomeTransactions")

)