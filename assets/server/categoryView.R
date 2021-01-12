# setwd("~/Documents/dev/personal_finance")
# source("global.R", local = TRUE)

categoryTreeData <- transactions_monthly %>%
  filter(year_month == "2020-9") %>%
  mutate(amount = abs(amount))

output$plotCategoryTree = shiny::renderPlot({
  treemap(categoryTreeData,
          #title = paste("Category Spending", ", ", max(treeData$year_month)),
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
