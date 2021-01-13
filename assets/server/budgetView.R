# Budget Tree-Chart

budgetTreeData <- budgets_long %>%
  filter(month == max(month)) %>%
  filter(type != "Income")

output$plotBudgetTree = shiny::renderPlot({
    treemap(budgetTreeData,
            title = paste("Budgets", ", ", max(budgetTreeData$month)), 
            index=c("group", "category"),
            vSize="amount",
            vColor="type",
            type="index",
            palette = "Set2",
            bg.labels=c("white"),
            align.labels=list(
              c("center", "center"), 
              c("right", "bottom")
            )  
    )
})

dollarMe <- scales::dollar_format(negative_parens = TRUE, prefix = "$")

# BUDGET WIDE
budgetTable <- budgets_long %>%
  filter(month >= as.Date('2020-08-01')) %>%
  mutate(amount = replace_na(amount,0)) %>%
  mutate(amount = dollarMe(amount)) %>%
  select(type, group, category, month, amount) %>%
  arrange(month) %>%
  dcast(category + group + type ~ month, value.var = "amount")
  

output$budgetTable = DT::renderDataTable({
  
  datatable(budgetTable, filter = 'top', rownames = FALSE, 
            options = list(scrollX = TRUE,
                           pageLength = 50,
                           autoWidth = TRUE,
                           columnDefs = list(
                             list(width = '125px', targets = c(0)),
                             list(width = '65px', targets = c(3:7))
                             )
                           ), 
  )
})