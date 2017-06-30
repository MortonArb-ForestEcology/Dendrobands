library(ggplot2) #Load necessary library
setwd("~/Forest_Ecology/Dendrobands") #Set working directory to data file location
dendroband <- read.csv("DendrobandObservations_OakCollection_2017-06-27.csv", na.strings=c("", "negative")) #read in data file
dendroband$date_observed <- as.Date(dendroband$date_observed, format="%m/%d/%Y") #Format dates as dates



ggplot(data=dendroband) + #Set basic plot parameters
  facet_wrap(~species, ncol=3) + #Specify panels
  geom_line(aes(x=date_observed, y=dist_from_collar, group = id, col = as.factor(id)), size=.9) + #Specify line graph
  theme(legend.position = "none", axis.text.x = element_text(angle = 90, hjust = 1)) + #legend and label parameters
  scale_color_discrete() + #Specify color scheme
  scale_y_continuous(breaks=c(0.00, 5.00, 10.00, 15.00, 20.00, 25.00, 30.00)) #Set y axis scale



