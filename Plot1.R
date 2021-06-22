#Import libraries
library(sqldf)
library(graphics)

#Dataset was already downloaded locally
#reading the file such that data corresponding to dates 01 and 02 of Feb 2007 are only read
df<-read.csv.sql("./exdata_data_household_power_consumption/household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007') ",header=TRUE,sep=";")

#Open a PNG file
png("plot1.png")

#Ploting the histogram with "Global_active_power" on x-axis which wont be displayed on screen
hist(df$Global_active_power,xlab="Global Active Power(Kilowatts)",main="Global Active Power",col="red")

#closing the file since plot is saved 
dev.off() 