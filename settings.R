
# TRANSACTIONS VIEW
transaction.months <- unique(transactions$month)

transactionsView.start <- as.Date(min(transactions$date)) # as.Date("2019-01-01")
transactionsView.end <- as.Date(max(transactions$date)) # max(transactions$date)

transactionsView.group.default <- "Expense"
transactionsView.table.columns <- c("type", "group", "category", "date", "amount", "description")

transactionsView.type.default <- levels(transactions$type)
transactionsView.group.default <- levels(transactions$group)
transactionsView.table.columns <- c("type", "group", "category", "date", "amount", "description")

# BUDGET VIEW
budget.months <- unique(budgets_long$month)
budget.groups <- list("None" = "None",
     "type" = "type",
     "group" = "group",
     "category" = "category",
     "year" = "year",
     "month" = "month",
     "week" = "week",
     "yearMonth" = "yearMonth")

budget.measures <- list("None" = "None",
                        "Transactions Count" = "Transactions Count",
                        "% of Transactions" = "% of Transactions",
                        "Total Spend"  = "Total Spend",
                        "% of Total Spend" = "% of Total Spend")
