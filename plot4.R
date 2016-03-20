##Energy Consumption Exploratory Data Analysis

#rm(list=ls())

#read the data
power_data<-read.table(unz('./data/exdata-data-household_power_consumption.zip',
                           'household_power_consumption.txt'),header=T, sep=';')

#check if read properly
dim(power_data)
head(power_data)
colnames(power_data)

#convert the date column to Date class - use POSIXct class
# power_data[,'Date']<-as.Date(power_data[,'Date'], format='%d/%m/%Y')
power_data[,'Date']<-as.POSIXct(strptime(paste(power_data$Date,
                                               power_data$Time),
                                         format="%d/%m/%Y %H:%M:%S"))

#use only the required data - 2007-02-01 to 2007-02-02 #from 66638... 2880 rows
power_data_subset<-power_data[which((power_data[,'Date'] >='2007-02-01 00:00:00') &
                                      (power_data[,'Date'] <= '2007-02-02 23:59:59')),]
colnames(power_data_subset)[1]<-"datetime"

dim(power_data_subset)
head(power_data_subset)
colnames(power_data_subset)

power_data_subset$Global_active_power<-as.numeric(power_data_subset$Global_active_power)
power_data_subset$Global_reactive_power<-as.numeric(power_data_subset$Global_reactive_power)
power_data_subset$Sub_metering_1<-as.numeric(power_data_subset$Sub_metering_1)
power_data_subset$Sub_metering_2<-as.numeric(power_data_subset$Sub_metering_2)
power_data_subset$Sub_metering_3<-as.numeric(power_data_subset$Sub_metering_3)
power_data_subset$Voltage<-as.numeric(power_data_subset$Voltage)

#The code till this point is common for all plots - including for completeness of code
# individuals plot follow.

# #Plot 1
# with(power_data_subset, hist(Global_active_power, col='red', 
#                              xlab='Global Active Power (kilowatts)',
#                              main='Global Active Power'))
# 
# dev.copy(png, file='./plot1.png', width=480, height=480)
# dev.off()
# 
# #Plot 2
# with(power_data_subset, plot(power_data_subset$datetime,
#                              power_data_subset$Global_active_power, 
#                              type='l', ylab='Global Active Power (kilowatts)'))
# 
# dev.copy(png, file='./plot2.png', width=480, height=480)
# dev.off()

#Plot 3
# with(power_data_subset, {
#   plot(power_data_subset$datetime,
#        power_data_subset$Sub_metering_1,
#        xlab='',
#        ylab='Energy sub metering', type='l')
#   lines(power_data_subset$datetime,
#         power_data_subset$Sub_metering_2, col='red')
#   lines(power_data_subset$datetime,
#         power_data_subset$Sub_metering_3, col='blue')
#   legend('topright', pch='-', col=c('black', 'red', 'blue'),
#          legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
# })
# 
# dev.copy(png, file='./plot3.png', width=480, height=480)
# dev.off()

#Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(power_data_subset, {
  plot(power_data_subset$datetime,
       power_data_subset$Global_active_power, 
       type='l',
       xlab='',
       ylab='Global Active Power (kilowatts)')
  plot(power_data_subset$datetime,
       power_data_subset$Voltage, 
       xlab='datetime',
       ylab='Voltage',
       type='l')
  plot(power_data_subset$datetime,
       power_data_subset$Sub_metering_1,
       xlab='datetime',
       ylab='Energy sub metering', type='l')
  lines(power_data_subset$datetime,
        power_data_subset$Sub_metering_2, col='red')
  lines(power_data_subset$datetime,
        power_data_subset$Sub_metering_3, col='blue')
  legend('topright', pch='-', col=c('black', 'red', 'blue'),
         legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
  plot(power_data_subset$datetime,
       power_data_subset$Global_reactive_power, 
       xlab='datetime',
       ylab='Global_reactive_power',
       type='l')
  mtext("All 'em plots...", outer=T)
})

dev.copy(png, file='./plot4.png', width=480, height=480)
dev.off()





