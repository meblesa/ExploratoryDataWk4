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

#Question: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland
#(fips == "24510") from 1999 to 2008? Use the base
#plotting system to make a plot answering this question.


#explore data
str(NEI)
#wanted columns Emissions and year

#filter data to fips=="24510"
NEI2<-NEI[which(NEI$fips=="24510"),]

#aggreagate EMissions to a total per year
NEI2<-aggregate(NEI2['Emissions'], by=NEI2['year'], sum)

#plot Emissions(y-axis) and year (x-axis) and save png
png("plot2.png")
barplot(NEI2$Emissions,NEI2$year,names.arg = NEI2$year,col="aquamarine",main="Total emissions from PM2.5 in Baltimore City, Maryland",xlab="Year",ylab="Emissions (tons)")
dev.off()