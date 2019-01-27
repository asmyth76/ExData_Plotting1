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

# Create the plot 2 Line Graph

png("plot2.png", width=480, height=480)

plot(df$DateTime,df$Global_active_power,ylab="Global Active Power (kilowatts)", type="n")

lines(df$DateTime,df$Global_active_power,ylab="Global Active Power (kilowatts)", lwd=2)

dev.off() ## close the PNG device