# Load Packages and get the Data
library("data.table")
library("dplyr")
setwd("C:/Users/bidhan.chakraborty/OneDrive - Kantar/Documents/Project2/Project2")
#Reads in data from file then subsets data for specified dates
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))
emi_balt <- NEI %>% group_by(year) %>% filter(fips == "24510") %>% summarise(total = sum(Emissions))
png("plot2.png", width=480, height=480)
## Plot 2
plot2 <- barplot(emi_balt$total, 
                 main = "Total PM2.5 Emissions in Baltimore City, Maryland", 
                 xlab = "Year", ylab = "PM2.5 Emissions in Tons", 
                 names.arg = emi_balt$year, col = "darkred", ylim = c(0,3600))

text(plot2, round(emi_balt$total), label = round(emi_balt$total), 
     pos = 3, cex = 1.2)
dev.off()