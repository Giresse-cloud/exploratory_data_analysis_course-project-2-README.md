library(dplyr)
library(ggplot2)

setwd("D:/Data Science/Git projet/exdata_data_NEI_data")

#Import data from rds file
file <- "summarySCC_PM25.rds"
data <- readRDS(file)

#2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == “24510”) from 1999 to 2008? Use the base plotting system to make a plot answering this question

#Calculate total emissions for Baltimore City
emission_balt_city <- data %>% group_by(year) %>% filter(fips == "24510") %>% summarise(total = sum(Emissions))

#Plot the data accordingly
plot2 <- barplot(emission_by_year$total/1000, main = "Total PM2.5 Emissions in Baltimore City, Maryland", 
                 xlab = "Year", ylab = "PM2.5 Emissions in Kilotons", 
                 names.arg = emission_by_year$year, col = "#7C7C7C", ylim = c(0,8300))

text(plot2, round(emission_balt_city$total), label = round(emission_balt_city$total), 
     pos = 3, cex = 1.2)

#Saving the plot
dev.copy(png, file = "plot2.png")
dev.off()
# comment : The graph show that Overall, Baltimore city PM2.5 emissions did decrease from 1999 to 2008, although the year 2005 noticed a spike at 3091 tons.
