# The first time you use a new version of R you will have
# to install all your packages. Try installing the raster
# package:

install.packages('raster')
install.packages('rgdal')
# Now it is installed in your computer but isn't loaded
# You will have to 'import' your library package every 
# time you start up R. 

library(raster)

# Raster data is stored in a format similar to that of 
# a matrix, except you have added data about georeferencing.
# Let's read in one raster and take a look

#set the working directory
setwd("H:\\Teaching Materials\\GEOG_6293 GIS III\\Lectures\\Lesson 11 R\\data\\data")

# notice that the working directory doesn't need to be a 
# path directly below your files of interest:

CWD_apr = raster('data//raster//CWD//cwd2010apr.tif')

# Get info about the raster object
CWD_apr

# Plot the image
plot(CWD_apr)

# there are a variety of different plot options. Here are
# a few important ones

plot(CWD_apr,main = 'Title')

plot(CWD_apr,col= heat.colors(10) ) # 10 designates the number of hex color codes that get generated

# Now use ?plot to change col to a different preset color
# scheme

?plot


# Raster Math -------------------------------------------------------------

# Rasters like matrices can make basic math functions very easy
# Note that rasters can be used in basic operations
# like CWD_apr *2 or CWD_apr^2, however 2 rasters with different
# extents, cell sizes, or projections CAN'T be used. You would
# need to reproject the data first. 

CWD_apr_sq = CWD_apr^2
plot(CWD_apr_sq)

# Now lets add two different rasters. Use the raster() function
# to read in the CWD for May

CWD_may = raster('fill//in//the//path')

CWD_A_M = CWD_apr + CWD_may
plot(CWD_A_M)

# To make this next challenge question a little easier we will
# change the working directory

setwd('raster//CWD//')

# Lets get a list of all files in our raster folder

list.files(path=".")

# Notice that .png and twf xml files are also listed. We can 
# narrow this down by using a grep style pattern search. Here
# we will only list files that have 'tif' in the name

list.files(path=".",pattern = 'tif')

# almost there... we still have problems with .tif.* files like
# tif.xml or tif.aux.xml. We can limit these using what I will call
# an ANTI-wildcard. "$"

list.files(path=".",pattern = 'tif$')

# The $ tells the computer that the file must end with the characters
# tif, no more, no less. Let's store that information:

CWDS = list.files(path=".", pattern = 'tif$')

# Challenge: In teams write down to read in and sum all of these
# rasters. 


### ### ### ### ### 
# YOUR CODE HERE
### ### ### ### ### 


# Finally, let's write out our results

writeRaster(someoutputraster,"output.tif")






