# Plot 1

# reading the raw dataset
raw_data <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                     nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
head(raw_data)
raw_data$Date <- as.Date(raw_data$Date, format="%d/%m/%Y")


# Subsetting data from the dates 2007-02-01 and 2007-02-02
data <- subset(raw_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
head(data)
tail(data)

rm(raw_data)

# converting the Date and Time variables to Date/Time classes in R using the as.Date() function
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

# Creating the plot and saving it to png file
windows()
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()

