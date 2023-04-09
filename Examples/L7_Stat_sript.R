options("scipen"=100, "digits"=4)

library(tidyverse)
data(iris)
head(iris)


# code to find the confidence interval

# Calculate the mean of the sample data
mean_value <- mean(iris$Sepal.Length)
mean_value

# Compute the test statistics

# Compute the size of the sample
n <- length(iris$Sepal.Length)
n

#assign the alpha
alpha <- 0.05

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
standard_deviation <- sd(iris$Sepal.Length)
standard_deviation

# Find the standard error
standard_error <- standard_deviation / sqrt(n)
standard_error


# Calculating lower bound and upper bound
lower_bound <- mean_value - t_score * standard_error
upper_bound <- mean_value + t_score * standard_error

# Print the confidence interval
print(c(lower_bound,upper_bound))

#######################################################################3

library(stats)

#test whether mean Sepal.Length is equal to 6
t.test(x = iris$Sepal.Length, 
       alternative = "two.sided", 
       mu = 6)

#test whether mean Sepal.Length >= 6 (right-tailed test)
t.test(x = iris$Sepal.Length, alternative = "less", 
       mu = 6)

#test whether mean Sepal.Length <= 6 (left-tailed test)
t.test(x = iris$Sepal.Length, alternative = "greater", 
       mu = 6)


#two-sample t-test

#test whether difference in means of Sepal.Length and Petal.Length is equal to 0
t.test(x = iris$Sepal.Length, 
       y = iris$Petal.Length,
         alternative = "two.sided", 
       mu = 0)


#########################################################################

head(taiwan_data)

#Simple Linear Regression
#Run a linear regression of price_twd_msq vs. n_convenience
mdl_price_vs_conv <- lm(data = taiwan_data, 
                        price_twd_msq ~ n_convenience)
mdl_price_vs_conv

summary(mdl_price_vs_conv)

#Multiple Linear Regression

#Run a linear regression of price_twd_msq vs. n_convenience and dist_to_mrt_m
mdl_price_vs_conv_dist <- lm(data = taiwan_data, 
                        price_twd_msq ~ n_convenience + dist_to_mrt_m)
mdl_price_vs_conv_dist

summary(mdl_price_vs_conv_dist)



#made a prediction
# create a new data frame with values for the predictors
new_data <- data.frame(n_convenience = 5, 
                       dist_to_mrt_m = 300)

# use the predict() function to make a prediction for the new data
prediction <- predict(mdl_price_vs_conv_dist, newdata = new_data)

# print the prediction
print(prediction)



