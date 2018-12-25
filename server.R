
server <- function(input, output) {
  
  dataInput <- reactive({
    
    if (input$sel_symbol == '')
      return(NULL)
    
    data = getSymbols(input$sel_symbol, src = "yahoo", 
               from = input$dates[1],
               to = input$dates[2],
               auto.assign = FALSE)
    colnames(data) = columnNames
    
    df <- data.frame(Date=index(data),coredata(data))    
    
    # create Bollinger Bands
    bbands <- BBands(data[,c("High","Low","Close")])
    
    rsi = RSI(data$Close)
    
    # join and subset data
    cbind(df, data.frame(bbands[,1:3]),data.frame(rsi))  
  })
  
  output$plot <- renderPlotly({
    
    df = dataInput()
    if (is.null(df))
      return(NULL)
    
    # colors column for increasing and decreasing
    for (i in 1:length(df[,1])) {
      if (df$Close[i] >= df$Open[i]) {
        df$direction[i] = 'Increasing'
      } else {
        df$direction[i] = 'Decreasing'
      }
    }
    
    i <- list(line = list(color = '#53B987'))
    d <- list(line = list(color = '#EB4D5C'))
    
    # plot candlestick chart
    p <- df %>%
      plot_ly(x = ~Date, type="candlestick",
              open = ~Open, close = ~Close,
              high = ~High, low = ~Low, name = input$sel_symbol,
              increasing = i, decreasing = d) %>%
      add_lines(x = ~Date, y = ~up , name = "Bollinger Bands",
                line = list(color = '#399898', width = 0.5),
                legendgroup = "Bollinger Bands",
                hoverinfo = "none", inherit = F) %>%
      add_lines(x = ~Date, y = ~dn, name = "Bollinger Bands",
                line = list(color = '#399898', width = 0.75),
                legendgroup = "Bollinger Bands", inherit = F,
                showlegend = FALSE, hoverinfo = "none") %>%
      add_lines(x = ~Date, y = ~mavg, name = "Moving Avg",
                line = list(color = '#965050', width = 0.75),
                hoverinfo = "none", inherit = F) %>%
      layout(yaxis = list(title = "Price"))
    
    # plot volume bar chart
    pp <- df %>%
      plot_ly(x=~Date, y=~Volume, type='bar', name = paste(input$sel_symbol,"Volume"),
              color = ~direction, colors = c('#92D2CC','#F7A9A7'), showlegend = FALSE) %>%
      layout(yaxis = list(title = "Volume"))

    # plot volume bar chart
    ppp <- df %>% plot_ly(x=~Date, y=~rsi, type = 'scatter', mode = 'lines',
                          line = list(color = "#AC52B4", width = 1), 
                          showlegend = FALSE) %>%
      add_trace(x = c(input$dates[1],input$dates[2]), y = c(70,70),
                line = list(color = '#cc94d1', width = 0.75, dash="dash"),
                showlegend = FALSE) %>%
      add_trace(x = c(input$dates[1],input$dates[2]), y = c(30,30),
                line = list(color = '#cc94d1', width = 0.75, dash="dash"), 
                showlegend = FALSE) %>%
      layout(yaxis = list(title = "RSI"))
    
    # create rangeselector buttons
    rs <- list(
               buttons = list(
                 list(count=1,
                      label='RESET',
                      step='all'),
                 list(count=1,
                      label='1 YR',
                      step='year',
                      stepmode='backward'),
                 list(count=3,
                      label='3 MO',
                      step='month',
                      stepmode='backward'),
                 list(count=1,
                      label='1 MO',
                      step='month',
                      stepmode='backward')
               ))
    
    # subplot with shared x axis
    p <- subplot(p, pp, ppp, heights = c(0.55,0.2,0.2), nrows=3,
                 shareX = TRUE, titleY = TRUE) %>%
      layout(xaxis = list(rangeselector = rs),
             legend = list(orientation = 'h', x = 0.5, y = 1,
                           xanchor = 'center', yref = 'paper',
                           font = list(size = 10),
                           bgcolor = 'transparent'))
    p
  })
  
  output$table = DT::renderDataTable({
    datatable(dataInput(), rownames = F)
  })
  
  output$caption <- renderText({ 
    paste(input$sel_symbol, "historical data")
  })
  
}
