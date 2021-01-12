# AMAZON TRANSACTIONS
output$amazonTransactions = DT::renderDataTable({
  datatable(amazon_transactions, filter = 'top', width = "1500px", rownames = FALSE, 
            options = list(scrollX = TRUE), 
  )
})