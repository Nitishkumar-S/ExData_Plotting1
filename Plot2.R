#Import libraries
library(sqldf)
library(graphics)

#Dataset was already downloaded locally
#reading the file such that data corresponding to dates 01 and 02 of Feb 2007 are only read
df<-read.csv.sql("./exdata_data_household_power_consumption/household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007') ",header=TRUE,sep=";")

#Open a PNG file
png("plot2.png")

#create a new column "date_time" which contains date and time in POSIXlt format
df=mutate(df,date_time=strptime(paste(Date,Time),format="%d/%m/%Y %H:%M:%S"))

#plot using this command
 with(df,plot(date_time,Global_active_power,type='l',ylab="Global Active Power (Kilowatts)"))

#close png file
dev.off() 