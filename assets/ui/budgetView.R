mainPanel(
  
  ### TAB-PANELS ###
  fluidRow(
    infoBox("Budget MTD", "$12,030", icon = icon("credit-card")),
    infoBox("Actual MTD", "$174,030", icon = icon("credit-card")),
    infoBox("Budget Rolling 3mo Avg", "$10,530", icon = icon("credit-card"))
  ),
  
  fluidRow(
    box(width = 6, status = "primary", solidHeader = TRUE, 
        selectInput("budgetMonthSelect", label = "Select Budget Month",
                    choices = c("Nov-2020", "Dec-2020", "Jan-2021", "Feb-2021"),
                    selected = "Jan-2021", multiple = FALSE)
    ),
    box(width = 6, status = "primary", solidHeader = TRUE, 
        selectInput("budgetChartSelect", label = "Select Budget Chart Type",
                    choices = c("Income Events YTD", "Total Income YTD", "Income By Source YTD"),
                    selected = "Income Events YTD", multiple = FALSE)
    )
  ),
  
  fluidRow(
    
    box(title = "Budgets", status = "primary", solidHeader = TRUE, width = 12, 
        tabsetPanel(
          tabPanel("Monthly Budget TreeMap",
                   plotOutput("plotBudgetTree")
          ),
          tabPanel("Monthly Budgets",
                   dataTableOutput("budgetTable")
          )
        )
    )
  )

)