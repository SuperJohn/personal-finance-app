
# incomeLast30Days <- income_events_last6mo %>% filter(year_month == max(year_month)) %>% ungroup() %>% summarise(total = sum(as.numeric(amount))) %>% select(total)

incomeTransactions <- income_transaction_history %>% 
  select(-type, -group, -year, -month, -week) %>%
  select(date, category, description, amount)

### TAB-PANELS ###
output$progressBox <- renderInfoBox({
  infoBox(
    "Income Past 30 Days", "$23,320", icon = icon("list"), # paste0("$",incomeLast30Days[[1]])
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
  s <- ggplot(df, aes(x = year_month, y = amount, fill = category)) + theme(legend.position = "bottom")
  s + geom_bar(position="stack", stat="identity")
}



output$plot_income_events_last6mo = shiny::renderPlot({
  col_charter(income_events_last6mo)
  })

### INCOME TRANSACTIONS TABLE ###
output$incomeTransactions = DT::renderDataTable({
  datatable(incomeTransactions, filter = 'top', width = "auto", rownames = FALSE, 
            options = list(scrollX = TRUE,
                           pageLength = 50,
                           autoWidth = TRUE,
                           columnDefs = list(
                             list(width = '500px', targets = 2)
                             )
                           )
  )
})