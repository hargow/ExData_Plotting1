setwd("./Coursera/exploratory/ExData_Plotting1")

zipfilepath<-"./household_power_consumption.zip"
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists(zipfilepath)) {
    download.file(url, destfile=zipfilepath, method = "curl")
    unzip(zipfilepath)
}

datafile<-"./household_power_consumption.txt"
data <- read.table(datafile, sep = ";", header = T, na.strings = "?")
rowstokeep<-data$Date=="1/2/2007" | data$Date=="2/2/2007"
data<-data[rowstokeep,]
data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

png(filename = "./plot1.png",width = 480, height = 480, units = "px")
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
dev.off()
