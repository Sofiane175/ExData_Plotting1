rm(list=ls())
library(data.table)
library(lubridate)
# Get data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "exdata_data_household_power_consumption.zip"
if (!file.exists(zipFile)) {download.file(fileUrl, zipFile, mode="wb")}


# Unzip the downloaded file
file <- "household_power_consumption.txt" ##verify again the file does not exist
if (!file.exists(file)) {unzip(zipFile)}

# Reading data from the downloaded files
wdpath <- getwd()

data <- fread(file.path(wdpath, file),
              na.strings="?")

str(data) ## check the format of the columns

# converte Date & Time form character to Date/time format
data$Date <- lubridate::dmy(data$Date)
data$Time <- lubridate::hms(data$Time)

# filter on 01 & 02 Feb 2007
data0207 <- subset(data,Date >= "2007-02-01" & Date <= "2007-02-02")


## Graph creation

fpf2 <- file.path(wdpath,"figure/plot2.png") # File path figure 2
png(filename = fpf2, width = 480, height = 480, units = "px")


plot(data0207$Global_active_power,ylab="Global Active Power (kilowatts)",
     type='l',xaxt='n',xlab="")
axis(side=1,at=c(0,1440,2880),label=c("Thu","Fri","Sat"))

dev.off()