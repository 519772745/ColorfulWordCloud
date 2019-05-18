#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(wordcloud2)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$distPlot <- renderWordcloud2({
    data <- switch (input$text,
      'demoFreq' = demoFreq,
      'demoFreqC'=demoFreqC
    )
    
    wordcloud2(data, size = 1, minSize = 0, gridSize =  0,  
                       
                       fontFamily = input$fontFamily, fontWeight = 'normal',  
                       
                       color = input$wordColor, backgroundColor = "white",  
                       
                       minRotation = -pi/4, maxRotation = pi/4, rotateRatio = 0.4,  
                       
                       shape=input$shape, ellipticity = 0.65, widgetsize = NULL) 
    
  })
  
})
