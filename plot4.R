setwd("/Users/liang.huang/Documents/R/Coursera/exploratory")

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

png(filename = "./ExData_Plotting1/plot4.png",width = 480, height = 480, units = "px")
par(mfrow=c(2,2)) 

# plot1, top left
plot(data$Datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

# plot2, top right
plot(data$Datetime, data$Voltage, type = "l", xlab = "datetime",ylab="Voltage")

# plot 3, bottom left
plot(data$Datetime, data$Sub_metering_1, type = "l", xlab="", ylab = "Energy sub metering",col="black")
points(data$Datetime, data$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
points(data$Datetime, data$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright",lty=1, bty="n", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))

# plot 4, bottom right
plot(data$Datetime, data$Global_reactive_power, type = "l", xlab = "datetime",ylim = c(0, 0.5), ylab="Global_reactive_power")

dev.off()

