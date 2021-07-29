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

#Question: Across the United States, how have emissions from coal combustion-related
#sources changed from 1999–2008?

#explore the data
str(SCC)
#common variable in both NEI and SCC is SCC string

#merge data
M1<-merge(NEI,SCC, by="SCC")

#filter Short.Name column by cells conatining the word "Coal"
M2<-dplyr::filter(M1, grepl("Coal",Short.Name))

#aggregate emissions values per year
M3<-aggregate(M2$Emissions, by=list(M2$year), sum)
colnames(M3)<-c("year","Emissions")

#plot Emissions(y-axis) and year (x-axis) and save png
png("plot4.png")
barplot(M3$Emissions,M3$year,names.arg = M3$year,col="orange",main="Total Coal emissions in the United States",xlab="Year",ylab="Emissions (tons)")
dev.off()