# This script creates the file plot3.png 
# Line graphs of three sub metering values vs date time
# black - sub metering 1
# red - sub metering 2
# blue - sub metering 3
# The working directory for the script should contain the data file household_power_consumption.txt
# The output file is plot3.png created in the same directory

# Select only the rows that are required
require(sqldf)
f <- file("household_power_consumption.txt") 
hpc <- sqldf("select * from f where Date = '1/2/2007' OR Date ='2/2/2007'",
             dbname = tempfile(), 
             file.format = list(header = T, row.names = F, sep=";"))

close(f)

# format the date time string as R POSIX object
date <- as.character(as.Date(hpc$Date, "%d/%m/%Y"))
dt <- paste(date, hpc$Time)
dateTime <- strptime(dt, "%Y-%m-%d %H:%M:%S")


# Open device
png("plot3.png",480,480)

# Create a plot with a single line first 
plot(dateTime, as.numeric(hpc$Sub_metering_1), 
     type="l",
     xlab="",
     ylab="Energy sub metering")

# add lines
lines(dateTime, as.numeric(hpc$Sub_metering_2), 
      type="l", 
      col="red")

lines(dateTime, as.numeric(hpc$Sub_metering_3), 
      type="l", 
      col="blue")

# add legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd =2.5,
       col=c("black", "red", "blue"))


#Close device
graphics.off()