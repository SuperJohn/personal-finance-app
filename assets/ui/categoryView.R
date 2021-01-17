mainPanel(
  
  ### TAB-PANELS ###
  fluidRow(
    infoBox("Budget MTD", "$12,030", icon = icon("credit-card")),
    infoBox("Actual MTD", "$174,030", icon = icon("credit-card")),
    infoBox("Budget Rolling 3mo Avg", "$10,530", icon = icon("credit-card"))
  ),
  
  fluidRow(
    box(width = 6, 
        selectInput("categoryMonthSelect", label = "Select Transaction Month",
                    choices = c(transaction.months),
                    selected = max(max(budget.months)), multiple = FALSE)
    ),
    box(width = 6, 
        selectInput("categoryChartSelect", label = "Select Category Chart Type",
                    choices = c("Category Spending MTD", "Category Spending YTD", "Category Spending Trends"),
                    selected = "Category Spending MTD", multiple = FALSE)
    )
  ),
  
  fluidRow(
    
    box(title = "Category Spending", status = "primary", solidHeader = TRUE, width = 12, 
        tabsetPanel(
          tabPanel("Category Treemap",
               plotOutput("plotCategoryTree")
          ),
          tabPanel("Actual vs Budgeted Spending",
               plotOutput("test_plot")
          )
        )
    )
  )
  
)