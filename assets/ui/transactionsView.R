
  # Show a plot of the generated distribution
mainPanel(
    h2("Transactions Data"),
    DT::dataTableOutput("mytable"),
    
    h2("Amazon Orders"),
    DT::dataTableOutput("amazonOrders")
  )