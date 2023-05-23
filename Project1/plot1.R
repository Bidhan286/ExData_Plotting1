# Load Packages and get the Data
library("data.table")
setwd("C:/Users/bidhan.chakraborty/OneDrive - Kantar/Documents/Project1/Project1")
#Reads in data from file then subsets data for specified dates
df_power <- fread("household_power_consumption.txt", na.strings="?")
df_power <- df_power[(Date >= "1/2/2007") & (Date <= "2/2/2007"),]
png("plot1.png", width=480, height=480)
## Plot 1
hist(df_power[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
