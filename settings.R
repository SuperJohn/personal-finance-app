
# TRANSACTIONS VIEW
transactionsView.start <- as.Date(min(transactions$date)) # as.Date("2019-01-01")
transactionsView.end <- as.Date(max(transactions$date)) # max(transactions$date)

transactionsView.group.default <- "Expense"
transactionsView.table.columns <- c("type", "group", "category", "date", "amount", "description")

transactionsView.type.default <- levels(transactions$type)
transactionsView.group.default <- levels(transactions$group)
transactionsView.table.columns <- c("type", "group", "category", "date", "amount", "description")

# Pivot-Table, Budgets
budget.groups <- list("None" = "None",
     "type" = "type",
     "group" = "group",
     "category" = "category",
     "year" = "year",
     "month" = "month",
     "week" = "week")

budget.measures <- list("Transactions Count" = "Transactions Count",
                        "% of Transactions" = "% of Transactions",
                        "% of Budget MTD" = "% of Budget MTD",
                        "% of Budget YTD" = "% of Budget YTD")
