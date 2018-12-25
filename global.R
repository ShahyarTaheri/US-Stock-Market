#library(googleVis)
library(quantmod)
library(shiny)
#library(ggplot2)
#library(dplyr)
#library(forecast)

library(shinydashboard)
library(DT)
#library(textshape)
library(plotly)
#library(tidyr)
library(rsconnect)
#library(dygraphs)
library("data.table")
library(shinycssloaders)

columnNames = c("Open","High","Low","Close","Volume","Adjusted")

#allSymbols = stockSymbols(exchange = "NASDAQ")$Symbol
#save(allSymbols, file = "./data/allSymbols.RData")

load("./data/allSymbols.RData")