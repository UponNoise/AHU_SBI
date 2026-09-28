#第7章 假设检验
#7.2正态总体单样本参数假设检验
#例7.1 R中岩石数据集(rock)是石油层中48个岩石样本测量数据, 包含孔隙面积(area,单位256x256像素)、周长(peri)、形状(shape=peri/sqrt(area))、渗透率。
#假定岩石样本的孔隙面积服从正态分布，标准差为2684.若某研究员声称石油储层中岩石孔隙面积的均值超过7200,检验他的说法是否与这批样本一致. 以下是编写程序u.test，R中有t.test函数

u.test<-function(a,mu,thegma,alternative="twoside"){  Se=thegma/sqrt(length(a))
 u=(mean(a)-mu)/Se
 if (alternative=="twoside") p=2*(1-pnorm(abs(u))) # "twoside":双边检验
 else if (alternative=="less") p=pnorm(u) # "less":左侧单边检验
 else   p=1-pnorm(u) # "greater":右侧单边检验
 return(data.frame(u,p.value=p)) }
head(rock)
#mean(rock$area)
u.test(rock$area,7200,2684,alternative="less")  #左侧单边检验

u.test(rock$area,7200,2684,alternative="twoside")  #双边检验
u.test(rock$area,7200,2684,alternative="greater")  #右侧单边检验
t.test(rock$area,mu=7200,alternative ="less") # 左侧单边检验，方差未知

#例7.2 基于例7.1数据集rock, 仍假定岩石孔隙面积服从正态N(7200,2700^2). 检验此说法是否与这批样本一致
#在R语言中，var.test()函数用于执行两个正态分布样本的方差比较。
#install.packages("TeachingDemos")
library(TeachingDemos)
sigma.test(rock$area, sigmasq = 2700^2)
#var.test(rock$area,2700) #运行错误
u.test(rock$area,7200,2700,alternative="twoside")  #双边检验

#7.3 正态总体双样本参数假设检验
#例7.3 R语言的植物生长数据集(PlantGrowth)共有30个样本观测值, 分成ctrl(对照组)、trt1(处理组1)、trt2(处理组2)三组，每组记录10个样本植物产量(以植物干重衡量).
#假定数据服从正态分布,检验对照组和处理组1的方差是否相等.
attach(PlantGrowth)
var.test(weight[group == 'ctrl'],weight[group == 'trt1'])

#例7.4  假设植物生长数据集(PlantGrowth)服从正态分布. 计算获得对照组样本均值为5.032, 小于处理组2的均值5.526. 那么这些数据能证明处理组2的处理方案提高了植物产量吗？
#假设显著性水平为0.05
attach(PlantGrowth)
var.test(weight[group == 'ctrl'],weight[group == 'trt2'])
t.test(weight[group == 'ctrl'],weight[group == 'trt2'],var.equal=TRUE)

#7.4 比例假设检验

#例7.5 为调查某大学男女比率是否是1:1，在校门处观察，发现100学生中有45个女性。那么，这是否支持该大学总体男性占比为50%的假设？

proptest<-function(x,n,p,alternative){
      Se=sqrt(p*(1-p)/n); u=(x/n-p)/Se
      if (alternative=="twoside")  p=2*(1-pnorm(abs(u))) # "twoside":双边检验
      else if (alternative=="less")  p=pnorm(u)# "less":左侧单边检验
      else   p=1-pnorm(u)# "more":右侧单边检验
      return(data.frame(u=u, p.value=p))}
proptest(45,100,0.5,alternative="twoside")

#重复上面的例子，假设我们询问1000个人，有450人回答“是”，现在问原假设是否还成立？
proptest(450,1000,0.5,alternative="twoside")

#7.5方差分析

#四种不同配方下原价寿命差异显著性检验问题
lamp<-c(1600,1610,1650,1680,1700,1700,1780,1500,1640,1400,1700,1750,1640,1550,1600,1620,1640,1600,1740,1800,1510,1520,1530,1570,1640,1600)
A<-factor(c(rep(1,7),rep(2,5),rep(3,8),rep(4,6)))
lamp.aov<-aov(lamp~A)
summary(lamp.aov)

#老鼠接种伤寒杆菌存活天数差异显著性检验问题
mouse<-c(2,4,3,2,4,7,7,2,2,5,4,5,6,8,5,10,7,12,12,6,6,7,11,6,6,7,9,5,5,10,6,3,10)
A1=factor(c(rep(1,11),rep(2,10),rep(3,12)))  %see table 1.5
mouse.aov<-aov(mouse~A1)
summary(mouse.aov)

#分析种子和施肥方案对产量显著性影响
#不考虑交互作用
y<-c(325,292,316,317,310,318,310,320,318,330,370,365)
A<-factor(gl(4,3))
B<-factor(gl(3,1,12))
y.aov<-aov(y~A+B)
summary(y.aov)

#考虑交互作用
y<-c(325,292,316,317,310,318,310,320,318,330,370,365)
A<-factor(gl(4,3))
B<-factor(gl(3,1,12))
y.aov<-aov(y~A+B+A*B)
summary(y.aov)