#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Word Cloud"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       #粘贴文本的地方
       textInput("text","please insert text"),
       #选择已存在的文本
       selectInput("text","Or...you can select an exist text",c('demoFreq','demoFreqC')),
       #选择图形
       selectInput("shape","select a shape ",c('circle','cardioid','diamond','pentagon','star','triangle','triangle-forward')),
       #展示多少个词
       sliderInput("bins",
                   "Number of words to show:",
                   min = 1,
                   max = 50,
                   value = 30),width = 3
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       wordcloud2Output("distPlot")
    )
  )
))
