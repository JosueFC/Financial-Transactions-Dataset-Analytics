# Load required libraries
library(tidyverse)
library(lubridate)
library(ggplot2)
library(forecast)
library(ggseas)
library(RColorBrewer)


# Load the dataset
df <- read.csv("C:/Users/Josue/Downloads/High-Level_Monthly_Trends.csv")

# Convert year and month into a proper Date format
df$date <- as.Date(paste(df$year, df$month, "01", sep = "-"))

# Sort by date
df <- df %>% arrange(date)

#Plot Monthly Spending Trends
ggplot(df, aes(x = date, y = total_spent)) +
  geom_line(color = "blue", size = 1) +
  geom_point(color = "red") +
  labs(title = "Monthly Spending Trends",
       x = "Date",
       y = "Total Spending") +
  theme_minimal()

df$month <- factor(month(df$date, label = TRUE), levels = month.abb)

# Plot seasonal subseries
# Custom colors for better contrast
custom_colors <- c(
  "Jan" = "#E41A1C",   # Red
  "Feb" = "#377EB8",   # Blue
  "Mar" = "#4DAF4A",   # Green
  "Apr" = "#FF7F00",   # Orange
  "May" = "#FFFF33",   # Yellow
  "Jun" = "#A65628",   # Brown
  "Jul" = "#F781BF",   # Pink
  "Aug" = "#999999",   # Gray
  "Sep" = "#00FFFF",   # Cyan
  "Oct" = "#FF00FF",   # Magenta
  "Nov" = "#00FF00",   # Lime
  "Dec" = "#0000FF"    # Blue
)

# Plot with custom colors
ggplot(df, aes(x = year, y = total_spent, group = month, color = month)) +
  geom_line(size = 1) +
  geom_point() +
  labs(title = "Seasonal Spending Trends by Month",
       x = "Year",
       y = "Total Spending") +
  scale_color_manual(values = custom_colors) +  # Apply custom colors
  theme_minimal()

##Time series decomposition
# Convert to a time series object
ts_data <- ts(df$total_spent, start = c(min(df$year), min(df$month)), frequency = 12)

# Decompose the time series
decomposed <- stl(ts_data, s.window = "periodic")

# Plot decomposition
plot(decomposed)

#Forecast Future Spending
# Fit ARIMA model
model <- auto.arima(ts_data)

# Forecast for next 12 months
forecasted <- forecast(model, h = 12)

# Plot forecast
autoplot(forecasted) +
  labs(title = "Spending Forecast for Next 12 Months",
       x = "Time",
       y = "Projected Total Spending")
