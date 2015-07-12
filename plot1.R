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

##produce plot1 (histogram of global active power)
png(filename='plot1.png', width=480, height=480)
hist(dat_sub$Global_active_power, col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)')
dev.off()
