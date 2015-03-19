####################
## dplyr tutorial ##
####################

# dplyr is a powerful R-package to transform and summarize tabular data with rows and columns.
# The package contains a set of functions that perform common data manipulation operations 
# such as filtering for rows, selecting specific columns, re-ordering rows, adding new columns and summarizing data.
# If you are familiar with R, you are probably familiar with base R functions 
# such as split(), subset(), apply(), sapply(), lapply(), tapply() and aggregate(). 
# Compared to base functions in R, the functions in dplyr are easier to work with, are more consistent in the syntax 
# and are targeted for data analysis around data frames instead of just vectors.

# To install dplyr:
install.packages("dplyr")
# To load dplyr:
library(dplyr)

# Data: mammals sleep
# The msleep (mammals sleep) data set contains the sleeptimes and weights for a set of mammals 
# and is available on github. This data set contains 83 rows and 11 variables.

install.packages("downloader")
library(downloader)
url <- "https://raw.githubusercontent.com/genomicsclass/dagdata/master/inst/extdata/msleep_ggplot2.csv"
filename <- "msleep_ggplot2.csv"
if (!file.exists(filename)) download(url,filename)
msleep <- read.csv("msleep_ggplot2.csv")
head(msleep)
# The columns (in order) correspond to the following:
#         
# column name   Description
# name	        common name
# genus	        taxonomic rank
# vore	        carnivore, omnivore or herbivore?
# order	        taxonomic rank
# conservation	the conservation status of the mammal
# sleep_total	total amount of sleep, in hours
# sleep_rem	rem sleep, in hours
# sleep_cycle	length of sleep cycle, in hours
# awake	        amount of time spent awake, in hours
# brainwt	brain weight in kilograms
# bodywt	body weight in kilograms

#######################################
## Important dplyr verbs to remember ##
#######################################

# dplyr verbs   Description
# select()	select columns
# filter()	filter rows
# arrange()	re-order or arrange rows
# mutate()	create new columns
# summarise()	summarise values
# group_by()	allows for group operations in the â€œsplit-apply-combineâ€ concept


# Select a set of columns: the name and the sleep_total columns.
sleepData <- select(msleep, name, sleep_total)
head(sleepData)

# To select all the columns except a specific column, use the -€ (subtraction) operator (also known as negative indexing)
head(select(msleep, -name))

# To select a range of columns by name, use the :(colon) operator
head(select(msleep, name:order))

# To select all columns that start with the character string sl, use the function starts_with()
head(select(msleep, starts_with("sl")))

# Some additional options to select columns based on a specific criteria include
# 
# ends_with() = Select columns that end with a character string
# contains() = Select columns that contain a character string
# matches() = Select columns that match a regular expression
# one_of() = Select columns names that are from a group of names

###################################
## Selecting rows using filter() ##
###################################
# Filter the rows for mammals that sleep a total of more than 16 hours.
filter(msleep, sleep_total >= 16)

# Filter the rows for mammals that sleep a total of more than 16 hours and have a body weight of greater than 1 kilogram.
filter(msleep, sleep_total >= 16, bodywt >= 1)

# Filter the rows for mammals in the Perissodactyla and Primates taxonomic order
filter(msleep, order %in% c("Perissodactyla", "Primates"))

########################
## Pipe operator: %>% ##
########################
# This operator allows you to pipe the output from one function to the input of another function. 
# Instead of nesting functions (reading from the inside to the outside), the idea of of piping is 
# to read the functions from left to right.
# The pipe operator is very useful when we combine many functions.

head(select(msleep, name, sleep_total))

# Now, we will pipe the msleep data frame to the function that will select two columns (name and sleep_total) 
# and then pipe the new data frame to the function head() which will return the head of the new data frame.

msleep %>% select(name, sleep_total) %>% head

##############################################
## Arrange or re-order rows using arrange() ##
##############################################
# To arrange (or re-order) rows by a particular column such as the taxonomic order, list the name of
# the column you want to arrange the rows by

msleep %>% arrange(order) %>% head

# Now, we will select three columns from msleep, arrange the rows by the taxonomic order and then 
# arrange the rows by sleep_total. Finally show the head of the final data frame

msleep %>% 
        select(name, order, sleep_total) %>%
        arrange(order, sleep_total) %>% 
        head

# Same as above, except here we filter the rows for mammals that sleep for 16 or more hours 
# instead of showing the head of the final data frame

msleep %>% 
        select(name, order, sleep_total) %>%
        arrange(order, sleep_total) %>% 
        filter(sleep_total >= 16)

# Something slightly more complicated: same as above, except arrange the rows in the sleep_total column in a descending order.
# For this, use the function desc()

msleep %>% 
        select(name, order, sleep_total) %>%
        arrange(order, desc(sleep_total)) %>% 
        filter(sleep_total >= 16)

#######################################
## Create new columns using mutate() ##
#######################################
# The mutate() function will add new columns to the data frame. 
# Create a new column called rem_proportion which is the ratio of rem sleep to total amount of sleep.

msleep %>% 
        mutate(rem_proportion = sleep_rem / sleep_total) %>%
        head

# You can create multiple new columns using mutate (separated by commas). 
# Here we add a second column called bodywt_grams which is the bodywt column in grams.

msleep %>% 
        mutate(rem_proportion = sleep_rem / sleep_total, 
               bodywt_grams = bodywt * 1000) %>%
        head

##########################################################
## Create summaries of the data frame using summarise() ##
##########################################################
# The summarise() function will create summary statistics for a given column in the data frame such as finding the mean.
# For example, to compute the average number of hours of sleep, apply the mean() function to the column sleep_total 
# and call the summary value avg_sleep.

msleep %>% 
        summarise(avg_sleep = mean(sleep_total))

# There are many other summary statistics you could consider, such as
# sd(), min(), max(), median(), sum(), n() (returns the length of vector), 
# first() (returns first value in vector), last() (returns last value in vector) and 
# n_distinct() (number of distinct values in vector).

msleep %>% 
        summarise(avg_sleep = mean(sleep_total), 
                  min_sleep = min(sleep_total),
                  max_sleep = max(sleep_total),
                  total = n())

#######################################
## Group operations using group_by() ##
#######################################
# The group_by() verb is used when we want to split the data frame by some variable (e.g. taxonomic order),
# apply a function to the individual data frames and then combine the output.

# Split the msleep data frame by the taxonomic order, then ask for the same summary statistics as above. 
# We expect a set of summary statistics for each taxonomic order.

msleep %>% 
        group_by(order) %>%
        summarise(avg_sleep = mean(sleep_total), 
                  min_sleep = min(sleep_total), 
                  max_sleep = max(sleep_total),
                  total = n())




