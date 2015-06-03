rm(list=ls())


## Load and Clean
startRow <- grep('1/2/2007',readLines('household_power_consumption.txt'))[1]
endRow <- grep('3/2/2007',readLines('household_power_consumption.txt'))[1]##I input 3/2/2007, one day after the desired day in order to take the last value of 2/2/2007 to use it in nrows option
Headers <- read.table('household_power_consumption.txt',nrows=1,header=FALSE,sep=';',stringsAsFactors = FALSE)
df<- read.table('household_power_consumption.txt',skip=startRow-1,nrows=endRow-startRow,sep=';',na.strings='?');rm(startRow,endRow)
colnames(df) <- unlist(Headers)
df <- cbind(time=paste(df$Date,df$Time),df)
df$time <- strptime(df$time,format= '%d/%m/%Y %H:%M:%S')
drops <- c('Date','Time')
df<-df[,!(names(df) %in% drops)]
##Plot
png("plot2.png", width = 480, height = 480)
plot(df$time,df$Global_active_power,
     type='l',
     ylab='Global Active Power (kilowatts)',
     xlab='')
dev.off()