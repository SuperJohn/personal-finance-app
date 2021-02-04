# setwd("~/Documents/dev/personal_finance")
# source("global.R", local = TRUE)

categoryTreeData <- transactions_monthly %>%
  filter(type != "Income") %>%
  mutate(amount = abs(amount))

output$plotCategoryTree = shiny::renderPlot({
  treemap(categoryTreeData %>% filter(month == max(categoryTreeData$month)),
          index=c("group", "category"),
          vSize="amount",
          vColor="group",
          type="index",
          palette = "Set2",
          bg.labels=c("white"),
          align.labels=list(
            c("center", "center"),
            c("right", "bottom")
          )
  )
  
})


bullet.data <- act_vs_est_monthly %>%
  filter(type != "Income") %>%
  filter(month == as.Date('2020-06-01')) %>%
  mutate(amount.budgeted = replace_na(-amount.budgeted,0), 
         amount.actual = replace_na(-amount.actual,0)) %>%
  mutate(mean = amount.budgeted * 1.2, 
         low = amount.budgeted * 0.8,
         high = amount.actual * 1.2) %>%
  rename(measure = category, 
         target = amount.budgeted, 
         value = amount.actual) %>%
  select(measure, high, mean, low, target, value) %>%
  filter(value + target > 0)

bullet.data$measure <- fct_reorder(bullet.data$measure, bullet.data$value)


output$test_plot = shiny::renderPlot({
  bullet.graph(bullet.data) 
})

### START CODE FOR PIVOT-TABLES ###
categoryPivotData <- reactive({
  transactions %>% 
    filter(date >= transaction.months[[input$monthsDisplayInput]]) %>%
    mutate(yearMonth = format(as.Date(month), format="%m-%y")) %>% 
    arrange(date)
})

output$categoryPivot <- renderPivottabler({
  pt <- PivotTable$new()
  pt$addData(categoryPivotData())
  
  pt$addRowDataGroups("type")
  pt$addRowDataGroups("group")
  pt$addRowDataGroups("category")
  pt$addColumnDataGroups("year", addTotal=FALSE)
  pt$addColumnDataGroups("yearMonth", addTotal=FALSE)
  
  pt$defineCalculation(calculationName="totalSpend",
                       caption="Total Spend",
                       summariseExpression="sum(amount, na.rm = TRUE)", format="%.0f")
  
  # generate pivot tabler
  pt$evaluatePivot()
  pt$renderPivot()
  pivottabler(pt)
  
})