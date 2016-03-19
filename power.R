

#rm(list=ls())

#read the data
power_data<-read.table(unz('./data/exdata-data-household_power_consumption.zip',
                           'household_power_consumption.txt'),header=T, sep=';')


#check if read properly
dim(power_data)
head(power_data)
colnames(power_data)

power_data[,'Date']<-as.Date(power_data[,'Date'], format='%d/%m/%Y')

##create and save an R object for the data - 
##   this can be loaded next time around, withouut having to read the file again
save(power_data, file='./data/power_data.RData')

#use only the required data - 2007-02-01 to 2007-02-02 #from 66638... 2880 rows
power_data_subset<-power_data[which((power_data[,'Date'] >='2007-02-01') &
                                    (power_data[,'Date'] <= '2007-02-02')),]
dim(power_data_subset)
head(power_data_subset)
colnames(power_data_subset)

power_data_subset$Global_active_power<-as.numeric(power_data_subset$Global_active_power)
power_data_subset$Global_reactive_power<-as.numeric(power_data_subset$Global_reactive_power)
power_data_subset$Sub_metering_1<-as.numeric(power_data_subset$Sub_metering_1)
power_data_subset$Sub_metering_2<-as.numeric(power_data_subset$Sub_metering_2)
power_data_subset$Sub_metering_3<-as.numeric(power_data_subset$Sub_metering_3)
power_data_subset$Voltage<-as.numeric(power_data_subset$Voltage)

#Plot 1
with(power_data_subset, hist(Global_active_power, col='red', 
                             xlab='Global Active Power (kilowatts)',
                             main='Global Active Power'))

dev.copy(png, file='./plot1.png', width=480, height=480)
dev.off()

#Plot 2
with(power_data_subset, plot(power_data_subset$Time,
                             power_data_subset$Global_active_power, 
                             type='l'))


#Plot 3
with(power_data_subset, {
      plot(power_data_subset$Sub_metering_1,
                             ylab='Energy sub metering', type='l')
      lines(power_data_subset$Sub_metering_2, col='red')
      lines(power_data_subset$Sub_metering_3, col='blue')
      legend('topright', pch='-', col=c('black', 'red', 'blue'),legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
             })

dev.copy(png, file='./plot3.png', width=480, height=480)
dev.off()


#Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(power_data_subset, {
  plot(power_data_subset$Time,
       power_data_subset$Global_active_power, 
       type='l')
  plot(power_data_subset$Time,
       power_data_subset$Voltage, 
       type='l')
  plot(power_data_subset$Sub_metering_1,
       ylab='Energy sub metering', type='l')
  lines(power_data_subset$Sub_metering_2, col='red')
  lines(power_data_subset$Sub_metering_3, col='blue')
  plot(power_data_subset$Time,
       power_data_subset$Global_reactive_power, 
       type='l')
  mtext("All 'em plots...", outer=T)
})

power_data_subset$Voltage
