# Budget Tree-Chart
budgetTreeData <- reactive({
  # budgets_long
  budgets_long %>%
  filter(type != "Income") %>%
  filter(month == as.Date(input$budgetMonthSelect))
})


output$plotBudgetTree = shiny::renderPlot({
    treemap(budgetTreeData(),
            title = paste("Budgets", ", ", max(budgetTreeData()$month)), 
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
transactions.data.grouped <- reactive({
  transactions %>% 
    filter(type == "Expense") %>%
    dplyr::group_by(group, category, month) %>%
    dplyr::summarise(amount = round(sum(abs(amount)), 2)) %>%
    filter(month == as.Date(input$budgetMonthSelect)) %>%
    data_to_hierarchical(group_vars = c(group,category), size_var = amount)
})

output$plotBudgetTreeMap = renderHighchart({
    hchart(transactions.data.grouped(), type = "treemap") # %>%
    # hc_exporting(enabled = TRUE) %>% 
    # hc_tooltip(crosshairs = TRUE, backgroundColor = "#FCFFC5", shared = TRUE, borderWidth = 2) %>%
    # hc_title(text="Time series plot of Inflation Rates", align="center") %>%
    # hc_subtitle(text="Data Source: IMF", align="center") %>%
    # hc_add_theme(hc_theme_elementary()) 
})

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

### START CODE FOR PIVOT-TABLES ###
budgetPivotData <- reactive({
  transactions %>% 
    filter(date >= transaction.months[[input$monthsDisplayInput]]) %>%
    mutate(yearMonth = format(as.Date(month), format="%m-%y")) %>% 
    arrange(date)
})

totalTransactionCount <- reactive({
  nrow(budgetPivotData())
})

output$pvt <- renderPivottabler({
  pt <- PivotTable$new()
  pt$addData(budgetPivotData())
  
  # rows and columns
  if (input$selectCols1 != "None") { pt$addColumnDataGroups(input$selectCols1) }
  if (input$selectCols2 != "None") { pt$addColumnDataGroups(input$selectCols2) }
  if (input$selectRows1 != "None") { pt$addRowDataGroups(input$selectRows1) }
  if (input$selectRows2 != "None") { pt$addRowDataGroups(input$selectRows2) }
  
  # measure 1
  if (input$selectMeasure1 == "Transactions Count") {
    pt$defineCalculation(calculationName="transactionCount",
                         summariseExpression="n()",
                         caption="Transactions Count")
  }
  else if (input$selectMeasure1 == "% of Transactions") {
    pt$defineCalculation(calculationName="totalTransactions",
                         summariseExpression="n()",
                         visible=FALSE)
    pt$defineCalculation(calculationName="PercentageOfTransactions",
                         caption="% of Transactions",
                         type="calculation",
                         basedOn=c("totalTransactions"),
                         format="%.2f %%",
                         calculationExpression=paste0("values$totalTransactions/", totalTransactionCount, "*100"))
  }
  else if (input$selectMeasure1 == "Total Spend") {
    pt$defineCalculation(calculationName="totalSpend",
                         caption="Total Spend",
                         summariseExpression="sum(amount, na.rm = TRUE)")
  }
  else if (input$selectMeasure1 == "% of Total Spend") {
    pt$defineCalculation(calculationName="totalSpend2",
                         caption="Total Spend",
                         summariseExpression="sum(amount, na.rm = TRUE)",
                         visible=FALSE)
    pt$defineCalculation(calculationName="PercentageOfTotalSpend",
                         caption="% of Total Spend",
                         type="calculation",
                         basedOn=c("totalSpend2"),
                         format="%.2f %%",
                         calculationExpression=paste0("values$totalSpend2/", totalSpend2, "*100")
                         )
  }
  
  # measure 2
  if (input$selectMeasure2 == "Transactions Count") {
    pt$defineCalculation(calculationName="transactionCount2",
                         summariseExpression="n()",
                         caption="Transactions Count")
  }
  else if (input$selectMeasure2 == "% of Transactions") {
    pt$defineCalculation(calculationName="totalTransactions2",
                         summariseExpression="n()",
                         visible=FALSE)
    pt$defineCalculation(calculationName="PercentageOfTransactions2",
                         caption="% of Transactions",
                         type="calculation",
                         basedOn=c("totalTransactions2"),
                         format="%.2f %%",
                         calculationExpression=paste0("values$totalTransactions2/", totalTransactionCount(), "*100"))
    
  }
  else if (input$selectMeasure2 == "Total Spend") {
    pt$defineCalculation(calculationName="totalSpend3",
                         caption="Total Spend",
                         summariseExpression="sum(amount, na.rm = TRUE)")
  }

  
  # generate pivot tabler
  pt$evaluatePivot()
  pivottabler(pt)
})