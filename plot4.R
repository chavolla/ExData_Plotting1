#######################################################################################
#  Thbis function reads the data from UC Irvine Machine Learning Repository, regarding 
# electric power consumption. With the obtained data, a set of 4 plots are generated 
# against the Date from 2007-02-01 to 2007-02-02
# Due to Memory usage in this script it is recommende to use a computer with more than 2 GB of RAM
#
#  To execute the script:
#   * The file household_power_consumption.txt must be in the same directory as the script
#   * Set your working directory to the folder where the script is located 
#   * execute > source("plot4.R")
#   * execute > plot4()
#
#######################################################################################


plot4<-function(){
  #Expected data file name
  dataFile<-"household_power_consumption.txt"
  # Check if the data file exists, if not the script stops
  if(!file.exists(dataFile)) {
    print("ERROR, the script requires the file household_power_consumption.txt, this can be downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")
    return;
  }
  #Load the data file
  print("Reading Data ...")
  data<-read.table(dataFile,sep = ";", na.strings = "?",header = T, stringsAsFactors = F)
  #Get the data for the required dates
  print("Getting data, between the required dates")
  idx<-grep("^0?[12].0?2.2007", data$Date)
  data2<-data[ idx ,]
  #Convert to date
  data2$rDate<-strptime(paste(data2$Date, data2$Time),"%d/%m/%Y %H:%M:%S")
  #Set locale language to ensure the weekday names to be in english
  Sys.setlocale("LC_TIME", "English")
  #Create graphic
  print("Creating graphic")
  png(filename = "plot4.png",height = 504, width = 504)
  #Set image layout
  par(mar=c(4,4,4,1), mfrow = c(2,2))
  #First plot
  plot(data2$rDate,data2$Global_active_power, type = "l",ylab = "Global Active Power",xlab="")
  #Second plot
  plot(data2$rDate,data2$Voltage, type = "l",ylab = "Voltage",xlab="datetime")
  #Third plot
  plot(data2$rDate,data2$Sub_metering_1, type = "l",ylab = "Energy sub metering",xlab="")
  points(data2$rDate, data2$Sub_metering_2, col="red", type="l")
  points(data2$rDate, data2$Sub_metering_3, col="blue", type="l")  
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1, bty = "n",  cex = 0.87)  
  #Fourth plot
  plot(data2$rDate,data2$Global_reactive_power, type = "l",xlab="datetime", ylab = "Global_reactive_power")  
  #close the png device
  dev.off()
  #Return plot layout
  par(mfrow = c(1,1))
  print("Done!")
}