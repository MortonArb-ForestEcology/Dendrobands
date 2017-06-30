library(ggplot2) #Load necessary library
setwd("~/Forest_Ecology/Dendrobands") #Set working directory to data file location
dendroband <- read.csv("DendrobandObservations_OakCollection_2017-06-27.csv", na.strings=c("", "negative")) #read in data file
dendroband$date_observed <- as.Date(dendroband$date_observed, format="%m/%d/%Y") #Format dates as dates
dendroband$date_observed <- factor(dendroband$date_observed) #Format dates as dates



#Diameter
dendroband$dist_from_collar <- dendroband$dist_from_collar / pi #convert circumference to diameter in the dataframe


#subtract minimum for each species to offset bands settling
for(id in unique(dendroband$id)){ #for each tree
  dendroband[which(dendroband$id == id),]$dist_from_collar <- 
    dendroband[which(dendroband$id == id),]$dist_from_collar -
    min(dendroband[which(dendroband$id == id),]$dist_from_collar, na.rm = TRUE) #subtract the minimum from each measurement
}


#Convert diameter to growth (mm/day) - use difftime to get days between each measurement



ggplot(data=dendroband) + #Set basic plot parameters
  facet_wrap(~species, ncol=3) + #Specify panels
  geom_point(aes(x=date_observed, y=dist_from_collar, group = id, col = as.factor(id)), size=1) + #Add points
  geom_line(aes(x=date_observed, y=dist_from_collar, group = id, col = as.factor(id)), size=.9) + #Specify line graph
  theme(legend.position = "none", axis.text.x = element_text(angle = 90, hjust = 1)) + #legend and label parameters
  scale_color_discrete() + #Specify color scheme
  scale_y_continuous(breaks=c(0.00, 5.00, 10.00)) #Set y axis scale



