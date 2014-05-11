# This script creates the file plot4.png 
# Sub graphs of the following
# Global active power
# Sub metering 
# Voltage
# Global reactive power
# The working directory for the script should contain the data file household_power_consumption.txt
# The output file is plot4.png created in the same directory

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
png("plot4.png",480,480)
# Set size of sub graph areas
par(mfrow = c(2, 2)) 

# Plot Global active power  
plot(dateTime, as.numeric(hpc$Global_active_power), 
     type="l",
     xlab = "",
     ylab="Global Active Power")

# Plot voltage
plot(dateTime, as.numeric(hpc$Voltage), 
     type="l",
     xlab="datetime",
     ylab="Voltage")

# create combined sub metering graph
plot(dateTime, as.numeric(hpc$Sub_metering_1), 
     type="l",
     xlab="",
     ylab="Energy sub metering")

lines(dateTime, as.numeric(hpc$Sub_metering_2), 
      type="l", 
      col="red")

lines(dateTime, as.numeric(hpc$Sub_metering_3), 
      type="l", 
      col="blue")

legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=1, lwd =2.5,
       col=c("black", "red", "blue"), 
       bty = "n")

# Plot reactive power
plot(dateTime, as.numeric(hpc$Global_reactive_power), 
     type="l", 
     xlab="datetime",
     ylab="Global_reactive_power")


#Close device
graphics.off()