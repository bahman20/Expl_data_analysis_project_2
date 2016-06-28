#Clear workspace
rm(list=ls())

#Check if zip folder is already downloaded. If not, downloads it. If the folder is not already unzipped, it unzips the folder.
if (!file.exists("exdata%2Fdata%2FNEI_data.zip")){download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", "exdata%2Fdata%2FNEI_data.zip")}  
if (!file.exists("summarySCC_PM25.rds")) {unzip("exdata%2Fdata%2FNEI_data.zip")}

#Read RDS data files
summarySCC_data<-readRDS("summarySCC_PM25.rds")
Source_Class_Code_data<-readRDS("Source_Classification_Code.rds")

#Merge two datasets by SCC. Takes a while!!
merged_data <- merge(summarySCC_data, Source_Class_Code_data, by="SCC")

#Look for "coal" in Short.Name column and subset the data containing "coal"
coal_comb  <- grepl("coal", merged_data$Short.Name, ignore.case=TRUE)
coal_comb_data<-merged_data[coal_comb,]

#Apply sum to coal_comb_data by year
plot_data<-with(coal_comb_data, tapply(Emissions, year,sum))

#Plot and save as png
png('plot4.png')
plot(as.numeric(names(plot_data)),plot_data, xlab = "Year", ylab = "Coal-related emission", main = "Emissions from coal combustion-related sources versus year")
dev.off()
