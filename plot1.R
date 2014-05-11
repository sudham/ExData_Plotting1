
# This script creates the file plot1.png 
# as a Histogram
# The working directory for the script should contain the data file household_power_consumption.txt
# The output file is plot1.png created in the same directory

# Select only the rows that are required
require(sqldf)
f <- file("household_power_consumption.txt") 
hpc <- sqldf("select * from f where Date = '1/2/2007' OR Date ='2/2/2007'",
           dbname = tempfile(), 
           file.format = list(header = T, row.names = F, sep=";"))
close(f)
# Open device
png("plot1.png",480,480)

# Create plot as histogram
hist(as.numeric(hpc$Global_active_power), 
     col = "red",
     main="Global Active Power", 
     xlab="Global Active Power(kilowatts)", 
     ylab="Frequency", 
     mar = c(2, 2, 2, 2))
#Close device
graphics.off()