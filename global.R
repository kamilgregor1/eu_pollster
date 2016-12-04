# global

## set parameters

beginning <- Sys.Date()-365 # a date from which the 4G function is calculated

## read libraries

library(googleVis)
library(reshape2)
library(plyr)
library(markdown)

## read data

original_data <- read.csv("www/data.csv", encoding = "utf-8", stringsAsFactors = FALSE)
original_polls <- read.csv("www/polls.csv", encoding = "utf-8", stringsAsFactors = FALSE)
psp_parties <- read.csv("www/psp_parties.csv", encoding = "utf-8", stringsAsFactors = FALSE)
psp_poll_types <- read.csv("www/psp_poll_types.csv", encoding = "utf-8", stringsAsFactors = FALSE)

## read data for development

# original_data <- read.csv("eu_pollster/www/data.csv", encoding = "utf-8", stringsAsFactors = FALSE)
# original_polls <- read.csv("eu_pollster/www/polls.csv", encoding = "utf-8", stringsAsFactors = FALSE)
# psp_parties <- read.csv("eu_pollster/www/psp_parties.csv", encoding = "utf-8", stringsAsFactors = FALSE)
# psp_poll_types <- read.csv("eu_pollster/www/psp_poll_types.csv", encoding = "utf-8", stringsAsFactors = FALSE)

## create a list of included political parties

psp_parties_choices <- psp_parties$id
names(psp_parties_choices) <- psp_parties$name

psp_parties_selected <- psp_parties[which(psp_parties$selected == 1), c("id")]

## create a list of included poll types

psp_poll_types_choices <- psp_poll_types$id
names(psp_poll_types_choices) <- psp_poll_types$name

psp_poll_types_selected <- psp_poll_types[which(psp_poll_types$selected == 1), c("id")]

## add new variables to data that will be used to create a data frame with percentages of votes

data_identifiers <- strsplit(original_data$id, "_")
data_identifiers <- sapply(data_identifiers, function(x) {x[c(1:7)]})
data_identifiers <- data.frame(t(data_identifiers), stringsAsFactors = FALSE)

data <- original_data
data$date <- data_identifiers$X2
data$poll_type_id <- paste(data_identifiers$X1, data_identifiers$X3, data_identifiers$X4, data_identifiers$X5, data_identifiers$X6, sep = "_")
data$column_name <- paste(data_identifiers$X1, data_identifiers$X3, data_identifiers$X4, data_identifiers$X5, data_identifiers$X6, data_identifiers$X7, sep = "_")

## subset original_data to only include data that will actually be used

data <- merge(data, psp_parties[c("id")], by.x = "option_id", by.y = "id", all = FALSE, stringsAsFactors = FALSE)
data <- merge(data, psp_poll_types[c("id")], by.x = "poll_type_id", by.y = "id", all = FALSE, stringsAsFactors = FALSE)

## create columns with lower and upper confidence intervals

data$lower_interval <- round(data$percentage - qnorm((0.8 + 1) / 2) * sqrt(data$percentage * (1 - data$percentage) / ifelse(is.na(data$denominator), data$deminator_estimate, data$denominator)), digits = 3)
data$upper_interval <- round(data$percentage + qnorm((0.8 + 1) / 2) * sqrt(data$percentage * (1 - data$percentage) / ifelse(is.na(data$denominator), data$deminator_estimate, data$denominator)), digits = 3)

## create a vector with colors of parties

psp_votes <- acast(data, date ~ column_name, fun.aggregate = mean, value.var = "percentage")
psp_votes <- data.frame(psp_votes)

colors <- strsplit(names(psp_votes), "_")
colors <- sapply(colors, function(x) {x[c(6)]})
colors <- data.frame(colors)
colors$order <- seq(1, nrow(colors), 1)
colors <- merge(colors, psp_parties[c("id", "color")], by.x = "colors", by.y = "id", all = FALSE, sort = TRUE)
colors <- colors[order(colors$order), ]
colors <- colors$color

## create a data frame with names of columns

psp_votes_names <- names(psp_votes)
psp_votes_names <- data.frame(psp_votes_names)

## create a data frame with percentages of votes

psp_votes$date <- row.names(psp_votes)
psp_votes$date <- as.Date(psp_votes$date, format = "%Y-%m-%d")
psp_votes <- cbind(psp_votes[c("date")], psp_votes[, 1:(ncol(psp_votes)-1)])

## randomize psp_votes in order to prevent data point from overlapping

psp_votes[, 2:ncol(psp_votes)] <- psp_votes[, 2:ncol(psp_votes)] + (sample(1:499, nrow(psp_votes) * (ncol(psp_votes) - 1), replace = TRUE)/1000000)

## create data frames with intervals

psp_votes_interval <- psp_votes[, 2:ncol(psp_votes)]
names(psp_votes_interval) <- paste0(names(psp_votes_interval), ".interval.3", sep = "")
 
psp_votes_lower_interval <- acast(data, date ~ column_name, fun.aggregate = mean, value.var = "lower_interval")
psp_votes_lower_interval <- data.frame(psp_votes_lower_interval)
names(psp_votes_lower_interval) <- paste0(names(psp_votes_lower_interval), ".interval.4", sep = "")

psp_votes_upper_interval <- acast(data, date ~ column_name, fun.aggregate = mean, value.var = "upper_interval")
psp_votes_upper_interval <- data.frame(psp_votes_upper_interval)
names(psp_votes_upper_interval) <- paste0(names(psp_votes_upper_interval), ".interval.5", sep = "")

## create a data frame with tooltips

data <- merge(data, original_polls[c("id", "pollster_id", "start_date", "end_date", "sample")], by.x = "poll_id", by.y = "id", all.x = TRUE, all.y = FALSE, stringsAsFactors = FALSE)
data <- merge(data, psp_poll_types[c("id", "name")], by.x = "poll_type_id", by.y = "id", all.x = TRUE, all.y = FALSE, stringsAsFactors = FALSE)
data <- merge(data, psp_parties[c("id", "name")], by.x = "option_id", by.y = "id", all.x = TRUE, all.y = FALSE, stringsAsFactors = FALSE)

start_date <- strsplit(data$start_date, "-")
start_date <- sapply(start_date, function(x) {x[c(1:3)]})
start_date <- apply(start_date, 1, function(x) {as.numeric(x)})
start_date <- paste0(start_date[, 3], ". ", start_date[, 2], ". ", start_date[, 1])

end_date <- strsplit(data$end_date, "-")
end_date <- sapply(end_date, function(x) {x[c(1:3)]})
end_date <- apply(end_date, 1, function(x) {as.numeric(x)})
end_date <- paste0(end_date[, 3], ". ", end_date[, 2], ". ", end_date[, 1])

midpoint <- strsplit(data$date, "-")
midpoint <- sapply(midpoint, function(x) {x[c(1:3)]})
midpoint <- apply(midpoint, 1, function(x) {as.numeric(x)})
midpoint <- paste0(midpoint[, 3], ". ", midpoint[, 2], ". ", midpoint[, 1])

data$start_date_tooltip <- start_date
data$end_date_tooltip <- end_date
data$midpoint_tooltip <- midpoint
data$psp_votes_tooltip <- paste0("<strong>Politická strana:</strong> ", data$name.y, "<br><strong>Podíl hlasů:</strong> ", round(data$percentage * 100, digits = 1), " %<br><strong>80% interval spolehlivosti:</strong> ", round(data$lower_interval * 100, digits = 1), " % - ", round(data$upper_interval * 100, digits = 1), " %<br>", paste0(replicate(85, "&nbsp;"), collapse = ""), "<br><strong>Průzkum:</strong> ", data$name.x, "<br><strong>Datum dotazování:</strong> ", data$start_date_tooltip, " - ", data$end_date_tooltip, "<br><strong>Střední den dotazování:</strong> ", data$midpoint_tooltip, "<br><strong>Počet respondentů:</strong> ", data$sample)

psp_votes_tooltip <- acast(data, date ~ column_name, fun.aggregate = NULL, value.var = "psp_votes_tooltip")
psp_votes_tooltip <- data.frame(psp_votes_tooltip)
names(psp_votes_tooltip) <- paste0(names(psp_votes_tooltip), ".html.tooltip", sep = "")

## join tables with percentages of votes, confidence intervals and tooltips

psp_votes_provisional <- cbind(psp_votes, psp_votes_interval)
psp_votes_provisional <- cbind(psp_votes_provisional, psp_votes_lower_interval)
psp_votes_provisional <- cbind(psp_votes_provisional, psp_votes_upper_interval)
psp_votes_provisional <- cbind(psp_votes_provisional, psp_votes_tooltip)
psp_votes <- psp_votes_provisional[c("date", rbind(names(psp_votes)[2:ncol(psp_votes)], names(psp_votes_interval), names(psp_votes_lower_interval), names(psp_votes_upper_interval), names(psp_votes_tooltip)))]

rm(psp_votes_provisional, psp_votes_interval, psp_votes_lower_interval, psp_votes_upper_interval)

# implement the 4G function

# source("4g.R")