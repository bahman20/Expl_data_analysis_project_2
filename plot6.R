#Clear workspace
rm(list=ls())

#Check if zip folder is already downloaded. If not, downloads it. If the folder is not already unzipped, it unzips the folder.
if (!file.exists("exdata%2Fdata%2FNEI_data.zip")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "exdata%2Fdata%2FNEI_data.zip")}  
if (!file.exists("summarySCC_PM25.rds")) {unzip("exdata%2Fdata%2FNEI_data.zip")}

#Read RDS file 
summarySCC_data<-readRDS("summarySCC_PM25.rds")
Source_Class_Code_data<-readRDS("Source_Classification_Code.rds")

#Subset Baltimore and Los Angeles on-road data
Baltimore_on_road_data<-subset(summarySCC_data,fips == "24510" & type=="ON-ROAD")
LosAngeles_on_road_data<-subset(summarySCC_data,fips == "06037" & type=="ON-ROAD")

#Apply sum to Baltimore_on_road_data and LosAngeles_on_road_data by year
Baltimore_plot_data<-with(Baltimore_on_road_data, tapply(Emissions, year,sum))
LosAngeles_plot_data<-with(LosAngeles_on_road_data, tapply(Emissions, year,sum))
rng<-range(Baltimore_plot_data,LosAngeles_plot_data)


#Plot and save as png
png('plot6.png')
plot(as.numeric(names(Baltimore_plot_data)),Baltimore_plot_data, ylim = rng, col="red",type="l", xlab = "Year", ylab = "Motor vehicle related emission", main = "Emissions from motor vehicle sources versus year")
lines(as.numeric(names(LosAngeles_plot_data)),LosAngeles_plot_data,col="blue")
legend(2005,3000,legend = c("Baltimore","Los Angeles"), lty=c(1,1), lwd=c(2.5,2.5),col=c("red","blue")) 
dev.off()
