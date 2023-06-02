library(lubridate)
# Reading the Data
options(scipen=999)
dat = read.table('household_power_consumption.txt', sep=';')
names = dat[1,]
colnames(dat) = names 
dat = dat[-1,]
dat = as.data.frame(dat)

# A bit of data cleaning since there are ? values
dat$Global_active_power[dat$Global_active_power=='?'] = NA
dat = na.omit(dat)

# Subsetting the data
sub <- dat[dat$Date %in% c("1/2/2007","2/2/2007") ,]


png("plot4.png", width=480, height=480)
# setting up partitions of the plot
par(mfrow = c(2,2))


#First Plot
datetime <- strptime(paste(sub$Date, sub$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 



plot(datetime, as.double(sub$Global_active_power),
     type = 'l',
     ylab = "Global Active Power (kilowatts)")

# Second Plot
plot(datetime, as.double(sub$Voltage),
     type = 'l',
     ylab = "Voltage")

# Third Plot

sub1 = cbind(as.double(sub$Sub_metering_1), as.double(sub$Sub_metering_2), as.double(sub$Sub_metering_3))
sub1 =  as.data.frame(sub1)
colnames(sub1) = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

plot(datetime, as.double(sub1$Sub_metering_1),
     type = 'l',
     ylab = "Energy sub metering")

lines(datetime, sub1$Sub_metering_2, col = "red")
lines(datetime, sub1$Sub_metering_3, col = "blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))


# Fourth Plot


plot(datetime, as.double(sub$Global_reactive_power),
     type = 'l',
     ylab = "Global Reactive Power (kilowatts)")

dev.off()