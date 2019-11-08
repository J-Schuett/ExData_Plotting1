file_name <- "household_power_consumption.txt"

#Returns only the needed data.
read_data1 <- function(file = file_name){
    df <- read.table(file, header = TRUE, sep = ";", na.strings = "?")
    dates <- as.character(df[["Date"]]) %in% c("1/2/2007", "2/2/2007")
    df[dates,"Global_active_power"]
}


gap <- read_data1()

par(pty="s", cex = 0.70)
hist(gap, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.copy(png, file = "plot1.png")
dev.off()