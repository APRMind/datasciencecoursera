## Reading, naming and subset power consumption data.
power_con <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power_con) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subpower_con <- subset(power_con,power_con$Date=="1/2/2007" | power_con$Date =="2/2/2007")

# Transforming the Date and Time from characters into objects of type Date and POSIXlt alike:
subpower_con$Date <- as.Date(subpower_con$Date, format="%d/%m/%Y")
subpower_con$Time <- strptime(subpower_con$Time, format="%H:%M:%S")
subpower_con[1:1440,"Time"] <- format(subpower_con[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subpower_con[1441:2880,"Time"] <- format(subpower_con[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


# initiating a composite plot with many graphs:
par(mfrow=c(2,2))

# calling the basic plot function, that calls different plot functions to render the 4 distinct plots that form the graph:
with(subpower_con,{
        plot(subpower_con$Time,as.numeric(as.character(subpower_con$Global_active_power)),type="l",  xlab="",ylab="Global Active Power")  
        plot(subpower_con$Time,as.numeric(as.character(subpower_con$Voltage)), type="l",xlab="datetime",ylab="Voltage")
        plot(subpower_con$Time,subpower_con$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
        with(subpower_con,lines(Time,as.numeric(as.character(Sub_metering_1))))
        with(subpower_con,lines(Time,as.numeric(as.character(Sub_metering_2)),col="red"))
        with(subpower_con,lines(Time,as.numeric(as.character(Sub_metering_3)),col="blue"))
        legend("topright", lty=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.6)
        plot(subpower_con$Time,as.numeric(as.character(subpower_con$Global_reactive_power)),type="l",xlab="datetime",ylab="Global_reactive_power")
})


#Format the graph as requested in PNG 480 X 480 pixels
#file4 <- png("Plot4.png", width=480, height=480)
#file4

#Copy my plot to a PNG file
dev.copy(png, file = "Plot4.png", width=480, height=480)

## Don't forget to close the PNG device!
dev.off()

