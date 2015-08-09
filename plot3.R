plot3 <- function() {
  # use the dplyr package for arranging, grouping, and summarising the data 
  require("dplyr")
  library(dplyr)   
  
  setwd("/Users/jimvo/Documents/coursera/datascience/exploratorydataanalysis/project1/ExData_Plotting1")
  
  # Verify the assumption that the data is there 
  if (!file.exists("household_power_consumption.txt")) {
    # download the raw data 
    dataUrl = "http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
    download.file(dataUrl, destfile = "household_power_consumption.zip", method = "curl")
    # unzip the raw data
    unzip("household_power_consumption.zip")
  }
  
  # read the power consumption data
  power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", comment.char = "", na.strings = "?", stringsAsFactors = FALSE)
  
  # Use the data from Feb 1st and 2nd, 2007 
  power <- filter(power, Date == '1/2/2007' | Date == '2/2/2007')
  
  # Combine the Date & Time fields in the Date column
  power$Date <- strptime(paste(power$Date,power$Time), format("%d/%m/%Y %T"))
  
  # plot the three sub metering lines and add a legend
  png("plot3.png")
  plot(power$Date, power$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(power$Date, power$Sub_metering_2, type="l", col="red")
  lines(power$Date, power$Sub_metering_3, type="l", col="blue")
  legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"))
  dev.off()
}