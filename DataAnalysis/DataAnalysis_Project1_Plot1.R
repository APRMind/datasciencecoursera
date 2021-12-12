##Read the power consumption dataset data, filter the data for the specified date range and plot the graph.
##power_data <- read.table("household_power_consumption.txt",skip=1,sep=";")
power_data <- read.table("household_power_consumption.txt", skip=1,sep=";")
names(power_data) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
power_filter_data <- subset(power_data,power_data$Date=="1/2/2007" | power_data$Date =="2/2/2007")


library(datasets)
#Let's call the basic plot - hist function to draw the graph
hist(as.numeric(as.character(power_filter_data$Global_active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")

# annotating graph
title(main="Global Active Power")

#Format the graph as requested in PNG 480 X 480 pixels
#file1 <- png("Plot1.png", width=480, height=480)
#file1

#Copy my plot to a PNG file
dev.copy(png, file = "Plot1.png", width=480, height=480)

## Don't forget to close the PNG device!
dev.off()
