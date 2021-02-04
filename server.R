shinyServer(function(input, output, session) {
    
  source("assets/server/transactionsView.R", local = TRUE)
  
  source("assets/server/amazonTransactionsView.R", local = TRUE)
  
  source("assets/server/incomeView.R", local = TRUE)
  
  source("assets/server/budgetView.R", local = TRUE)
  
  source("assets/server/categoryView.R", local = TRUE)
  
  source("assets/server/balanceView.R", local = TRUE)
  
  
  # Generate Data
  transactionsData <- eventReactive(input$monthSelectInput, {
    dataGrabber(type_selected = input$typeSelectInput,
                group_selected = input$groupSelectInput,
                category_selected = input$categorySelectInput,
                month_selected = input$monthSelectInput
                )
    })
  
  })
  
