#Clear workspace
rm(list=ls())

#Check if zip folder is already downloaded. If not, downloads it. If the folder is not already unzipped, it unzips the folder.
if (!file.exists("exdata%2Fdata%2FNEI_data.zip")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "exdata%2Fdata%2FNEI_data.zip")}  
if (!file.exists("summarySCC_PM25.rds")) {unzip("exdata%2Fdata%2FNEI_data.zip")}

#Read RDS file 
summarySCC_data<-readRDS("summarySCC_PM25.rds")

#Obtain total PM2.5 emission by year
total_data<-with(summarySCC_data, tapply(Emissions, year,sum))

#Plot and save as png
png('plot1.png')
plot(as.numeric(names(total_data)),total_data, xlab = "Year", ylab = "Total PM2.5 emission", main = "Total PM2.5 emission versus year")
dev.off()
