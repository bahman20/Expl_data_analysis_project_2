#Clear workspace
rm(list=ls())

#Check if zip folder is already downloaded. If not, downloads it. If the folder is not already unzipped, it unzips the folder.
if (!file.exists("exdata%2Fdata%2FNEI_data.zip")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "exdata%2Fdata%2FNEI_data.zip")}  
if (!file.exists("summarySCC_PM25.rds")) {unzip("exdata%2Fdata%2FNEI_data.zip")}

#Read RDS file 
summarySCC_data<-readRDS("summarySCC_PM25.rds")

#Obtain total PM2.5 emission by year for Baltimore, MD
Baltimore_data<-subset(summarySCC_data,fips == "24510")
Baltimore_data_type<-aggregate(Emissions ~ year + type, Baltimore_data, sum)

#Plot and save as png
png('plot3.png')
g <- ggplot(Baltimore_data_type, aes(year, Emissions, color = type)) + geom_line() + xlab("year") + ylab("Total PM2.5 emission") + ggtitle("Baltimore's total PM2.5 emission versus year for different types")
print(g)
dev.off()
