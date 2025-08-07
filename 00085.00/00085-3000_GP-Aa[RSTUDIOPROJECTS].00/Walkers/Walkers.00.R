install.packages("readr")
install.packages("lubridate")
install.packages("ggplot2")
install.packages("dplyr")
library(readr)
library(lubridate)
library(ggplot2)
library(dplyr)

data <- read.csv("C:\\Users\\jed_ferreras\\PROMFI\\50006-MIMMS.00\\Walkers_06.02.2025.csv", stringsAsFactors = FALSE)

# head(data)
# str(data)
# summary(data)
# names(data)

# data$time <- hms::as.hms(data$time)
# head(data$time)
data$time <- trimws(data$time)
data$Time <- parse_date_time(data$time, orders = "I:M p")

# summary(data$time)

# data$hour <- hour(data$time)

# unique(is.na(data$time))
# sum(is.na(data$time))

# head(data[c("time", "hour")])

# class(data$time)

names(data)[names(data) == "walkers.10.min"] <- "walkers_10_min"

# people_per_hour <- aggregate(walkers_10_min ~ hour, data = data, sum)

# print(people_per_hour)

# Convert to time-of-day (HMS object) for time-only filtering
data$clock_time <- hms::as_hms(data$time)

# Define your ranges
start1 <- hms::as_hms("09:30:00")
end1   <- hms::as_hms("11:30:00")

start2 <- hms::as_hms("13:30:00")
end2   <- hms::as_hms("15:30:00")

# Filter between 9:30 AM and 11:30 AM
morning <- data %>%
  filter(clock_time >= start1, clock_time <= end1)

# Filter between 1:30 PM and 3:30 PM
afternoon <- data %>%
  filter(clock_time >= start2, clock_time <= end2)

# Averages
mean_morning <- mean(morning$walkers_10_min)
mean_afternoon <- mean(afternoon$walkers_10_min)

# Output
mean_morning
mean_afternoon

ggplot(data, aes(x = time, y = walkers_10_min)) +
  geom_line(color="steelblue") +
  geom_point() +
  labs(title = "Walkers Over Time", x = "Time", y = "Walkers per 10 Min")+
  theme_minimal()
