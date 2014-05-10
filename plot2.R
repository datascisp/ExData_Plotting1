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


# create plot2
png("plot2.png",width = 480, height = 480, bg = "transparent")
plot(x=1:nrow(SUBSET),y=SUBSET$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="",xaxt="n")
axis(1, c(1,24*60,48*60), c('Thu', 'Fri', 'Sat')) # ticks after 24 hrs and 48 hrs
dev.off()
