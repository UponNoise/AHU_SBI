#第6章  描述性数据分析

###6.1  单变量数据分析
##例6.1   假如对一组25人饮酒者所饮酒类进行调查，饮酒者按照红酒（1）、白酒（2）、黄酒（3）和啤酒（4）分成4类统计。数据如下：
drink <- c(3,4,1,1,3,4,3,3,1,3,2,1,2,1,2,3,2,3,1,1,1,1,4,3,1)
drink.count <- table(drink) # 分组计数
names(drink.count) <- c("红酒","白酒","黄酒","啤酒") 
drink.count
barplot(drink.count) # 画条形图
pie(drink.count) # 画饼图

##6.1.2  数值型数据
#例6.2 datasets包里数据集Nile记录了尼罗河1871-1970年每年平均水流量（单位10^8立方米）
data(Nile)
mean(Nile) # 求均值
mean(Nile,trim = 0.2) # 截尾均值(截去两端20%后的数据)
median(Nile) # 求中位数
var(Nile) # 求方差
grubbsary(Nile) # 求分位数
IQR(Nile) # 四分位间距
mad(Nile) # 平均差

Nile.group = cut(Nile, breaks = seq(400,1400,100)) # 数据分箱
table(Nile.group)
hist(Nile, breaks = seq(400,1400,100), main = '频数直方图') 
hist(Nile, breaks = seq(400,1400,100), probability = T, main = '频率直方图')
lines(density(Nile),col='red') # 在频率直方图上添加核密度估计曲线
legend("topright", legend='密度函数线', lty = 1, col = 'red', cex = 0.7)

boxplot(Nile) # 垂直型箱线图
boxplot(Nile, horizontal=T) # 水平型箱线图

ts.plot(Nile)

##6.1.2  离群值探索
#例6.3
Nile2 <- c(Nile, 1800)
boxplot(Nile2)
boxplot.stats(Nile2)
#install.packages("outliers")
library("outliers")
grubbs.test(Nile2, type = 10)

##6.2  双变量数据分析
#例对datasets包里中mtcars数据集，使用箱线图比较自动档和手动档汽车的每加仑汽油行驶英里数(mpg)。
head(mtcars)
attach(mtcars); options(digits=3)
table(vs, am) # 二维列联表
prop.table(table(vs, am), 1) # 占行总数的比例
prop.table(table(vs, am), 2) # 占列总数的比例
# 以发动机类型为横轴、变速器类型为分类变量画条形图
barplot(table(vs, am),names.arg = c('V型', '直列'), legend.text=c('自动', '手动'))
# 以变速器类型为横轴、发动机类型为分类变量画条形图
barplot(table(am, vs),names.arg = c('自动', '手动'), legend.text=c('V型', '直列'))
# 并列式条形图
barplot(table(am, vs), beside = T,names.arg = c('自动', '手动'), legend.text=c('V型', '直列'))
detach(mtcars)

##6.2.2  分类数据vs数值型数据
attach(mtcars)
mtcars.auto <- mtcars[am==0,]; mtcars.manual <- mtcars[am==1,]
boxplot(mtcars.auto$mpg,mtcars.manual$mpg, names = c('自动', '手动'))
boxplot(mpg ~ am, names = c('自动', '手动'), xlab = '变速器', ylab = '油耗'); detach(mtcars)

##6.2.3  数值型数据vs数值型数据
attach(mtcars); par(mfrow=c(1,2))
plot(disp, hp, xlab = '排量', ylab = '总马力')
abline(lm(hp~disp)) # 添加回归趋势线
cor(disp,hp) # Person相关系数
cor(disp,hp,method="spearman") # Spearman等级相关系数，等于cor(rank(disp),rank(hp))

###6.3  多变量探索性数据分析
##6.3.1  多维分类数据
attach(mtcars)
table(data.frame(cyl, vs, am)) # 多维列联表
ftable(data.frame(cyl, vs, am)) # 平面二维列联表
ftable(data.frame(vs, am, cyl)) # 改变变量的顺序会改变平面二维列联表的形状
mosaicplot(~ vs + am + cyl, color = TRUE, main = NULL) #马赛克图
detach(mtcars)

##6.3.2  多维连续变量数据
#例datasets包里iris数据集
attach(iris); iris.lab = rep(c("1", "2", "3"), rep(50, 3))
plot(iris[,1],iris[,3],type="n", xlab = "花萼长度", ylab = "花瓣长度")
text(iris[,1],iris[,3],cex=0.6)        # 显示样本序号
plot(iris[,1],iris[,3],type="n", xlab = "花萼长度", ylab = "花瓣长度")
text(iris[,1],iris[,3],iris.lab,cex=0.7)  # 显示分类序号
#制三维散点图
#install.packages("scatterplot3d")
library(scatterplot3d); attach(iris); par(mfrow=c(1,2))
scatterplot3d(iris[,1:3],color = as.numeric(Species))
scatterplot3d(iris[,1:3],color = as.numeric(Species),angle = 10) # 旋转10度
legend("bottomright",legend =c('setosa','versicolor','virginica'), pch=rep(1,3),col=1:3)
detach(iris)

attach(iris) 
pairs(iris,pch=20)  # 绘制矩阵散点图
pairs(iris[1:4],pch=21,bg=Species)  # 使用不同颜色来区分种类
#install.packages("car")
library(car)  # 在散点图矩阵的对角线绘制核密度估计曲线
scatterplotMatrix(~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width|Species, col = 4:6)

#对iris数据集的连续变量绘制关系矩阵图。
#install.packages("corrplot")
library(corrplot); attach(iris); par(mfrow=c(1,2))
corrplot(cor(iris[,1:4]), tl.pos = "d", cl.pos = "n")
corrplot(cor(iris[,1:4]), order = "h", tl.pos = "d", cl.pos = "n", addrect = 2); detach(iris)
#install.packages("fmsb")
library(fmsb)
?radarchart #查询radarchart
maxmin <- data.frame(total=c(5,1), phys=c(15,3), psycho=c(3,0), social=c(5,1), env=c(5,1))
RNGkind("Mersenne-Twister");set.seed(123)
dat <- data.frame(total=runif(5,1,5), phys=rnorm(5,10,2), psycho=c(1,1,0.5,NA,3), social=runif(5,1,5), env=c(5,2,2,2.5,4))
dat <- rbind(maxmin,dat) # 使得前两行为该列可能的最大值和可能的最小值
radarchart(dat, axistype=1, seg=5, plty=1, vlabels=c("Total\nQOL","Physical\naspects","Phychological\naspects", "Social\naspects", "Environmental\naspects"),title="(axis=1, 5 segments, with specified vlabels)", vlcex=0.5)
radarchart(dat, axistype=2, pcol=topo.colors(3), plty=1, pdensity=c(5, 10, 30),pangle=c(10, 45, 120), pfcol=topo.colors(3),title="(topo.colors, fill, axis=2)")






