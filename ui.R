source("global.R", local = TRUE)

# Declare UI Page ---------------------------------------------------------
dashboardPage(
  title = paste0("Testing", version),
  header,
  sidebar,
  body
)