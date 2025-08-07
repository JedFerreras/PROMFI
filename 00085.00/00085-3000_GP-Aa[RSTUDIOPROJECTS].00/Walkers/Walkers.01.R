# Load libraries
library(readr)
library(lubridate)
library(ggplot2)
library(dplyr)
library(hms)

# Load CSV
data <- read_csv("C:/Users/jed_ferreras/PROMFI/50006-MIMMS.00/Walkers_06.02.2025.csv")

# Rename walkers column if needed
names(data)[names(data) == "walkers/10 min"] <- "walkers_10_min"

# If time is already in HMS format, use it directly
data$clock_time <- as_hms(data$time)

# Add rate columns
data$rate_per_minute <- data$walkers_10_min / 10
data$rate_per_hour <- data$walkers_10_min * 6

# Define time windows
start1 <- as_hms("09:30:00")
end1   <- as_hms("11:30:00")

start2 <- as_hms("13:30:00")
end2   <- as_hms("15:30:00")

# Filter time blocks
morning <- data %>% filter(clock_time >= start1 & clock_time <= end1)
afternoon <- data %>% filter(clock_time >= start2 & clock_time <= end2)

# ==== AVERAGES & VARIABILITY ====
avg_morning_min <- mean(morning$rate_per_minute)
sd_morning_min  <- sd(morning$rate_per_minute)
var_morning_min <- var(morning$rate_per_minute)

avg_afternoon_min <- mean(afternoon$rate_per_minute)
sd_afternoon_min  <- sd(afternoon$rate_per_minute)
var_afternoon_min <- var(afternoon$rate_per_minute)

# ==== OUTPUT ====
cat("🕤 9:30 AM – 11:30 AM:\n")
cat("   • Avg rate per minute:", round(avg_morning_min, 2), "people/min\n")
cat("   • SD:                 ", round(sd_morning_min, 2), "\n")
cat("   • Variance:           ", round(var_morning_min, 2), "\n\n")

cat("🕜 1:30 PM – 3:30 PM:\n")
cat("   • Avg rate per minute:", round(avg_afternoon_min, 2), "people/min\n")
cat("   • SD:                 ", round(sd_afternoon_min, 2), "\n")
cat("   • Variance:           ", round(var_afternoon_min, 2), "\n\n")

# ==== PLOT ====
ggplot(data, aes(x = clock_time, y = rate_per_minute)) +
  geom_line(color = "steelblue", linewidth = 1) +
  geom_point(size = 2) +
  labs(
    title = "Rate of Walkers Over Time",
    subtitle = "Measured in people per minute",
    x = "Time of Day",
    y = "People per Minute"
  ) +
  theme_minimal()
