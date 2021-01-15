# setwd("~/Documents/dev/personal_finance")
# source("global.R", local = TRUE)

### BUDGETS ###
budgets_long <- tiller_categories_data %>%
  select(-`Hide From Reports`) %>%
  melt(id = c("Category", "Group", "Type"), variable.name = "date", value.name = "amount") %>%
  mutate(date = as.character(date)) %>%
  mutate(date = parse_date(date, format = "%m/%d/%y")) %>%
  rename(month = date) %>%
  mutate(amount = parse_number(str_remove(amount, regex("\\$", ignore_case = TRUE)))) %>%
  mutate(month_num = month(as.Date(month)), year = year(month)) %>%
  mutate(year_month = paste0(year, "-", month_num)) %>%
  clean_names()

budgets_wide <- budgets_long %>%
  select(category, group, type, month, amount) %>%
  dcast(category + group + type ~ month, value.var = "amount") %>%
  arrange(-`2020-12-01`)

category_lookup_table <- budgets_wide %>%
  select(category, group, type) %>% 
  unique()


### TILLER TRANSACTIONS ###
transactions <- tiller_transactions %>% 
  janitor::clean_names() %>%
  left_join(category_lookup_table, by = "category") %>%
  mutate(date = mdy(date), month = mdy(month), week = mdy(week)) %>%
  mutate(category = as_factor(category), group = as_factor(group), type = as_factor(type), year = year(date)) %>%
  mutate(amount = parse_number(str_remove(amount, regex("\\$", ignore_case = TRUE)))) %>%
  dplyr::select(c(type, group, category, year, month, week, date, amount, description)) 

transactions_monthly <- transactions %>% 
  mutate(month_num = month(as.Date(date)), year = year(date)) %>%
  # mutate(year_month = paste0(year, "-", month_num)) %>%
  group_by(type, group, category, year, month, month_num) %>%
  summarise(amount = sum(amount)) %>%
  arrange(-amount)

### ACTUAL VS BUDGETED ###
act_vs_est_monthly <- budgets_long  %>%
  left_join(transactions_monthly, by = c("type", "group", "category", "month"), suffix = c(".budgeted", ".actual")) %>%
  select(type, group, category, month, year_month, amount.budgeted, amount.actual) %>%
  mutate(amount.budgeted = case_when(type=="Income" ~ amount.budgeted,
                                     TRUE ~ -amount.budgeted)) %>%
  mutate(amount.diff = amount.actual - amount.budgeted, amount.variance = round((amount.actual - amount.budgeted)/amount.budgeted,2)) %>%
  mutate(year_num = year(month), month_num = month(month)) %>%
  mutate(category = as_factor(category), group = as_factor(group), type = as_factor(type)) %>%
  arrange(-amount.budgeted)

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
  mutate(month = month(as.Date(date)), year = year(date)) %>%
  mutate(year_month = paste0(year, "-", month)) %>%
  group_by(group, category, year_month) %>% 
  summarise(amount = sum(amount)) %>%
  filter(year_month >= "2020-1")

### FOR PIVOT-TABLE IN BUDGET VIEW ###

  # to be used when getting station names in joins below
  tsorigin = transmute(trainstations, CrsCode=as.character(CrsCode),
                       OriginName=as.character(StationName))
  tsdestination = transmute(trainstations, CrsCode=as.character(CrsCode),
                            DestinationName=as.character(StationName))
  
  # recode status and join to get station names from CrsCodes
  data <- bhmtrains %>%
    mutate(Status = recode(Status,
                           "A" = "Active", "C" = "Cancelled", "R" = "Reinstated"),
           Origin = as.character(Origin),
           Destination = as.character(Destination)) %>%
    left_join(tsorigin, by = c("Origin" = "CrsCode")) %>%
    left_join(tsdestination, by = c("Destination" = "CrsCode"))
  
  # derive some additional delay data
  data <- mutate(data,
                 GbttDateTime=if_else(is.na(GbttArrival), GbttDeparture, GbttArrival),
                 GbttMonth=make_date(year=year(GbttDateTime), month=month(GbttDateTime), day=1),
                 IsArrival=ifelse(is.na(GbttArrival), 0, 1),
                 ArrivalDelta=difftime(ActualArrival, GbttArrival, units="mins"),
                 ArrivalDelay=ifelse(ArrivalDelta<0, 0, ArrivalDelta),
                 DelayedByMoreThan5Minutes=ifelse(ArrivalDelay>5,1,0))
  
  data <- transactions
  
  totalTrainCount <- nrow(data)
