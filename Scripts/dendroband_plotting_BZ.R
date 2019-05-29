library(ggplot2) #Load necessary library
library(scales)
#setwd("~/Forest_Ecology/Dendrobands/Oak_Collection") #Set working directory to data file location
setwd("C:/Users/BZumwalde/Desktop/Dendro")
dendroband <- read.csv("DendrobandObservations_EastWoods_v2.csv", na.strings=c("", "negative", "9999.00", "999.00","9999", "999")) #read in data file
#dendroband <- read.csv("LCDendrometerBands_Quercus_Consolidated_2017-2019.csv", na.strings=c("", "negative", "9999.00", "999.00")) #read in data file
dendroband$date_observed <- as.Date(dendroband$date_observed, format="%m/%d/%Y") #Format dates as dates Not working anymore, but doesn't seem to be needed
dendroband$date_observed <- factor(dendroband$date_observed) #Format dates as dates
summary(dendroband) 

#Order by date observed
dendroband <- dendroband[order(dendroband$date_observed),] #sort dataframe by date of measurement

#Diameter
dendroband$dist_from_collar <- dendroband$dist_from_collar / pi #convert circumference to diameter in the dataframe

#subtract minimum for each tree to offset bands settling
for(id in unique(dendroband$id)){ #for each tree
  dendroband[which(dendroband$id == id),]$dist_from_collar <- 
    dendroband[which(dendroband$id == id),]$dist_from_collar -
    min(dendroband[which(dendroband$id == id),]$dist_from_collar, na.rm = TRUE) #subtract the minimum from each measurement
}

#Basal area (mm^2) 
dendroband$dist_from_collar <- pi * ((dendroband$dist_from_collar / 2) ^2)

#Convert diameter/area to growth (mm/day) - use difftime to get days between each measurement
growth_df1 <- data.frame() #create empty df for rbinding

for (id in unique(dendroband$id)){ #for each tree
  
  dates <- dendroband[which(dendroband$id == id),]$date_observed #get observation dates
  obs <- dendroband[which(dendroband$id == id),]$dist_from_collar #get measurements
  seq_1 <- seq(2, length(dates)) #create sequence for selecting dates to subtract
  seq_2 <- seq_1 + 1 #create sequence for selecting dates to subtract from
  
  id_df <- dendroband[which(dendroband$id==id),][3:(length(dates)),][,1:which(colnames(dendroband) == "id")] #create df with metadata
  
  date_diff <- list() #create empty list for number of days
  obs_diff <- list() #create empty list for mm grown
  
  for (d in 1:(length(dates) - 2)){ #for each date difference (remembering that the 1st date is considered not reliable)
    diff <- difftime(dates[seq_2[d]], dates[seq_1[d]], units = c("days")) #calculate difference between two dates
    date_diff <- append(date_diff, as.numeric(diff), after = length(date_diff)) #append days between observations to list
    
    
    dist_diff <- obs[seq_2[d]] - obs[seq_1[d]] #calculate difference between measurements
    obs_diff <- append(obs_diff, dist_diff, after = length(obs_diff)) #append measurement differences to list
    
    
  }
 
  growth <- as.numeric(obs_diff) / as.numeric(date_diff) #Divide mm distance by number of days to get mm/day
  id_df <- do.call(cbind, list(id_df,growth)) #add growth measurements to new column combined with metadata  
  colnames(id_df)[length(id_df)] <- "mm_day" #Change column name
  growth_df1 <- rbind(growth_df1, id_df) #add growth df for each individual tree to a single df
  
}

dendroband$date_observed <- as.POSIXct(dendroband$date_observed, format="%Y-%m-%d")
after2017 <- subset(dendroband, date_observed > "2018-01-01")


#Plot distance
ggplot(data=after2017[!is.na(after2017$dist_from_collar),]) + #Set basic plot parameters
  geom_point(aes(x=date_observed, y=dist_from_collar, group = id, col = as.factor(id)), size=1) + #Add points
  geom_line(aes(x=date_observed, y=dist_from_collar, group = id, col = as.factor(id)), size=.9) + #Specify line graph
  theme(legend.position = "none", axis.text.x = element_text(angle = 90, hjust = 1)) + #legend and label parameters
  scale_x_datetime(date_breaks = "months", labels = date_format("%b %y"))+
  scale_color_discrete() +
  facet_wrap(~species, ncol=2, scales = "free") #Specify panels
  

#Plot growth in mm/day
growth_df2 <- na.omit(growth_df1)
growth_df2$date_observed <- as.POSIXct(growth_df2$date_observed, format="%Y-%m-%d")
growth_df3 <- subset(growth_df2, date_observed > "2018-01-01")


ggplot(data=growth_df3) + #Set basic plot parameters
  geom_point(aes(x=date_observed, y=mm_day, group = id, col = as.factor(id)), size=1) + #Add points
  geom_line(aes(x=date_observed, y=mm_day, group = id, col = as.factor(id)), size=.9) + #Specify line graph
  theme(legend.position = "none", axis.text.x = element_text(angle = 90, hjust = 1)) + #legend and label parameters
  scale_color_discrete()+ #Specify color scheme
  scale_x_datetime(date_breaks = "months", labels = date_format("%b %y"))+
  facet_wrap(~species, ncol=2, scales = "free") #Specify panels
  #scale_y_continuous(breaks=c(0.00, 5.00, 10.00)) #Set y axis scale

