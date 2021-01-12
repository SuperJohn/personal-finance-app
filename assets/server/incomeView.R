
### TAB-PANELS ###
output$progressBox <- renderInfoBox({
  infoBox(
    "Income Past 30 Days", "$174,031", icon = icon("list"),
    color = "purple"
  )
})

output$approvalBox <- renderInfoBox({
  infoBox(
    "Income Past 90 Days", "$22,983", icon = icon("thumbs-up", lib = "glyphicon"),
    color = "yellow"
  )
})

### INCOME CHART ###
col_charter <- function(df){
  ggplot(df, aes(x = date, y = amount, colour=category)) + 
    geom_col() 
}

output$plot_income_events_last6mo = shiny::renderPlot({
  col_charter(income_events_last6mo)
  })

### INCOME TRANSACTIONS TABLE ###
output$incomeTransactions = DT::renderDataTable({
  datatable(income_transaction_history, filter = 'top', width = "1500px", rownames = FALSE, 
            options = list(scrollX = TRUE), 
  )
})