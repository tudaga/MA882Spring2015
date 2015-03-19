# Install and load ggplot2
install.packages("ggplot2")
library(ggplot2)

# Simple Example
# For this example we are going to use the `mpg` data set that comes with base R.
# This dataset contains a subset of the fuel economy data that the EPA makes available 
# on http://fueleconomy.gov.

data(mpg)
head(mpg)

# We can do a simple scatter plot showing the relationship between the engine displacement in liters 
# and the average highway miles per gallon using the base R graphing functions.

plot(mpg$displ,mpg$hwy)

# The default plot can be improved:

plot(mpg$displ,mpg$hwy,pch=16,cex=0.6,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon")

# Now we are going to do the same plot using the `qplot()` function with default options.

qplot(displ,hwy,data=mpg)

# Note that the default settings for `qplot()` include a grey background and a grid. 
# If we want to get rid of the grey background but keep the grid, we can use `theme_bw()`

qplot(displ,hwy,data=mpg,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon") + theme_bw()

# If we want to get rid of the grid but keep the grey background, we can use the `element_blank()` 
# to suppress the grid.

myplot1 <- qplot(displ,hwy,data=mpg,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon")
myplot1 <- myplot1 + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
myplot1

# If we want to remove both the grid and the background, 
# we can use both `theme_bw()` for the background and 
# `element_blank()` to suppress the grid.

myplot2 <- qplot(displ,hwy,data=mpg,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon")
myplot2 <- myplot2 + theme_bw() 
myplot2 <- myplot2 + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                           panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
myplot2

# From now on, we are going to use a white background and supress the grid.

# Scatterplots 

# Now we are going to use a third variable (number of cylinders) to color the points in the scatterplot.
unique(mpg$cyl)

# Using the base R graphic functions, we might use

plot(mpg$displ,mpg$hwy,pch=16,cex=0.6,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon",
     col=factor(mpg$cyl))
legend("topright",levels(factor(mpg$cyl)),col=levels(factor(mpg$cyl)),pch=16)

# Note that the default color palettes of `qplot()` and the base R graphing functions are different:

myplot3 <- qplot(displ,hwy,data=mpg,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon",
                 colour=factor(cyl)) 
# get rid of grey background
#myplot3 <- myplot3 + theme_bw()
# get rid of grid
#myplot3 <- myplot3 + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                           panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
myplot3

# In some cases it is better to use different symbols instead of color to denote the third variable.
# Using the base R graphic functions we can do it with

plot(mpg$displ,mpg$hwy,cex=0.6,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon",
     pch=as.numeric(factor(mpg$cyl)))
legend("topright",as.character(sort(unique(mpg$cyl),dec=F)),pch=sort(unique(mpg$cyl),dec=F))

# We can do the same using `qplot()` 

myplot4 <- qplot(displ,hwy,data=mpg,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon",
                 shape=factor(cyl))
myplot4 <- myplot4 + theme_bw()
myplot4 <- myplot4 + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                         panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
myplot4

# Boxplots

# We want to do a boxplot of the average highway miles per gallon grouped by the number of cylinders.
# First using the base R graphing functions:

boxplot(hwy~cyl,data=mpg,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon",
        main="Gouped by Number of Cylindars")

# Using the `qplot()` function 

myplot5 <- qplot(factor(cyl),
                 hwy,data = mpg,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon",
                 geom = "boxplot")
myplot5 <- myplot5 + theme_bw()
myplot5 <- myplot5 + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                           panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
myplot5

# Histograms

# We are going to plot a histogram of highway miles per gallon using the base graphing functions.
hist(mpg$hwy,xlab="Engine Displacement (Liters)",main="",freq=T)

# using qplot()

myplot6 <- qplot(hwy,data=mpg,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon",
                 geom="histogram")
myplot6 <- myplot6 + theme_bw()
myplot6


# Density Plot

# We are going to plot a density plot of highway miles per gallon using the base graphing functions.

plot(density(mpg$hwy),main="",xlab="Engine Displacement (Liters)")

# using `qplot()`

myplot7 <- qplot(hwy,data=mpg,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon",
                geom="density")
# get rid of grey background
myplot7 <- myplot7 + theme_bw()
# get rid of grid
#myplot7 <- myplot7 + theme(panel.border = element_blank(), panel.grid.major = element_blank(), panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
myplot7


# Facets 

# One of the major advantages of `ggplot` is the use of facets. 
# Facets offer a way to get plots side by side based on a categorical variable.

# We are going to plot engine displacement vs. highway miles per gallon
# in separate plots based on year. We can do it with the base R functions
unique(mpg$year)

mpg_split <- split(mpg,mpg$year)
par(mfrow=c(1,2))
for(lst in mpg_split){
        plot(lst$displ,lst$hwy,pch=16,cex=0.6,
             xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon")
}
par(mfrow=c(1,1))

# If you are splitting the plot up by one variable, we can use `facet_wrap`. 

myplot8 <- qplot(displ,hwy,data=mpg,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon",
                 facets=.~year)
# get rid of grey background
myplot8 + theme_bw()

# Now we are going to plot engine displacement vs.highway miles per gallon
# in separate plots based on the groups defined by two variables: year and number of cylinders.  
# Doing it with the base R function is possible but tedious.

mpg_split <- split(mpg,mpg$year)
par(mfrow=c(2,4))
for(x in mpg_split){
        y <- split(x,factor(x$cyl))
        for(lst in y){
                plot(lst$displ,lst$hwy,pch=16,cex=0.6,xlab="displ",ylab="hwy")
        }
}
par(mfrow=c(1,1))


# If you are using two variables, use can use `facet_grid`.

myplot9 <- qplot(displ,hwy,data=mpg,
        xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon") + facet_grid(year ~ cyl)
# get rid of grey background
myplot9 + theme_bw()


# Regression Lines

# Now we are going to plot the line of regressing highway miles per gallon on engine displacement 
# using the `lm` function for each group defined by the number of cylinders. 
# This kind of plots are easy to handle using `qplot()`.


myplot10 <- qplot(displ,hwy,data=mpg,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon",
                  colour=factor(cyl))  + stat_smooth(method = "lm")
# get rid of grey background
myplot10 <- myplot10 + theme_bw()
# get rid of grid
myplot10 <- myplot10 + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
                             panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
myplot10


# We can still do this with the base R functions.
# However, this is way more complicated than using `qplot()`.

plot(mpg$displ,mpg$hwy,pch=16,cex=0.6,xlab="displ",ylab="hwy",col=factor(mpg$cyl))
legend("topright",levels(factor(mpg$cyl)),col=levels(factor(mpg$cyl)),pch=16)
mpg_split <- split(mpg,mpg$cyl)
for(lst in mpg_split){
        fit <- lm(lst$hwy ~ lst$displ)
        if(!any(is.na(coef(fit)))){
                betahat <- coef(fit)
                displ_range = range(lst$displ)
                hwy_range = range(lst$hwy)
                segments(x0=displ_range[1],
                         y0=betahat[1] + betahat[2]*displ_range[1],
                         x1=displ_range[2],
                         y1=betahat[1] + betahat[2]*displ_range[2],
                         lwd=1.5)
        }
}

myplot2 <- qplot(displ,hwy,data=mpg,xlab="Engine Displacement (Liters)",ylab="Avg Highway Miles/Gallon") + stat_smooth(method = "lm")
myplot2 <- myplot2 + theme_bw() 
myplot2 <- myplot2 + theme(panel.border = element_blank(), panel.grid.major = element_blank(), 
                           panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))
myplot2


sample(x=c(),prob=c(1/12,1/6,1/12,1/12,1/6,1/12,1/6,0,1/6))