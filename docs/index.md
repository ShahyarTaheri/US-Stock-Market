---
title       : Stock Watch
subtitle    : View NASDAQ Historical Data
author      : Shahyar Taheri
job         : 
framework   : shower        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
url :
  lib: ./libraries
--- 

--- .cover .w #Cover
# Stock Watch

![cover](./market.jpeg)

<br>
<br>
<br>
<br>
<br>
<span style="color:white">by: Shahyar Taheri</span>
<br>
<span style="color:white">12/20/2018</span>, 


---
## About

Stock watch provides a simple interface to query and view the historical data for NASDAQ stock exchange. The `Quantmode` library was used for getting data from `yahoo` website.

```r
getSymbols("AMZN",src="yahoo",auto.assign=F)[1:2,1:4]
```

```
##            AMZN.Open AMZN.High AMZN.Low AMZN.Close
## 2007-01-03     38.68     39.06    38.05       38.7
## 2007-01-04     38.59     39.14    38.26       38.9
```

---
## Usage
Navigate to the dashboard tab, choose the symbol and the date range for querying the data. The time span can be narrowed down using the range selector on the bottom of the plot or using the date selector buttons. A table of processed data can be viewed in the raw data tab.

- [Website](https://staheri.shinyapps.io/US-Stock-Market/)   
- [Source Code](https://en.wikipedia.org/wiki/Moving_average)  

--- .cover #FitToWidth
![cover](./plot.png)

--- 
## Indicators
The following indicators are included calculated in the server and displayed on the dashboard:

- [Moving Average](https://en.wikipedia.org/wiki/Moving_average)          
- [Bollinger Bands](https://en.wikipedia.org/wiki/Bollinger_Bands)
- [Relative Strength Index (RSI)](https://en.wikipedia.org/wiki/Relative_strength_index)
