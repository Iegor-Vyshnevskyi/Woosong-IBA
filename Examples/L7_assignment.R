# Load the mtcars dataset
data(mtcars)
head(mtcars)
summary(mtcars)

#Calculate the 90% confidence interval for the population mean of mpg in the mtcars dataset?
#Question ( ) what is the standard_deviation of the mean?
#Question ( ) What is value of the lower bound of the mean? 

# Calculate the mean of the sample data
mean_value <- mean(mtcars$mpg)
mean_value

# Compute the test statistics

# Compute the size of the sample
n <- length(mtcars$mpg)
n

#assign the alpha
alpha <- 0.1

# Compute the degree of freedom
degrees_of_freedom <- n - 1
degrees_of_freedom

# use the function qt() to calculate the t-score for 
#a given level of significance (alpha) and degrees of freedom.
t_score <- qt(p = alpha/2, 
              df = degrees_of_freedom,
              #to calculate the t-value corresponding to 
              #the upper tail of the t-distribution
              lower.tail=F)
t_score


# Find the standard deviation
standard_deviation <- sd(mtcars$mpg)
standard_deviation

# Find the standard error
standard_error <- standard_deviation / sqrt(n)
standard_error


# Calculating lower bound and upper bound
lower_bound <- mean_value - t_score * standard_error
upper_bound <- mean_value + t_score * standard_error

# Print the confidence interval
print(c(lower_bound,upper_bound))


########################################################################

#Question ( ) What conclusion can you do basing on the result of the given test?
#Question ( ) What type of hypothesis testing is used in the code?
t.test(x = mtcars$wt, alternative = "greater", mu = 3)


#Question ( ) Run t-test to check whether difference in means is equal to 0? What p-value you would obtain?

cyl_4 <- mtcars$mpg[mtcars$cyl == 4]
cyl_6 <- mtcars$mpg[mtcars$cyl == 6]


t.test(x = mtcars$mpg[mtcars$cyl == 4], 
       y = mtcars$mpg[mtcars$cyl == 6],
       alternative = "two.sided",
       mu = 0)


##########################################################################

#Question ( ) Run the linear regression. What conclusions regarding 
#p-value of Estimates can you make basing of the results you obtained?

#Run a linear regression of the miles per gallon (mpg) vs weight (wt), 
#displacement (disp), and horsepower (hp) using the mtcars dataset. What conclusions regarding 
#p-value of Estimates can you make basing of the results you obtained?
fit <- lm(mpg ~ wt + disp + hp, data = mtcars)

summary(fit)

#Question ( )  Run a linear regression of the miles per gallon (mpg) vs weight (wt), and horsepower (hp) using the mtcars dataset. 
#What would be the predicted mpg for a new car with weight 2.5 tons, and horsepower 120?
reg_mpg_vs_wt_hp <- lm(mpg ~ wt + hp, data = mtcars)

new_car <- data.frame(wt = 2.5, hp = 120)

pred <- predict(reg_mpg_vs_wt_hp, newdata = new_car)

print(pred)




