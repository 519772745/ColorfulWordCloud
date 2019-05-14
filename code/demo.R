#进行文字云前要做的事

#1.安装文字云的包
install.packages("wordcloud2")
#2.加载文字云的包
library(wordcloud2)
#3.语法精要
wordcloud2(demoFreqC, size = 1, minSize = 0, gridSize =  0,  
           
           fontFamily = NULL, fontWeight = 'normal',  
           
           color = 'random-dark', backgroundColor = "white",  
           
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