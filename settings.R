
# TRANSACTIONS VIEW
transaction.months <- unique(transactions$month)
transaction.months.max <- max(transaction.months)

transactionsView.start <- as.Date(min(transactions$date)) # as.Date("2019-01-01")
transactionsView.end <- as.Date(max(transactions$date)) # max(transactions$date)

transactionsView.table.columns <- c("type", "group", "category", "date", "amount", "description")

transactionsView.type.default <- levels(transactions$type)
transactionsView.group.default <- levels(transactions$group)
transactionsView.category.default <- levels(transactions$category)
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

### INCOME VIEW ### 

income.plots <- c("Income Events YTD", "Total Income YTD", "Income By Source YTD")
income.plots.selected <- c("Income Events YTD")


### DATA IMPORT ### 

category_col_types <- cols(
        Category = col_character(),
        Group = col_character(),
        Type = col_character(),
        `Hide From Reports` = col_character(),
        `1/1/20` = col_character(),
        `2/1/20` = col_character(),
        `3/1/20` = col_character(),
        `4/1/20` = col_character(),
        `5/1/20` = col_character(),
        `6/1/20` = col_character(),
        `7/1/20` = col_character(),
        `8/1/20` = col_character(),
        `9/1/20` = col_character(),
        `10/1/20` = col_character(),
        `11/1/20` = col_character(),
        `12/1/20` = col_character()
        )

transactions_col_types <- cols(
        Date = col_character(),
        Description = col_character(),
        Category = col_character(),
        Amount = col_character(),
        Account = col_character(),
        Statement = col_logical(),
        `Account #` = col_character(),
        Institution = col_character(),
        Month = col_character(),
        Week = col_character(),
        `Transaction ID` = col_character(),
        `Check Number` = col_double(),
        `Full Description` = col_character(),
        `Categorized Date` = col_character(),
        Metadata = col_logical(),
        `Date Added` = col_character()
)

balance_history_col_types <- cols(
        Date = col_character(),
        Time = col_time(format = ""),
        Account = col_character(),
        `Account #` = col_character(),
        `Account ID` = col_character(),
        Institution = col_character(),
        Balance = col_character(),
        Month = col_character(),
        Week = col_character(),
        Type = col_character(),
        Class = col_character()
)

amazon_orders_col_types <- cols(
        .default = col_character(),
        `UNSPSC Code` = col_double(),
        `Release Date` = col_datetime(format = ""),
        Quantity = col_double(),
        `Purchase Order Number` = col_logical(),
        `PO Line Number` = col_logical(),
        `Shipping Address Street 2` = col_logical(),
        `Tax Exemption Applied` = col_logical(),
        `Tax Exemption Type` = col_logical(),
        `Exemption Opt-Out` = col_logical(),
        `Group Name` = col_logical()
)