# Load Packages and get the Data
library("data.table")
library("dplyr")
library("ggplot2")
setwd("C:/Users/bidhan.chakraborty/OneDrive - Kantar/Documents/Project2/Project2")
#Reads in data from file then subsets data for specified dates
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))
Vehicle<- grep("Vehicle", SCC[,SCC.Level.Two])
SCC_Vehicle <- SCC[Vehicle,]
NEI_Vehicle <- NEI[(NEI$SCC %in% unique(SCC_Vehicle$SCC)), ]
Vehicle_year <- NEI_Vehicle %>% filter(fips == "24510") %>% group_by(year) %>% summarise(total = sum(Emissions))

png("plot5.png", width=480, height=480)
## Plot 5
ggplot(Vehicle_year, aes(factor(year), total, label = round(total))) + 
  geom_bar(stat = "identity", fill = "darkred") + 
  ggtitle("Total Motor Vehicle Emissions in Baltimore City") + 
  xlab("Year") + ylab("PM2.5 Emissions in Tonnes") +
  ylim(c(0, 450)) + theme_classic()+ geom_text(size = 5, vjust = -1) + 
  theme(plot.title = element_text(hjust = 0.5))

dev.off()