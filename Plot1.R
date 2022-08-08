library(dplyr)
library(ggplot2)

setwd("D:/Data Science/Git projet/exdata_data_NEI_data")

#Import data from rds file
file <- "summarySCC_PM25.rds"
data <- readRDS(file)

#1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008

#Calculate total PM2.5 emissions for each year
emission_by_year <- data %>% group_by(year) %>% summarise(total = sum(Emissions))

#Plot the data accordingly
plot1 <- barplot(emission_by_year$total/1000, main = "Total PM2.5 Emissions", 
                 xlab = "Year", ylab = "PM2.5 Emissions in Kilotons", 
                 names.arg = emission_by_year$year, col = "#7C7C7C", ylim = c(0,8300))

text(plot1, round(emission_by_year$total/1000), label = round(emission_by_year$total/1000), 
     pos = 3, cex = 1.2)

dev.copy(png, file = "plot1.png")
dev.off()
# comment : The graph show that PM2.5 emissions did decrease from 1999 to 2008 with an overall decrease.

