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
                    choices = c(budget.months),
                    selected = max(budget.months), multiple = FALSE)
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
          ),
          tabPanel("Budget Pivot",
                   fluidRow(
                     column(3,
                            selectInput("selectRows1", label = h5("Rows 1"),
                                        choices = budget.groups,
                                        selected = "category")
                     ),
                     column(3,
                            selectInput("selectRows2", label = h5("Rows 2"),
                                        choices = budget.groups,
                                        selected = "None")
                     ),
                     column(3,
                            selectInput("selectCols1", label = h5("Columns 1"),
                                        choices = budget.groups,
                                        selected = "year")
                     ),
                     column(3,
                            selectInput("selectCols2", label = h5("Columns 2"),
                                        choices = budget.groups,
                                        selected = "yearMonth")
                     )
                   ),
                   
                   fluidRow(
                     column(3,
                            selectInput("selectMeasure1", label = h5("Measure 1"),
                                        choices = budget.measures,
                                        selected = "Total Spend")
                     ),
                     column(3,
                            selectInput("selectMeasure2", label = h5("Measure 2"),
                                        choices = budget.measures,
                                        selected = "None")
                     ),
                     column(6,
                            sliderInput("monthsDisplayInput", label = "Months to Display", min = 1, max = 12, value = 6, step = 1)
                     )
                   ),
                   
                   hr(),
                   
                   pivottablerOutput('pvt')
                   
          )
        )
    )
  )

)