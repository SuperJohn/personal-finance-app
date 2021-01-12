# CHASE BANKING TRANSACTIONS
output$mytable = DT::renderDataTable({
  datatable(transactions, filter = 'top', width = "1500px", rownames = FALSE, 
            options = list(scrollX = TRUE, 
                           autoWidth = TRUE,
                           columnDefs = list(
                             list(width = '300px', targets = c(3)),
                             list(width = '50px', targets = c(0,1))
                             )
                           ), 
  )
})

# AMAZON ORDERS
output$amazonOrders = DT::renderDataTable({
  datatable(amazon_orders, filter = 'top', width = "1500px", rownames = FALSE, 
            options = list(scrollX = TRUE), 
  )
})