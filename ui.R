source("global.R", local = TRUE)

# Declare UI Page ---------------------------------------------------------
dashboardPage(
  title = paste0("Houghton App", version),
  header,
  sidebar,
  body
)