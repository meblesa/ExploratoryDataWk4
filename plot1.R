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
  
#Question: Have total emissions from PM2.5 decreased in the United States from
#1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5
#emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#explore data
str(NEI)
#wanted columns Emissions and year

#aggregate Emissions to a total per year
NEI1<-aggregate(NEI['Emissions'], by=NEI['year'], sum)

#plot Emissions(y-axis) and year (x-axis) and save png
png("plot1.png")
barplot(NEI1$Emissions,NEI1$year,names.arg = NEI1$year,col="steelblue",main="Total emissions from PM2.5 in the United States",xlab="Year",ylab="Emissions (tons)")
dev.off() 
