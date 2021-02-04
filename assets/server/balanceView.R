balances <- balance_history %>%
  clean_names() %>% 
  mutate(balance = parse_number(balance)) %>% 
  mutate(date = parse_date(date, format = "%m/%d/%y")) %>% 
  filter(account != "4060 Sequoia Mortgage") %>% 
  dplyr::arrange(desc(date)) %>%
  dplyr::group_by(account) %>% 
  mutate(roll_mean = zoo::rollmean(balance, k = 7, fill = balance))

output$accountBalancePlot = renderHighchart({

  hchart(balances, type = "area", hcaes(x = date, y = roll_mean, group = account))
  
})