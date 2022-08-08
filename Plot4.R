library(dplyr)
library(ggplot2)

setwd("D:/Data Science/Git projet/exdata_data_NEI_data")

#Import data from rds file
file <- "Source_Classification_Code.rds"
file2 <- "summarySCC_PM25.rds"
data <- readRDS(file)
data2 <- readRDS(file2)

#5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

#Keywords from the Ei.Sector column
motor_data <- data[grepl("Comb.*Coal", data$EI.Sector), ]

#Calculate total coal combustion-related emissions
coal_scc <- unique(coal_data$SCC)
coal_emission <- data2[(data2$SCC %in% coal_scc), ]

#Calculate coal emissions by year
coal_year <- coal_emission %>% group_by(year) %>% summarise(total = sum(Emissions))

#Plot total coal combustion-related emissions for each year

ggplot(coal_year, aes(factor(year), total/1000, label = round(total/1000))) + 
  geom_bar(stat = "identity", fill = "#7C7C7C") + 
  ggtitle("Total coal combustion related PM2.5 Emissions") + 
  xlab("Year") + ylab("PM2.5 Emissions in Kilotons") +
  ylim(c(0, 620)) + theme_classic()+ geom_text(size = 5, vjust = -1) + 
  theme(plot.title = element_text(hjust = 0.5))

#Saving the plot
dev.copy(png, file = "plot4.png")
dev.off()
# comment : The graph show that Overall, Baltimore city PM2.5 emissions did decrease from 1999 to 2008, although the year 2005 noticed a spike at 3091 tons.
