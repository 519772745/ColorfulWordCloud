#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

#Generate word cloud
library(wordcloud2)

#English word frequency statistics
#dplyr for data processing
#readr read the file(*txt only)
#textstem for lemmatization
#plyr for statistical frequency
library(plyr)
library(dplyr)
library(readr)
library(textstem)



#define stop word
stop_word <- read_csv('./WordFreq/stop-word-list.csv') 
welcome_word <-read_csv('./welcome/demo.csv')
print(welcome_word)
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$distPlot <- renderWordcloud2({

    #1.
    if(is.null(input$text$datapath)){
      data <- welcome_word
    }
    else{
      data <-GenerateWordFreq(input$text$datapath)
    }

    
    #3.rotation
    textlayout=input$textlayout
    if(textlayout=='horizontal'){
      minRotation=0
      maxRotation=0
      rotateRatio=1
    }else if(textlayout=='verticality'){
      minRotation= -pi/2
      maxRotation= -pi/2
      rotateRatio=1
    }else{
      minRotation=-pi/4
      maxRotation= pi/4
      rotateRatio=0.4
    }

    #4.bins
    length=nrow(data)
    print(length)
    #5.color
    colorcontrol <- input$wordColor
    if(colorcontrol=='custom-colors'){
      colorcontrol = input$cl
    }else{
      colorcontrol = input$wordColor
    }
    print(input$bins)
    wordcloud2(data[0:(length*(input$bins / 100)),], size = 1, minSize = 0, gridSize =  0,  
                       
                       fontFamily = input$fontFamily, fontWeight = 'normal',  
                        
                       color = colorcontrol, backgroundColor = input$backgroundColor,  
                       
                       minRotation = minRotation, maxRotation = maxRotation, rotateRatio = rotateRatio,  
                       
                       shape=input$shape,ellipticity = 0.65, widgetsize = NULL) 
   })

  #3data <- mtcars
  ##6.download
  #output$dowmloadData <- downloadHandler(
  #  filename = function(){
  #    paste('data',Sys.Date(),'.csv',sep='')
  #  },
  #  content = function(file){
  #    write.csv(data,file)
  #  }
  #)
  
  
  
})

#Fection for word frequency statistics
GenerateWordFreq <- function(file_path){
  #2.Read the text file to be analyzed
  text = readLines(file_path,encoding = 'UTF-8')
  #3.Remove meaningless line breaks, in txt
  txt = text[text!='']
  #4.Convert all to lowercase, avoiding the impact of capitalization
  txt = tolower(txt)
  
  #5.Divide strings into spaces and store them in the list.
  txtList = lapply(txt, strsplit,' ')
  #6.Remove the effect of punctuation(.,!:;?()~)
  #7.simplifies it to produce a vector which contains all the atomic components which occur
  txtChar = unlist(txtList)
  txtChar = gsub('\\.|,|\\!|:|;|\\?|\\(|\\)|~|\\[|\\]|\\"|\\/|\\+','',txtChar) 
  txtChar = txtChar[txtChar!='']
  
  #8.Put clean data into data and name each column
  data = as.data.frame(table(txtChar))
  colnames(data) = c('Word','freq')
  
  #9.Sort data
  ordFreq = data[order(data$freq,decreasing=T),]
  

  #10.Performing a morphological restoration; here the morphological restoration is done for greater efficiency
  lemmatize_result <- lemmatize_words(result$Word)
  result$Word=lemmatize_result
  result=na.omit(result)
  

  #11.Combine the same words and add freq
  result=aggregate(freq ~ Word, data = result, sum)
  
  #12.Filter stop words
  antiWord = data.frame(stop_word,stringsAsFactors=F)
  result = anti_join(ordFreq,antiWord,by='Word') %>% arrange(desc(freq))
  
  #13.Filter words with a length greater than 2 (usually less than 2 words are meaningless words, numbers, symbols)
  result <- filter(result, nchar(as.character(Word)) > 3)
  result <- filter(result, freq > 2)
  
  #14.rearrange
  result = result[order(result$freq,decreasing=T),]
  
  return (result)
}