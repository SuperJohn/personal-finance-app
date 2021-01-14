# AMAZON TRANSACTIONS
output$amazonTransactions = DT::renderDataTable({
  datatable(amazon_transactions, filter = 'top', width = "1500px", rownames = FALSE, 
            options = list(scrollX = TRUE,
                           pageLength = 25,
                           columnDefs = list(
                             list(width = '300px', 
                                  targets = 5,
                                  render = JS(
                               "function(data, type, row, meta) {",
                               "return type === 'display' && data.length > 35 ?",
                               "'<span title=\"' + data + '\">' + data.substr(0, 35) + '...</span>' : data;",
                               "}")
                             ))), 
            callback = JS('table.page(3).draw(false);'))
})