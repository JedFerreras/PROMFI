# Load libraries
library(readr)
library(lubridate)
library(ggplot2)
library(dplyr)
library(hms)
library(tidyr)

# Load CSV
data <- read_csv("C:/Users/jed_ferreras/PROMFI/50006-MIMMS.00/Walkers_06022025-06062025.csv")

# Rename columns
names(data)[names(data) == "walkers/10 min"] <- "walkers_10_min"
names(data)[names(data) == "focus/work done"] <- "focus_score"

# Parse time
data$clock_time <- as_hms(data$time)

# Parse date if needed
data$date <- as.Date(data$date)

# Add useful columns
data$rate_per_minute <- data$walkers_10_min / 10
data$rate_per_hour <- data$walkers_10_min * 6
data$hour <- hour(data$clock_time)
data$weekday <- factor(weekdays(data$date), levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"))

# Define lunch window
data$period <- ifelse(data$clock_time < as_hms("12:00:00"), "Morning",
                      ifelse(data$clock_time < as_hms("14:00:00"), "Lunch", "Afternoon"))

# === DAILY AVERAGES ===
daily_summary <- data %>%
  group_by(date) %>%
  summarise(
    avg_min = mean(rate_per_minute),
    avg_hour = mean(rate_per_hour),
    max_rate = max(rate_per_minute),
    total_walkers = sum(walkers_10_min),
    avg_focus = mean(focus_score, na.rm = TRUE)
  )

# === PERIOD AVERAGES ===
period_summary <- data %>%
  group_by(date, period) %>%
  summarise(
    avg_rate_min = mean(rate_per_minute),
    avg_focus = mean(focus_score, na.rm = TRUE)
  )

# === PEAK TIME BLOCKS ===
peak_blocks <- data %>%
  group_by(date) %>%
  top_n(1, rate_per_minute) %>%
  select(date, time, rate_per_minute)

# === HIGHEST TRAFFIC DAY ===
busiest_day <- daily_summary %>%
  filter(avg_min == max(avg_min))

# === CORRELATION ===
cor_test <- cor.test(data$rate_per_minute, data$focus_score, use = "complete.obs")

# === TIME + WEEKDAY PATTERNS ===
pattern_summary <- data %>%
  group_by(weekday, hour) %>%
  summarise(
    avg_rate = mean(rate_per_minute),
    .groups = "drop"
  )

# === PLOTS ===

# Plot: Walkers Over Time by Day
ggplot(data, aes(x = clock_time, y = rate_per_minute, color = as.factor(date))) +
  geom_line() +
  labs(title = "Walkers per Minute Throughout Each Day", x = "Time", y = "People per Minute") +
  theme_minimal()

# Plot: Daily average vs focus
ggplot(daily_summary, aes(x = avg_min, y = avg_focus)) +
  geom_point() +
  geom_smooth(method = "lm") +
  labs(title = "Daily Walkers vs Focus", x = "Avg Walkers/Min", y = "Focus Score") +
  theme_minimal()

# Plot: Rate heatmap by weekday and hour
ggplot(pattern_summary, aes(x = hour, y = weekday, fill = avg_rate)) +
  geom_tile() +
  scale_fill_gradient(low = "white", high = "red") +
  labs(title = "Predicted Walkers by Hour & Weekday", x = "Hour", y = "Weekday", fill = "Avg/Min") +
  theme_minimal()
