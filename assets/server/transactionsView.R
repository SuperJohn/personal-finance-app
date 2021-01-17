# CHASE BANKING TRANSACTIONS
mytableData <- reactive({
  transactions %>% 
    select(transactionsView.table.columns) %>% 
    mutate(amount = replace_na(amount,0)) %>%
    mutate(amount = dollarMe(amount)) %>%
    filter(date >= input$dateSelectorInput[1]) %>%
    filter(date <= input$dateSelectorInput[2]) %>%
    mutate(day_of_week = format(as.Date(date), format="%a")) %>%
    mutate(date = format(as.Date(date), format="%b-%d-%Y"))
})

output$mytable = DT::renderDataTable({
  datatable(mytableData(),
            filter = 'top', rownames = FALSE, 
            options = list(scrollX = TRUE, 
                           autoWidth = TRUE ,
                           columnDefs = list(
                             list(width = '400px', targets = 5)
                             # list(width = '100px', targets = c(0,1))
                             )
                           ), 
  )
})

transactionsView.category.table <- transactions %>% 
  filter(type == "Expense") %>%
  tabyl(month, category) %>%
  adorn_totals(c("row", "col")) %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting(rounding = "half up", digits = 0) %>% 
  adorn_ns() %>%
  adorn_title("combined")

# CATEGORY TRANSACTIONS SUMMARY
output$transactionsView.category.table = DT::renderDataTable({
  datatable(transactionsView.category.table, width = "1500px", rownames = TRUE , 
            options = list(scrollX = TRUE), 
  )
})