# Install libraries
install.packages('ggplot2')
install.packages('cluster')



install.packages('DT')
install.packages('ggvis')
install.packages('gridExtra')
install.packages("class")
install.packages('gmodels')


# Load libraries
library(ggplot2)
library(cluster)

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

# Iris scatter plot
ggplot(iris, aes(Petal.Length, Petal.Width)) + 
  geom_point(aes(col=Species), size=4) +
  theme_bw()




# The Actual K-means Model
set.seed(101)
irisCluster <- kmeans(iris[,1:4], center=3, nstart=20)
irisCluster

# Comparison with original data
table(irisCluster$cluster, iris$Species)
# Plotting the clusters
clusplot(iris, irisCluster$cluster, color=T, shade=T, labels=0, lines=0)


  
# The Elbow Method
tot.withinss <- vector(mode="character", length=10)
for (i in 1:10){
  irisCluster <- kmeans(iris[,1:4], center=i, nstart=20)
  tot.withinss[i] <- irisCluster$tot.withinss
}
# Visualizing it
plot(1:10, tot.withinss, type="b", pch=19)

