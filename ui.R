shinyUI(dashboardPage (
  skin = "green",
  dashboardHeader(title = 'US Stock Market'),
  dashboardSidebar(
    sidebarUserPanel('Author', subtitle = "Shahyar Taheri",
                     image = 'https://avatars0.githubusercontent.com/u/21279530?s=400&v=4'),
    sidebarMenu(
      menuItem('About', tabName = 'home', icon = icon('home')),
      menuItem(
        'Dashboard',
        tabName = 'ts',
        icon = icon('line-chart')
      ),
      menuItem('Raw Data', tabName = 'dt', icon = icon('database'))
    )
  ),
  dashboardBody(tabItems(
    tabItem(
      tabName = 'home',
      box(title = 'About',status = 'info',solidHeader = F, width = 12,
          p("This site provides a simple system to view historical data for NASDAQ stock exchange.")),
      box(title = 'How does it work?',status = 'info',solidHeader = F, width = 12,
          p("Navigate to the dashboard tab, choose the symbol and the date range for querying the data. 
            The time span can be narrowed down using the range selector on the bottom of the plot or using the date selector buttons.  
            A table of processed data can be viewed in the raw data tab.")),      
      box(title = 'Indicators',status = 'info',solidHeader = F, width = 12,
          p("Follwing indicators are included:"),
          tags$ul(
          tags$li(tags$a(href="https://en.wikipedia.org/wiki/Moving_average", "Moving Average")),
          tags$li(tags$a(href="https://en.wikipedia.org/wiki/Bollinger_Bands", "Bollinger Bands")),
          tags$li(tags$a(href="https://en.wikipedia.org/wiki/Relative_strength_index", "Relative Strength Index (RSI)")))
          )
    ),
    tabItem(
      tabName = 'dt',
      h2("NASDAQ Exchange"),
      h3(textOutput("caption")),
      fluidRow(
        box(
          DT::dataTableOutput('table'),
          width = 12,
          solidHeader = T,
          status = 'warning'
        )
      ),
      tags$a(href = "https://www.kaggle.com/dgawlik/nyse", "Data Source")
    ),
    tabItem(
      tabName = 'ts',
      sidebarLayout(
        position = "right",
        sidebarPanel(
          helpText(
            "Select a stock to examine.
            Information will be collected from Yahoo finance."
          ),
          
          selectizeInput(
            'sel_symbol', label = NULL, choices = allSymbols,
            options = list(create = TRUE),selected = "AMZN"
          ),
          
          dateRangeInput(
            "dates",
            "Date range",
            start = "2017-01-01",
            end = as.character(Sys.Date())
          )
          ),
        mainPanel(withSpinner(plotlyOutput("plot", height= 800),color="#222D32"))
      )
    )
  ))
))
