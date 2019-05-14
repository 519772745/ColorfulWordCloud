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
    #获取默认的数据集
    data <- switch (input$text,
      'demoFreq' = demoFreq,
      'demoFreqC'=demoFreqC
    )
    
    #生成文字云
    wordcloud2(data, size = 1, minSize = 0, gridSize =  0,  
                       
                       fontFamily = NULL, fontWeight = 'normal',  
                       
                       color = 'random-dark', backgroundColor = "white",  
                       
                       minRotation = -pi/4, maxRotation = pi/4, rotateRatio = 0.4,  
                       
                       shape=input$shape, ellipticity = 0.65, widgetsize = NULL) 
    
  })
  
})
