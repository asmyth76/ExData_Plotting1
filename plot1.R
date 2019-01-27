## read text file

data <- read.csv("household_power_consumption.txt", header=TRUE, sep=";", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),na.strings="?")

data$FixedDate <- as.Date(data$Date,format="%d/%m/%Y")

data$FixedTime <- strptime(data$Time,format="%H:%M:%S")

#Set date vars between Feb 1 - 2 2007
date1 <- as.Date("01/02/2007",format="%d/%m/%Y")
date2 <- as.Date("02/02/2007",format="%d/%m/%Y")

#Create new data set with only the selected dates

df <- data[data$FixedDate %in% date1:date2, ]

# Create the plot 1 Histogram

png("plot1.png", width=480, height=480)

hist(df$Global_active_power,col = "red",main = "Global Active Power",xlab="Global Active Power (kilowatts)", ylab="Frequency")

dev.off() ## close the PNG device