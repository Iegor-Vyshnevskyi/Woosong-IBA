
#basic package
install.packages("tidyverse")
library(tidyverse)

#useful for data processing and transformation 
install.packages("dplyr")
library(dplyr)
install.packages("tidyr")
library(tidyr)

#to load the csv file
install.packages("utils")
 <- <- <-   
  
  
  #load data set on data stocks prcies
  data_stocks <- read.csv(file = "https://raw.githubusercontent.com/singh1985/rforanalytics/master/data/us_stocks.csv", 
                          header = TRUE)

#load a dataset on video games sales
vg_data <- read.csv(file = "https://gist.githubusercontent.com/Ironraptor3/34f3938c703111353ee5f28cc9b29d68/raw/5c57e51dbc550a141a44f93028104ffce6281624/vgsales.csv", 
                    header = TRUE) #the file is without header



#view first several rows of the table
head(data_stocks)

#to view the exact number of first rows of the table
head(data_stocks, 3)

#to view the tail of the table
tail(data_stocks)
tail(data_stocks, 2)

#return MSFT data as a vector
data_stocks$MSFT

#return MSFT data as column  
data_stocks["MSFT"]


#return the price of AAPL stock in 3th row
data_stocks[3,"AAPL"]
data_stocks[3,4]

#return the values of AAPL stock in 3-5 rows
data_stocks[3:5,"AAPL"]
data_stocks[3:5, 4]

##Combining Data Frames

msft_ret <- diff(data_stocks$MSFT)

#check the number of values for MSFT columns and MSFT returns
length(data_stocks$MSFT)
length(msft_ret)

#add a zero value to the beginning of the vector
msft_ret <- c(0, msft_ret)
#check the length
length(msft_ret)

#combine the tables adding the column msft_ret to the data_stocks table
data_stocks_r <- cbind(data_stocks, msft_ret)
head(data_stocks_r)

#create two dataframes from data_stocks
data_r1 <- data_stocks_r[1:10,]  #first 10 rows
data_r2 <- data_stocks_r[2775:2784,]  #last 10 rows

#combine the tables adding one under another
data_stocks_rbind <- rbind(data_r1, data_r2)

#check the results
head(data_stocks_rbind)
tail(data_stocks_rbind)


##check for missing values
#to examine the table and check for missing values
summary(data_stocks)


#remove all rows with NA from data_stocks
data_stocks_naomit <- na.omit(data_stocks)

head(data_stocks)
head(data_stocks_naomit)


#extract a subset of a data frame based on certain conditions
#Subset the data to include only the columns for Microsoft (MSFT) and IBM (IBM)
subset_data <- subset(data_stocks, 
                      select=c("Date", "MSFT", "IBM"))

head(subset_data)




# Convert data_stocks table from wide to long format
data_stocks_l <- pivot_longer(data_stocks, 
                              # tells pivot_longer() to use all columns in data_stocks 
                              #except for Date as the values to reshape
                              cols = -Date, 
                              #specifies that the column headers in the original 
                              #data_stocks table should become the values in 
                              #the new Stock column of data_stocks_l
                              names_to = "Stock", 
                              #tells pivot_longer() to stack the data_stocks values 
                              #in a single column named Price
                              values_to = "Price")

head(data_stocks_l)

####################################################3



#look at the head of vg_data dataset we loaded earlier
head(vg_data)


#select specific columns from a data frame
# select only the columns Rank, Name, Year, and Global_Sales
vg_data_select <- select(vg_data, Rank, Name, Year, Global_Sales)
head(vg_data_select)

#filter rows based on conditions
# filter the data to include only games released in or after 2010
vg_data_filtered <- filter(vg_data, Year >= 2010)
head(vg_data_filtered)

#create new columns based on existing columns
# add a new column to the data frame that calculates the total sales for each game
vg_data_mutated <- mutate(vg_data, 
                          Total_Sales = NA_Sales + EU_Sales + JP_Sales + Other_Sales + Global_Sales)
head(vg_data_mutated)



#group_by() - group data by one or more columns
#summarize() - compute summary statistics of grouped data

#group the data by genre and calculate the sum of global sales for each genre
vg_data_grouped <- group_by(vg_data, Genre) %>% summarize(sum(Global_Sales))
head(vg_data_grouped)


