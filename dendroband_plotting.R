library(ggplot2) #Load necessary library
setwd("") #Set working directory to data file location
dendroband <- read_csv("") #read in data file
dendroband$dist_from_collar[which(dendroband$dist_from_collar == "negative")] <- NA #Change observations marked "negative" to NA


dendroplot<- ggplot(data=dendroband, aes(x=date_observed, y=as.numeric(dist_from_collar), group = id, col = as.factor(id))) #Set basic plot parameters
dendroplot<- dendroplot+geom_line(size=.9) #Specify line graph
dendroplot<- dendroplot+facet_wrap(~species, ncol=3) #Specify panels
dendroplot<- dendroplot+scale_color_discrete() #Specify color scheme
dendroplot<- dendroplot+theme(legend.position = "none", axis.text.x = element_text(angle = 90, hjust = 1)) #legend and label parameters
dendroplot<- dendroplot+scale_y_continuous(breaks=c(0.00, 5.00, 10.00, 15.00, 20.00, 25.00, 30.00)) #Set y axis scale
dendroplot #Plot graph




