


# GG-PLOT: INCOME LAST 6 MO BY DATE, CATEGORY, TYPE
## bar chart, colours = type, x = date, y = amount
col_charter <- function(df){
  ggplot(df, aes(x = date, y = amount, colour=category)) + 
    geom_col() 
}

output$plot_income_events_last6mo = shiny::renderPlot({
  col_charter(income_events_last6mo)
  })

output$incomeTransactions = DT::renderDataTable({
  datatable(income_transaction_history, filter = 'top', width = "1500px", rownames = FALSE, 
            options = list(scrollX = TRUE), 
  )
})