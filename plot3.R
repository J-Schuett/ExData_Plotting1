file_name <- "household_power_consumption.txt"

#Returns only the needed data.
read_data3 <- function(file = file_name){
    df <- read.table(file, header = TRUE, sep = ";", na.strings = "?")
    dates <- as.character(df[["Date"]]) %in% c("1/2/2007", "2/2/2007")
    df <- df[dates,]
    df$Datetime <- paste(df[["Date"]],df[["Time"]], sep =" ")
    df$Datetime <- strptime(df$Datetime,"%d/%m/%Y %H:%M:%S") 
    subset(df, select=c("Datetime", "Sub_metering_1","Sub_metering_2",
                        "Sub_metering_3"))
}

sub_metering <- read_data3()

# plot
par(pty="s", cex = 0.70)
with(sub_metering,{
    plot(Datetime, Sub_metering_1, type = "n", 
         xlab = "", ylab = "Energy sub metering")
    # black lines
    lines(Datetime, Sub_metering_1, type = "l")
    # red lines
    lines(Datetime, Sub_metering_2, type = "l", col = "red")
    # blue lines
    lines(Datetime, Sub_metering_3, type = "l", col = "blue")
})
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col = c("black","red","blue"), lty=c(1,1,1))

# create file
dev.copy(png, file = "plot3.png")
dev.off()