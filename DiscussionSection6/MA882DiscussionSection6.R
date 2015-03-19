##################
##  R packages  ##
##################

# http://cran.r-project.org/
# MANY packages! For almost anything you would like to do, someone has already written a package.
# If you there is no package for something you are interested in, you may develope your own package!
# In fact, there are packages to use in order to create a package:
# install.packages("roxygen2")
# install.packages("devtools")
# These packages make it really easy to create an R package from scratch.
# Then you would have to complete the following steps:
# Step 1: Create the Package Directory
# Step 2: Add Functions
# Step 3: Add Documentation
# Step 4: Install Documentation

# The package car has very useful functions for checking the assumptions for linear regression.

install.packages("car")
library(car)

## Duncan Data Set
# We are going to use the Duncan data set from car for the following example. 
# This data set has information on the prestige and other characteristics of 45 US occupations in 1950. 
# We are going to use three variables
#  prestige: percentage of participants that rated the occupation as excellent or good in prestige
#  income: precent of males earning $3,500 or more in 1950
#  education: percent of males in occupation who were high-school graduates in 1950
# We are going to regress prestige on education and income.

data(Duncan)
?lm
lm

fit <- lm(prestige ~ income + education,data=Duncan)

## Outliers
# We can use outlierTest() function. This function performs a t-test on the largest absolute residual 
# in the model to determine if it is an outlier.

outlierTest(fit)

# The Bonferroni-adjusted p value is not statistically significant, so it seems like there are no outliers

## Influential Observations

# Cook's distance measure the influence of an observation on the linear model. 
# Intuitively, Cook'™s distance measures the effect of deleting a given observation
# on the fitted values from the linear model.
# Observations with a Cook's distance greater than 4/(n-k-1)
# are considered influential points where
# n is the number of observations and
# k is the number of predictors.

# We can get Cook's' distance using the cooks.distance() function. 
# We are going to plot Cook's distance for all observations and 
# add to the same plot a line with the cut-off for influential observations.

cutoff <- 4/((nrow(Duncan)-length(fit$coefficients)-2))
plot(cooks.distance(fit))
abline(h=cutoff)

# We can see that we have two influential observations. 
# Let us label these points interactively in R using the identify function. 
# After running the line below, click the points that you want to label and then press Esc

identify(1:45, cooks.distance(fit), row.names(Duncan))

# The two influential points correspond to minister(6) and conductor(16)

## Added Variable Plots
# Added variable plots are a way to visualize the marginal role of an individual variable 
# within a regression model given that other variables are already in the model.
# If a given variable has a significant marginal association with Y 
# (after we account for other independent variables already included in model) 
# then should be included in the model.
# Here is an example of this concept:
# Suppose we focus on two variables: X_1 and X_2. 
# We want to evaluate the role of x_1 given that X_2 is already in the model
# Y = beta_0 + beta * X_2 + epsilon
# We will do this through AV plots.
# First regress Y on X_2 and save the residuals e_i(Y|X_2) = Y_i - hat{Y}_i
# Second regress X_1 on X_2
# X_1 = alpha_0 + alpha * X_2 + epsilon
# and save the residuals e_i(X_1|X_2) = X_1_i - hat{X_1}_i
# The scatter plot of e_i(Y|X_2) and e_i(X_1|X_2) provides a graph of 
# the strength of the relationship between Y and X_1 adjusted for X_2


avPlots(fit)

# From the AV plots we see that it seems like a good idea to include both income and education in our model.

## Non-normality
# One of the assumptions of linear regression is that the residuals follow a normal distribution. 
# We can plot a histogram for the residuals and compare it to a normal distribution.

sresid <- rstudent(fit)
hist(sresid, freq=FALSE, main="Distribution of Studentized Residuals")
xfit<-seq(min(sresid),max(sresid),length=40)
yfit<-dnorm(xfit)
lines(xfit, yfit) 


# Also, we can use a QQ-plot:

qqPlot(fit, pch=16,main="QQ Plot")

# Based on the above plots we conclude that the residuals seem fairly normal.

## Non-constant Variance

# Another assumption of linear regression is that the error terms have constant variance. 
# A way to visualize the varaince of the error terms is plotting the residuals vs. the fitted values. 
# The points should be spread evenly across the plot with no pattern. 
# We can get this plot through the spreadLevelPlot() function.

spreadLevelPlot(fit)

# The car package also provides us with a formal test for the constatnt variance assumption
# using the ncvTest() function. 
# The null hypothesis is that the variance is constant, thus if we get a large p-value
# that means that the assumption of constant variance is will not be rejected.

ncvTest(fit)

# Since we get p-value=0.5370169, it seems that the assumption of constant variance holds for our model.

# we demonstrated many of the useful function in the car package, but not all.
# To access more detailed information about the package, read the manual at http://cran.r-project.org/

## Vignettes
# A vignette is a long-form guide for a package. 
# Function documentation is great if you know the name of the function you need, but useless otherwise.
# A vignette is similar to  a book chapter or an academic paper: 
# it can describe the problem that the package is designed to solve, and then 
# show the reader how to solve it through detailed examples.
# Many existing packages have vignettes. You can see all the installed vignettes with browseVignettes().

browseVignettes()

# To see the vignette for a specific package, use the argument, browseVignettes("packagename").

browseVignettes("car")

