file_name <- "household_power_consumption.txt"

#Returns only the needed data.
read_data2 <- function(file = file_name){
    df <- read.table(file, header = TRUE, sep = ";", na.strings = "?")
    dates <- as.character(df[["Date"]]) %in% c("1/2/2007", "2/2/2007")
    df <- df[dates,]
    df$Datetime <- paste(df[["Date"]],df[["Time"]], sep =" ")
    df$Datetime <- strptime(df$Datetime,"%d/%m/%Y %H:%M:%S") 
    subset(df, select=c("Datetime", "Global_active_power"))
}

gap_per_min <- read_data2()

par(pty="s", cex = 0.70)
with(gap_per_min, plot(Datetime, Global_active_power, type = "l", 
                      xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.copy(png, file = "plot2.png")
dev.off()