library(dplyr)
library(tidyr)
library(ggplot2)
library(scales)

load("saas data.RData")

shinyServer(  
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