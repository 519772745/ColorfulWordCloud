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

#English word frequency statistics
#dplyr for data processing
#readr read the file(*txt only)
#textstem for lemmatization
#plyr for statistical frequency
library(dplyr)
library(readr)
library(textstem)
library(plyr)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Colorful Word Cloud"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      #select your file
      fileInput("text", "upload a file", multiple = FALSE, accept = NULL, width = NULL, buttonLabel = "Browse...", placeholder = "No selected"),
      
      #select a shape
      selectInput("shape","select a shape ",c('circle','cardioid','diamond','pentagon','star','triangle','triangle-forward')),
      #select your file
      fileInput("custom_shape", "or upload a Shape", multiple = FALSE, accept = NULL, width = NULL, buttonLabel = "Browse...", placeholder = "No selected"),
      
      #text layout
      radioButtons("textlayout","text layout type",selected="random",c("random"="random","horizontal"="horizontal","verticality"="verticality")),
      
      #font family
      selectInput("fontFamily","font family",c('-defalut-','Arial','Times New Roman','Lucida Caligraphy','Helvetica','STCaiyun','STXingkai','Centaur','Comic sans MS','Courier New','Impact','Verdana','FangSong','KaiTi','SimHei','SimSun')),
      
      
      
      #word color
      #random
      selectInput("wordColor","word color",c('random-dark','random-light')),
      
      #only one color
      HTML('<label for="clx">choose word color(all word one color)</label>',
           '<input id="clx" type="color" class="form-control" value="#ffffaa">',
           '<input id="cl" type="text" class="form-control" value="#ffffaa" style="display:none">',
           '<script>',
           '$(function(){$("#clx").change(function(){$("#cl").val($(this).val()).trigger("change");});})',
           '</script>'
      ),
      
      #background
      selectInput("backgroundColor","background color",c('white','antiquewhite','skyblue','gray','darkseagreen',
                                                         'ghostwhite','khaki','lightblue','lightpink','lightyellow')),
      
      #how many to show
      sliderInput("bins",
                  "Number of words to show (xx %):",
                  min = 1,
                  max = 100,
                  value = 100),
      width = 3
      
    ),
    # Show a plot of the generated distribution
    mainPanel(
      wordcloud2Output("distPlot"),width=9
    )
  )
))
