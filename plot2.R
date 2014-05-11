# This script creates the file plot2.png 
# Line graph of Global active power vs date time
# The working directory for the script should contain the data file household_power_consumption.txt
# The output file is plot2.png created in the same directory

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
png("plot2.png", 480,480)
# Plot as a line
plot(dateTime, as.numeric(hpc$Global_active_power), 
     type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)", 
     mar = c(2, 2, 2, 2))

#Close device
graphics.off()