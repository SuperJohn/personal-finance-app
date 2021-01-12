# CHASE BANKING TRANSACTIONS
output$mytable = DT::renderDataTable({
  datatable(transactions, filter = 'top', width = "1500px", rownames = FALSE, 
            options = list(scrollX = TRUE), 
  )
})

# AMAZON ORDERS
output$amazonOrders = DT::renderDataTable({
  datatable(amazon_orders, filter = 'top', width = "1500px", rownames = FALSE, 
            options = list(scrollX = TRUE), 
  )
})