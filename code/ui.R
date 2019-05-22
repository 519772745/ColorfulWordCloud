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
      
      #text layout
      radioButtons("textlayout","text layout type",selected="random",c("random"="random","horizontal"="horizontal","verticality"="verticality")),
      
      #font family
      selectInput("fontFamily","font family",c('-defalut-','Arial','Times New Roman','Lucida Caligraphy','Helvetica','STCaiyun','STXingkai','Centaur','Comic sans MS','Courier New','Impact','Verdana','FangSong','KaiTi','SimHei','SimSun')),
      
      
      
      #word color
      #random
      #selectInput("wordColor","word color",c('random-dark','random-light')),
      radioButtons("wordColor","Choose Word Color",c(
        "random-dark"="random-dark",
        "random-light"="random-light",
        "custom-colors"="custom-colors"
      )),
      
      #only one color
      #'<label for="clx">choose word color(all word one color)</label>',
      HTML('<input id="clx" type="color" class="form-control" value="#ff0000">',
           '<input id="cl" type="text" class="form-control" value="#ff0000" style="display:none">',
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
    mainPanel(HTML(
      '<div style="width:100%;height:700px;overflow:hidden;positive:absolute">'),wordcloud2Output("distPlot"),width=9,HTML('</div>',
      '<script>',
      'window.onload=function(){
        var elem=document.getElementById("distPlot");
        elem.style.height="700px";
      }',
      '</script>'
      )
    )
    
  )
))
