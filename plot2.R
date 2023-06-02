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


datetime <- strptime(paste(sub$Date, sub$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
png("plot2.png", width=480, height=480)

plot(datetime, as.double(sub$Global_active_power),
     type = 'l',
     ylab = "Global Active Power (kilowatts)")


axis(1, at= 1:3, labels=c('Thu', 'Fri', 'Sat')    )

dev.off()