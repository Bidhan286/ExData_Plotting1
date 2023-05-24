# Load Packages and get the Data
library("data.table")
library("dplyr")
setwd("C:/Users/bidhan.chakraborty/OneDrive - Kantar/Documents/Project2/Project2")
#Reads in data from file then subsets data for specified dates
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))
emi_year <- NEI %>% group_by(year) %>% summarise(total = sum(Emissions))
png("plot1.png", width=480, height=480)
## Plot 1
plot1 <- barplot(emi_year$total/1000, main = "Total PM2.5 Emissions", 
                 xlab = "Year", ylab = "PM2.5 Emissions in Kilotons", 
                 names.arg = emi_year$year, col = "darkred", 
                 ylim = c(0,8300))

text(plot1, round(emi_year$total/1000), label = round(emi_year$total/1000), 
     pos = 3, cex = 1.2)
dev.off()
