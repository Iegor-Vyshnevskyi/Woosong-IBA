# Install libraries
install.packages('tidyverse')
install.packages('DT')
install.packages('ggvis')
install.packages('gridExtra')
install.packages("class")
install.packages('gmodels')


# Load libraries
library(tidyverse)
library(DT)
library(ggvis)
library(gridExtra)
library(class)
library(gmodels)


# Load data
data(iris)

iris

# Dataset information
datatable(iris)

glimpse(iris)

summary(iris)

# For more details, see 
?iris

# Iris scatter plot (1)
iris %>% ggvis(~Sepal.Length, ~Sepal.Width, fill = ~Species) %>% layer_points()

# Iris scatter plot (2)
iris %>% ggvis(~Petal.Length, ~Petal.Width, fill = ~Species) %>% layer_points()

# Training and test sets
set.seed(1234)
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))
iris.training <- iris[ind==1, 1:4]
iris.test <- iris[ind==2, 1:4]
iris.trainLabels <- iris[ind==1, 5]
iris.testLabels <- iris[ind==2, 5]

# Plots
# Sepal.Length
p1 = ggplot(iris.training, aes(x = Sepal.Length)) + 
  geom_density(trim = TRUE,
               aes(color = "Training"), size = 1) + 
  geom_density(data = iris.test, aes(x = Sepal.Length,
                                         color = "Testing"), trim = TRUE, size = 1, linetype = 2)
(p1 = p1 + theme_bw() + labs(color = "Density", title = "Random Sampling",
                             x = "Sepal.Length", y = "Density"))
# Sepal.Width
p2 = ggplot(iris.training, aes(x = Sepal.Width)) + 
  geom_density(trim = TRUE,
               aes(color = "Training"), size = 1) + 
  geom_density(data = iris.test, aes(x = Sepal.Width,
                                     color = "Testing"), trim = TRUE, size = 1, linetype = 2)
(p2 = p2 + theme_bw() + labs(color = "Density", title = "Random Sampling",
                             x = "Sepal.Width", y = "Density"))
# Petal.Length
p3 = ggplot(iris.training, aes(x = Petal.Length)) + 
  geom_density(trim = TRUE,
               aes(color = "Training"), size = 1) + 
  geom_density(data = iris.test, aes(x = Petal.Length,
                                     color = "Testing"), trim = TRUE, size = 1, linetype = 2)
(p3 = p3 + theme_bw() + labs(color = "Density", title = "Random Sampling",
                             x = "Petal.Length", y = "Density"))

# Petal.Width
p4 = ggplot(iris.training, aes(x = Petal.Width)) + 
  geom_density(trim = TRUE,
               aes(color = "Training"), size = 1) + 
  geom_density(data = iris.test, aes(x = Petal.Width,
                                     color = "Testing"), trim = TRUE, size = 1, linetype = 2)
(p4 = p4 + theme_bw() + labs(color = "Density", title = "Random Sampling",
                             x = "Petal.Width", y = "Density"))

# Combine all four plots
grid.arrange(p1, p2, p3, p4,  nrow = 1)

# The Actual KNN Model
# Building the Classifier
iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k=3)
iris_pred
  
# The Model Evaluation
CrossTable(x = iris.testLabels, y = iris_pred, prop.chisq=FALSE)

# Confusiin Matrix
cm <- table(iris.testLabels, iris_pred)
cm

# Calculate out of Sample error  
misClassError <- mean(iris_pred != iris.testLabels)
print(paste('Accuracy =', 1-misClassError))



