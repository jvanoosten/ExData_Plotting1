plot1 <- function() {
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
  
  # open png device for the plot
  png("plot1.png")
  # create a histogram of the Global_active_power
  hist(power$Global_active_power, xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power", col="red", ylim=c(0,1200))
  dev.off()
}