
#  tutorial @ http://stat405.had.co.nz/ggmap.pdf
install.packages("ggmap")
library(ggmap)
install.packages('colorspace')
#install.packages("ggplot2")
library(ggplot2)
library(colorspace)

register_google(key = "AIzaSyDiF6OzHmlbGnDR-qIjZYjBXWW7NeDShsk")

# use ggmaps geocoding function. This calls the google maps API
geocode("the white house")

# geocode more than one location 
geocode(c("the white house",'40 Quincy Pl NE DC', 'Black Cat Club washington DC'))

# reverse geocode to find an address
revgeocode(c(-77.03650, 38.89768), output = "address")

# Let's play!
obamasnightout =   geocode(c("the white house",'package store North Capital and Florida ave NE DC'
                             ,'40 Quincy Pl NE DC', 'Black Cat Club  washington DC'))

map <- get_googlemap('Washington DC', markers = obamasnightout,
                     path = obamasnightout, scale = 2, zoom=11)
windows()  # use quartz() if you are running a mac
ggmap(map)

# FROM THE CODE ABOVE:  Try adjusting the zoom level to something appropriate


# Look at some map alternatives 
windows()
qmap("Washington DC", zoom = 14, source = "stamen",
     maptype = "watercolor")

windows()
qmap("Washington DC", zoom = 14, source = "stamen" ,
     maptype = "toner")

# for detail on available maps use ?qmap


 

# Crime Mapping In Houston TX ---------------------------------------------


# find a reasonable zoom level for Houston
qmap('houston tx', zoom = 18)

# now let's look at crime data from Houston
head(crime)
# check the types of crimes
unique(crime$offense)

# check date range 
range(crime$date)

# count the number of murders in Houston 
sum(crime$offense=='murder')

# create a data subset of violent crimes
violent_crimes <- subset(crime, offense != "auto theft" &
                             offense != "theft" & offense != "burglary")

# Turn categorical data into a factor with ordered levels
violent_crimes$offense <- factor( violent_crimes$offense, 
                                  levels = c("robbery", "aggravated assault","rape", "murder"))

# let's start mapping 
theme_set(theme_bw(16))   # set a color theme from ggplot2

# create the map object
HoustonMap <- qmap("houston", zoom = 13,
                   color = "bw" , legend = "bottomright")

# overlay points
windows()
HoustonMap +  geom_point(data=violent_crimes,aes(x = lon, y = lat, colour = offense ) )

# overlay points scaled by offense type 
HoustonMap +  geom_point(data=violent_crimes,aes(x = lon, y = lat, colour = offense
                                                 , size = offense) )

 

# create a heat map of robberies
HoustonMap +
    stat_density2d( aes(x = lon, y = lat, fill = ..level..,  alpha = ..level..),
                    size = 2, bins = 4, data = violent_crimes, geom = "polygon")  

# create a heat map of robberies
HoustonMap +
    stat_density2d( aes(x = lon, y = lat, fill = ..level..,  alpha = ..level..),
                    size = 2, bins = 4, data = violent_crimes, geom = "polygon")  +facet_wrap(~day )

# create heat map of violent crimes by type
HoustonMap +
    stat_density2d( aes(x = lon, y = lat, fill = ..level..,  alpha = ..level.., colour=offense),
                    size = 2, bins = 4, data = violent_crimes, geom = "polygon")




#  Challenge Questions ----------------------------------------------------

# Create a group and do the following tasks. 
# For each question rotate who is in charge of running R. 


# 1)  Create a map tracing a route between your homes

### ### ### ### ### 
# YOUR CODE HERE
### ### ### ### ### 


# 2) Download crime data for DC & produce a heat map of gun related homocide in DC

# HELP
temp = tempfile()
download.file("https://opendata.arcgis.com/datasets/6af5cb8dc38e4bcbac8168b27ee104aa_38.csv",temp)
DCdata = read.table( temp,sep=',',header=T)
unlink(temp)
head(DCdata)

# now you DC crime data is stored in 'DCdata'

### ### ### ### ### 
# YOUR CODE HERE
### ### ### ### ### 

# # find gun homocides
# guns = subset(DCdata, DCdata$METHOD == 'GUN' & DCdata$OFFENSE =='HOMICIDE')
# # geocode block addresses
# latlon = geocode(paste(guns$BLOCKSITEADDRESS, 'washington dc'))
# 
# DC = qmap("DC", zoom = 12, source = "stamen", maptype = "watercolor")
# 
# DC +  stat_density2d( aes(x =lon , y = lat, fill = ..level..,  alpha = ..level..),
#                 size = 2, bins = 4, data = latlon, geom = "polygon") +ggtitle('Gun Related Homocide of DC')
