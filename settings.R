
# TRANSACTIONS VIEW
transactionsView.start <- as.Date(min(transactions$date)) # as.Date("2019-01-01")
transactionsView.end <- as.Date(max(transactions$date)) # max(transactions$date)
transactionsView.type.default <- levels(transactions$type)
transactionsView.group.default <- levels(transactions$group)
transactionsView.table.columns <- c("type", "group", "category", "date", "amount", "description")