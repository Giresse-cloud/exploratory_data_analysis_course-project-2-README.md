library(dplyr)
library(ggplot2)

setwd("D:/Data Science/Git projet/exdata_data_NEI_data")

#Import data from rds file
file <- "Source_Classification_Code.rds"
file2 <- "summarySCC_PM25.rds"
data <- readRDS(file)
data2 <- readRDS(file2)

#6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == “06037”). Which city has seen greater changes over time in motor vehicle emissions?

#Select motor vehicle emissions in Baltimore City and Los Angeles County
motor_data <- data[grepl("Vehicle", data$SCC.Level.Two), ]

#Calculate total coal combustion-related emissions
motor_scc <- unique(motor_data$SCC)
motor_emission <- data2[(data2$SCC %in% motor_scc), ]

#Select motor vehicle emissions in Baltimore City and Los Angeles County
motor_bal_los <- motor_emission %>% filter(fips == "24510" | fips == "06037") %>% 
  group_by(fips, year) %>% summarise(total = sum(Emissions))

#create column ensemble for (Baltimore City or LA County)
motor_bal_los = mutate(motor_bal_los, 
                  ensemble = ifelse(fips == "24510", "Baltimore City", 
                                ifelse(fips == "06037", "Los Angeles County")))

#PLot total motor vehicle emissions in Baltimore and Los Angeles

ggplot(motor_bal_los, aes(factor(year), total, 
                          fill = ensemble, label = round(total))) + 
  geom_bar(stat = "identity") + facet_grid(. ~ ensemble) + 
  ggtitle("Total Motor Vehicle Emissions") +
  xlab("Year") + ylab("Pm2.5 Emissions in Tons") +
  theme(plot.title = element_text(hjust = 0.5)) + ylim(c(0, 8000)) +
  theme_classic() + geom_text(size = 4, vjust = -1)

#Saving the plot
dev.copy(png, file = "plot6.png")
dev.off()
