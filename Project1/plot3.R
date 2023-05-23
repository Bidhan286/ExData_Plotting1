# Load Packages and get the Data
library("data.table")
setwd("C:/Users/bidhan.chakraborty/OneDrive - Kantar/Documents/Project1/Project1")
#Reads in data from file then subsets data for specified dates
Sys.setlocale("LC_TIME", "English")
df_power <- fread("household_power_consumption.txt", na.strings="?")
df_power[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
df_power <- df_power[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
time_axis <- as.POSIXct(paste(df_power[, Date], df_power[, Time]))
png("plot3.png", width=480, height=480)
## Plot 3
plot(time_axis, df_power[, Sub_metering_1], xlab = "", ylab = "Energy sub metering", type = "l")
lines(time_axis, df_power[, Sub_metering_2], col = "red")
lines(time_axis, df_power[, Sub_metering_3], col = "blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"), lty = 1)
dev.off()


