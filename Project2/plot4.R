# Load Packages and get the Data
library("data.table")
library("dplyr")
library("ggplot2")
setwd("C:/Users/bidhan.chakraborty/OneDrive - Kantar/Documents/Project2/Project2")
#Reads in data from file then subsets data for specified dates
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))
coal<- grep("Comb.*Coal", SCC[,EI.Sector])
SCC_coal <- SCC[coal,]
NEI_coal <- NEI[(NEI$SCC %in% unique(SCC_coal$SCC)), ]
coal_year <- NEI_coal %>% group_by(year) %>% summarise(total = sum(Emissions))

png("plot4.png", width=480, height=480)
## Plot 4
ggplot(coal_year, aes(factor(year), total/1000, label = round(total/1000))) + 
  geom_bar(stat = "identity", fill = "darkred") + 
  ggtitle("Total coal combustion related PM2.5 Emissions") + 
  xlab("Year") + ylab("PM2.5 Emissions in Kilotons") +
  ylim(c(0, 620)) + theme_classic()+ geom_text(size = 5, vjust = -1) + 
  theme(plot.title = element_text(hjust = 0.5))

dev.off()