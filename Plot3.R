library(dplyr)
library(ggplot2)

setwd("D:/Data Science/Git projet/exdata_data_NEI_data")

#Import data from rds file
file <- "summarySCC_PM25.rds"
data <- readRDS(file)

#3. Of the four types of sources indicated by the type(point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

#Calculate total emissions by year and source type for Baltimore City
emission_balt_type <- data %>% group_by(type, year) %>% filter(fips == "24510") %>% summarise(total = sum(Emissions))

#Plot Baltimore City emissions by type for each year

ggplot(emission_balt_type, aes(year, total, color=type))+ggtitle("Total PM2.5 Emissions in Baltimore City")+ 
  geom_line(size=1.25,linetype = "F1")+theme(axis.text=element_text(color="red",size=10))+
  theme(axis.title.x=element_text(color='black',vjust=-0.9),
        axis.title.y=element_text(color='black',vjust=1.5),plot.title=element_text(color="blue",size=12,vjust=1))

#Saving the plot
dev.copy(png, file = "plot3.png")
dev.off()
# comment : The graph show that Overall, Baltimore city PM2.5 emissions did decrease from 1999 to 2008, although the year 2005 noticed a spike at 3091 tons.
