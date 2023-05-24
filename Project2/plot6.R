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
balti_la_year <- NEI_Vehicle %>% filter(fips == "24510" | fips == "06037") %>% 
  group_by(fips, year) %>% summarise(total = sum(Emissions))
balti_la_year <- mutate(balti_la_year, 
                        Unit = ifelse(fips == "24510", "Baltimore City", 
                                      ifelse(fips == "06037", "Los Angeles County")))
png("plot6.png", width=480, height=480)
## Plot 6
ggplot(balti_la_year, aes(factor(year), total, 
                          fill = Unit, label = round(total))) + 
  geom_bar(stat = "identity") + facet_grid(. ~ Unit) + 
  ggtitle("Total Motor Vehicle Emissions") +
  xlab("Year") + ylab("Pm2.5 Emissions in Tons") +
  theme(plot.title = element_text(hjust = 0.5)) + ylim(c(0, 8000)) +
  theme_classic() + geom_text(size = 4, vjust = -1)

dev.off()