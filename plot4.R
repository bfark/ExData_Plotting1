system.time(totData<-read.table("./household_power_consumption.txt", 
                                header=TRUE, sep=";", stringsAsFactors=FALSE))


projdata1<-totData[totData$Date=="1/2/2007",]
projdata2<-totData[totData$Date=="2/2/2007",]

projdata<-rbind(projdata1,projdata2)

# Modified the dates to the correct format:
projdata$Date<-as.Date(projdata$Date, "%d/%m/%Y")

# Modify the times and paste the date to it for accuracy 
projdata$Time<-strptime( paste(projdata$Date, projdata$Time), 
                         "%Y-%m-%d %H:%M:%S")
projdata$Time<-strptime( paste(projdata$Date, projdata$Time), 
                         "%Y-%m-%d %H:%M:%S")


# Now, screwing around with the histogram, I realize that the columns should
# all be numeric:

projdata$Global_active_power<-as.numeric(projdata$Global_active_power)
projdata$Global_reactive_power<-as.numeric(projdata$Global_reactive_power)
projdata$Voltage<-as.numeric(projdata$Voltage)
projdata$Global_intensity<-as.numeric(projdata$Global_intensity)
projdata$Sub_metering_1<-as.numeric(projdata$Sub_metering_1)
projdata$Sub_metering_2<-as.numeric(projdata$Sub_metering_2)
projdata$Sub_metering_3<-as.numeric(projdata$Sub_metering_3)


# plot the 4 required charts and write them to a file:
png("plot4.png")

#set the canvas
par(mfcol=c(2,2))

#plot 1
plot(ts(projdata$Global_active_power), ylab="Global Active Power",xlab="", xaxt='n')
axis(1, at = c(0, 1440, 2880), labels=c("Thu","Fri","Sat"))

#plot 2
plot(ts(projdata$Sub_metering_1), ylab="Energy sub metering",xlab="", xaxt='n')
lines(ts(projdata$Sub_metering_2), col="red")
lines(ts(projdata$Sub_metering_3), col="blue")
axis(1, at = c(0, 1440, 2880), labels=c("Thu","Fri","Sat"))
legend("topright",col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1, bty="n")

#plot 3 - Voltage
plot(ts(projdata$Voltage), ylab="Voltage",xlab="datetime", xaxt='n')
axis(1, at = c(0, 1440, 2880), labels=c("Thu","Fri","Sat"))

#plot 4 - Global_reactive_power
plot(ts(projdata$Global_reactive_power), ylab="Global_reactive_power",xlab="datetime", xaxt='n')
axis(1, at = c(0, 1440, 2880), labels=c("Thu","Fri","Sat"))

dev.off()
