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


#filter data to fips=="24510"
M22<-M2 %>% 
  filter(fips %in% c("24510", "06037"))
#rename
M22$fips[M22$fips=="24510"]<-"Baltimore City"
M22$fips[M22$fips=="06037"]<-"Los Angeles County"


#aggregate emissions values per year
M3<-aggregate(Emissions ~ fips + year, data = M22, FUN = sum, na.rm = TRUE)

#plot Emissions(y-axis) and year (x-axis) and save png
png("plot6.png")

ggplot(M3, aes(x=factor(year), y=Emissions, fill=fips,label = round(Emissions,0))) +
geom_bar(stat="identity") + 
facet_grid(fips~., scales="free") +
ylab(expression("Emissions (tons)")) + 
xlab("year") +
ggtitle(expression("Motor Vehicle Emissions in Baltimore City vs Los Angeles County"))+
geom_label(aes(fill = fips),colour = "white")+theme(plot.title = element_text(hjust = 0.5))+
scale_fill_ordinal()+ guides(fill=guide_legend(title="County"))
dev.off()
