output$account.balance.plot = renderHighchart({
  # hchart(balances, "area", hcaes(x = date, y = roll_mean, group = account))
  
  highchart() %>% 
    hc_chart(type = "column") %>% 
    hc_title(text = "MyGraph") %>% 
    hc_yAxis(title = list(text = "Weights")) %>% 
    hc_plotOptions(column = list(
      dataLabels = list(enabled = FALSE),
      stacking = "normal",
      enableMouseTracking = FALSE)
    ) %>% 
    hc_series(list(name="main checking",data=balances.wide$cpc_checking),
              list(name="shared checking",data=balances.wide$shared_account),
              list(name="johns checking",data=balances.wide$johns_personal),
              list(name="savings",data=balances.wide$cpc_savings),
              list(name="john retirement a",data=balances.wide$you_invest_trade),
              list(name="john retirement b",data=balances.wide$you_invest_port_ret)
    )
})

