#######################################################################################
#  Thbis function reads the data from UC Irvine Machine Learning Repository, regarding 
# electric power consumption. With the obtained data, a histogram graphic is created 
# for the Global Active Power from 2007-02-01 to 2007-02-02
# Due to Memory usage in this script it is recommende to use a computer with more than 2 GB of RAM
#
#  To execute the script:
#   * The file household_power_consumption.txt must be in the same directory as the script
#   * Set your working directory to the folder where the script is located 
#   * execute > source("plot1.R")
#   * execute > plot1()
#
#######################################################################################


plot1<-function(){
  #Expected data file name
  dataFile<-"household_power_consumption.txt"
  # Check if the data file exists, if not the script stops
  if(!file.exists(dataFile)) {
    print("ERROR, the script requires the file household_power_consumption.txt, this can be downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip")    
  }else{
    #Load the data file
    print("Reading Data ...")
    data<-read.table(dataFile,sep = ";", na.strings = "?",header = T, stringsAsFactors = F)
    #Get the data for the required dates
    print("Getting data, between the required dates")
    idx<-grep("^0?[12].0?2.2007", data$Date)
    data2<-data[ idx ,]
    #Create grafic
    print("Creating graphic")
    par(mfrow = c(1,1))
    hist(data2$Global_active_power, col="red",xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
    #send current device to png
    print("Saving graphic as plot1.png ...")
    dev.copy(png, "plot1.png")
    #close the png device
    dev.off()
    print("Done!")
  }
}