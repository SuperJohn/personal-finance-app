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
  ),
  
### START CODE FOR PIVOT-TABLE ###
box(title = "Budget Explorer Pivot Table", status = "primary", solidHeader = TRUE, width = 12, 
  # titlePanel("Budget Explorer Pivot Table"),
  
  fluidRow(
    column(3,
           selectInput("selectRows1", label = h5("Rows 1"),
                       choices = list("None" = "None",
                                      "Status" = "Status",
                                      "Train Category" = "TrainCategory",
                                      "TOC" = "TOC",
                                      "Power Type" = "PowerType",
                                      "Scheduled Speed" = "SchedSpeedMPH",
                                      "Origin" = "OriginName",
                                      "Destination" = "DestinationName"),
                       selected = "TOC")
    ),
    column(3,
           selectInput("selectRows2", label = h5("Rows 2"),
                       choices = list("None" = "None",
                                      "Status" = "Status",
                                      "Train Category" = "TrainCategory",
                                      "TOC" = "TOC",
                                      "Power Type" = "PowerType",
                                      "Scheduled Speed" = "SchedSpeedMPH",
                                      "Origin" = "OriginName",
                                      "Destination" = "DestinationName"),
                       selected = "None")
    ),
    column(3,
           selectInput("selectCols1", label = h5("Columns 1"),
                       choices = list("None" = "None",
                                      "Status" = "Status",
                                      "Train Category" = "TrainCategory",
                                      "TOC" = "TOC",
                                      "Power Type" = "PowerType",
                                      "Scheduled Speed" = "SchedSpeedMPH",
                                      "Origin" = "OriginName",
                                      "Destination" = "DestinationName"),
                       selected = "TrainCategory")
    ),
    column(3,
           selectInput("selectCols2", label = h5("Columns 2"),
                       choices = list("None" = "None",
                                      "Status" = "Status",
                                      "Train Category" = "TrainCategory",
                                      "TOC" = "TOC",
                                      "Power Type" = "PowerType",
                                      "Scheduled Speed" = "SchedSpeedMPH",
                                      "Origin" = "OriginName",
                                      "Destination" = "DestinationName"),
                       selected = "None")
    )
  ),
  
  fluidRow(
    column(3,
           selectInput("selectMeasure1", label = h5("Measure 1"),
                       choices = list("Train Count" = "Train Count",
                                      "% of Trains" = "% of Trains",
                                      "Total Arrival Delay Minutes" = "Total Arrival Delay Minutes",
                                      "Average Arrival Delay Minutes" = "Average Arrival Delay Minutes",
                                      "Max Arrival Delay Minutes" = "Max Arrival Delay Minutes",
                                      "Trains with Arrival Delay >= 5 Minutes",
                                      "% of Trains with Arrival Delay >= 5 Minutes"),
                       selected = "Train Count")
    ),
    column(3,
           selectInput("selectMeasure2", label = h5("Measure 2"),
                       choices = list("None",
                                      "Train Count" = "Train Count",
                                      "% of Trains" = "% of Trains",
                                      "Total Arrival Delay Minutes" = "Total Arrival Delay Minutes",
                                      "Average Arrival Delay Minutes" = "Average Arrival Delay Minutes",
                                      "Max Arrival Delay Minutes" = "Max Arrival Delay Minutes",
                                      "Trains with Arrival Delay >= 5 Minutes",
                                      "% of Trains with Arrival Delay >= 5 Minutes"),
                       selected = "None")
    ),
    column(6,
           br(),
           helpText("Note:  Selecting Origin and/or Destination in rows/columns will result in thousands or
               tens of thousands of cells being calculated, so the pivot table may take a couple of
               minutes to calculate.")
    )
  ),
  
  hr(),
  
  pivottablerOutput('pvt')
)

)