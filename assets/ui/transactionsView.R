
  # Show a plot of the generated distribution
mainPanel(
  fluidRow(
    column(12,
    h2("Transactions Data"),
    div(DT::dataTableOutput("mytable"), style = "font-size: 100%; width: 100%")
    )
  ), 
  
  fluidRow(
    column(12,
    h2("Amazon Orders"),
    DT::dataTableOutput("amazonOrders")
    )
  )
)