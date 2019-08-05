# install all libraries needed
install.packages("devtools")
devtools::install_github("tidyverse/ggplot2")
install.packages( 'sf')
install.packages( 'tidycensus')
install.packages( 'tidyverse')


# load libraries for use
library(ggplot2)
library(sf)
library(tidycensus)
library(tidyverse)
library(utils)

# set working directory
setwd('C://Users/mmann/Desktop/')


# request key here https://api.census.gov/data/key_signup.html
census_api_key("983980b9fc504149e82117c949d7ed44653dc507",install = F)


# get variable names
acs = load_variables(year = 2016,dataset = "acs5", cache = TRUE)
view(acs)


# see download options
?get_acs

# doanload data

medinc_bg <- get_acs(geography = "tract", 
                     variables = c(medincome = "B19013_001",  total_pop = 'B01001_001'), 
                     state = "DC",geometry=T,output = 'wide',cache_table = F)

head(medinc_bg)

# visualize income on map
ggplot()+ geom_sf(data= medinc_bg,aes(fill = medincomeE)) 

# visualize on map change colors
ggplot()+ geom_sf(data= medinc_bg,aes(fill = medincomeE)) +
              scale_fill_gradient2(low = "white", high = "blue" ) # colors you can also use hexadecimal color codes like "#132B43"


# visualize on map change colors
ggplot()+ geom_sf(data= medinc_bg,aes(fill = black_popE/total_popE)) +
  scale_fill_gradient2(low = "white", high = "green" ) # colors you can also use hexadecimal color codes like "#132B43"


# Bivariate plots
ggplot()+geom_point(data= medinc_bg, aes(x=medincomeE, y = black_popE/total_popE))


#write out
st_write(medinc_bg,'./BG2016.shp')



