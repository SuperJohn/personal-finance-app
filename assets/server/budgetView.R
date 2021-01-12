# Budget Tree-Chart

treeData <- budgets_long %>%
  filter(date == max(date))

output$plotBudgetTree = shiny::renderPlot({
    treemap(treeData,
            title = paste("Budgets", ", ", max(treeData$date)), 
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

# BUDGET WIDE
budgetTable <- budgets_long %>%
  filter(date >= as.Date('2020-08-01')) %>%
  dcast(category + group + type ~ date) %>%
  arrange(-`2020-12-01`)

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