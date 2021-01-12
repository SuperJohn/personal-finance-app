### TILLER CATEGORIES ###
category_lookup_table <- tiller_categories_data %>%
  clean_names() %>% 
  select(category, group, type)


### TILLER TRANSACTIONS ###
transactions <- tiller_transactions %>% 
  readr::type_convert() %>%
  mutate(Date = mdy(Date), Month = mdy(Month), Week = mdy(Week), `Categorized Date` = mdy(`Categorized Date`), `Date Added` = mdy(`Date Added`), Category = factor(Category)) %>%
  mutate(Amount = str_remove(Amount, regex("\\$", ignore_case = TRUE))) %>%
  mutate(Amount = parse_number(Amount), Account = factor(Account), `Account #` = factor(`Account #`)) %>% 
  dplyr::select(c('Date', 'Amount', 'Category', 'Description')) %>%
  janitor::clean_names() %>%
  left_join(category_lookup_table, by = "category")


### AMAZON TRANSACTIONS ###
clean_amazon_items <- function(df){
  df %>%
    mutate(`Order Date` = as.Date(parse_date_time(`Order Date`, "m/d/y"))) %>%
    mutate(`Shipment Date` = as.Date(parse_date_time(`Shipment Date`, "m/d/y"))) %>%
    mutate(`Item Total` = -as.numeric(gsub("\\$", "", `Item Total`))) %>%
    mutate(`Category` = as.factor(`Category`)) %>%
    select(c("Order ID", "Item Total", "Order Date", "Shipment Date", "Category", "Title")) %>%
    clean_names() %>%
    rename(amount = item_total)
  
}

amazon_transactions <- bind_rows(
  clean_amazon_items(john_amazon_items),
  clean_amazon_items(sarah_amazon_items)
)

amazon_orders <- amazon_transactions %>%
  group_by(order_date, shipment_date, order_id) %>%
  summarise(amount = sum(amount))

### INCOME TRANSACTIONS VIEW ###
income_transaction_history <- transactions %>% 
  filter(type == "Income")

income_events_last6mo <- income_transaction_history %>%
  filter(date >= as.Date("2020-01-01"))

