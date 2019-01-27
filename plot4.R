## read text file

data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?")

data$FixedDate <- as.Date(data$Date,format="%d/%m/%Y")

#Set date vars between Feb 1 - 2 2007
date1 <- as.Date("01/02/2007",format="%d/%m/%Y")
date2 <- as.Date("02/02/2007",format="%d/%m/%Y")

#Create new data set with only the selected dates
df <- data[data$FixedDate %in% date1:date2, ]

# create new column with datetime
df$FixedTime <- strptime(df$Time,format="%H:%M:%S")

# drop the date and keep the time
df$FixedTime <- format(df$FixedTime, format="%H:%M:%S")

# merge date and time into one field
df$DateTime <- with(df, as.POSIXct(paste(FixedDate, FixedTime)))

# Create  plot 4 

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

#Plot the first chart
plot(df$DateTime,df$Global_active_power,ylab="Global Active Power (kilowatts)", type="n")
lines(df$DateTime,df$Global_active_power,ylab="Global Active Power (kilowatts)", lwd=1)

#Plot the 2nd chart 
plot(df$DateTime,df$Voltage,ylab="voltage", xlab="datetime", type="n")
lines(df$DateTime,df$Voltage, lwd=1)

#Plot the 3rd chart
plot(Sub_metering_1 ~ DateTime, data=df, ylab="Energy sub metering", type="n")
lines(df$DateTime, df$Sub_metering_1, col="black")
lines(df$DateTime, df$Sub_metering_2, col="red")
lines(df$DateTime, df$Sub_metering_3, col="blue")

## Create legend
legend("topright", border="black", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))

# Plot the 4th chart
plot(df$DateTime,df$Global_reactive_power,ylab="Global_reactive_power", xlab="datetime", type="n")
lines(df$DateTime,df$Global_reactive_power, lwd=1)

dev.off() ## close the PNG device