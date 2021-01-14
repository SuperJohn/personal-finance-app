
  # Show a plot of the generated distribution
mainPanel(
  
  ### TAB-PANELS ###
  fluidRow(
    infoBox("Expenses MTD", "$12,030", icon = icon("credit-card")),
    infoBox("Income MTD", "$14,030", icon = icon("credit-card")),
    infoBox("Net Income MTD", "$1,530", icon = icon("credit-card"))
  ),

  fluidRow(
    box(title = "Transactions", status = "primary", solidHeader = TRUE, width = 12, 
        box(width = 4,
            dateRangeInput(inputId = "dateSelectorInput", label = "Select Dates", start = transactionsView.start, end = transactionsView.end, 
                           min = as.Date(min(transactions$date)), max = as.Date(max(transactions$date)), 
                           format = "yyyy-mm-dd",
                           startview = "year",
                           weekstart = 0,
                           language = "en",
                           separator = " to ",
                           width = NULL,
                           autoclose = TRUE)
            ),
        
        box(width = 4, 
            selectInput("typeSelectInput", label = "Select Type",
                        choices = levels(transactions$type),
                        selected = levels(transactions$type)[1], multiple = TRUE)
            ),
        
        box(width = 4, 
            selectInput("groupSelectInput", label = "Select Group",
                        choices = levels(transactions$group),
                        selected = transactionsView.group.default, multiple = FALSE)
            ),
        
        selectizeInput("categorySelectInput", label = "Select Category",
                       choices = levels(transactions$category),
                       selected = levels(transactions$category), multiple = TRUE, size = 5)
        )
  ),
  
  
                                                                           
  fluidRow(
    box(title = "Transactions", status = "primary", solidHeader = TRUE, width = 12, 
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