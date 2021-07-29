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

#Question: How have emissions from motor vehicle sources changed from 1999–2008
#in Baltimore City?

#merge data
M1<-merge(NEI,SCC, by="SCC")

#filter Short.Name column by cells conatining the word "Coal"
M2<-dplyr::filter(M1, grepl("Mobile",EI.Sector))

#filter by 
#filter data to fips=="24510"
M2<-M2[which(M2$fips=="24510"),]

#aggregate emissions values per year
M3<-aggregate(M2$Emissions, by=list(M2$year), sum)
colnames(M3)<-c("year","Emissions")

#plot Emissions(y-axis) and year (x-axis) and save png
png("plot5.png")
barplot(M3$Emissions,M3$year,names.arg = M3$year,col="pink",main="Total Mobile emissions in Baltimore City",xlab="Year",ylab="Emissions (tons)")
dev.off()