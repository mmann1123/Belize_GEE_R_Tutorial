


# Assignment --------------------------------------------------------------
# The most straight forward way to store a list of numbers is 
# through an assignment using the c command. (c stands for 
# "combine.") The idea is that a list of numbers is stored 
# under a given name, and the name is used to refer to the 
# data. A list is specified with the c command, and assignment
# is specified with the "<-" or "=" symbols. Another term 
# used to describe the list of numbers is to call it a 
# "vector."
# 
# The numbers within the c command are separated by commas. 
# As an example, we can create a new variable, called "bubba"
# which will contain the numbers 3, 5, 7, and 9:

bubba = c(3,5,7,9)

# When you enter this command you should not see any output 
# except a new command line. The command creates a list of 
# numbers called "bubba." To see what numbers is included 
# in bubba type "bubba" and press the enter key: 

bubba

# > bubba
# [1] 3 5 7 9

# If you wish to work with one of the numbers you can get 
# access to it using the variable and then square brackets 
# indicating which number. Try the example below:
    
bubba[2]
bubba[1]
bubba[0]

# > bubba[2]
# [1] 5
# > bubba[1]
# [1] 3
# > bubba[0]
# numeric(0)
    
# Notice that the first entry is referred to as the number 
# 1 entry, and the zero entry can be used to indicate how 
# the computer will treat the data. or use class(bubba) 
# You can store strings using both single and double quotes,
# and you can store real numbers.    
    
bubba = c('HI','1','some text')
bubba

# Notice that we reassigned our original numeric vector 
# as a character vector. 

# Try replacing a single element

bubba[3] = 'more meaningful text'
bubba

# Notice that you can't mix data types in a single vector
bubba_test = c(1, 'hi','2')
bubba_test    # it simply converts 1 to '1' stored as a character



# Reading in a CSV file ---------------------------------------------------

# Unfortunately, it is rare to have just a few data points 
# that you do not mind typing in at the prompt. It is much
# more common to have a lot of data points with complicated 
# relationships. Here we will examine how to read a data set 
# from a file using the read.csv function but first discuss 
# the format of a data file.
# 
# We assume that the data file is in the format called "comma
# separated values" (csv). That is, each line contains a row 
# of values which can be numbers or letters, and each value 
# is separated by a comma. We also assume that the very first
# row contains a list of labels. The idea is that the labels
# in the top row are used to refer to the different columns 
# of values.
# 
# First we read a very short, somewhat silly, data file. The 
# data file is called simple.csv and has three columns of 
# data and six rows. The three columns are labeled "trial," 
# "mass," and "velocity." We can pretend that each row comes 
# from an observation during one of two trials labeled "A" 
# and "B."

# silly.csv
# trial    mass	velocity
# A	     10	     12
# A	     11	     14
# B   	 5	     8
# B	     6	     10
# A	     10.5	 13
# B	     7	     11

# The command to read the data file is read.csv. We have to 
# give the command at least one arguments, but we will give 
# three different arguments to indicate how the command can 
# be used in different situations. The first argument is the
# name of file. The second argument indicates whether or not
# the first row is a set of labels. The third argument 
# indicates that there is a comma between each number of 
# each line. 

# First we need to tell R where to look (by default) for new
# files by setting the working directory. Notice "//" not "\"
# change it to the path were you have your data stored

setwd("H:\\Teaching Materials\\GEOG_6293 GIS III\\Lectures\\Lesson 11 R\\data")

dir()

# The following command will read in the data and
# assign it to a variable called "heisenberg:"

heisenberg <- read.csv(file="simple.csv",head=TRUE,sep=",")
heisenberg

# You can also use head and tail to look at the top and bottom
# of your file:

head(heisenberg,2)
head(heisenberg,5)
tail(heisenberg,1)

# To get more information on the different options available
# you can use the help command:

?read.csv
#or
help(head)

# The object "heisenberg" contains the three columns of 
# data. Each column is assigned a name based on the header 
# (the first line in the file). You can now access each 
# individual column using a "$" to separate the two names:
    

heisenberg$trial

heisenberg$mass

heisenberg$velocity  

# This is because your data has been read into a very
# common data format, called a 'data.frame"

class(heisenberg)

# which can be used to store data of different types in
# each column 

class(heisenberg$trial)
class(heisenberg$mass)




# Data Types --------------------------------------------------------------


# Another way that information is stored is in data frames. 
# This is a way to take many vectors of different types and 
# store them in the same object. The vectors can be of all
# different types. For example, a data frame may contain 
# many lists, and each list might be a list of factors, 
# strings, or numbers.

# There are different ways to create and manipulate data 
# frames. Most are beyond the scope of this introduction. 
# They are only mentioned here to offer a more complete 
# description.

# One example of how to create a data frame is given below:
    
a <- c(1,2,3,4)
b <- c(2,4,6,8)
levels <- factor(c("A","B","A","B")) # factors can be used for categorical data

bubba <- data.frame(first=a, second=b, f=levels)
bubba

# Again each column can be called by name:
bubba$first

# if you forget the names just use 
head(bubba) 
#or 
names(bubba)

# You can also call a column name like this:

bubba[,c('first')]

# and a particular row and column like this:

bubba[4,c('first')]


# indexing of data.frames takes the following form: 
# data.frame.name[row,column]. Note that we can also call
# the same location using row and column number

bubba[4,1]



##### CHALLENGE  #####
# Create a data.frame that contains the following info:

# Student   Score    Grade
# 'Jim'       93        'A+'
# 'Sally'     98        'A+'
# 'James'     85        'B'


### ### ### ### ### 
# YOUR CODE HERE
### ### ### ### ### 

# Then use write.csv to export your data to a csv file. 
# Use ?write.csv for the syntax


### ### ### ### ### 
# YOUR CODE HERE
### ### ### ### ### 



# Another important data type is a matrix, which can be used
# to store data of ONE type and can be used for matrix 
# algrebra. 

matrix1 = matrix(data = c(1,2,3,4,5,6,7,8,9), nrow=3, ncol=3)
matrix1

# A matrix is similar to a raster but lacks any georeferencing
# header information that might exist in a geotiff file. 
# Notice that like any math operations are very easy

matrix1^2  
matrix1*matrix1

matrix1*3
sqrt(matrix1)


# Packages ----------------------------------------------------------------

# You can extend the capabilities of R by installing and
# importing packages written by folks like you. For a list
# of packages relevant to spatial data go to 
# http://cran.r-project.org/web/views/Spatial.html

# The first time you use a new version of R you will have
# to install all your packages. Try installing the raster
# package:

install.packages('raster')

# Now it is installed in your computer but isn't loaded
# You will have to 'import' your library package every 
# time you start up R. 

library(raster)

?raster



# A FOR loop --------------------------------------------------------------

# One of the most powerful functions in programming is the ability
# to do loops or iteration. For loops simple loop through a 
# series of numbers or alternatively elements in a vector.


# The basic for loop

for(i in c(1:10)){
    print(i)
}


# Loop through a list of names
names= c('sally','jim','george')
for(name in names){
    print(name)  # notice we use 'name' here not 'names'
}

# Nested loops
numbers = c(1:3)
names = c('sally','jim','george')

for(number in numbers){
    for(name in names){
        print(number)
        print(name)
    }
}


# CHALLENGE: Create a loop that prints each element of a matrix 
# row by row

printme = matrix(c(1,2,3,4,5,6,7,8,9), nrow=3, ncol=3)


### ### ### ### ### 
# YOUR CODE HERE
### ### ### ### ### 



