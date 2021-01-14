
  # Show a plot of the generated distribution
mainPanel(
  
  ### TAB-PANELS ###
  fluidRow(
    infoBox("Expenses MTD", "$12,030", icon = icon("credit-card")),
    infoBox("Income MTD", "$14,030", icon = icon("credit-card")),
    infoBox("Net Income MTD", "$1,530", icon = icon("credit-card"))
  ),

  fluidRow(
    box(title = "Transaction Filters", status = "primary", solidHeader = FALSE, width = 12, collapsible = TRUE, collapsed = FALSE,
        # verbatimTextOutput(output$dateSelectorOutput),
        box(selectInput("typeSelectInput", label = "Select Type",
                        choices = levels(transactions$type),
                        selected = transactionsView.type.default, multiple = TRUE, selectize = TRUE)
            ),
        box(selectInput("groupSelectInput", label = "Select Group",
                        choices = levels(transactions$group),
                        selected = transactionsView.group.default, multiple = TRUE, selectize = TRUE)
            ),
        selectizeInput("categorySelectInput", label = "Select Category",
                       choices = levels(transactions$category),
                       selected = levels(transactions$category), multiple = TRUE, size = 5)
        )
  ),
  
  
                                                                           
  fluidRow(
    box(title = "Transactions", status = "primary", solidHeader = FALSE, width = 12, 
      tabsetPanel(
        tabPanel("Transactions", 
                 
                     div(DT::dataTableOutput("mytable"), style = "font-size: 100%; width: 100%")
                 ), 
        tabPanel("Category Summary", 
                     DT::dataTableOutput("transactionsView.category.table")
                 )
        )
    )
  )
  
)