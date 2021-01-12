mainPanel(
  
  ### TAB-PANELS ###
  fluidRow(
    infoBox("Budget MTD", "$12,030", icon = icon("credit-card")),
    infoBox("Actual MTD", "$174,030", icon = icon("credit-card")),
    infoBox("Budget Rolling 3mo Avg", "$10,530", icon = icon("credit-card"))
  ),
  fluidRow(
    box(title = "Budgets", status = "primary", solidHeader = TRUE, width = 12, 
        selectInput("budgetChartSelect", label = "Select Income Chart Type",
                    choices = c("Income Events YTD", "Total Income YTD", "Income By Source YTD"),
                    selected = "Income Events YTD", multiple = FALSE,
                    width = "100%"),
        plotOutput("plotBudgetTree")
    )
  ),
  h2("Monthly Budgets"),
  div(DT::dataTableOutput("budgetTable"), style = "font-size: 100%; width: 100%")
)