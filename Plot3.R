## Plot 3

# reading the raw dataset
raw_data <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                     nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
raw_data$Date <- as.Date(raw_data$Date, format="%d/%m/%Y")

# Subsetting data from the dates 2007-02-01 and 2007-02-02
data <- subset(raw_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(raw_data)

# converting the Date and Time variables to Date/Time classes in R using the as.Date() function
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

# Creating the plot and saving it to png file
windows()
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
