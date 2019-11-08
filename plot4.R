file_name <- "household_power_consumption.txt"

#Returns only the needed data.
read_data4 <- function(file = file_name){
    df <- read.table(file, header = TRUE, sep = ";", na.strings = "?")
    dates <- as.character(df[["Date"]]) %in% c("1/2/2007", "2/2/2007")
    df <- df[dates,]
    df$Datetime <- paste(df[["Date"]],df[["Time"]], sep =" ")
    df$Datetime <- strptime(df$Datetime,"%d/%m/%Y %H:%M:%S") 
    subset(df, select=c("Datetime", "Sub_metering_1","Sub_metering_2",
                        "Sub_metering_3", "Global_active_power",
                        "Global_reactive_power", "Voltage"))
}

data <- read_data4()

par(mfrow = c(2,2), mar = c(4.2, 4.2, 2, 2.8), pty = "m", cex = 0.70)

# Plot 1
with(data, plot(Datetime, Global_active_power, type = "l", 
                      xlab = "", ylab = "Global Active Power"))

# Plot 2
with(data, plot(Datetime, Voltage, type = "l", 
                xlab = "datetime", ylab = "Voltage"))

# Plot 3
with(data,{
    plot(Datetime, Sub_metering_1, type = "n", 
         xlab = "", ylab = "Energy sub metering")
    lines(Datetime, Sub_metering_1, type = "l")
    lines(Datetime, Sub_metering_2, type = "l", col = "red")
    lines(Datetime, Sub_metering_3, type = "l", col = "blue")
})
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), lty=c(1,1,1), bty = "n")

# Plot 4
with(data, plot(Datetime, Global_reactive_power, type = "l", 
                xlab = "datetime", ylab = "Global_reactive_power"))

# create file
dev.copy(png, file = "plot4.png")
dev.off()

# Reset par values
par(mfrow = c(1,1), mar = c(5.1, 4.1, 4.1, 2.1))