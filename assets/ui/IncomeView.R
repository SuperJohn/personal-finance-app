
mainPanel(
  
  ### TAB-PANELS ###
  fluidRow(
    # A static infoBox
    infoBox("Income YTD", "$174,030", icon = icon("credit-card")),
    # Dynamic infoBoxes
    infoBoxOutput("progressBox"),
    infoBoxOutput("approvalBox")
  ),
  
  fluidRow(
    # Clicking this will increment the progress amount
    box(width = 4, actionButton("count", "Increment progress"))
  ), 
  
  
  fluidRow(
    ### INCOME CHART ###
    box(title = "Income Events", status = "primary", solidHeader = TRUE, width = 8, 
      plotOutput("plot_income_events_last6mo")
      ),
    
    ### SLIDER & RIGHT CONTENT ###
    box(title = "Test Input", status = "primary", solidHeader = TRUE, width = 4,
      "Box content here", br(), "More box content",
      sliderInput("slider", "Slider input:", 1, 100, 50),
      textInput("text", "Text input:")
      )
    ), 
   
  ### INCOME TRANSACTIONS TABLE ###
  h2("Income Transactions"),
  DT::dataTableOutput("incomeTransactions")

)