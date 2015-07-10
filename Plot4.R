## Plot 4

# make sure the data (text file) is in the working directory, and then read the data using
# code below
full_data <- read.csv("household_power_consumption.txt", sep = ";", 
                      nrows = 2075259,na.strings="?", 
                      check.names=F, stringsAsFactors=F, 
                      comment.char="")

head(full_data) # checking to see if the data has loaded correctly
classes <- sapply(full_data, class) # checking to see the classes of the data columns
classes 

# indicated that majority of them are "character" class, so we revise them by running 
# below set of codes to assign appropriate class


full_data$Date <- as.Date(full_data$Date, format="%d/%m/%Y")
full_data$Global_active_power <- as.numeric(full_data$Global_active_power)
full_data$Global_reactive_power <- as.numeric(full_data$Global_reactive_power)
full_data$Voltage <- as.numeric(full_data$Voltage)
full_data$Global_intensity <- as.numeric(full_data$Global_intensity)
full_data$Sub_metering_1 <- as.numeric(full_data$Sub_metering_1)
full_data$Sub_metering_2 <- as.numeric(full_data$Sub_metering_2)
full_data$Sub_metering_3 <- as.numeric(full_data$Sub_metering_3) 


# extracting a subset of data as indicated by the dates below
subset_data <- subset(full_data, as.Date(full_data$Date) >= "2007-02-01" & 
                              as.Date(full_data$Date) <= "2007-02-02")
table(subset_data$Date) # helps to check if we have the specific dates that we need

rm(full_data) # removing the original data set to free up memory

DateTime <- paste(as.Date(subset_data$Date), subset_data$Time) # concatenates two columns 
# to include as a separate column in the data frame
subset_data$DateTime <- as.POSIXct(DateTime)
head(subset_data) # making sure the new column has been added to the data frame

# creating plot 4 in the working directory as a PNG file (graphic file device)
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subset_data, {
        plot(Global_active_power~DateTime, type="l", 
             ylab="Global Active Power", xlab="")
        plot(Voltage~DateTime, type="l", 
             ylab="Voltage", xlab="datetime")
        plot(Sub_metering_1~DateTime, type="l", 
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~DateTime,col='Red')
        lines(Sub_metering_3~DateTime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", 
               pt.cex = 0.5, cex = 0.8,
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~DateTime, type="l", 
             ylab="Global_reactive_power",xlab="datetime")
})

dev.off()