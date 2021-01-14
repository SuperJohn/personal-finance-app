
# filterTransactions <- function(datesSelected){
  # id <- transactions %>% filter(date = )
}

# dataGrabber <- function(location_selected, region_selected, level_selected, includeRBOOwned) {
#   
#   if (level_selected == "By Property") {
#     id <- properties %>% filter(name == location_selected) %>% select(property_id) %>% na.omit()
#   } else if (level_selected == "By Service Area") {
#     if (includeRBOOwned == TRUE) {
#       id <- properties %>% filter(service_area == region_selected) %>% select(property_id) %>% na.omit()
#     } else {
#       id <- properties %>% filter(service_area == region_selected) %>% filter(!(property_id %in% rboOwned)) %>% select(property_id) %>% na.omit()
#     }
#   } else if (level_selected == "Portfolio Level") {
#     if (includeRBOOwned == TRUE) {
#       id <- properties %>% distinct(property_id) %>% select(property_id) %>% na.omit()
#     } else {
#       id <- properties %>% distinct(property_id) %>% filter(!(property_id %in% rboOwned)) %>% select(property_id) %>% na.omit()
#     }
#     
#   }
  
# 
# 
# # Create progress object
# progress <- shiny::Progress$new()
# on.exit(progress$close()) # ensure it closes when we exit the reactive
# 
# progress$set(message = "Grabbing financials", value = 0.2)
# # Create empty list
# data <- list()
# 
# data$ytdErrorCheck <- nrow(financials %>% filter(LOC %in% id$property_id) %>% filter(YEAR == currentYear))
# data$financialErrorCheck <- nrow(financials %>% filter(LOC %in% id$property_id))
# 
# if (data$ytdErrorCheck > 0) {
#   
#   # Calculate YTD - Budgeted
#   data$ytdbRaw <- sum(financials %>% filter(LOC %in% id$property_id) %>% filter(YEAR == currentYear) %>% select(BUDGETED))
#   data$ytdb <- paste0("$", format(round(data$ytdbRaw, digits = 0), big.mark = ","))
#   
#   # Calculate YTD - Actual
#   data$ytdaRaw <- sum(financials %>% filter(LOC %in% id$property_id) %>% filter(YEAR == currentYear) %>% select(ACTUAL))
#   data$ytda <- paste0("$", format(round(data$ytdaRaw, digits = 0), big.mark = ","))
#   
#   # Calculate YTD - Variance
#   data$ytdvRaw <- data$ytdbRaw - data$ytdaRaw
#   data$ytdvPercentRaw <- (data$ytdvRaw/data$ytdbRaw)*100
#   
#   # Calculate YTD - Variance - Adjusted
#   tmpExplainableVariance <- explainableVariance %>% filter(property_id %in% id$property_id)
#   data$ytdExplainableVariance <- sum(tmpExplainableVariance$cost[tmpExplainableVariance$year == currentYear], na.rm = TRUE)
#   data$ytdvAdjustedRaw <- data$ytdvRaw + data$ytdExplainableVariance
#   data$ytdvAdjustedPercentRaw <- (data$ytdvAdjustedRaw/data$ytdbRaw)*100
#   
#   if (data$ytdvRaw < 0) {
#     data$ytdv <- paste0("($", format(round(abs(data$ytdvRaw), digits = 0), big.mark = ","), ")")
#     data$ytdvColor <- "maroon"
#     data$ytdvIcon <- "minus-circle"
#     data$ytdvPercent <- paste0("(", round(abs(data$ytdvPercentRaw), digits = 2), "%)")
#   } else if (data$ytdvRaw > 0) {
#     data$ytdv <- paste0("$", format(round(data$ytdvRaw, digits = 0), big.mark = ","))
#     data$ytdvColor <- "green"
#     data$ytdvIcon <- "plus-circle"
#     data$ytdvPercent <- paste0(round(abs(data$ytdvPercentRaw), digits = 2), "%")
#   }
#   
#   if (data$ytdvAdjustedRaw < 0) {
#     data$ytdvAdjusted <- paste0("($", format(round(abs(data$ytdvAdjustedRaw), digits = 0), big.mark = ","), ")")
#     data$ytdvAdjustedColor <- "maroon"
#     data$ytdvAdjustedIcon <- "minus-circle"
#     data$ytdvAdjustedPercent <- paste0("(", round(abs(data$ytdvAdjustedPercentRaw), digits = 2), "%)")
#   } else if (data$ytdvAdjustedRaw > 0) {
#     data$ytdvAdjusted <- paste0("$", format(round(data$ytdvAdjustedRaw, digits = 0), big.mark = ","))
#     data$ytdvAdjustedColor <- "green"
#     data$ytdvAdjustedIcon <- "plus-circle"
#     data$ytdvAdjustedPercent <- paste0(round(abs(data$ytdvAdjustedPercentRaw), digits = 2), "%")
#   }
#   
# }
# # Get budgeted & actuals by property id by month and year
# if (data$financialErrorCheck > 0) {
#   
#   data$budget <- financials %>%
#     filter(LOC %in% id$property_id) %>%
#     group_by(MONTH, YEAR) %>%
#     summarize(ACTUAL = sum(ACTUAL), BUDGETED = sum(BUDGETED))
#   
#   data$budget$MONTH <- match(tolower(data$budget$MONTH), tolower(month.abb))
#   
#   data$budget$DATE <- as.Date(paste0(data$budget$MONTH, "/01/", data$budget$YEAR), "%m/%d/%Y")
#   
#   data$adjustment <- explainableVariance %>%
#     filter(property_id %in% id$property_id) %>%
#     filter(substring(date_of_emergency, 1, 4) == currentYear) %>%
#     group_by(property_id) %>%
#     summarize(adjusted = sum(cost, na.rm = TRUE))
#   
#   data$adjustment <- data$adjustment[complete.cases(data$adjustment),]
#   
#   if (nrow(data$adjustment) > 0) {
#     
#   } else {
#     data$adjustment <- data.frame()
#   }
#   
#   
#   data$adjusted <- explainableVariance %>%
#     filter(property_id %in% id$property_id) %>%
#     # filter(substring(date_of_emergency, 1, 4) == currentYear) %>%
#     group_by(date_of_emergency) %>%
#     summarize(adjusted = sum(cost, na.rm = TRUE))
#   
#   data$adjusted <- data$adjusted[complete.cases(data$adjusted),]
#   
#   if (nrow(data$adjusted) > 0) {
#     data$adjusted$month <- format(data$adjusted$date_of_emergency, "%m")
#     data$adjusted$year <- format(data$adjusted$date_of_emergency, "%Y")
#     
#     data$adjusted$DATE <- as.Date(paste0(data$adjusted$month, "/01/", data$adjusted$year), format = "%m/%d/%Y")
#     data$adjusted <- data$adjusted[, c("DATE", "adjusted")]
#     
#     data$adjusted <- data$adjusted %>% group_by(DATE) %>% summarize(adjusted = sum(adjusted))
#   } else {
#     data$adjusted <- data.frame()
#   }
#   
#   # Fold in adjustment into budget
#   if (nrow(data$adjusted) > 0) {
#     data$budget <- plyr::join(as.data.frame(data$budget), data$adjusted, by = "DATE")  
#   }
#   
#   
# }
# 