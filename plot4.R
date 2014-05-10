# prerequirements
library(data.table)

# get data. it is assumed, that the household_power_consumption.txt is located in the working directory
DT <- fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?", stringsAsFactors=TRUE) #fread is way faster than read.table
DT <- cbind(DT[, 1, with=FALSE], DT[, lapply(.SD[, -1, with=FALSE], as.numeric)]) # convert to numeric
# convert to datatype DATE
DT$Date <- as.Date(as.character(DT$Date),format="%d/%m/%Y")
# create subset dataset
SUBSET <- DT[ which(DT$Date=='2007-02-01' | DT$Date =='2007-02-02'), ]
# free memory
rm(DT) # remove object from environment


# create plot4
png("plot4.png",width = 480, height = 480, bg = "transparent")
layout(matrix(c(1,2,3,4), 2, 2, byrow = TRUE))
# 1st subplot
plot(x=1:nrow(SUBSET),y=SUBSET$Global_active_power,type="l",ylab="Global Active Power",xlab="",xaxt="n")
axis(1, c(1,24*60,48*60), c('Thu', 'Fri', 'Sat')) # ticks after 24 hrs and 48 hrs
# 2nd subplot
plot(x=1:nrow(SUBSET),y=SUBSET$Voltage,type="l",ylab="Voltage",xlab="",xaxt="n")
axis(1, c(1,24*60,48*60), c('Thu', 'Fri', 'Sat')) # ticks after 24 hrs and 48 hrs
# 3rd subplot
plot(x=1:nrow(SUBSET),y=SUBSET$Sub_metering_1,type="l",ylab="Energy sub metering",xlab="",xaxt="n")
axis(1, c(1,24*60,48*60), c('Thu', 'Fri', 'Sat')) # ticks after 24 hrs and 48 hrs
lines(x=1:nrow(SUBSET),y=SUBSET$Sub_metering_2, type="l", col="red")
lines(x=1:nrow(SUBSET),y=SUBSET$Sub_metering_3, type="l", col="blue")
legend("topright", legend= names(SUBSET)[7:9], pch="__", col = c("black","red","blue"), lwd=2, bty="n")
# 4th subplot
plot(x=1:nrow(SUBSET),y=SUBSET$Global_reactive_power,type="l",ylab="Global_reactive_power",xlab="",xaxt="n")
axis(1, c(1,24*60,48*60), c('Thu', 'Fri', 'Sat')) # ticks after 24 hrs and 48 hrs
dev.off()
