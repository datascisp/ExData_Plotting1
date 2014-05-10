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


# create plot1
png("plot1.png",width = 480, height = 480, bg = "transparent")
hist(SUBSET$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")
dev.off()
