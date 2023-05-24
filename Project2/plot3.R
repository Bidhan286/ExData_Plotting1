# Load Packages and get the Data
library("data.table")
library("dplyr")
library("ggplot2")
setwd("C:/Users/bidhan.chakraborty/OneDrive - Kantar/Documents/Project2/Project2")
#Reads in data from file then subsets data for specified dates
NEI <- as.data.table(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.table(readRDS("Source_Classification_Code.rds"))
emi_balt_type <- NEI %>% group_by(type,year) %>% summarise(total = sum(Emissions))
png("plot3.png", width=480, height=480)
## Plot 3
ggplot(emi_balt_type, aes(x = factor(year), 
                       y = total, fill = type, label = round(total))) + 
  geom_bar(stat = "identity") + facet_grid(. ~ type) + 
  ggtitle("Total PM2.5 Emissions in Baltimore City, Maryland") + 
  xlab("Year")+ ylab("PM2.5 Emissions in Tons") +
  theme_classic() + theme(plot.title = element_text(hjust = 0.5))
dev.off()
