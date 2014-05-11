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

# Histogram with labels 

hist(projdata$Global_active_power, col="red", main="Global active power",xlab="Global active power (kilowatts)")

# write it to a file:
png("plot1.png")
hist(projdata$Global_active_power, col="red", main="Global active power",xlab="Global active power (kilowatts)")
dev.off()
