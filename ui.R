shinyUI(
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
            "is improving or worsening over time."),
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