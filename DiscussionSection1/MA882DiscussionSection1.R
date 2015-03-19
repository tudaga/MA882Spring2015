# entering input
# <- is the assignment operator
x <- 1
print(x) # explicit printing
x # auto-printing
5/0
0/0 # NaN, not a number
Inf/Inf

# create an integer sequence
x <- 1:100
x 
# one alternative way to create the same vector
x <- seq(from=1, to=100, by=1)
# other examples with seq
seq(from=1, to=100, by=49)
seq(from=1, to=10, by=0.5)
seq(from=10, to=1, by=-1)
y <- 1:1e+5 # 1:(10^5)
y # entries are omitted
head(y)
head(x) # the first few elements are the same but do not forget x and y are different
length(x)
length(y)
# more examples of vectors
vector() # empty vector
vector(mode="numeric", length=10)
vector("logical", length=2)
# rep stands for replicate
x <- rep(NA,times=10) # NA indicates missing values
y <- c(NA,1,3,4,5,NA,45) # c stands for concatenate or combine
mean(x)
mean(y)

# subsetting using a vector of indices
y[c(2,3,4,5,7)]
y[c(2:5,7)]
mean(y[c(2:5,7)])
?mean
mean(y, na.rm = TRUE)
is.na(y)
!is.na(y)
# subsetting using a vector of logicals
y[!is.na(y)]
mean(y[!is.na(y)])

# vectors can also contain characters
x <- c("Hello,","world!")
x
paste(x[1],x[2], sep=" ")

# factors
x <- c("yes","yes","no","yes","no")
factor(x) # levels are in alphabetical order unless specified otherwise
factor(x, levels=c("yes","no"))
table(x)

# creating a matrix
?matrix
matrix(data = NA, nrow=2, ncol=3)
matrix(1:6, 2, 3)
A <- matrix(1:6, 2, 3, byrow = TRUE)
A
attributes(A)
dim(A) # returns a vector containing the dimentions of the matrix A
dim(A)[1] # will give us the number of rows in A
dim(A)[2] # will give us the number of columns in A

# subsetting from a matrix
A[1,2]
A[2,3]
A[4,5] # we get an error message
dimnames(A) <- list(c("A1","A2"),c("B1","B2","B3"))
A

# alternative way to make a matrix
x <- 1:3
y <- 4:6
A <- rbind(x, y)
A
B <- cbind(x, y)
B

# reading data
# read.table, read.csv
# if the data file is saved you the same directory as the one your Rscript is saved in, then

data <- read.csv(file="data1.csv")
head(data)

# basic concepts from programming

# if, else: testing a condition

# if(<condition>) {
#         ## do something
# }

# if(<condition1>) {
#         ## do something
# } else if(<condition2>) {
#         ## do something different
# } else {
#         ## do something different
# }

# example
x <- 5
if(x > 3) {
        y <- 10
} else {
        y <- 0
}
y

# for: execute a loop a fixed number of times

for(i in 1:10) {
        print(i)
}

x <- c("a", "b", "c", "d")
for(i in 1:4) {
        print(x[i])
}

for(i in seq_along(x)) {
        print(x[i])
}
seq_along(x)

x <- matrix(1:6, 2, 3, byrow = TRUE)
x
for(i in 1:2) {
        for(j in 1:3) {
                print(x[i, j])
        }
}

# while: execute a loop while a condition is true
# use carefully, can potentially result in infinite loops if not written properly
count <- 1
while(count < 11) {
        print(count)
        count <- count + 1
}
count

# simulating data
?sample
names <- c("Xinyue","Jianing","Yujing","Hongbo","Ran","Qianyun")
sample(names, 2, replace = FALSE)

?rnorm
?rbinom
?rpois
?rexp

# example
z <- 5
count <- 0
plot(x=count, y=z, xlim=c(0,20), ylim=c(3,10), pch=19)
while(z >= 3 && z <= 10) {
        coin <- rbinom(1, 1, 0.5)
        if(coin == 1) {                
                z <- z + 1
                points(x=count, y=z, pch=19)
        } else {                
                z <- z - 1
                points(x=count, y=z, pch=19)
        }
        count = count+1
}



