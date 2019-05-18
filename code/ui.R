#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(wordcloud2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Word Cloud"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       textInput("text","please insert text"),
       
       #select default text
       selectInput("text","Or...you can select an exist text",c('demoFreq','demoFreqC')),
       
       #select a shape
       selectInput("shape","select a shape ",c('circle','cardioid','diamond','pentagon','star','triangle','triangle-forward')),
       
       #how many to show
       sliderInput("bins",
                   "Number of words to show:",
                   min = 1,
                   max = 50,
                   value = 30),
       
       #font family
       selectInput("fontFamily","font family",c('-defalut-','Arial','Centaur','Comic sans MS','Courier New','Impact','Verdana','FangSong','KaiTi','SimHei','SimSun'))
       ,
       
       #word color
       selectInput("wordColor","word color",c('random-dark','random-light','skyblue')),
       width = 3
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       wordcloud2Output("distPlot"),width=9
    )
  )
))
