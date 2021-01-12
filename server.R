shinyServer(function(input, output, session) {
    
  source("assets/server/transactionsView.R", local = TRUE)
  
  source("assets/server/amazonTransactionsView.R", local = TRUE)
  
  source("assets/server/incomeView.R", local = TRUE)
  
  })
  
