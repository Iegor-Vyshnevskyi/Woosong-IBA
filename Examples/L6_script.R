library(tidyverse)


#Line Plot-------------------------------------------------
#(1) Basic Line Plot
print(AirPassengers)

plot(AirPassengers)


#(2) More Complex Example
head(GDP)

plot(GDP$Australia)


plot(x = GDP$Year, 
     #specify values for the y-axis
     y = GDP$Australia, 
     #specify the type of the line
     type = "l",
     #change the color of the line
     col = "red",
     #change the line thickness
     lwd = 2,
     #specify the line type of the plot
     lty = 2,
     #add title 
     main = "Australia GDP per Capita (1990-2013)",
     #add axis labels
     xlab = "Years",
     ylab = "GDP per Capita")

#(3) Multiple-line plot
plot(x = GDP$Year, y = GDP$Australia, 
     type = "l", col = "red", lwd = 2,
     main = "Australia and Germany GDP per Capita (1990-2013)",
     xlab = "Years", ylab = "GDP per Capita")
#add the new line to the plot 
lines(x = GDP$Year,
      y = GDP$Germany,
      col = "blue")

#add legend box to the plot
legend(x = "bottomright",   #location of the legend
       legend = c("Australia", "Germany"),       
       col = c("red", "blue"), 
       #add line type to the legend box
       lty = c(1, 1))



#(4) Bar Plot---------------------------------------------------------------------

barplot(height = GDP$Australia, 
        names.arg = GDP$Year,
        main = "Australia GDP per Capita (1990-2013)",
        xlab = "Years",
        ylab = "GDP per Capita") 


#(5) Scatter Plot-------------------------------------------------------------------

plot(GDP$Australia, GDP$Germany,
     main = "Australia GDP per Capita vs Germany GDP per capita \n (1990-2013)")

#(6) Pie Chart---------------------------------------------------------------------

#extract 2013 data
GDP_2013 <- GDP[nrow(GDP),]

#delete the first column
GDP_2013 <- GDP_2013[, -1]

#change the class from data.frame to matrix
GDP_2013 <- as.matrix(GDP_2013)

#check the class
class(GDP_2013)


pie(GDP_2013, labels = colnames(GDP_2013))


#ggplot2----------------------------------------------------------------------

install.packages("ggplot2")
library(ggplot2)

#Line plot

ggplot(GDP, 
       aes(x = Year, 
           y = Australia,
           group = 1)) +
  geom_line()+
  #add points to the line
  geom_point()

#Multiple line plot
head(GDP)
head(GDP_l)

ggplot(GDP_l,
       aes(Year, GDP,
           group = Country, 
           colour = Country))+
geom_line()


#Bar plot
options("scipen"=100, "digits"=4) 

ggplot(GDP_l,
       aes(x = Year, y = GDP))+
  geom_bar(aes(fill = Country), stat = "identity")


#OR

ggplot(GDP_l,
       aes(x = Year,y = GDP))+
  geom_col(aes(fill = Country))

#grouped bar chart

ggplot(GDP_l,
       aes(x = Year, y = GDP))+
  geom_bar(aes(fill = Country), stat = "identity", position = "dodge")


# plot customization 
ggplot(GDP_l,
       aes(Year, GDP, 
           colour = Country, 
           group = Country))+
  geom_line()+
  #add labels
  labs(title = "World GDP per Capita (1990-2013)",
       x = "Year", y = "GDP per Capita")+
  #customize the background
  theme_bw()+
  #modify the appearance of the x-axis labels
  #rotates the labels by 45 degrees
  theme(axis.text.x=element_text(angle = 45, 
                                 #adjusts the vertical justification of the labels
                                 vjust = 1,  
                                 #adjusts the horizontal justification of the labels
                                 hjust = 1))+
  #change the location of the title
  theme(plot.title = element_text(hjust = 1))+
  #change the location of the legend
  theme(legend.position = c(0.1, 0.7),
        #modify the background of the legend box
        legend.box.background = element_rect(),
        #remove the borders of the plot
        panel.border = element_blank(),
        #remove the major grid lines from the plot panel
        panel.grid.major = element_blank(),
        #remove the minor grid lines from the plot panel
        panel.grid.minor = element_blank() )



ggplot(GDP_l,
       aes(Year, GDP, 
           colour = Country, 
           group = Country))+
  geom_line()+
  labs(title = "World GDP per Capita (1990-2013)",
       x = "Year", y = "GDP per Capita")+
  theme_bw()+
  theme(axis.text.x=element_text(angle = 45, 
                                 vjust = 1,  
                                 hjust = 1))+
  theme(plot.title = element_text(hjust = 0.5))+
  theme(legend.position = c(0.1, 0.7),
        legend.box.background = element_rect(),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank())



  
  
  
  
 
  