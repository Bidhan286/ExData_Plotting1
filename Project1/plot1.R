# Load Packages and get the Data

library("data.table")
setwd("C:/Users/bidhan.chakraborty/OneDrive - Kantar/Documents/Project1/Project1")
#Reads in data from file then subsets data for specified dates
df_power <- fread("household_power_consumption.txt", na.strings="?")
df_power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
df_power[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]
df_power <- df_power[(Date >= "2007-02-01") & (Date <= "2007-02-02")]
png("plot1.png", width=480, height=480)
## Plot 1
hist(df_power[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
