#
# plot2.R
#
# 1. Extracts and then reads the Electric power consumption dataset from 
#    the UC Irvine Machine Learning Repository. Only the observations for
#    2007-02-01 and 2007-02-02 are used.
# 
# 2. Outputs a line chart of Global_active_power over time into plot2.png
#
saveObjects <- c("pc")   # for housekeeping

# set toScreen to 0 to create a png or 1 to send to your terminal

toScreen <- 0   # 1: screen 0: png

library(sqldf)
library(lubridate)

url <- "https://d396qusza40orc.cloudfront.net/exdata/data/household_power_consumption.zip"


#    download power consumption file if it doesn't exist

if (!file.exists("household_power_consumption.txt")) {
  if (!file.exists("household_power_consumption.zip")) {
    download.file(url,"household_power_consumption.zip")
  }
  unzip("household_power_consumption.zip")
}  

# create pc with a subset of dates

if (!exists("pc")) {
  
  pc <- read.table("household_power_consumption.txt",sep = ";", header = TRUE,
                   na.strings = "?")
  
  pc <- pc[pc$Date=='1/2/2007' | pc$Date=='2/2/2007',]
  
  pc$dt <- strptime(paste(pc$Date,pc$Time), format='%d/%m/%Y %H:%M:%S')
}

# create chart

if (!toScreen) {
  png(filename = "plot2.png",  width = 480, height = 480, units = "px")
}


plot(pc$dt,pc$Global_active_power,type="l",
     main="",
     xlab="",
     ylab="Global Active Power (kilowatts)")


if (!toScreen) {
  dev.off()
}




# cleanup - remove unwanted objects

rm(list=setdiff(ls(), saveObjects))

