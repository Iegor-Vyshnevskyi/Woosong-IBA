# Install forecast library
install.packages('forecast')

# Load forecast library
library(forecast)

# Load the Air Passengers’ dataset and view its class
data("AirPassengers")

class(AirPassengers)

# Display the dataset
AirPassengers

# Let’s check on our date values
start(AirPassengers) # start date

end(AirPassengers) # end date

# Find out if there are any missing values
sum(is.na(AirPassengers))

# Check the summary of the dataset
summary(AirPassengers)

# Plot the dataset
plot(AirPassengers)

# Decompose the data into four components and plot
tsdata <- ts(AirPassengers, frequency = 12) 
ddata <- decompose(tsdata, "multiplicative")
plot(ddata)

# Plot the different components individually
plot(ddata$trend)
plot(ddata$seasonal)
plot(ddata$random)

# Plot a trend line on the original dataset
plot(AirPassengers)
abline(reg=lm(AirPassengers~time(AirPassengers)))

# Create a box plot by cycle
boxplot(AirPassengers~cycle(AirPassengers), 
                            xlab="Date", 
                            ylab = "Passenger Numbers (1000's)", 
                            main = "Monthly air passengers boxplot from 1949-1960")

# Build the ARIMA Model: using auto.arima() function
mymodel <- auto.arima(AirPassengers)
mymodel

# Check that the residuals look like white noise
checkresiduals(mymodel)

# Forecast the values for the next 10 years
myforecast <- forecast(mymodel, level=c(95), h=10*12)
myforecast <- forecast(mymodel, level=c(80,95), h=10*12)
plot(myforecast)

# Validate the model by selecting lag values
Box.test(mymodel$resid, lag=5, type="Ljung-Box")
Box.test(mymodel$resid, lag=10, type="Ljung-Box")
Box.test(mymodel$resid, lag=15, type="Ljung-Box")










# Install and load quantmod library
#install.packages("quantmod")
library(quantmod)

# Retrieve Microsoft stock prices from Yahoo Finance from 2022-01-01 to present
prices <- getSymbols(Symbols = "MSFT", src = "yahoo", from = "2022-03-01", 
                     auto.assign = FALSE)

head(prices)

# Display candlestick chart with black color 
chart_Series(prices, col = "black")

#zoom for period of 2023
zoom_Chart("2023") 

#zoom for period from 2022-06 to 2022-12
zoom_Chart("2022-06/2022-12")

#zoom for the period staring from 2023-02 to the last available data in the data set
zoom_Chart("2023-02::") 

# Retrieve closing prices and remove missing values from closing prices if any
cl_prices <- Cl(prices)

#plot the closing prices
chart_Series(cl_prices)

#add RSI indicator with period of 14
add_RSI(n = 14, maType = "SMA")

# Add Bollinger Bands 
add_BBands(n = 20, maType = "SMA", sd = 1, on = 1)


# Add MACD indicator 
add_MACD(fast = 12, slow = 26, signal = 9, maType = "SMA", histogram = TRUE)

###############################################################################

# Load PerformanceAnalytics library
library(PerformanceAnalytics)


# Calculate the trading signal based on the MACD indicator
macd <- MACD(cl_prices, maType = "SMA")
tail(macd)

plot(macd)

# Calculate the difference between the MACD and Signal lines
macd$diff <- macd$macd - macd$signal

# Display the last 20 rows of the MACD data with the signal column added
tail(macd,20) 



