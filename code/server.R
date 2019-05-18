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
library(dplyr)
library(readr)
library(textstem)
library(plyr)

#define stop word
stop_word <- read_csv('F:/Study/WordCloud/WordFreq/stop-word-list.csv') 

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$distPlot <- renderWordcloud2({
    data <- switch (input$text,
      'demoFreq' = demoFreq,
      'demoFreqC'=demoFreqC
    )
    
    wordcloud2(GenerateWordFreq(), size = 1, minSize = 0, gridSize =  0,  
                       
                       fontFamily = input$fontFamily, fontWeight = 'normal',  
                       
                       color = input$wordColor, backgroundColor = "white",  
                       
                       minRotation = -pi/4, maxRotation = pi/4, rotateRatio = 0.4,  
                       
                       shape=input$shape, ellipticity = 0.65, widgetsize = NULL) 
  })
  
})

#Fection for word frequency statistics
GenerateWordFreq <- function(){
  #2.Read the text file to be analyzed
  filePath = 'F:/Study/WordCloud/book/Gilbert_Strang_Introduction_to_Linear_Algebra__2009.txt'
  text = readLines(filePath,encoding = 'UTF-8')
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
  
  #10.Filter stop words
  antiWord = data.frame(stop_word,stringsAsFactors=F)
  result = anti_join(ordFreq,antiWord,by='Word') %>% arrange(desc(freq))
  
  #11.Performing a morphological restoration; here the morphological restoration is done for greater efficiency
  lemmatize_result <- lemmatize_words(result$Word)
  result$Word=lemmatize_result
  result=na.omit(result)
  
  #12.Combine the same words and add freq
  result=aggregate(freq ~ Word, data = result, sum)
  
  #13.Filter words with a length greater than 2 (usually less than 2 words are meaningless words, numbers, symbols)
  result <- filter(result, nchar(as.character(Word)) > 3)
  result <- filter(result, freq > 2)
  
  #14.rearrange
  result = result[order(result$freq,decreasing=T),]
  
  return (result)
}