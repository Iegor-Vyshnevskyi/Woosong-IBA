#install.packages("rvest")
library(tidyverse)
library(rvest)


#Example (1)

url <- "https://www.imdb.com/chart/top"

titles <- read_html(url) %>% 
  html_nodes("#main > div > span > div > div > div.lister > table > tbody > tr:nth-child(n) > td.titleColumn > a") %>% 
  html_text()


years <- read_html(url) %>% 
  html_nodes("#main > div > span > div > div > div.lister > table > tbody > tr:nth-child(n) > td.titleColumn > span") %>% 
  html_text()


ratings <- read_html(url) %>% 
  html_nodes("#main > div > span > div > div > div.lister > table > tbody > tr:nth-child(n) > td.ratingColumn.imdbRating > strong") %>% 
  html_text()

# Combine the extracted data into a data frame
imdb_data <- data.frame(title = titles, year = years, rating = ratings)

# View the data
view(imdb_data)

#----------------------------------

#Example(2)web-scrap the FULL text from Woosong university web-site/About/Who we Are

url <- "https://english.wsu.ac.kr/page/index.jsp?code=eng0101"

who_we_are <- read_html(url) %>% 
  html_nodes("#rightCont > div") %>% 
  html_text()

print(who_we_are)

#---------------------------------------------------------------------------



<- 