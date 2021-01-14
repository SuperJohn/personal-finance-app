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

output$pvt <- renderPivottabler({
  pt <- PivotTable$new()
  pt$addData(data)
  
  # rows and columns
  if (input$selectCols1 != "None") { pt$addColumnDataGroups(input$selectCols1) }
  if (input$selectCols2 != "None") { pt$addColumnDataGroups(input$selectCols2) }
  if (input$selectRows1 != "None") { pt$addRowDataGroups(input$selectRows1) }
  if (input$selectRows2 != "None") { pt$addRowDataGroups(input$selectRows2) }
  
  # measure 1
  if (input$selectMeasure1 == "Train Count") {
    pt$defineCalculation(calculationName="TotalTrains",
                         summariseExpression="n()",
                         caption="Train Count")
  }
  else if (input$selectMeasure1 == "% of Trains") {
    pt$defineCalculation(calculationName="TotalTrains",
                         summariseExpression="n()",
                         visible=FALSE)
    pt$defineCalculation(calculationName="PercentageOfTrains",
                         caption="% of Trains",
                         type="calculation",
                         basedOn=c("TotalTrains"),
                         format="%.2f %%",
                         calculationExpression=paste0("values$TotalTrains/", totalTrainCount, "*100"))
  }
  else if (input$selectMeasure1 == "Total Arrival Delay Minutes") {
    pt$defineCalculation(calculationName="TotalArrivalDelayMinutes",
                         caption="Total Arrival Delay Minutes",
                         summariseExpression="sum(ArrivalDelay, na.rm = TRUE)")
  }
  else if (input$selectMeasure1 == "Average Arrival Delay Minutes") {
    pt$defineCalculation(calculationName="TotalArrivals",
                         summariseExpression="sum(IsArrival, na.rm=TRUE)", visible=FALSE)
    pt$defineCalculation(calculationName="TotalArrivalDelayMinutes",
                         summariseExpression="sum(ArrivalDelay, na.rm = TRUE)", visible=FALSE)
    pt$defineCalculation(calculationName="AverageArrivalDelayMinutes",
                         caption="Average Arrival Delay Minutes",
                         type="calculation",
                         basedOn=c("TotalArrivals", "TotalArrivalDelayMinutes"),
                         format="%.2f",
                         calculationExpression="values$TotalArrivalDelayMinutes/values$TotalArrivals")
  }
  else if (input$selectMeasure1 == "Max Arrival Delay Minutes") {
    pt$defineCalculation(calculationName="MaxArrivalDelayMinutes",
                         caption="Max Arrival Delay Minutes",
                         summariseExpression="max(ArrivalDelay, na.rm = TRUE)")
  }
  else if (input$selectMeasure1 == "Trains with Arrival Delay >= 5 Minutes") {
    pt$defineCalculation(calculationName="Trains5orMoreMinsLate",
                         caption="Trains with Arrival Delay >= 5 Minutes",
                         summariseExpression="sum(DelayedByMoreThan5Minutes, na.rm = TRUE)")
  }
  else if (input$selectMeasure1 == "% of Trains with Arrival Delay >= 5 Minutes") {
    pt$defineCalculation(calculationName="TotalArrivals",
                         summariseExpression="sum(IsArrival, na.rm=TRUE)", visible=FALSE)
    pt$defineCalculation(calculationName="Trains5orMoreMinsLate",
                         summariseExpression="sum(DelayedByMoreThan5Minutes, na.rm = TRUE)",
                         visible=FALSE)
    pt$defineCalculation(calculationName="PercentageOfTrainsWithArrivalDelay5orMoreMinutesLate",
                         caption="% of Trains with Arrival Delay >= 5 Minutes",
                         type="calculation", basedOn=c("TotalArrivals", "Trains5orMoreMinsLate"),
                         format="%.2f %%",
                         calculationExpression="values$Trains5orMoreMinsLate/values$TotalArrivals*100")
  }
  
  # measure 2
  if (input$selectMeasure2 == "Train Count") {
    pt$defineCalculation(calculationName="TotalTrains2",
                         summariseExpression="n()",
                         caption="Train Count")
  }
  else if (input$selectMeasure2 == "% of Trains") {
    pt$defineCalculation(calculationName="TotalTrains2",
                         summariseExpression="n()",
                         visible=FALSE)
    pt$defineCalculation(calculationName="PercentageOfTrains2",
                         caption="% of Trains",
                         type="calculation",
                         basedOn=c("TotalTrains2"),
                         format="%.2f %%",
                         calculationExpression=paste0("values$TotalTrains2/", totalTrainCount, "*100"))
  }
  else if (input$selectMeasure2 == "Total Arrival Delay Minutes") {
    pt$defineCalculation(calculationName="TotalArrivalDelayMinutes2",
                         caption="Total Arrival Delay Minutes",
                         summariseExpression="sum(ArrivalDelay, na.rm = TRUE)")
  }
  else if (input$selectMeasure2 == "Average Arrival Delay Minutes") {
    pt$defineCalculation(calculationName="TotalArrivals2",
                         summariseExpression="sum(IsArrival, na.rm=TRUE)", visible=FALSE)
    pt$defineCalculation(calculationName="TotalArrivalDelayMinutes2",
                         summariseExpression="sum(ArrivalDelay, na.rm = TRUE)", visible=FALSE)
    pt$defineCalculation(calculationName="AverageArrivalDelayMinutes2",
                         caption="Average Arrival Delay Minutes",
                         type="calculation",
                         basedOn=c("TotalArrivals2", "TotalArrivalDelayMinutes2"),
                         format="%.2f",
                         calculationExpression="values$TotalArrivalDelayMinutes2/values$TotalArrivals2")
  }
  else if (input$selectMeasure2 == "Max Arrival Delay Minutes") {
    pt$defineCalculation(calculationName="MaxArrivalDelayMinutes2",
                         caption="Max Arrival Delay Minutes",
                         summariseExpression="max(ArrivalDelay, na.rm = TRUE)")
  }
  else if (input$selectMeasure2 == "Trains with Arrival Delay >= 5 Minutes") {
    pt$defineCalculation(calculationName="Trains5orMoreMinsLate2",
                         caption="Trains with Arrival Delay >= 5 Minutes",
                         summariseExpression="sum(DelayedByMoreThan5Minutes, na.rm = TRUE)")
  }
  else if (input$selectMeasure2 == "% of Trains with Arrival Delay >= 5 Minutes") {
    pt$defineCalculation(calculationName="TotalArrivals2",
                         summariseExpression="sum(IsArrival, na.rm=TRUE)", visible=FALSE)
    pt$defineCalculation(calculationName="Trains5orMoreMinsLate2",
                         summariseExpression="sum(DelayedByMoreThan5Minutes, na.rm = TRUE)",
                         visible=FALSE)
    pt$defineCalculation(calculationName="PercentageOfTrainsWithArrivalDelay5orMoreMinutesLate2",
                         caption="% of Trains with Arrival Delay >= 5 Minutes",
                         type="calculation", basedOn=c("TotalArrivals2", "Trains5orMoreMinsLate2"),
                         format="%.2f %%",
                         calculationExpression="values$Trains5orMoreMinsLate2/values$TotalArrivals2*100")
  }
  
  # generate pivot tabler
  pt$evaluatePivot()
  pivottabler(pt)
})