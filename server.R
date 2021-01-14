shinyServer(function(input, output, session) {

dateSelected<- eventReactive(input$dateSelectorInput, {
    input$dateSelectorInput
  })
# hide(id = "kpps-overlay-load")
# 
# delay(3500, toggle(id = "kpps-overlay", anim = TRUE, animType = "slide", time = 1))
# 
# # Set location, region, level, and includeRBOOwned as reactive
# selectedDates <- eventReactive(input$dateSelectorInput, {
#   input$dateSelectorInput
# })
# 
# regionSelected <- eventReactive(input$buildDashboard, {
#   input$serviceArea
# })
# 
# levelSelected <- eventReactive(input$buildDashboard, {
#   input$regionTypeSelect
# })
# 
# includeRBOOwned <- eventReactive(input$buildDashboard, {
#   input$includeRBOOwned
# })
# 
# 
# Generate Data
# mainData <- eventReactive(input$dateSelectorInput, {
#   toggle(id = "kpps-overlay-load", anim = TRUE, animType = "fade", time = 0.25)
#   dataGrabber(location_selected = input$property,
#               region_selected = input$serviceArea,
#               level_selected = input$regionTypeSelect,
#               includeRBOOwned = input$includeRBOOwned)
# })
# 
  
  source("assets/server/transactionsView.R", local = TRUE)
  
  source("assets/server/amazonTransactionsView.R", local = TRUE)
  
  source("assets/server/incomeView.R", local = TRUE)
  
  source("assets/server/budgetView.R", local = TRUE)
  
  source("assets/server/categoryView.R", local = TRUE)
  
  })
  
