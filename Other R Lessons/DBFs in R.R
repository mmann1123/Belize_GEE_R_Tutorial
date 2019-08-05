

# First you should know that .shp files are pretty complex objects. Lots and data
# and a complex structure. 


# For that reason I will start by teaching you the easiest thing first (and maybe
# the most useful). One of the major advantages of using R or Python for .shp files
# is the ability to read and write attribute tables quickly. 

# Luckily the attribute table of a .shp file is in an easy to read format. Let's
# install a package that allows us to read and write .dbf files. 

install.packages('foreign')
library(foreign)

# Now let's read in a .dbf file of interest
setwd("H:\\Teaching Materials\\GEOG_6293 GIS III\\Lectures\\Lesson 11 R\\data")
jepson = read.dbf('.//data//polygon//Jepson//Jepson_simplified.dbf')

head(jepson)
unique(jepson$ECOREGION)


# Before you start messing with your dbf it is always a good idea to backup your original.
# there is a good chance that you will mess it up. Better to keep the original somewhere.

write.dbf(jepson,'data//polygon//Jepson//Jepson_simplified_backup.dbf')



# Notice that jepson is now a data.frame. Column names can now be accessed using jepson$atributename
class(jepson)

# you can now easily add and remove attributes. Let's add an attribute that converts area
# in acres into km^2. Let's create an attribute KM2 and store the new area there:

jepson$KM2 = jepson$ACRES * 0.00404686

head(jepson)

# We can remove attributes by subsetting our data. For instance we can isolate a handful of
# data of interest and store it in a new data.frame

areas = subset(jepson, select = c( KM2,ACRES, HECTARES))

head(areas)

# Alternatively we can remove those area attributes using  -c()

not_areas = subset(jepson, select = -c(KM2,ACRES,HECTARES))

head(not_areas)


# Now we can overwrite the original .dbf with the new one

write.dbf(not_areas, 'data//polygon//Jepson//Jepson_simplified.dbf')
