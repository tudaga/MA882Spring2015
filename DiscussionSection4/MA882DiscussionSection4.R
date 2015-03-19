###############
###############
##           ##
##    EDA    ##
##           ##
###############
###############

# Biases, systematic errors and unexpected variability are common in data. 
# Failure to discover these problems often leads to flawed analyses and false discoveries.
# Graphing data is a powerful approach to detecting these problems.
# Here we present a general introduction to EDA using height data.

# Histograms

# Suppose you have measured the heights of all men in a population. 
# Imagine you need to describe these numbers to someone that has no idea what these heights are, 
# for example an alien that has never visited earth.

install.packages("UsingR")
library(UsingR)
x=father.son$fheight

# One approach is to simply list out all the numbers for the alien to see. 
# Here are 20 randomly selected heights.

round(sample(x,20),1)

# From scanning through these numbers we start getting a rough idea of what the entire list looks like
# but it is certainly inefficient. We can quickly improve on this approach by creating bins, 
# say by rounding each value to the nearest inch, and reporting the number of individuals in each bin. 
# A plot of these heights is called a histogram.

hist(x)

# We can specify the bins and add better labels in the following way:
        
bins <- seq(floor(min(x)),ceiling(max(x)))
hist(x,breaks=bins,xlab="Height",main="Adult men heights")

# Showing this plot to the alien is much more informative than showing the numbers. 
# Note that with this simple plot we can approximate the number of individuals in any given interval. 
# For example, there are about 70 individuals over six feet (72 inches) tall.


# Empirical Cummulative Density Function

# Although not as popular as the histogram for EDA, the empirical cumulative density function (CDF) 
# shows us the same information and does not require us to define bins. 
# For any number x the empirical CDF reports the proportion of numbers in our list smaller or equal to x.
# R provides a function that has as out the empirical CDF function:
        
myCDF <- ecdf(x) 

# we create a function called myCDF based on our data x that can then be used to generate a plot.
# We will evaluate the function at these values:

xs<-seq(floor(min(x)),ceiling(max(x)),0.1) 
# and then plot them:

plot(xs,myCDF(xs),type="l",xlab="x=Height",ylab="F(x)")

# The probability distribution we see above approximates one that is very common in a nature: 
# the normal distribution also refereed to as the bell curve or Gaussian distribution.

# QQ-plot

# To corroborate that the normal distribution is in fact a good approximation we can use 
# quantile-quantile plots (QQ-plots). Quantiles are best understood by considering the special case 
# of percentiles. The p-th percentile of a list of a distribution is defined as the number q that is 
# bigger than p% of numbers.

qqnorm(x)
qqline(x) 

# We can also get a sense for how non-normally distributed data looks. 
# Here we generate data from the t-distribution with different degrees of freedom. 
# Note that the smaller the degrees of freedoms the fatter the tails.

dfs <- c(3,6,12,30)
par(mfrow=c(2,2))
for(df in dfs){
        x <- rt(1000,df)
        qqnorm(x,xlab="t quantiles",main=paste0("d.f=",df),ylim=c(-6,6))
        qqline(x)
}
par(mfrow=c(1,1))


# Boxplots

# Data is not always normally distributed. Take income for example. 
# In these cases the average and standard deviation are not necessarily informative 
# since one can't infer the distribution from just these two numbers. 
# The properties described above are specific to the normal. 
# For example, the normal distribution does not seem to be a good approximation for 
# the direct compensation for 199 United States CEOs in the year 2000

hist(exec.pay)

qqnorm(exec.pay)
qqline(exec.pay)

# A practical summary is to compute 3 percentiles: 25-th, 50-th (the median) and the 75-th. 
# A boxplots shows these 3 values along with 
# a range calculated as median ± 1.5 75-th percentiles - 25th-percentile. 
# Values outside this range are shown as points and sometimes refereed to as outliers.

boxplot(exec.pay,ylab="10,000s of dollars",ylim=c(0,400))

# Now we describe EDA and summary statistics for paired data.


# Scatterplots and correlation

# The methods described above relate to univariate variables. In the biomedical sciences it is common 
# to be interested in the relationship between two or more variables. 
# A classic examples is the father/son height data used by Galton to understand heredity. 
# Were we to summarize these data we could use the two averages and two standard deviations 
# as both distributions are well approximated by the normal distribution. 
# This summary, however, fails to describe an important characteristic of the data.

x=father.son$fheight
y=father.son$sheight
plot(x,y,xlab="Father's height in inches",ylab="Son's height in inches",
     main=paste("correlation =",signif(cor(x,y),2)))

# The scatter plot shows a general trend: the taller the father the taller to son. 
# A summary of this trend is the correlation coefficient which in this cases is 0.5. 
# We motivate this statistic by trying to predict son's height using the father's.

# Suppose we are asked to guess the height of randomly select sons. 
# The average height, 68.7 inches, is the value with the highest proportion (see histogram) 
# and would be our prediction.
# But what if we are told that the father is 72 inches tall, do we sill guess 68.7?
# Note that the father is taller than average. 
# He is 1.7 standard deviations taller than the average father. 
# So should we predict that the son is also 1.75 standard deviations taller? 
# Turns out this is an overestimate. 
# To see this we look at all the sons with fathers who are about 72 inches. 
# We do this by stratifying the son heights.

groups <- split(y,round(x)) 
boxplot(groups)

print(mean(y[ round(x) == 72]))

# Stratification followed by boxplots lets us see the distribution of each group. 
# The average height of sons with fathers that are 72 is 70.7. 
# We also see that the means of the strata appear to follow a straight line. 
# This line is refereed to the regression line and it's slope is related to the correlation.

