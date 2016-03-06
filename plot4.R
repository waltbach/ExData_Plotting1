#
# plot4.R
#
# 1. Extracts and then reads the Electric power consumption dataset from 
#    the UC Irvine Machine Learning Repository. Only the observations for
#    2007-02-01 and 2007-02-02 are used.
# 
# 2. Outputs a 4 chartsto plot4.png  
#    1. global active power over time
#    2. energy submetering over time
#    3. voltage over time
#    4. global reactive power over time
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

# create charts

if (!toScreen) {
  png(filename = "plot4.png",  width = 480, height = 480, units = "px")
}

par(mfcol=c(2,2))

# plot 1

plot(pc$dt,pc$Global_active_power,type="l",
     main="",
     xlab="",
     ylab="Global Active Power (kilowatts)")

# plot 2

plot(pc$dt,pc$Sub_metering_1,type="l",
     main="",
     xlab="",
     ylab="Energy submetering")

lines(pc$dt,pc$Sub_metering_2,type="l",col="red")

lines(pc$dt,pc$Sub_metering_3,type="l",col="blue")

legend("topright", lty=1,
       col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# plot 3

plot(pc$dt,pc$Voltage,type="l",
     main="",
     xlab="datetime",
     ylab="Voltage")

# plot 4

plot(pc$dt,pc$Global_reactive_power,type="l",
     main="",
     xlab="datetime",
     ylab="Global_reactive_power")


if (!toScreen) {
  dev.off()
}




# cleanup - remove unwanted objects

rm(list=setdiff(ls(), saveObjects))

