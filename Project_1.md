**Project 1**
=============



```r
# Plot 1

# make sure the data (text file) is in the working directory, and then read the data using
# code below
setwd("C:/Users/Vin/Desktop/Edu/Coursera/Specialization - Data Science/04. Exploratory Data Analysis/Exercises")
full_data <- read.csv("household_power_consumption.txt", sep = ";", 
                     nrows = 2075259,na.strings="?", 
                     check.names=F, stringsAsFactors=F, 
                     comment.char="")

head(full_data) # checking to see if the data has loaded correctly
```

```
##         Date     Time Global_active_power Global_reactive_power Voltage
## 1 16/12/2006 17:24:00               4.216                 0.418  234.84
## 2 16/12/2006 17:25:00               5.360                 0.436  233.63
## 3 16/12/2006 17:26:00               5.374                 0.498  233.29
## 4 16/12/2006 17:27:00               5.388                 0.502  233.74
## 5 16/12/2006 17:28:00               3.666                 0.528  235.68
## 6 16/12/2006 17:29:00               3.520                 0.522  235.02
##   Global_intensity Sub_metering_1 Sub_metering_2 Sub_metering_3
## 1             18.4              0              1             17
## 2             23.0              0              1             16
## 3             23.0              0              2             17
## 4             23.0              0              1             17
## 5             15.8              0              1             17
## 6             15.0              0              2             17
```

```r
classes <- sapply(full_data, class) # checking to see the classes of the data columns
classes 
```

```
##                  Date                  Time   Global_active_power 
##           "character"           "character"             "numeric" 
## Global_reactive_power               Voltage      Global_intensity 
##             "numeric"             "numeric"             "numeric" 
##        Sub_metering_1        Sub_metering_2        Sub_metering_3 
##             "numeric"             "numeric"             "numeric"
```

```r
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
```

```
## 
## 2007-02-01 2007-02-02 
##       1440       1440
```

```r
rm(full_data) # removing the original data set to free up memory

DateTime <- paste(as.Date(subset_data$Date), subset_data$Time) # concatenates two columns 
# to include as a separate column in the data frame
subset_data$DateTime <- as.POSIXct(DateTime)
head(subset_data) # making sure the new column has been added to the data frame
```

```
##             Date     Time Global_active_power Global_reactive_power
## 66637 2007-02-01 00:00:00               0.326                 0.128
## 66638 2007-02-01 00:01:00               0.326                 0.130
## 66639 2007-02-01 00:02:00               0.324                 0.132
## 66640 2007-02-01 00:03:00               0.324                 0.134
## 66641 2007-02-01 00:04:00               0.322                 0.130
## 66642 2007-02-01 00:05:00               0.320                 0.126
##       Voltage Global_intensity Sub_metering_1 Sub_metering_2
## 66637  243.15              1.4              0              0
## 66638  243.32              1.4              0              0
## 66639  243.51              1.4              0              0
## 66640  243.90              1.4              0              0
## 66641  243.16              1.4              0              0
## 66642  242.29              1.4              0              0
##       Sub_metering_3            DateTime
## 66637              0 2007-02-01 00:00:00
## 66638              0 2007-02-01 00:01:00
## 66639              0 2007-02-01 00:02:00
## 66640              0 2007-02-01 00:03:00
## 66641              0 2007-02-01 00:04:00
## 66642              0 2007-02-01 00:05:00
```

```r
# creating plot 1 in the working directory as a PNG file (graphic file device)
png("plot1.png", width = 480, height = 480)
hist(subset_data$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     col = "red", main = "Global Active Power")
dev.off()
```

```
## RStudioGD 
##         2
```


```r
# displaying the plot on the screen
hist(subset_data$Global_active_power, xlab = "Global Active Power (kilowatts)", 
     col = "red", main = "Global Active Power")
```

<img src="figure/unnamed-chunk-2-1.png" title="plot of chunk unnamed-chunk-2" alt="plot of chunk unnamed-chunk-2" style="display: block; margin: auto;" />


```r
# creating plot 2 in the working directory as a PNG file (graphic file device)
png("plot2.png", width = 480, height = 480)
plot(subset_data$Global_active_power~subset_data$DateTime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
```

```
## RStudioGD 
##         2
```



```r
# displaying the plot on the screen
plot(subset_data$Global_active_power~subset_data$DateTime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
```

<img src="figure/unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />


```r
# creating plot 3 in the working directory as a PNG file (graphic file device)
png("plot3.png", width = 480, height = 480)
with(subset_data, {
        plot(Sub_metering_1~DateTime, type="l",
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~DateTime,col='Red')
        lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", xjust = 0, col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()
```

```
## RStudioGD 
##         2
```



```r
# displaying the plot on the screen
with(subset_data, {
        plot(Sub_metering_1~DateTime, type="l",
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~DateTime,col='Red')
        lines(Sub_metering_3~DateTime,col='Blue')
})
legend("topright", xjust = 0, col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
```

<img src="figure/unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />


```r
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
```

```
## RStudioGD 
##         2
```


```r
# displaying the plot on the screen
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
```

<img src="figure/unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" style="display: block; margin: auto;" />

