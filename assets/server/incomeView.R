income.mtd <- reactive({
  total <-  transactions %>%
    filter(month == input$incomeMonthSelect) %>%
    filter(type == "Income") %>% 
    summarise(total = sum(amount)) 
  total[[1]]
})
library(data.table)
# transactions %>%
#   mutate(rollmeanz = rollmean(d, 3))

### TAB-PANELS ###
output$progressBox <- renderInfoBox({
  infoBox(
    "Income Past 30 Days", income.mtd(), icon = icon("list"),
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
  datatable(income_transaction_history, filter = 'top', width = "1500px", rownames = FALSE, 
            options = list(scrollX = TRUE), 
  )
})