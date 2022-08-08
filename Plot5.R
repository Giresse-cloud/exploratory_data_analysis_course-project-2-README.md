library(dplyr)
library(ggplot2)

setwd("D:/Data Science/Git projet/exdata_data_NEI_data")

#Import data from rds file
file <- "Source_Classification_Code.rds"
file2 <- "summarySCC_PM25.rds"
data <- readRDS(file)
data2 <- readRDS(file2)

#5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

#motor vehicle sources
motor_data <- data[grepl("Vehicle", data$SCC.Level.Two), ]

#Total emissions from motor vehicle sources in Baltimore City
motor_scc <- unique(motor_data$SCC)
motor_emission <- data2[(data2$SCC %in% motor_scc), ]

#Calculate coal emissions by year
motor_year <- motor_emission %>% filter(fips == "24510") %>% group_by(year) %>% summarise(total = sum(Emissions))

#Plot total emissions from motor vehicle sources in Baltimore City

ggplot(motor_year, aes(factor(year), total, label = round(total))) + 
  geom_bar(stat = "identity", fill = "#7C7C7C") + 
  ggtitle("Total Motor Vehicle Emissions in Baltimore City") + 
  xlab("Year") + ylab("PM2.5 Emissions in Tonnes") +
  ylim(c(0, 450)) + theme_classic()+ geom_text(size = 5, vjust = -1) + 
  theme(plot.title = element_text(hjust = 0.5))

#Saving the plot
dev.copy(png, file = "plot5.png")
dev.off()
