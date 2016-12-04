# set parameters

alpha <- 0.1
days <- 100

# create a list of poll types to use for the 4G model and their weights

used_pollsters <- data.frame(matrix(c(
  
  "cvvm_volebni_model_psp_1", 1,
  "median_volebni_model_psp_1", 1,
  "phoenix_stranicke_preference_psp_4", 0.1,
  "ppm_volebni_model_psp_1", 1,
  "sanep_volebni_preference_psp_1", 0.1,
  "stem_volebni_model_psp_1", 1,
  "tns_volebni_model_psp_1", 1
  
  ), ncol = 2, byrow= TRUE), stringsAsFactors = FALSE)

# create a subset of data which only contains used poll types

used_data <- merge(data, used_pollsters, by.x = "poll_type_id", by.y = "X1", all = FALSE, stringsAsFactors = FALSE)
used_data$date <- as.Date(used_data$date, format = "%Y-%m-%d")
used_data <- used_data[which(used_data$date >= as.Date(beginning, format = "%Y-%m-%d")), ]

dates <- data.frame(date = as.character(seq(as.Date(beginning, format = "%Y-%m-%d"), Sys.Date(), 1)))

# create an empty data frame where results of the 4G model will be written

g <- data.frame(matrix(data = NA, nrow = length(seq(as.Date(beginning, format = "%Y-%m-%d") + days, Sys.Date(), 1)), ncol = nrow(psp_parties) + 1))
names(g) <- c("date", psp_parties$id)
g$date <- seq(as.Date(beginning, format = "%Y-%m-%d") + days, Sys.Date(), 1)

# execute the model

start <- Sys.time()

for (index_1 in 2:ncol(g)) {
  
  used_data_party <- used_data[which(used_data$option_id == names(g)[index_1]), ]
  
  acast_poll_type_id <- acast(used_data_party, date ~ option_id, value.var = "X2", fun.aggregate = max)
  acast_percentage <- acast(used_data_party, date ~ option_id, value.var = "percentage", fun.aggregate = mean)
  
  acast_frame <- data.frame(cbind(acast_poll_type_id, acast_percentage), stringsAsFactors = FALSE)
  acast_frame$date <- row.names(acast_frame)
  acast_frame <- merge(acast_frame, dates, by = "date", all = TRUE, stringsAsFactors = FALSE)
  acast_frame[, 2] <- as.numeric(acast_frame[, 2])
  acast_frame[, 3] <- as.numeric(acast_frame[, 3])
  
  for (index_2 in 1:nrow(g)) {
    
    g[index_2, index_1] <- sum(dnorm((seq(0, days, 1)) * alpha, mean = 0, sd = 1) * acast_frame[index_2:(index_2 + days), 3] * acast_frame[index_2:(index_2 + days), 2], na.rm = TRUE) / sum(dnorm((seq(0, days, 1)) * 0.05, mean = 0, sd = 1) * acast_frame[index_2:(index_2 + days), 2], na.rm = TRUE)
    
  } # for (index_2 in 1:nrow(g))
  
} # for (index_1 in 2:ncol(g))

end <- Sys.time()

end - start