# Load Packages and get the Data
library("data.table")
setwd("C:/Users/bidhan.chakraborty/OneDrive - Kantar/Documents/Project1/Project1")
#Reads in data from file then subsets data for specified dates
Sys.setlocale("LC_TIME", "English")
df_power <- fread("household_power_consumption.txt", na.strings="?")
df_power[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
df_power <- df_power[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
time_axis <- as.POSIXct(paste(df_power[, Date], df_power[, Time]))
png("plot4.png", width=480, height=480)
## Plot 4
par(mfrow = c(2,2))

plot(time_axis, df_power[, Global_active_power], xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")

plot(time_axis, df_power[, Voltage], xlab = "datetime", ylab = "Voltage", type = "l")

plot(time_axis, df_power[, Sub_metering_1], xlab = "", ylab = "Energy sub metering", type = "l")
lines(time_axis, df_power[, Sub_metering_2], col = "red")
lines(time_axis, df_power[, Sub_metering_3], col = "blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black","red","blue"), cex = 0.8, lty = 1 , bty = "n")

plot(time_axis, df_power[, Global_reactive_power], xlab = "datetime", ylab = "Global_reactive_power", type = "l")
dev.off()


