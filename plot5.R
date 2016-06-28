#Clear workspace
rm(list=ls())

#Check if zip folder is already downloaded. If not, downloads it. If the folder is not already unzipped, it unzips the folder.
if (!file.exists("exdata%2Fdata%2FNEI_data.zip")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "exdata%2Fdata%2FNEI_data.zip")}  
if (!file.exists("summarySCC_PM25.rds")) {unzip("exdata%2Fdata%2FNEI_data.zip")}

#Read RDS file 
summarySCC_data<-readRDS("summarySCC_PM25.rds")
Source_Class_Code_data<-readRDS("Source_Classification_Code.rds")

#Subset Baltimore's on-road data
Baltimore_on_road_data<-subset(summarySCC_data,fips == "24510" & type=="ON-ROAD")

#Apply sum to Baltimore_on_road_data by year
plot_data<-with(Baltimore_on_road_data, tapply(Emissions, year,sum))

#Plot and save as png
png('plot5.png')
plot(as.numeric(names(plot_data)),plot_data, xlab = "Year", ylab = "Motor vehicle related emission", main = "Emissions from motor vehicle sources versus year for Baltimore")
dev.off()
