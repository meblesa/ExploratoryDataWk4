# Getting Data
# 1.Unzip file into project folder
filen<-"Data.zip"
fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileURL, filen, method="curl")
unzip(filen)
install.packages("RDS")
library(RDS)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Question: Of the four types of sources indicated by the type (point, nonpoint, 
#onroad, nonroad) variable, which of these four sources have seen decreases in 
#emissions from 1999–2008 for Baltimore City? Which have seen increases in 
#emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.


#filter data to fips=="24510"
NEI3<-NEI[which(NEI$fips=="24510"),]

#aggreagate EMissions to a total per year per type
NEI3<-aggregate(Emissions ~ type + year, data = NEI3, FUN = sum, na.rm = TRUE)

#plot Emissions(y-axis) and year (x-axis) and save png
png("plot3.png")
ggplot(NEI3,aes(x=year,y=Emissions,fill=type))+geom_bar(stat="identity")+
  +     ggtitle("Total Emissions in Maryland") +
  +     facet_wrap(~type)+theme_light()+scale_x_discrete(limits=NEI3$year)
dev.off()