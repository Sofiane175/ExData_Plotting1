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

fpf3 <- file.path(wdpath,"figure/plot3.png") # File path figure 3

png(filename = fpf3, width = 480, height = 480, units = "px")

plot(data0207$Sub_metering_1,ylab="Energy sub meterning",
     type='l',xaxt='n',xlab="")

points(data0207$Sub_metering_2,ylab="Energy sub meterning",
     type='l',xaxt='n',xlab="",col="red")

points(data0207$Sub_metering_3,ylab="Energy sub meterning",
       type='l',xaxt='n',xlab="",col="blue")

axis(side=1,at=c(0,1440,2880),label=c("Thu","Fri","Sat"))
leg.text <- c('Sub_metering_1','Sub_metering_2','Sub_metering_3')
legend('topright',lty=1,leg.text,col=c('black','red','blue'))
dev.off()