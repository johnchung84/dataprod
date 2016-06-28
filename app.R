library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)

load("saas data.RData")

ui<-shinyUI(
  pageWithSidebar(
    # Applicataion title
    headerPanel("Revenue Retention Curves\nfor my SaaS business"),  
    sidebarPanel(
      h3("DOCUMENTATION"),
      helpText("I own a SaaS (Software as a Subscription) business.",
               "I have 3 products (ProductA, ProductB, and ProductC) and",
               "one key metric measured for SaaS busineses is Revenue Retention.",
               "In this application, I generate the retention curves for my different",
               "products and measure how much is retained over time. Also, you can select",
               "(one or more) different starting months of the customers to see if retention",
               "is improving or worsening over time./n",
               "My ui.R and server.R code is available on my github. https://github.com/johnchung84/dataprod"),
      h3("Retention Curve Generator"),
      selectInput('product','Select the PRODUCT:',
                  c('PRODUCT1'='GTM',
                    'PRODUCT2'='GTW',
                    'PRODUCT3'='GTT')),
      selectizeInput('startmonth','Select the Starting Month of the Customers:',selected="2015-01-01", 
                     choices=as.character(unique(all.rr.final$START_MONTH)), 
                     multiple=TRUE)
    ),
    mainPanel(
      h3('REVENUE RETENTION CURVES'),
      plotOutput('LOSSES')
    )
  )
)

server<-shinyServer(  
  function(input, output) {    
    output$LOSSES <- renderPlot({
      # dataset that contains my saas business data
      all.rr.final %>% 
        filter(PRODUCT==input$product & 
                 CHANNEL=='ONLINE' &
                 START_MONTH %in% as.POSIXct(input$startmonth) &
                 AGE %in% 0:24) %>%
        ggplot(aes(x=AGE, y=REN.RATE, group=START_MONTH, color=as.factor(START_MONTH))) + 
        geom_line() + 
        ylab("Revenue Retention (%)") +
        xlab("# of months since Starting Month") +
        theme(text=element_text(size=15))+
        scale_y_continuous(labels=percent)+
        scale_color_discrete(name="Starting Month")})
  }
)

shinyApp(ui=ui, server=server)