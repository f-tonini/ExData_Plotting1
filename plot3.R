##read first 100 lines to determine data class types
initial <- read.table("household_power_consumption.txt", sep=';', header=T, nrows = 100)
classes <- sapply(initial, class)
## read table using classes. Set NA values to be "?".
dat <- read.table("household_power_consumption.txt", colClasses=classes, sep=';', stringsAsFactors=F, 
                  header=T, na.strings = "?")
##using as.Date() subset table for desired data range
dat_sub <- dat[as.Date(dat$Date,"%d/%m/%Y") <= "2007-02-02" & as.Date(dat$Date,"%d/%m/%Y") >= "2007-02-01", ]

##add date/time variable to table subset
dat_sub$datetime <- strptime(paste(dat_sub$Date, dat_sub$Time), "%d/%m/%Y %H:%M:%S")

##produce plot3 (time series by sub metering type)
png(filename='plot3.png', width=480, height=480)
plot(dat_sub$datetime, dat_sub$Sub_metering_1, type='n', ylab='Energy sub metering', xlab='')
lines(dat_sub$datetime, dat_sub$Sub_metering_1)
lines(dat_sub$datetime, dat_sub$Sub_metering_2, col='red')
lines(dat_sub$datetime, dat_sub$Sub_metering_3, col='blue')
legend('topright', legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=1, col=c("black","red", "blue"))
dev.off()
