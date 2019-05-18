#进行文字云前要做的事

#1.安装文字云的包
install.packages('wordcloud2')
#2.加载文字云的包
library(wordcloud2)
#3.语法精要
wordcloud2(demoFreqC, size = 1, minSize = 0, gridSize =  0,  
           
           fontFamily = NULL, fontWeight = 'normal',  
           
           color = 'random-dark', backgroundColor = 'white',  
           
           minRotation = -pi/4, maxRotation = pi/4, rotateRatio = 0.4,  
           
           shape = 'circle', ellipticity = 0.65, widgetsize = NULL) 

#（1）data：词云生成数据，包含具体词语以及频率；

#（2）size：字体大小，默认为1，一般来说该值越小，生成的形状轮廓越明显；

#（3）fontFamily：字体，如‘微软雅黑’；

#（4）fontWeight：字体粗细，包含‘normal’，‘bold’以及‘600’；；

#（5）color：字体颜色，可以选择‘random-dark’以及‘random-light’，其实就是颜色色系；

#（6）backgroundColor：背景颜色，支持R语言中的常用颜色，如‘gray’，‘blcak’，但是还支持不了更加具体的颜色选择，如‘gray20’；

#（7）minRontatin与maxRontatin：字体旋转角度范围的最小值以及最大值，选定后，字体会在该范围内随机旋转；

#（8）rotationRation：字体旋转比例，如设定为1，则全部词语都会发生旋转；

#（9）shape：词云形状选择，默认是‘circle’，即圆形。还可以选择‘cardioid’（苹果形或心形），‘star’（星形），‘diamond’（钻石），‘triangle-forward’（三角形），‘triangle’（三角形），‘pentagon’（五边形）



#安装中文分词包
install.packages('jiebaR')
library('jiebaR')

wk = worker()
wk['我是《R的极客理想》图书作者']


#英文词频

#安装包
#dplyr用于数据处理
#textstem 用于做词形还原
#readr 用于读取文件
install.packages('dplyr')
install.packages('textstem')
install.packages('plyr')
library(dplyr)
library(readr)
library(textstem)
library(plyr)

#1.读取停用词
stop_word <- read_csv('F:/Study/WordCloud/WordFreq/stop-word-list.csv') 

#2.读取要分析的文本文件
filePath = 'F:/Study/WordCloud/book/Gilbert_Strang_Introduction_to_Linear_Algebra__2009.txt'
text = readLines(filePath,encoding = 'UTF-8')
#3.去除无意义的换行，存在txt中
txt = text[text!='']
#4.全部转换为小写，避免大小写的影响
txt = tolower(txt)

#5.将字符串以空格为划分，存入list中
txtList = lapply(txt, strsplit,' ')
#6.去除标点符号的影响(.,!:;?()~)
#7.simplifies it to produce a vector which contains all the atomic components which occur
txtChar = unlist(txtList)
txtChar = gsub('\\.|,|\\!|:|;|\\?|\\(|\\)|~|\\[|\\]|\\"|\\/|\\+','',txtChar) 
txtChar = txtChar[txtChar!='']

#8.将处理干净的数据放入data中，并给各列命名
data = as.data.frame(table(txtChar))
colnames(data) = c('Word','freq')

#9.将数据排序
ordFreq = data[order(data$freq,decreasing=T),]

#10.过滤停用词
antiWord = data.frame(stop_word,stringsAsFactors=F)
result = anti_join(ordFreq,antiWord,by='Word') %>% arrange(desc(freq)) #ordFreq - antiWord，即取差集

#11.进行词形还原；在这里进行词形还原是为了效率更高
lemmatize_result <- lemmatize_words(result$Word)
result$Word=lemmatize_result
result=na.omit(result)

#12.合并相同的词，并将freq相加
result=aggregate(freq ~ Word, data = result, sum)

#13.筛选长度大于2的词(通常小于2的词都是一些无意义的单词、数字、符号)
result <- filter(result, nchar(as.character(Word)) > 3)
result <- filter(result, freq > 2)

#14.重新排序
result = result[order(result$freq,decreasing=T),]



#13.取长度
result = result[1:50,]


