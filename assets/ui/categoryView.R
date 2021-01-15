mainPanel(
  
  ### TAB-PANELS ###
  fluidRow(
    infoBox("Budget MTD", "$12,030", icon = icon("credit-card")),
    infoBox("Actual MTD", "$174,030", icon = icon("credit-card")),
    infoBox("Budget Rolling 3mo Avg", "$10,530", icon = icon("credit-card"))
  ),
  
  fluidRow(
    
    box(title = "Category Spending", status = "primary", solidHeader = TRUE, width = 12, 
        fluidRow(
          box(width = 6, 
              selectInput("categoryMonthSelect", label = "Select Transaction Month",
                          choices = c("Nov-2020", "Dec-2020", "Jan-2021", "Feb-2021"),
                          selected = "Jan-2021", multiple = FALSE)
          ),
          box(width = 6, 
              selectInput("categoryChartSelect", label = "Select Category Chart Type",
                          choices = c("Category Spending MTD", "Category Spending YTD", "Category Spending Trends"),
                          selected = "Category Spending MTD", multiple = FALSE)
          )
        ),
        plotOutput("plotCategoryTree")
    )
  ),
  
  fluidRow(
    box(title = "Actual vs Budgeted Spending", status = "primary", solidHeader = TRUE, width = 12, 
        plotOutput("test_plot")
        )
    
    
  )
  
)