# Dear Students, 
# Take advantage of the "Coder's Corner"
# Monday from 3 pm to 4 pm and 
# Tuesday from 4 pm to 5 pm in MCS B24.

#########
# Lists #
#########
# Lists are collections of other objects collected into one place.
x <- list(1,2,3,4)
x

# Lists do not need to contain objects of the same type or length.
# We can pre-specify the names of the elements of the list:
y <- list(letters=c("a","b","c"),nums=2:3,missing=NA)
y

# Subsetting lists is done with double square brackets:
x[[1]]
x[[4]]
y[[1]]
# If a component has more than one element, we can access them using their corresponding indices:
y[[1]][2]

names(y)
# The components of the list can be accessed through their names using the symbol $
y$letters
# or by the name enclosed in square brackets
y["letters"]


z <- list(1:10, matrix(1:12,nrow=3), "Fisher")
z
names(z)
# Alternatively, we can name the components of a list using the names function:
names(z) <- c("my_vector","my_matrix","my_name")

z$my_vector
z["my_vector"]
z[[1]]


z[[2]][1,2]
z$my_matrix[1,2]

length(z)
dim(z$my_matrix)


#########
# Apply #
#########
# lapply: Loop over a list and evaluate a function on each element
# sapply: Same as lapply but try to simplify the result
# apply: Apply a function over the margins of an array


set.seed(124)
x <- list(a = 1:4, b = rnorm(10), c = rnorm(20, 1), d = rnorm(100, 5))
# Q : Find the mean of each element of the list.

mean(x[[1]])
mean(x[[2]])
mean(x[[3]])
mean(x[[4]])


mean_vector <- vector()
for(i in 1:4) {
       mean_vector[i] <-  mean(x[[i]])
}
mean_vector


lapply(x, mean) # lapply returns a list
sapply(x,mean) # does the same as lapply but returns a vector

# Recall the runif function for generating numbers from Uniform distribution
?runif
x <- 1:4
set.seed(127)
lapply(x, runif)
set.seed(128)
lapply(x, runif, min = 0, max = 10)

x <- matrix(rnorm(200), 20, 10)
?apply
apply(x, 2, mean) # Q: What would be the dimension of the result?
apply(x, 1, mean) # Q: What would be the dimension of the result?

###############
# Data Frames #
###############
# Data frames are used to store tabular data.
# They are a special type of list where every element of the list has the same length.
# Each elementof the list is a column vector and the length of each column is the number of rows.
# Unlike matrices, data frames can store different classes of objects in each column.

x <- data.frame() # creates an empty data frame


x <- data.frame(numbers = 1:4, logicals = c(T, T, F, F))
x
nrow(x)
ncol(x)
attributes(x)
x$numbers
x$logicals

t = data.frame(x = c(11,12,14), y = c(19,20,21), z = c(10,9,7))
t
mean(t$z)
apply(t, 2, mean)

# We are going to look at the women data set from R. 
# This data set gives the average heights and weights for American women aged 30–39
data(women)
head(women)
# object lm

linear_model <- lm(women$weight ~ women$height)
linear_model
