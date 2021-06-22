#Import libraries
library(sqldf)
library(graphics)
library(tidyr)

#Dataset was already downloaded locally
#reading the file such that data corresponding to dates 01 and 02 of Feb 2007 are only read
df<-read.csv.sql("./exdata_data_household_power_consumption/household_power_consumption.txt",sql="select * from file where Date in ('1/2/2007','2/2/2007') ",header=TRUE,sep=";")

#create a new column "date_time" which contains date and time in POSIXlt format
df=mutate(df,date_time=strptime(paste(Date,Time),format="%d/%m/%Y %H:%M:%S"))

#Open a PNG file
png("plot4.png")

#To tell the system how(order) graphs are to be inserted
par(mfrow=c(2,2))

#Plot 1 for Global Active Power
with(df,plot(date_time,Global_active_power,type='l',ylab="Global Active Power (Kilowatts)"))

#Plot2 for Voltage
with(df,plot(date_time,Voltage,type='l',ylab="Global Active Power (Kilowatts)"))


#Plot3 for Energy sub metering
df2<-df[,1:9]

#all 3 sub_meter readings are grouped in one column
df2<-df2%>%gather(Enery_sub_meter,Energy_value,Sub_metering_1:Sub_metering_3)

#create a new column "date_time" which contains date and time in POSIXlt format
df2=mutate(df2,date_time=strptime(paste(Date,Time),format="%d/%m/%Y %H:%M:%S"))

#intiate plotting
plot(df2$date_time,df2$Energy_value,xlab="datetime",ylab="Energy sub metering",type="n")

#subset df based on readings corresponding to sub_meter_1-3 
sub1<-subset(df2,Enery_sub_meter=="Sub_metering_1")
sub2<-subset(df2,Enery_sub_meter=="Sub_metering_2")
sub3<-subset(df2,Enery_sub_meter=="Sub_metering_3")

#Plot them using points()
with(sub1,points(date_time,Energy_value,type="l"))
with(sub2,points(date_time,Energy_value,type="l",col="red"))
with(sub3,points(date_time,Energy_value,type="l",col="blue"))

#Legend
legend("topright",lty=c(1,1,1),col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

#Plot4
with(df,plot(date_time,Global_reactive_power,type='l',ylab="Global Active Power (Kilowatts)"))

#close PNG file
dev.off()
